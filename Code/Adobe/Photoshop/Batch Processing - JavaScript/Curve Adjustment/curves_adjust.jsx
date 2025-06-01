////////////////////////////////////////////////////////////////////////
// curves_adjust.jsx
//
// Photoshop CS6 ExtendScript that supports two modes:
//   1) If an image is open, prompts user to choose:
//        * Single-Image Mode: Apply transformations to the active image.
//        * Batch Mode: Process all images in a chosen folder.
//   2) In Single-Image Mode:
//        a. Runs adjustImage() on the active document.
//        b. Reports completion via alert.
//   3) In Batch Mode:
//        a. Prompts for a SOURCE folder.
//        b. Creates or truncates a log file named "<source_folder_name>.log"
//           in the parent of SOURCE.
//        c. Prompts for an OUTPUT folder (starting at SOURCE parent).
//        d. For each *.jpg, *.jpeg, *.tif, *.png in SOURCE:
//             i.  Checks if Escape pressed to abort.
//             ii. Opens the file.
//             iii.Calls adjustImage(doc).
//             iv. Saves as a progressive JPEG (5 scans, Quality=8) in OUTPUT,
//                 overwriting any existing file.
//             v.  Closes the document.
//             vi. Logs messages to the log file.
//        e. Skips non-8bit RGB files with a log entry.
//        f. Aborts on critical errors or when Escape is pressed.
//   4) Shared function adjustImage(doc): samples two 3x3 blocks,
//      chooses darker luminance as white point, applies Levels,
//      converts to 8bit Grayscale, applies autoLevels, and preserves resolution.
//   5) Uses only ASCII characters in comments and code.
//   6) Minimizes user interaction: only folder prompts and single confirm.
//
// Usage:
//   1. Open ExtendScript Toolkit (or any text editor).
//   2. Create a new file and paste this entire code into it.
//   3. Save it as "processOrActiveWithAutoLevels_refactored.jsx".
//   4. In ExtendScript Toolkit, set the target to "Adobe Photoshop CS6".
//   5. Press > (Play) to run.
//   6. If an image is open, you will be asked: "Click OK to process the active image, or Cancel to run batch on a folder."
//      * OK = Single-Image Mode.
//      * Cancel = Batch Mode.
//   7. Follow the folder prompts in Batch Mode. Check the log file next to SOURCE afterward.
//
// IMPORTANT: All input images (batch mode) must be 8bit RGB. Otherwise they are skipped with a log entry.
//
//----------------------------------------------------------------------------

#target photoshop
app.bringToFront();

// Suppress all Photoshop dialogs (profile mismatch, save options, etc.)
app.displayDialogs = DialogModes.NO;

// Check if a document is open
if (app.documents.length > 0) {
  // Ask user: OK = single image, Cancel = batch
  var singleMode = confirm(
    "A document is open.\n" +
    "Click OK to process the active image,\n" +
    "or Cancel to run batch on a folder."
  );
  if (singleMode) {
    processActiveImage();
  } else {
    processFolderBatch();
  }
} else {
  // No open document, go directly to batch
  processFolderBatch();
}

//----------------------------------------------------------------------------
// Function: adjustImage
// Applies sampling, levels, grayscale, autoLevels, and preserves resolution.
//----------------------------------------------------------------------------

