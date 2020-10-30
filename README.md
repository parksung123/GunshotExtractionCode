# Extracting Gunshot Audio Data using MATLAB
# Introduction
There are many gunshot audio files that are being used to calculate the position of the enemy sniper. This calculation requires TDOA (time difference of arrival), which computes using the audio files to get accurate result. If, however, the audio files are extremely large, then the computation gets slow. For instance, a recording might be a minute long but the actual gunshot could just be 2 seconds. In this particular example, only 0.03% of the entire audio data is actually useful. **To avoid this inefficiency, I wrote a program that could extract just the essential parts of the gunshot: the shockwave and its trailing muzzle blast.**

# Project Description
In this project, I wrote a MATALB program that reads large audio files which contains multiple gunshots, automatically parse each gunshot, and extract the essential bits in one text file for each gunshot. I've added three different methods to extract them: 1) cross-correlation method, 2) specifying left and right padding w.r.t the position of the shockwave, and 3) manually picking the start and end points of the gunshot portion.    

# Personal Context
This was a project done while I interned at Jain Technology in South Korea. One of the many things they specialize in is the research and development of military systems. Since this code parses gunshots individually and saves them into txt files, I utilized this project for my other personal project, [Bullet Classification](https://github.com/parksung123/BulletClassification). 

# Help and References
I received help from many MATLAB Q&As. 
