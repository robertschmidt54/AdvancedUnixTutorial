# AdvancedUnixTutorial
### Rob Schmidt
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
cat \<file\> | Prints contents of file to screen.
less \<file\> | Opens file for viewing in the less interface.
more \<file\> | Opens file for viewing in the more interface.
head -n \<file\> | print top n lines of a file.
tail -n \<file\> | print last n lines of a file.

Commands can take multiple options as well as arguments take the rm command. See that "-r" in the rm command on line 4 of the table? That is an option. It means to perform the the remove command on all the files in \<directory\>. Options always follow 1 or 2 "-" characters in the command. You can always see a list of options for a given command by entering:

man \<command\>

or

\<command\> -h

Where you can replace \<command\> with any command you know. Not all commands will work with the -h option, but most basic unix commands will work with man. The man (short for manual) command will bring up the documentation (also called the man page) for the command. Very useful if you ever forget what a commmand is suposed to do or the options to that command.

# grep and the Power of Regular Expressions.
![xkcd208](Images/xkcd208.png)

*Source: Randal Monroe(https://xkcd.com/208/)*

Often we find ourselves in the unenviable position of needing to search large bodies of text for something important. This could be an address, a name, a particular gene, or gene family. We could manually go line by line and search for what we want, but that sounds very boring, and prone to error. Luckily for us Unix provides a very powerful command for searching files for what we want: 
```
grep
```

grep (short for **g**lobally search for a **r**egular **e**xpression and **p**rint matching lines) acts like the find function in many programs. You provide it some text and it will search a file for that text and return matching results. However unlike the find functions you may be used to grep can take and understand *regular expressions*
## So what are these regular expressions you keep going on about?
Regular expressions are patterns
