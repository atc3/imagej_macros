


//for(i=0; i < inputImages.length; i++) {
//	open(inputImages[i]);
//}

imageFolder = "/Users/atchen/Library/CloudStorage/GoogleDrive-albert_chen@g.harvard.edu/My Drive/Gu Lab Rotation/230314_anti-Ly6a_10x"
prefix = "230314_anti-Ly6a_10x_"
files = newArray(
	"M1_cbx", "M1_ctx", "M1_hpf", "M1_mid", 
	"M2_ctx", "M2_hpf", "M2_mid",
	"M3_cbx", "M3_ctx", "M3_hpf", "M3_mid",
	"M4_cbx", "M4_ctx", "M4_hpf", "M4_mid",
	"M5_cbx", "M5_ctx", "M5_hpf", "M5_mid",
	"M6_cbx", "M6_ctx", "M6_hpf", "M6_mid")

for(k = 0; k < files.length; k++) {
	fname = prefix + files[k];
	inputImages = newArray(3);
	for(ch=0; ch < 3; ch++) {
		inputImages[ch] = imageFolder + "/" + fname + "_ch0" + toString(ch) + ".tif";
	}
	//for (z = 0; z < 3; z++) {
		//for(ch = 0; ch < 4; ch++) {
		//}
	//}
	
	for(i=0; i < inputImages.length; i++) {
		print(inputImages[i]);
		open(inputImages[i]);
	}
	
	run("Images to Stack", "use");
	run("8-bit");
	run("Stack to Hyperstack...", "order=xyczt(default) channels=3 slices=1 frames=1 display=Composite");
	Property.set("CompositeProjection", "null");
	Stack.setDisplayMode("color");
	Stack.setChannel(1);
	run("Blue");
	run("Enhance Contrast", "saturated=0.35");
	Stack.setChannel(2);
	run("Green");
	run("Enhance Contrast", "saturated=0.35");
	Stack.setChannel(3);
	//run("Yellow");
	//run("Enhance Contrast", "saturated=0.35");
	//Stack.setChannel(4);
	run("Magenta");
	run("Enhance Contrast", "saturated=0.35");
	saveAs("Tiff", imageFolder + "/" + fname + ".tif");
	//run("Z Project...", "projection=[Average Intensity]");
	//saveAs("Tiff", imageFolder + "/" + fname + "_avg.tif");
	//close();
	close();
}