function adjustImage(doc, logFile) {
  // Verify mode: must be RGB and 8bit
  if (doc.mode !== DocumentMode.RGB || doc.bitsPerChannel !== BitsPerChannelType.EIGHT) {
    if (logFile) {
      logFile.writeln("  Skipped (not 8bit RGB).");
    }
    return false;
  }

  // Record original resolution
  var origRes = doc.resolution;

  // Dimensions in pixels
  var widthPx  = doc.width.as("px");
  var heightPx = doc.height.as("px");

  // --- Sample first 3x3 block around (100,100) ---
  var centerX1 = 100;
  var centerY1 = 100;
  var sumR1 = 0, sumG1 = 0, sumB1 = 0, count1 = 0;
  for (var dx1 = -1; dx1 <= 1; dx1++) {
    for (var dy1 = -1; dy1 <= 1; dy1++) {
      var x1 = centerX1 + dx1;
      var y1 = centerY1 + dy1;
      // Clamp to image bounds
      if (x1 < 0) x1 = 0;
      if (x1 > widthPx  - 1) x1 = widthPx  - 1;
      if (y1 < 0) y1 = 0;
      if (y1 > heightPx - 1) y1 = heightPx - 1;
      var pt1 = [ UnitValue(x1, "px"), UnitValue(y1, "px") ];
      var cs1 = doc.colorSamplers.add(pt1);
      var c1 = cs1.color.rgb;
      sumR1 += c1.red;
      sumG1 += c1.green;
      sumB1 += c1.blue;
      count1++;
      cs1.remove();
    }
  }
  var avgR1 = sumR1 / count1;
  var avgG1 = sumG1 / count1;
  var avgB1 = sumB1 / count1;
  var avgLum1 = (avgR1 + avgG1 + avgB1) / 3;
  if (avgLum1 < 1)   avgLum1 = 1;
  if (avgLum1 > 254) avgLum1 = 254;

  // --- Sample second 3x3 block around (widthPx-100, heightPx-100) ---
  var centerX2 = widthPx  - 100;
  var centerY2 = heightPx - 100;
  var sumR2 = 0, sumG2 = 0, sumB2 = 0, count2 = 0;
  for (var dx2 = -1; dx2 <= 1; dx2++) {
    for (var dy2 = -1; dy2 <= 1; dy2++) {
      var x2 = centerX2 + dx2;
      var y2 = centerY2 + dy2;
      // Clamp to image bounds
      if (x2 < 0) x2 = 0;
      if (x2 > widthPx  - 1) x2 = widthPx  - 1;
      if (y2 < 0) y2 = 0;
      if (y2 > heightPx - 1) y2 = heightPx - 1;
      var pt2 = [ UnitValue(x2, "px"), UnitValue(y2, "px") ];
      var cs2 = doc.colorSamplers.add(pt2);
      var c2 = cs2.color.rgb;
      sumR2 += c2.red;
      sumG2 += c2.green;
      sumB2 += c2.blue;
      count2++;
      cs2.remove();
    }
  }
  var avgR2 = sumR2 / count2;
  var avgG2 = sumG2 / count2;
  var avgB2 = sumB2 / count2;
  var avgLum2 = (avgR2 + avgG2 + avgB2) / 3;
  if (avgLum2 < 1)   avgLum2 = 1;
  if (avgLum2 > 254) avgLum2 = 254;

  if (logFile) {
    logFile.writeln("  avgLum1 (top-left sample)     : " + Math.round(avgLum1));
    logFile.writeln("  avgLum2 (bottom-right sample) : " + Math.round(avgLum2));
  }

  // Choose darker luminance as white point
  var chosenLum = (avgLum1 < avgLum2) ? avgLum1 : avgLum2;
  if (logFile) {
    logFile.writeln("  Chosen luminance for white point: " + Math.round(chosenLum));
  }

  // Apply Levels(inBlack=0, inputWhite=chosenLum, gamma=1.0, outBlack=0, outWhite=255)
  doc.activeLayer.adjustLevels(
    0,
    Math.round(chosenLum),
    1.0,
    0,
    255
  );

  // Convert to 8bit Grayscale
  doc.changeMode(ChangeMode.GRAYSCALE);

  // Apply Auto Levels to active layer
  try {
    doc.activeLayer.autoLevels();
    if (logFile) {
      logFile.writeln("  Auto Levels applied successfully.");
    }
  } catch (e) {
    if (logFile) {
      logFile.writeln("  Warning: Auto Levels failed: " + e.message);
    }
  }

  // Restore resolution without resampling
  doc.resizeImage(undefined, undefined, origRes, ResampleMethod.NONE);

  return true;
}

//----------------------------------------------------------------------------
// Function: processActiveImage
// Applies adjustImage() to the active document.
//----------------------------------------------------------------------------

function processActiveImage() {
  try {
    var doc = app.activeDocument;
    var success = adjustImage(doc, null);
    if (success) {
      alert(
        "Single-image processing complete.\n" +
        "Please save your document manually if desired."
      );
    }
  } catch (err) {
    alert("Fatal error in single-image mode:\n" + err.message);
  }
}

//----------------------------------------------------------------------------
// Function: processFolderBatch
// Processes all images in a folder, logs actions, supports Escape abort.
//----------------------------------------------------------------------------

