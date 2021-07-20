// Inputs
originalName = getInfo("image.filename");

path = getInfo("image.directory");

//path = "C:\\Users\\Anna\\Downloads"

print("Working on " + originalName);
print(path);

// Output name
parts = split(originalName, " ");

newBaseName = parts[0]; // AM007KD

for (i=0; i < lengthOf(parts); i++) {
	
	if (indexOf(parts[i], "Convidat") >= 0) {
		parts2 = split(parts[i], "_");
		part2 = parts2[1];
		newBaseName = newBaseName + "_" + part2; // AM007KD_13.55.07
	}
}
	

print("New name will be XXX_&newBaseName");

// Rename image window for easier handling
rename(newBaseName);


run("Split Channels");
selectWindow("C2-" + newBaseName);
run("Z Project...", "projection=[Max Intensity]");
selectWindow("C3-" + newBaseName);
run("Z Project...", "projection=[Max Intensity]");
selectWindow("C1-" + newBaseName);
run("Z Project...", "projection=[Max Intensity]");

c1pic = "MAX_C1-" + newBaseName;
c2pic = "MAX_C2-" + newBaseName;
c3pic = "MAX_C3-" + newBaseName;


//Red
run("Brightness/Contrast...");  // open Brightness/Contrast tool
selectWindow(c3pic);
title = "Set Brightness/Contrast Red";
msg = "Set Brightness/Contrast\nDo not click Apply \n \"OK\".";
waitForUser(title, msg);


//Green
run("Brightness/Contrast...");  // open Brightness/Contrast tool
selectWindow(c2pic);
title = "Set Brightness/Contrast Green";
msg = "Set Brightness/Contrast\nDo not click Apply \n \"OK\".";
waitForUser(title, msg);

//Blue
run("Brightness/Contrast...");  // open Brightness/Contrast tool
selectWindow(c1pic);
title = "Set Brightness/Contrast Blue";
msg = "Set Brightness/Contrast\nDo not click Apply \n \"OK\".";
waitForUser(title, msg);


run("Merge Channels...", "c1=&c3pic c2=&c2pic c3=&c1pic create keep");
run("RGB Color");
name_merge = "MAX_MERGE_" + newBaseName + ".tif";
save(path + "\\" +name_merge);

selectWindow(c1pic);
run("RGB Color");
name_b = "MAX_B_" + newBaseName + ".tif";
save(path + "\\" +name_b);

selectWindow(c2pic);
run("RGB Color");
name_g = "MAX_G_" + newBaseName + ".tif";
save(path + "\\" +name_g);


selectWindow(c3pic);
run("RGB Color");
name_r = "MAX_R_" + newBaseName + ".tif";
save(path + "/" +name_r);

if (isOpen("Log")) {
     selectWindow("Log");
     run("Close" );
}

while (nImages>0) {
  selectImage(nImages);
  close();
} 



