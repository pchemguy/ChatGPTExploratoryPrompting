////////////////////////////////////////////////////////////////////////
// curves_adjust.jsx
//
// Photoshop CS6 ExtendScript that:
//   1) Prompts for a SOURCE folder of images.
//   2) Creates (or truncates) a log file named "<source_folder_name>.log"
//      in the parent of the SOURCE folder.
//   3) Prompts for an OUTPUT folder, initializing the dialog to the parent
//      of the SOURCE folder.
//   4) For each file in the SOURCE folder matching (*.jpg, *.jpeg, *.tif, *.png):
//        a. Checks if the user pressed Escape to abort.
//        b. Opens the file.
//        c. Samples a 3x3 pixel block centered at (100,100).
//        d. Samples a second 3x3 block centered at (doc.width-100, doc.height-100)
//           (i.e. 100px left and 100px up from bottom-right).
//        e. Computes average R,G,B for each block -> average luminance.
//        f. Chooses the darker (smaller) luminance as new white point.
//        g. Applies Levels so that chosen avgLum -> white (255).
//        h. Converts the document to 8-bit Grayscale.
//        i. Ensures output resolution equals source resolution (no resampling).
//        j. Saves as a PROGRESSIVE JPEG with 5 scans and Quality = 8
//           into the OUTPUT folder, overwriting any existing file.
//        k. Closes the document without further prompts.
//   5) Writes all non-critical messages to the log file. Uses no dialogs
//      except for the folder-pick prompts. Critical errors abort the script.
//
// Press Escape at any time during processing to interrupt the batch.
//
// Usage:
//   1. Open ExtendScript Toolkit (or any text editor).
//   2. Create a new file and paste this entire code into it.
//   3. Save it as "processFolder_interruptible_fixed.jsx".
//   4. In ExtendScript Toolkit, set the target to "Adobe Photoshop CS6".
//   5. Press > (Play) to run.
//   6. When prompted, pick your SOURCE folder, then your OUTPUT folder.
//   7. Check the log file in the parent of SOURCE for details.
//
// IMPORTANT: All input images must be 8-bit RGB. Otherwise they are skipped
// and a message is written to the log.
//
////////////////////////////////////////////////////////////////////////

#target photoshop
app.bringToFront();

// Suppress all Photoshop dialogs (profile mismatch, save options, etc.)
app.displayDialogs = DialogModes.NO;

function processFolderInterruptible() {
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

      // b) Verify mode: must be RGB and 8-bit
      if (doc.mode !== DocumentMode.RGB || doc.bitsPerChannel !== BitsPerChannelType.EIGHT) {
        logFile.writeln("  Skipped (not 8-bit RGB).");
        doc.close(SaveOptions.DONOTSAVECHANGES);
        logFile.writeln("");
        continue;
      }

      // c) Sample first 3x3 block around (100,100)
      var centerX1 = 100;
      var centerY1 = 100;
      var sumR1 = 0, sumG1 = 0, sumB1 = 0, count1 = 0;
      var widthPx1  = doc.width.as("px");
      var heightPx1 = doc.height.as("px");
      for (var dx1 = -1; dx1 <= 1; dx1++) {
        for (var dy1 = -1; dy1 <= 1; dy1++) {
          var x1 = centerX1 + dx1;
          var y1 = centerY1 + dy1;
          // Clamp to image bounds
          if (x1 < 0) x1 = 0;
          if (x1 > widthPx1  - 1) x1 = widthPx1  - 1;
          if (y1 < 0) y1 = 0;
          if (y1 > heightPx1 - 1) y1 = heightPx1 - 1;
          var pt1 = [
            UnitValue(x1, "px"),
            UnitValue(y1, "px")
          ];
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

      // d) Sample second 3x3 block around (doc.width-100, doc.height-100)
      var widthPx  = doc.width.as("px");
      var heightPx = doc.height.as("px");
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
          var pt2 = [
            UnitValue(x2, "px"),
            UnitValue(y2, "px")
          ];
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

      // e) Clamp both avgLum values to [1,254]
      if (avgLum1 < 1)   avgLum1 = 1;
      if (avgLum1 > 254) avgLum1 = 254;
      if (avgLum2 < 1)   avgLum2 = 1;
      if (avgLum2 > 254) avgLum2 = 254;

      logFile.writeln("  avgLum1 (top-left sample)     : " + Math.round(avgLum1));
      logFile.writeln("  avgLum2 (bottom-right sample) : " + Math.round(avgLum2));

      // f) Choose the darker luminance (smaller value) as new white point
      var chosenLum = (avgLum1 < avgLum2) ? avgLum1 : avgLum2;
      logFile.writeln("  Chosen luminance for white point: " + Math.round(chosenLum));

      // g) Apply Levels(inBlack=0, inputWhite=chosenLum, gamma=1.0, outBlack=0, outWhite=255)
      doc.activeLayer.adjustLevels(
        0,                      // inputBlack
        Math.round(chosenLum),  // inputWhite
        1.0,                    // gamma
        0,                      // outputBlack
        255                     // outputWhite
      );

      // h) Convert to 8-bit Grayscale
      doc.changeMode(ChangeMode.GRAYSCALE);

      // i) Ensure output image resolution equals source resolution (no resampling)
      var origRes = doc.resolution;
      doc.resizeImage(undefined, undefined, origRes, ResampleMethod.NONE);

      // j) Build the output filename: original base name + "_gray.jpg"
      var baseName = inputFile.name.replace(/\.[^\.]+$/, "");
      var outFile = new File(outputFolder.fsName + "/" + baseName + "_gray.jpg");

      // k) Set JPEG save options: progressive, 5 scans, Quality = 8
      var jpgSaveOpts = new JPEGSaveOptions();
      jpgSaveOpts.embedColorProfile = true;
      jpgSaveOpts.formatOptions = FormatOptions.PROGRESSIVE;
      jpgSaveOpts.scans = 5;             // progressive JPEG with 5 scans
      jpgSaveOpts.matte = MatteType.NONE;
      jpgSaveOpts.quality = 8;           // quality level 8 (0-12 scale)

      // l) Save as JPEG, overwriting any existing file
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

// Run the folder-processing function
try {
  processFolderInterruptible();
} catch (err) {
  alert("Fatal error in script:\n" + err.message);
}
