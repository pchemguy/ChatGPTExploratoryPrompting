// BatchProcessAndSaveJPEG.jsx
// Photoshop CS6 Script to batch process images:
// 1. Asks for an input directory.
// 2. Opens each image.
// 3. Performs a specific column modification (selects column from pixel 2151, 200px wide, fills white).
//    - This processing step is intended for Grayscale images.
// 4. Saves the processed image as a progressive JPEG (Quality 8, 5 Scans) in an "OUTPUT_Processed_Images" subfolder.
// 5. Closes the original image without saving changes.
// 6. Allows cancellation by pressing the ESC key.

#target photoshop
app.bringToFront(); // Bring Photoshop to the front

// Global flag for script cancellation
$.global.gScriptCancelled = false; // Explicitly global

// --- ActionManager function to make a rectangular selection (robust) ---
function selectRegionAM(left, top, right, bottom) {
    var desc = new ActionDescriptor();
    var ref = new ActionReference();
    ref.putProperty(charIDToTypeID("Chnl"), charIDToTypeID("fsel")); // Channel: Selection
    desc.putReference(charIDToTypeID("null"), ref);                 // To: (current selection)
    var rectDesc = new ActionDescriptor();
    rectDesc.putUnitDouble(charIDToTypeID("Top "), charIDToTypeID("#Pxl"), top);    // Top border in pixels
    rectDesc.putUnitDouble(charIDToTypeID("Left"), charIDToTypeID("#Pxl"), left);  // Left border in pixels
    rectDesc.putUnitDouble(charIDToTypeID("Btom"), charIDToTypeID("#Pxl"), bottom); // Bottom border in pixels
    rectDesc.putUnitDouble(charIDToTypeID("Rght"), charIDToTypeID("#Pxl"), right); // Right border in pixels
    desc.putObject(charIDToTypeID("T   "), charIDToTypeID("Rctn"), rectDesc);     // As: Rectangle
    executeAction(charIDToTypeID("setd"), desc, DialogModes.NO);                 // Command: Set (selection)
}

// --- ActionManager function to fill current selection with White ---
function fillWhiteAM() {
    var desc = new ActionDescriptor();
    desc.putEnumerated( charIDToTypeID( "Usng" ), charIDToTypeID( "FlCn" ), charIDToTypeID( "Wht " ) ); 
    executeAction( charIDToTypeID( "Fl  " ), desc, DialogModes.NO ); // Command: Fill
}

// --- Core Processing Function for a single document ---
function applyColumnModification(docToProcess) {
    var originalActiveDocument = app.activeDocument;
    if (app.activeDocument !== docToProcess) {
        app.activeDocument = docToProcess;
    }
    var success = false;
    try {
        if (docToProcess.mode !== DocumentMode.GRAYSCALE) {
            return true; 
        }
        if (docToProcess.layers.length === 0 || !docToProcess.activeLayer) {
            return false; 
        }
        var layerToModify = docToProcess.activeLayer;
        if (layerToModify.allLocked || layerToModify.pixelsLocked ||
            (layerToModify.kind !== LayerKind.NORMAL && !layerToModify.isBackgroundLayer) ||
            !layerToModify.visible) {
            return false; 
        }
        var startXcoordinate = 2150; 
        var columnWidth = 200;       
        var docWidthPx = docToProcess.width.as('px');
        var docHeightPx = docToProcess.height.as('px');
        if (startXcoordinate >= docWidthPx || startXcoordinate < 0) {
            return true; 
        }
        var selectionEndX = startXcoordinate + columnWidth;
        if (selectionEndX > docWidthPx) {
            selectionEndX = docWidthPx;
        }
        if (startXcoordinate >= selectionEndX) {
             return true; 
        }
        var selectionY1 = 0;
        var selectionY2 = docHeightPx;
        if (docToProcess.quickMaskMode) {
            docToProcess.quickMaskMode = false;
        }
        try { docToProcess.selection.deselect(); } catch(e) { /* Ignore */ }
        selectRegionAM(startXcoordinate, selectionY1, selectionEndX, selectionY2);
        fillWhiteAM(); 
        docToProcess.selection.deselect(); 
        success = true;
    } catch (e) {
        // $.writeln("Error in applyColumnModification for " + docToProcess.name + ": " + e.message);
        success = false; 
    } finally {
        if (originalActiveDocument && app.activeDocument !== originalActiveDocument) {
            app.activeDocument = originalActiveDocument;
        }
    }
    return success;
}