function processFolderBatch() {
  // 1) Prompt user to pick the SOURCE folder
  var sourceFolder = Folder.selectDialog("Select the SOURCE folder of images to process");
  if (sourceFolder === null) {
    // User cancelled; abort without creating log
    return;
  }

  // Determine parent of the SOURCE folder
  var parentFolder = sourceFolder.parent;
  if (parentFolder === null) {
    alert("Cannot determine parent folder of the source. Aborting.");
    return;
  }

  // 2) Create or truncate the log file named "<source_folder_name>.log" in parentFolder
  var logFileName = sourceFolder.name + ".log";
  var logFile = new File(parentFolder.fsName + "/" + logFileName);
  if (logFile.exists) {
    logFile.remove();
  }
  if (!logFile.open("w")) {
    alert("Cannot open log file for writing:\n" + logFile.fsName);
    return;
  }

  // Write header to log
  var now = new Date();
  logFile.writeln("Log for folder: " + sourceFolder.fsName);
  logFile.writeln("Date: " + now.toString());
  logFile.writeln("------------------------------------------------------------");

  // 3) Prompt user to pick the OUTPUT folder, initializing at parentFolder
  var outputFolder = Folder.selectDialog(
    "Select the OUTPUT folder (will contain processed JPEGs)",
    parentFolder
  );
  if (outputFolder === null) {
    logFile.writeln("User cancelled at OUTPUT folder prompt. Aborting.");
    logFile.close();
    return;
  }

  logFile.writeln("Source folder: " + sourceFolder.fsName);
  logFile.writeln("Output folder: " + outputFolder.fsName);
  logFile.writeln("");

  // 4) Build a list of files in the SOURCE folder matching *.jpg, *.jpeg, *.tif, *.png
  var allFiles = sourceFolder.getFiles(function(f) {
    if (f instanceof File) {
      var name = f.name.toLowerCase();
      return (
        name.match(/\.jpe?g$/i)   ||   // .jpg or .jpeg
        name.match(/\.tif(f)?$/i) ||   // .tif or .tiff
        name.match(/\.png$/i)          // .png
      );
    }
    return false;
  });

  if (allFiles.length === 0) {
    logFile.writeln("No supported image files (.jpg, .jpeg, .png, .tif, .tiff) found in:");
    logFile.writeln("  " + sourceFolder.fsName);
    logFile.close();
    return;
  }

  logFile.writeln("Found " + allFiles.length + " image file(s) to process.");
  logFile.writeln("");

  // 5) Loop through each file
  var processedCount = 0;
  for (var i = 0; i < allFiles.length; i++) {
    // Check if Escape has been pressed to abort
    if (
      ScriptUI &&
      ScriptUI.environment &&
      ScriptUI.environment.keyboardState &&
      ScriptUI.environment.keyboardState.keyName === "Escape"
    ) {
      logFile.writeln("Interrupted by user via Escape key. Aborting batch.");
      break;
    }

    var inputFile = allFiles[i];
    var doc = null;
    try {
      logFile.writeln("Processing: " + inputFile.name);

      // a) Open the file
      doc = open(inputFile);

      // b) Apply transformations
      var success = adjustImage(doc, logFile);
      if (!success) {
        doc.close(SaveOptions.DONOTSAVECHANGES);
        logFile.writeln("");
        continue;
      }

      // c) Build the output filename: original base name + "_gray.jpg"
      var baseName = inputFile.name.replace(/\.[^\.]+$/, "");
      var outFile = new File(outputFolder.fsName + "/" + baseName + "_gray.jpg");

      // d) Set JPEG save options: progressive, 5 scans, Quality = 8
      var jpgSaveOpts = new JPEGSaveOptions();
      jpgSaveOpts.embedColorProfile = true;
      jpgSaveOpts.formatOptions = FormatOptions.PROGRESSIVE;
      jpgSaveOpts.scans = 5;             // progressive JPEG with 5 scans
      jpgSaveOpts.matte = MatteType.NONE;
      jpgSaveOpts.quality = 8;           // quality level 8 (0-12 scale)

      // e) Save as JPEG, overwriting any existing file
      if (outFile.exists) {
        outFile.remove();
      }
      doc.saveAs(outFile, jpgSaveOpts, true /*asCopy*/, Extension.LOWERCASE);
      doc.close(SaveOptions.DONOTSAVECHANGES);

      logFile.writeln("  Saved: " + outFile.name);
      logFile.writeln("");
      processedCount++;

    } catch (e) {
      logFile.writeln("  ERROR: " + e.message);
      try {
        if (doc !== null && app.documents.length && app.activeDocument === doc) {
          doc.close(SaveOptions.DONOTSAVECHANGES);
        }
      } catch (_) {
        // ignore further errors
      }
      logFile.writeln("");
      // Continue with next file
    }
  }

  // 6) Write summary to log
  logFile.writeln("------------------------------------------------------------");
  logFile.writeln("Finished processing.");
  logFile.writeln("Total files found    : " + allFiles.length);
  logFile.writeln("Total files processed: " + processedCount);
  logFile.close();
}
