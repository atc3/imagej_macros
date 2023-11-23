


//for(i=0; i < inputImages.length; i++) {
//	open(inputImages[i]);
//}

imageFolder = "/Users/atchen/Library/CloudStorage/GoogleDrive-albert_chen@g.harvard.edu/My Drive/Gu Lab Rotation/230302_DN+tracer"
//prefix = "230302_DN+tracer_M2_brain_40x_1_s0_z0_ch00.tif"
prefix = "230302_DN+tracer_M2_brain_40x_2";

for(s = 0; s < 9; s++) {
	fname = prefix + "_s" + toString(s);
	inputImages = newArray(12);
	for (z = 0; z < 3; z++) {
		for(ch = 0; ch < 4; ch++) {
			inputImages[(z*4)+ch] = imageFolder + "/" + fname + "_z" + toString(z) + "_ch0" + toString(ch) + ".tif";
		}
	}
	
	for(i=0; i < inputImages.length; i++) {
		print(inputImages[i]);
	}
	
	for(i=0; i < inputImages.length; i++) {
		open(inputImages[i]);
	}
	
	run("Images to Stack", "use");
	run("8-bit");
	run("Stack to Hyperstack...", "order=xyczt(default) channels=4 slices=3 frames=1 display=Composite");
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
	close();
	close();
}


