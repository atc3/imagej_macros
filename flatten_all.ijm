num_images = nImages;

for (i = 0; i < num_images; i++) { 
	selectImage(i+1); 
	title = getTitle();
	path = getDirectory("image");
	print(path);
	
	run("Flatten")
	save(path + title);
}