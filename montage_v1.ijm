Dialog.create("Montage v1");

Dialog.addCheckbox("Process all open images?", false);
Dialog.addCheckbox("Close montage images?", false);

Dialog.addNumber("Columns", 2);
Dialog.addNumber("Rows", 2);
Dialog.addNumber("First Slice", 1);
Dialog.addNumber("Last Slice", 3);

Dialog.addNumber("Scale", 0.5);
Dialog.addNumber("Scale Bar Width", 50);

Dialog.show();
//exit;

//run("Channels Tool...");
//run("Brightness/Contrast...");

process_all = Dialog.getCheckbox();
close_montage = Dialog.getCheckbox();

columns = Dialog.getNumber();
rows = Dialog.getNumber();
first_slice = Dialog.getNumber();
last_slice = Dialog.getNumber();

montage_scale = Dialog.getNumber();
scale_bar_width = Dialog.getNumber();

num_images = 1;
if (process_all) {
	num_images = nImages;
}
for (i = 0; i < num_images; i++) { 
	if (process_all) {
		selectImage(i+1); 
	}
	
	path = getDirectory("image");
	title = getTitle();
	width = getWidth();
	height = getHeight();
	
	
	Property.set("CompositeProjection", "null");
	Stack.setDisplayMode("color");
	
	Stack.setChannel(1);
	run("Blue");
	Stack.setChannel(2);
	run("Green");
	Stack.setChannel(3);
	run("Magenta");
	
	Property.set("CompositeProjection", "null");
	Stack.setDisplayMode("grayscale");
	// run("Save");
	
	run("Make Montage...", "columns=" + toString(floor(columns)) + " rows=" + toString(floor(rows)) + " scale=" + toString(montage_scale) + " first=" + toString(first_slice) + " last=" + toString(last_slice));
	
	selectImage(title);
	Property.set("CompositeProjection", "Sum");
	Stack.setDisplayMode("composite");
	run("RGB Color");
	run("Scale...", "x="+toString(montage_scale)+" y="+toString(montage_scale)+" width="+width+" height="+height+" interpolation=Bilinear average create title=scale");
	scaleWidth = getWidth();
	scaleHeight = getHeight();
	
	selectImage("scale");
	run("Copy");
	
	selectImage("Montage");
	rename(title + "_montage.tif");
	makeRectangle(scaleWidth, scaleHeight, scaleWidth, scaleHeight);
	run("Paste");
	
	scale_bar_thickness = floor((scaleHeight*2)/200);
	scale_bar_font_size = floor(scale_bar_thickness * 3);
	
	run("Scale Bar...", "width=" + toString(scale_bar_width) + " height=" + scale_bar_width + " thickness=" + toString(scale_bar_thickness) + " font=" + scale_bar_font_size + " overlay");
	
	save(path + title + "_montage.tif");
	// close();
	selectImage("scale");
	close();
	selectImage(title + " (RGB)");
	close();
	
	if (close_montage) {
		selectImage("Montage");
		close();
	}
}