// --- Main Batch Processing Function ---
function batchProcessImagesAndSaveJPEG() {
    $.global.gScriptCancelled = false; // Reset flag at the start of each run

    var inputFolder = Folder.selectDialog("Select the folder containing images to process");
    if (!inputFolder) {
        alert("No input folder selected. Script will now exit.");
        return;
    }

    var outputFolderName = "OUTPUT_Processed_Images";
    var outputFolder = new Folder(inputFolder.fsName + "/" + outputFolderName);
    if (!outputFolder.exists) {
        if (!outputFolder.create()) {
            alert("Could not create output folder: " + outputFolder.fsName + "\nPlease check permissions. Script will exit.");
            return;
        }
    }

    var fileList = inputFolder.getFiles(function(file) {
        if (file instanceof Folder) return false;
        var fileName = file.name.toLowerCase();
        if (fileName.match(/\.(jpg|jpeg|tif|tiff|psd|png|gif|bmp)$/i)) {
            if (file.parent.name === outputFolderName && file.parent.parent.fsName === inputFolder.fsName) {
                return false;
            }
            return true;
        }
        return false;
    });

    if (fileList.length === 0) {
        alert("No suitable image files found in: " + inputFolder.displayName);
        return;
    }

    // Create a simple palette for cancellation
    var cancelPalette = new Window("palette", "Processing Monitor", undefined, {resizeable:false, closeButton: false});
    cancelPalette.orientation = 'column';
    cancelPalette.alignChildren = ['fill', 'top'];
    var progressText = cancelPalette.add('statictext', [0,0,280,40], 'Initializing...', {multiline:true}); // Width 280, height 40
    
    cancelPalette.onCancel = function() { // Triggered by ESC if palette has focus context
        $.global.gScriptCancelled = true;
        // $.writeln("ESC detected by palette, gScriptCancelled set to true."); // For debugging
        if(cancelPalette.visible) cancelPalette.close();
        return true; // Indicate event was handled
    };
    cancelPalette.show();


    alert(fileList.length + " image(s) found. Processing will start.\nPress ESC to cancel (may take effect after current file).\nProcessed files saved in '" + outputFolderName + "'.");

    var errorFiles = [];       
    var processedCount = 0;    

    var originalDisplayDialogs = app.displayDialogs;
    app.displayDialogs = DialogModes.NO; 

    for (var i = 0; i < fileList.length; i++) {
        // Update progress text on the palette
        if (cancelPalette.visible) {
            progressText.text = "Processing file " + (i + 1) + " of " + fileList.length + ":\n" + decodeURI(fileList[i].name) + "\n(Press ESC to cancel)";
            // cancelPalette.layout.layout(true); // May not be needed if size is fixed
            // cancelPalette.update(); // Force redraw - use sparingly if it slows things down
        }

        // Crucial: Allow Photoshop to process UI events, including ESC for the palette
        app.refresh(); 
        
        // Check for cancellation flag
        if ($.global.gScriptCancelled) {
            // $.writeln("Cancellation detected in loop. Breaking."); // For debugging
            break; 
        }

        var currentFile = fileList[i];
        var docRef = null; 

        try {
            docRef = app.open(currentFile);
            if (!docRef) { 
                errorFiles.push(decodeURI(currentFile.name) + " (Failed to open)");
                continue; 
            }
            var originalDocName = docRef.name;
            var modificationSuccess = applyColumnModification(docRef);
            
            if (!modificationSuccess) {
                errorFiles.push(decodeURI(originalDocName) + " (Core modification failed)");
                docRef.close(SaveOptions.DONOTSAVECHANGES); 
                docRef = null;
                continue; 
            }

            if (docRef.mode !== DocumentMode.RGB && docRef.mode !== DocumentMode.GRAYSCALE) {
                // $.writeln(decodeURI(originalDocName) + " is in " + docRef.mode + " mode. Consider conversion for JPEG.");
            }

            var saveOptions = new JPEGSaveOptions();
            saveOptions.quality = 8;                        
            saveOptions.formatOptions = FormatOptions.PROGRESSIVE; 
            saveOptions.scans = 5;                          
            // saveOptions.embedColorProfile = docRef.colorProfileType !== ColorProfile.NONE;

            var baseName = decodeURI(originalDocName).replace(/\.[^\.]+$/, ''); 
            var saveFile = new File(outputFolder.fsName + "/" + baseName + ".jpg");
            docRef.saveAs(saveFile, saveOptions, true); 
            docRef.close(SaveOptions.DONOTSAVECHANGES);
            docRef = null; 
            processedCount++;

        } catch (e) {
            var errorMsg = (decodeURI(currentFile.name) || "File " + (i+1)) + " - Error: " + e.message;
            if (e.line) errorMsg += " (Line: " + e.line + ")";
            errorFiles.push(errorMsg);
            if (docRef) {
                try { docRef.close(SaveOptions.DONOTSAVECHANGES); } catch (closeError) { /* Ignore */ }
                docRef = null;
            }
        }
    } // End of loop

    // Close the cancellation palette if it's still visible
    if (cancelPalette.visible) {
        cancelPalette.close();
    }

    app.displayDialogs = originalDisplayDialogs;

    var summaryMessage;
    if ($.global.gScriptCancelled) {
        summaryMessage = "Batch processing CANCELLED BY USER after " + processedCount + " file(s) were processed and saved.";
        if (processedCount < fileList.length) {
             summaryMessage += "\n" + (fileList.length - processedCount - errorFiles.length) + " file(s) were not processed due to cancellation.";
        }
    } else {
        summaryMessage = "Batch processing complete.\nSuccessfully processed and saved " + processedCount + " out of " + fileList.length + " files.";
    }
    
    if (errorFiles.length > 0) {
        summaryMessage += "\n\nThe following files/operations encountered errors or were skipped:\n- " + errorFiles.join("\n- ");
    }
    alert(summaryMessage);
    $.global.gScriptCancelled = false; // Reset for any future script runs in the same session
}

// --- Run the main batch processing function ---
batchProcessImagesAndSaveJPEG();
