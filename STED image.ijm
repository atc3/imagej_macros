// @ String (label="filename") fname

list = getList("image.titles");
for (i = list.length-1; i >= 0; i--) {
	print(list[i]);
}


selectWindow(list[list.length-1]);
//selectWindow("C:/Users/bert/AppData/Local/Temp/Abberior Instruments GmbH/Lightbox/2023-03-16/~23-41-02.obf - " + fname + "-Alexa 594 STED");
rename("Alexa 594 STED");

selectWindow(list[list.length-2]);
//selectWindow("C:/Users/bert/AppData/Local/Temp/Abberior Instruments GmbH/Lightbox/2023-03-16/~23-41-02.obf - " + fname + "-Alexa 594");
rename("Alexa 594");

selectWindow(list[list.length-3]);
//selectWindow("C:/Users/bert/AppData/Local/Temp/Abberior Instruments GmbH/Lightbox/2023-03-16/~23-41-02.obf - " + fname + "-STAR RED STED");
rename("STAR RED STED");

selectWindow(list[list.length-4]);
//selectWindow("C:/Users/bert/AppData/Local/Temp/Abberior Instruments GmbH/Lightbox/2023-03-16/~23-41-02.obf - " + fname + "-STAR RED");
rename("STAR RED");

run("Images to Stack", "use");
run("Stack to Hyperstack...", "order=xyczt(default) channels=4 slices=1 frames=1 display=Color");
//run("Brightness/Contrast...");
run("Red");
run("Enhance Contrast", "saturated=0.35");
run("Next Slice [>]");
run("Red");
run("Enhance Contrast", "saturated=0.35");
run("Next Slice [>]");
run("Green");
run("Enhance Contrast", "saturated=0.35");
run("Next Slice [>]");
run("Green");
run("Enhance Contrast", "saturated=0.35");
saveAs("Tiff", "G:/My Drive/Gu Lab Rotation/230208_STED_Ly6a-Cav1/" + fname + ".tif");
