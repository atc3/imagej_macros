Dialog.create("Montage v1");

Dialog.addCheckbox("Save initial image", false);
Dialog.addCheckbox("Close initial image", false);
Dialog.addCheckbox("Process all open images?", false);
Dialog.addCheckbox("Close montage images?", false);
Dialog.addCheckbox("Flatten?", false);
Dialog.addString("Output path", "image (default)");

Dialog.addNumber("Columns", 2);
Dialog.addNumber("Rows", 2);
Dialog.addNumber("First Slice", 1);
Dialog.addNumber("Last Slice", 3);
Dialog.addNumber("Increment", 1);

Dialog.addNumber("Scale", 0.5);
Dialog.addNumber("Scale Bar Width", 50);
Dialog.addNumber("Font Scaling Factor", 3);

luts = getList("LUTs");
Dialog.addChoice("Channel 1 LUT", luts, "Blue");
Dialog.addChoice("Channel 2 LUT", luts, "Green");
Dialog.addChoice("Channel 3 LUT", luts, "Magenta");
Dialog.addChoice("Channel 4 LUT", luts, "Cyan");

Dialog.show();
//exit;

//run("Channels Tool...");
//run("Brightness/Contrast...");

save_initial = Dialog.getCheckbox();
close_initial = Dialog.getCheckbox();
process_all = Dialog.getCheckbox();
close_montage = Dialog.getCheckbox();
do_flatten = Dialog.getCheckbox();
output_path = Dialog.getString();

columns = Dialog.getNumber();
rows = Dialog.getNumber();
first_slice = Dialog.getNumber();
last_slice = Dialog.getNumber();
increment = Dialog.getNumber();

montage_scale = Dialog.getNumber();
scale_bar_width = Dialog.getNumber();
font_scale_factor = Dialog.getNumber();

lut_1 = Dialog.getChoice();
lut_2 = Dialog.getChoice();
lut_3 = Dialog.getChoice();
lut_4 = Dialog.getChoice();

num_images = 1;
if (process_all) {
	num_images = nImages;
}
for (i = 0; i < num_images; i++) { 
	if (process_all) {
		selectImage(i+1); 
	}
	
	Property.set("CompositeProjection", "Sum");
	Stack.setDisplayMode("composite");
	
	path = getDirectory("image");
	if (output_path != "image (default)") {
		path = output_path;
	}
	
	title = getTitle();
	Stack.getDimensions(width, height, channels, slices, frames) 
	// rename("original");
	
	// Crunch into just one slice (the current slice)
	Stack.getPosition(channel, slice, frame);
	if (slices > 1) {
		run("Duplicate...", "title=dupe duplicate slices=" + toString(slice));	
	} else {
		run("Duplicate...", "title=dupe duplicate");	
	}
	selectImage("dupe");
	
	title = replace(title, "/", "-");
	// rename(title);
	
	Property.set("CompositeProjection", "null");
	Stack.setDisplayMode("color");
	
	luts = newArray(lut_1, lut_2, lut_3, lut_4);
	for (j = 0; j < channels; j++) {
		Stack.setChannel(j+1);
		run(luts[j]);
	}
	
	Property.set("CompositeProjection", "null");
	Stack.setDisplayMode("grayscale");
	
	if (save_initial) {
		selectImage(title);
		save(path + title + ".tif");
		selectImage("dupe");
	}
	
	run("Make Montage...", "columns=" + toString(floor(columns)) + " rows=" + toString(floor(rows)) + " scale=" + toString(montage_scale) + " first=" + toString(first_slice) + " last=" + toString(last_slice) + " increment=" + toString(increment));
	wait(200);
	
	selectImage("dupe");
	
	Property.set("CompositeProjection", "Sum");
	Stack.setDisplayMode("composite");
	run("RGB Color", "keep");
	rename("RGB");
	run("Scale...", "x="+toString(montage_scale)+" y="+toString(montage_scale)+" width="+width+" height="+height+" interpolation=Bilinear average create title=scale");
	scaleWidth = getWidth();
	scaleHeight = getHeight();
	
	selectImage("scale");
	run("Copy");
	
	selectImage("Montage");
	rename(title + "_montage.tif");
	makeRectangle(scaleWidth*(columns-1), scaleHeight*(rows-1), scaleWidth, scaleHeight);
	run("Paste");
	
	scale_bar_thickness = floor((scaleHeight*2)/200);
	scale_bar_font_size = floor(scale_bar_thickness * font_scale_factor);
	
	run("Scale Bar...", "width=" + toString(scale_bar_width) + " height=" + scale_bar_width + " thickness=" + toString(scale_bar_thickness) + " font=" + scale_bar_font_size + " overlay");
	
	if (do_flatten) {
		rename("pre_flatten");
		run("Flatten");	
		rename(title + "_montage.tif");
		selectImage("pre_flatten");
		close();
		selectImage(title + "_montage.tif");
	}
	
	
	save(path + title + "_montage.tif");
	selectImage("scale");
	close();
	selectImage("RGB");
	close();
	selectImage("dupe");
	close();	
	
	if (close_montage) {
		selectImage(title + "_montage.tif");
		close();
	}
	
}

if (close_initial) {
	if (process_all) {
		for (i = num_images; i > 0; i--) { 
			selectImage(i); 
			close();
		}
	} else {
		selectImage(title);
		close();	
	}
}

