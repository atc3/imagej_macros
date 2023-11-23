//@ File[] inputImages (label="select files or folders", style="both")
//@ String (label="filename") fname
//@ File (label="Select a directory", style="directory") imageFolder


for(i=0; i < inputImages.length; i++) {
	open(inputImages[i]);
}

run("Images to Stack", "use");
run("8-bit");
run("Stack to Hyperstack...", "order=xyczt(default) channels=4 slices=5 frames=1 display=Composite");
Property.set("CompositeProjection", "null");
Stack.setDisplayMode("color");
Stack.setChannel(1);
run("Blue");
run("Enhance Contrast", "saturated=0.35");
Stack.setChannel(2);
run("Green");
run("Enhance Contrast", "saturated=0.35");
Stack.setChannel(3);
run("Yellow");
run("Enhance Contrast", "saturated=0.35");
Stack.setChannel(4);
run("Magenta");
run("Enhance Contrast", "saturated=0.35");
saveAs("Tiff", imageFolder + "/" + fname + ".tif");
run("Z Project...", "projection=[Average Intensity]");
saveAs("Tiff", imageFolder + "/" + fname + "_avg.tif");
