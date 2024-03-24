Dialog.create("Montage v1");
Dialog.addString("Output path", "image (default)");
Dialog.addCheckbox("Close images?", true);
Dialog.show();

output_path = Dialog.getString();
close_images = Dialog.getCheckbox();

num_images = nImages;

for (i = 0; i < num_images; i++) { 
	selectImage(i+1); 
	title = getTitle();
	title = replace(title, "/", "-");
	save(output_path + title + ".tif");
}

if (close_images) {
	for (i = num_images; i > 0; i--) { 
		selectImage(i); 
		close();
	}
}
