imageFolder = "/Users/atchen/Library/CloudStorage/GoogleDrive-albert_chen@g.harvard.edu/My Drive/Gu Lab Rotation/230302_DN+tracer"
fname = "230302_DN+tracer_M2_brain_40x_1"
for (ch = 0; ch < 3; ch += 1) {
	for(z = 0; z < 3; z += 1) {
		run("Grid/Collection stitching", "type=[Grid: row-by-row] order=[Right & Down                ] grid_size_x=3 grid_size_y=3 tile_overlap=20 first_file_index_i=0 directory=[/Users/atchen/Library/CloudStorage/GoogleDrive-albert_chen@g.harvard.edu/My Drive/Gu Lab Rotation/230302_DN+tracer] file_names=" + fname + "_s{i}_z" + toString(z) + "_ch0" + toString(ch) + ".tif output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=0.30 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 compute_overlap computation_parameters=[Save memory (but be slower)] image_output=[Fuse and display]");
		selectWindow("Fused");
		saveAs("Tiff", imageFolder + "/" + fname + "_z" + toString(z) + "_ch0" + toString(ch) + ".tif");
		close();
	}
}

