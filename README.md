# AdvancedUnixTutorial
## Rob Schmidt
Tutorial for workshop given on 3/20/21

This is the second in a series of tutorials for the Bioinformatics and Computational Biology workshop series on Unix. In this tutorial we will cover some more advanced Unix topics and run through a quick RNA Seq alignment and count using real (but reduced) data. 

# Let's get started: Why do we even want to learn about Unix?
Linux/Unix has become the standard operating system for high performance computing clusters (HPCs) all around the globe. If you want the power of an HPC you need to learn the fundamentals of Unix. Plus almost all of the most popular bioinformatics tools are used on the commandline. Trust me it may look intimidating at first, but I hope you are finding it is not as hard as you may have thought.

![No GUI No Problem](Images/NoGUINoProblem.png)
*No GUI No Problem :sunglasses:*

# Some Review
By now you probably know enough Unix to be dangerous. Congratulations! It wont hurt to reveiw some fundamentals though:

Command | Description
--------|-------------
ls \<directory\> | Lists all files in the current directory. If used without an argument lists files in current directory.
cd \<directory\> | Changes to a directory.
rm \<file\> | Permenatly deletes a file.
rm -r \<directory\> | Permenatly deletes a directory.
cat \<file\> | prints contents of file to screen.

