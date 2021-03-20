# AdvancedUnixTutorial
### Rob Schmidt
Tutorial for workshop given on 3/20/21

This is the 2nd in a series of tutorials for the Bioinformatics and Computational Biology workshop series on Unix. In this tutorial, we will cover some more advanced Unix topics. 

# Before Starting Run These Commands:
```
ssh <netID>@hpc-class.its.iastate.edu
```
```
git clone https://github.com/robertschmidt54/AdvancedUnixTutorial/
```

# Let's get started: Why do we even want to learn about Unix?
Linux/Unix has become the standard operating system for high performance computing clusters (HPCs) all around the globe. If you want the power of an HPC you need to learn the fundamentals of Unix. Plus almost all of the most popular bioinformatics tools are used on the command line. Trust me it may look intimidating at first, but I hope you are finding it is not as hard as you may have thought.

![No GUI No Problem](Images/NoGUINoProblem.png)
*No GUI No Problem :sunglasses:*

# Some Review
By now you probably know enough Unix to be dangerous. Congratulations! It won't hurt to review some fundamentals though:

Command | Description
--------|-------------
ls \<directory\> | Lists all files in the current directory. If used without an argument lists files in current directory.
cd \<directory\> | Changes to a directory.
rm \<file\> | Permanently deletes a file.
rm -r \<directory\> | Permanently deletes a directory. **Be very careful with rm. Always be absolutely sure you know what you are deleting.**
cat \<file\> | Prints contents of file to screen.
less \<file\> | Opens file for viewing in the less interface.
more \<file\> | Opens file for viewing in the more interface.
head -n \<file\> | print top n lines of a file.
tail -n \<file\> | print last n lines of a file.
cp \<file\> \<new location\> | copies file to new location. Keeps old file.
mv \<file\> \<new location\> | moves file to new location. Deletes old file. Also can be used to rename files.
pwd | prints out current working directory.
mkdir \<directory\> | make new directory.
touch \<file\> | make a new file.

Commands can take multiple flags/options as well as arguments take the rm command. Options always follow 1 or 2 "-" characters in the command.

ex:

```ls -lh``` lists all files in directory and their sizes.

```head -n 5 \<file\>``` prints first 5 lines of a file.

You can always see a list of options for a given command by entering:

```
man <command>
```
or

```
<command> -h
```
Where you can replace \<command\> with any command you know. Not all commands will work with the -h option, but most basic unix commands will work with man. 

The man (short for manual) command will bring up the documentation (also called the man page) for the command. Very useful if you ever forget what a commmand is supposed to do or the options to that command.

I should remind you: **rm -r can be a very dangerous command** Always be sure you are using it properly. **NEVER USE THE COMMAND: rm -rf /** you will literally delete everything on your hard drive.



# Introduction to Programming with Unix
We have learned how to run commands in Unix one at a time via the commandline. However, most of the time we would like to run multiple commands in sequence. 

You learned during the last workshop about the pipe ```|``` operator that allows us to chain commands together. This is useful, but will quickly becomes cumbersome when you have more than a handfull of commands you need to run on multiple files. Enter bash scripting!

Programming in bash is just like programming in other languages. So the skills you pick up here can easily transfer to other languages as well.

In order to write our programs, I will need to introduce a new command ```nano``` nano is one of Unix's built in text editors ([other](https://www.vim.org/) [text editors](https://www.gnu.org/software/emacs/) [are available](https://xkcd.com/378/)).

To open a file with nano:
```
nano helloWorld.sh
```
Your screen will shift to something like this:
![VimSample1](Images/nano1.png)
You can type anything you want just like you can in Notepad or TextEdit. 
Go ahead and type the following:

```{bash}
#!bin/bash

#This is a comment!
#This is also a comment.
echo "Hello World!"

#Another comment.
```
Once you've typed that hit ```CTRL + X``` you will then be prompted to save your work. Type ```Y``` to save then hit ```Enter``` and you should be brought back to your normal bash shell.

Let's run our program:

```
bash helloWorld.sh
```

Which should print:

```
Hello World!
```

Congratulations you've just written your first program!

Let's take some time to break down what we just did. The first line: ```#!bin/bash``` is required at the beginning of every bash script. It tells the computer what program to use to interpret our instructions. 

You have already seen the ```echo``` command from the last workshop. As a reminder echo prints whatever follows it to the screen. In our case it will be the string "Hello World!".

You may have noticed the lines that begin with ```#``` didn't print or mess anything up. This is because they are what are known as comments. Comments are ignored by computers, and are for us humans to know what the code is doing.

Let's try something a little more complicated open up your helloWorld.sh script and add the following to the end:

```{bash}
#Set x to be the answer to life the universe and everything.
x=42


echo "The answer to life the universe and everything is: $x"
```
Go ahead and save that then run it the output will now be:

```
Hello World!

The answer to life the universe and everything is: 42
```

Here we see an example of declaring a variable. Variables can store values to be used later. They can be numeric or strings. In this case we define a variable ```x``` to be the number ```42```. We then print the variable to the screen using the echo command. Notice how we have to call the variable as ```$x```. This is true of every variable in bash scripting. You need that $. 

### Let's practice:
Let's give you some practice using variables.

1. Open a new script called ```Exercise1.sh```  (using `nano`)
2. Assign the names "Jess", "Jack", and "Jenn" to the variables a, b, c
3. Add a line that uses these variables to print out the sentence:
   "Jess, Jack, and Jenn say hi!"
   
### Parameter and command expansion
A useful feature of bash is parameter expansion. 
say we have a variable storing the word 'cat'

```
x='cat'
```
We want to print the word cats without making another variable. 

We could try:
```
echo $xs #This will not work
```

But this won't work, because Unix thinks we want to print a variable called 'xs'.

To solve this we can use parameter expansion which has the following syntax:

```
echo ${x}s
```

Which will print what we want. 

Command substitution is another tool it can let us evaluate commands inside of other commands. For example:

```
head $(ls *.sh)
```

It can also let us set the output of some commands as variables. For instance:

```
Files=$(ls *.txt)
```

Will give us a variable that is a space separated list of all text files in the current directory. 

### More Practice:
 1) Use parameter expansion and the variables from Exercise 1 (you can add to the exercise 1 file or rewrite them in a new file) to print the
    sentence:
    "Many Jesses, Jacks, and Jenns say bye!
    
 2) The command `whoami` prints your username.
    The command `date` prints the current time.
    Use command substitution to print the sentence:
    "I am \<username\> and today is \<date\>"
    Replacing \<username\> and \<date\> with output of `whoami` and `date`

### Taking arguments from the command line.

Let's make a script to take an argument from the command line. Let's open a new file:

```
nano myEcho.sh
```

We will add the following to it:

```
#!/bin/bash

echo $1
```
Go on and save it. Then type:

```
bash myecho.sh "I want to print this string"
```
Congratulations you've just rewritten the echo command!

As useless as this is it does illustrate a key feature of bash scripting: we can take in arguments from the command line and do things with them.

Arguments coming in from the command line are stored in a hidden list we can access with the variables $0, $1, $2, $3, etc. 

For example:

```
#!/bin/bash

echo $1

echo $2

echo $3 $5

echo $4
```

will print when run:

```
bash myecho.sh "I want to print this string" "And this one" "This one too" "See how this works" "PI"

I want to print this string
And this one
This one too PI
See how this works
```
This is very useful if we want to run a tool on multiple files and we want to keep the same parameters. Here is an example using the aligner ```bowtie2```:

```
#!/bin/bash

bowtie2 --sensitive -p 32 -x Index/AB -1 $1 -2 $2 -S $3
```

If I wrote it to a file called bowtieScript.sh I would run it like this:

```
bash bowtieScript.sh ForwardReads.fastq ReverseReads.fastq Alignment.sam
```
### Practice:
1) Write a line to print arguments 0, 1 and 2

## Running through a list: The for loop:
There are many times when we want to repeat a set of instructions over many elements in a list. Maybe we want to manipulate all the files in a directory, maybe we want to align a list of genes to a reference sequence, or maybe we just want to print out the numbers 1 to 10 in order. All of these can be accomplished using a `for` loop. The `for` loop is outlined in this flowchart:
![ForLoop](Images/forLoop.png)
I think it is best illustrated with an example:

```
for i in 1 2 3 4 5 6 7 8 9 10
do
       echo $i
done
```

which will produce:

```
1
2
3
4
5
6
7
8
9
10
```
We just printed the numbers 1 to 10 without needing 10 separate `echo` statements! So what's going on here? 

Let's break down the first line: ```for x in 1 2 3 4 5 6...``` The word `for` is a key word in Unix that means I am starting a `for` loop. 

`i` is a variable (it could be anything I just chose `i` randomly, but you can give it any name you want like `variable` or `bob`), and the stuff after the word "in" are the values I want `i` to take on. 

The next line is the word ```do``` this is another key word in Unix. It means that for every value of `i` do the following. 

The next line is my code that I want to run. 

And finally we end with the word ```done``` to let the computer know we are finished. 

When we start the loop ```i``` first takes on the value 1 since it is the first in the list. We then move to the instruction which is to print whatever the value of ```i``` is. 

When that is done, we find there is no other instruction. We have just completed one itteration of the loop.

We then go back to our list, and see if we have reached the end. We have not, so ```i``` will now be assigned the value 2 (the next value in the list). We then repeat the loop until ```i``` can no longer take on anymore values. Once we reach that point we are done, and exit the loop. 

### for loop practice
1) Write a for-loop that prints (using the variables from exercise 1, you can rewrite them in this file)
    Hello Jess
    Hello Jack
    Hello Jenn
    
 2) Write a for-loop that uses command substitution to loop over the first
    three names in names.txt (located in the `data` directory) (hint: use `head -3`).
    Output should be:
    Hello Alice
    Hello Bob
    Hello Carl
    
 3) Adapt the for-loop from 2) to write the output for each name to a file
    named \<name\>.txt (pro tip: make a new directory to contain all the text files).
    
# Slurm and the HPC.
Much of what you probably want to do requires a lot of computational resources. 

Luckily, Iowa State provides us with some great computational resources (In fact we are using them right now!). You can find out more about what kind of machines they have [here](https://www.hpc.iastate.edu/systems).

We will assume you have access to a cluster (if you don't there is a link to sign up on the [HPC homepage](https://www.hpc.iastate.edu/), you may have to talk with your PI). 

To access one of the clusters you can use the `ssh` command you used to get into this session. Just replace the `@hpc-class...` with the correct cluster.

### Let's talk about Slurm
Slurm is a job manager that Iowa State uses to run your scripts in an orderly fashion.

A Slurm script is just like any other bash script, but you need to add some extra lines at the beginning:

```
#!/bin/bash

#SBATCH --time=1:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=16   # 16 processor core(s) per node 
#SBATCH --job-name="MyJob"

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
```

All the #SBATCH lines you see are special comments that Slurm can look at to get information about your job like how long you want the job to run for, number of nodes you want, the number of threads per node, and a job name.

Incidently you don't have to memorize all the slurm comments. Iowa State provides a Slurm script generator that will serve most of your needs it even has options for emailing you when your jobs finish:

https://www.hpc.iastate.edu/guides/classroom-hpc-cluster/slurm-job-script-generator

This is the one for hpc-class (the server we are running on) but there are others for other servers.

Let's run our helloWrold script from earlier on the cluster!
In case you deleted it here it is with the right slurm comments:

```
#!/bin/bash

#SBATCH --time=1:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=16   # 16 processor core(s) per node 
#SBATCH --job-name="MyJob"

echo "Hello World!"

#Set x to be the answer to life the universe and everything.
x=42


echo "The answer to life the universe and everything is: "$x
```

To get the cluster to run your script using Slurm the command is `sbatch`

```
sbatch helloWorld.sh

```
This should only take a few seconds. Congrats you've just run something using a high performance computing cluster.

Let's make something that takes a little longer let's open a script called theEndisNvr.sh and place this into it:

```
#!/bin/bash

#SBATCH --time=1:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=16   # 16 processor core(s) per node 
#SBATCH --job-name="ThisIsTheLoopThatNeverEnds"

while [[ 1 -eq 1 ]]
do
   echo "The end is never."
done
```
Save it like normal. Let's go ahead and run it locally to see what the output is.

As you can see it just prints out "The end is never." over and over with no end in sight.

What we have here is an infinite loop. Breaking the code down line by line we see a new kind of structure we haven't seen before: a `while` loop. 

While loops will continue to loop through their instructions so long as their condition is true. 

In our case the condition is 1 = 1. Which is always true no matter what. So the  
code will continue to print forever.

To get out of this hit `CTRL + C` to terminate the program.

Now let's run the infinte looping code on slurm:

```
sbatch theEndIsNvr.sh
```

This will now run on the cluster, forever taking up resources (ok realistically it will only run for 1 hour because that's the time we gave it). We can check to see if it is running using the command `squeue`.

The output is divided into 9 fields: a job ID, a partition, a name, a user, a state, the time it has been running, the number of nodes the job is using, and list of said nodes. 

All of your jobs should be running so they will have the R state (the column after your user name). If they were queued they would have the PD state for pending.

If you just want to see your jobs we can pass the -u flag to `squeue` like this:

```
squeue -u <NETID>
```

This will filter the output to only your user name. 

Our code will never stop. So to avoid receiving some nasty emails from IT we should do the responsible thing and stop it. 

To stop a job we use the `scancel` command. It requires that we supply a job ID. You can find the job ID in the first column of the `squeue` output. The command will be:

```
scancel <jobID>
```
You will not get a message from slurm, but if you `squeue` you should see your script is no longer running. 

### Modules
The cluster has many different tools installed on it. We can see a list of these tools using the `module avail` command.

This will give you a long long list of availible modules. But you probalby have an idea of the kind of tool you want. 

Let's see if the cluster has `bowtie2`. To do this we will use the `module spider` command. 

`module spider` takes a string as an argument, and will search through all the availible commands for what you want. 

We can see `bowtie2` is availible. 

```
module spider bowtie2
```

In order to use a tool installed on the cluster we must first activate the tool. To do this we use the command `module load`.

```
module load bowtie2
```

You will now find if you use the command:

```
bowtie2 -h
```

that you will get a man page for bowtie2. 

We can now put our skills to the test. Let's build a script that will run through a directory of single end sequence files and align them one by one to a reference genome:

```
#!/bin/bash

#SBATCH --time=1:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=16   # 16 processor core(s) per node 
#SBATCH --job-name="ThisIsTheLoopThatNeverEnds"


#load the tools we want to use
module load bowtie2 # load the bowtie2 aligner
module load samtools #load samtools

for fq in data/seqs/*.fastq #Creating a for loop to run over the files in dir.
do

#run bowtie2 on our fastq file aligning to reference sequence index (made previously using bowtie2-build see bowtie2's manual for details). 

#We then pipe the output of bowtie2 to samtools view. 

#samtools view will compress our alignment files because they can be quite large.

#We finish by redirecting (>) samtools output to a file. Parameter expansion is used to make sure the final file has the same ID as the input file. 

bowtie2 -x data/Index/RefSeqIndex -U $fq | samtools view -b > ${fq}.bam 

done

#Print a nice message to screen.
echo "Done :)"
```
We will not be running this script in this course as alignment is a computationally intensive process.  

I am required by law to tell you:
**Do not run intensive commands, or store things on the head node**

Remember to use Slurm to run your commands on the cluster. Try to avoid using the interactive nodes to run your scripts. Use the interactive nodes to trouble shoot and test.

**Never run the command `rm -rf /`!**

# grep and the Power of Regular Expressions.
![xkcd208](Images/xkcd208.png)



Often we find ourselves in the unenviable position of needing to search large bodies of text for something important. This could be an address, a name, a particular gene, or gene family. We could manually go line by line and search for what we want, but that sounds very boring, and prone to error. Luckily for us Unix provides a very powerful command for searching files for what we want: 
```
grep
```

grep (short for **g**lobally search for a **r**egular **e**xpression and **p**rint matching lines) acts like the find function in many programs. You provide it some text and it will search a file for that text and return matching results. Let's give it a try now. I have in the data directory a text file containing a list of different words (conveniently called ```list.txt```:

```
apple
Apple
orange
pear
peach
peach
spam
foo
bar
paypa
dog
Cat

```
if we run the following command:

```
grep 'apple' data/list.txt
```
We should see this output:

```
apple
```
As you can see we can do a simple word search using grep just like we can in other programs. Let's breakdown the command: grep is obviously the name of the command. The second argument is the PATTERN. This can be a word (or regular expression we will get to those a bit later) and this is the bit of text you want your search to find. The second argument is the path to the file you want to search. In this case it is data/list.txt.  

You may have noticed: there are two instances of the word 'apple': 'apple' and 'Apple', but we only got one returned to us. This is because the patterns grep takes are by default case sensitive. Let's take a look at the man page for grep using the following command:

```
man grep
```
 We can see there is a -i option that is for ignoring case. Let's give it a go:
 
 ```
 grep -i 'apple' data/list.txt
 ```
 The output should look like:
 
 ```
 apple
 Apple
 ```
 
Searching for particular words is great and all, but the true power of grep comes from its use of *regular expressions*
## So what are these regular expressions you keep going on about?
Regular expressions are a way to encode patterns of text. So instead of searching for actual words we search for patterns in the words. For example say we want to find all words in our list.txt file that start with the letter p. One way to do this is with the command:

```
grep '^p' data/list.txt
```
Don't worry if you don't know what '^p' means yet we will get to that. The output will be:

```
pear
peach
peach
papya
```
All the lines that start with the letter p.

There are a few rules to keep in mind when forming regular expression. The first is that any alpha numeric character (the letters a-z and numbers 0-9) will be interpreted literally. So for example the following command:
```
grep 'p' data/list.txt
```

Will return:

```
apple
Apple
pear
peach
peach
spam
```
These are the words that have a the letter 'p' *anywhere* in the word.  We can alter it easily:

```
grep 'pp' data/list.txt
```
will return:

```
apple
Apple
```
All words with the characters 'pp' anwhere in the word. Go ahead and give it a try using other combinations of letters. What happens if you enter a pattern that isn't in the file?

Regular expressions also have special characters (we saw it earlier with my '^p' example). Some of these special characters are summarized in the following table:

Character | Regular Expression Meaning | Example
----------|---------------------------|---------
\. | Any character except line breaks. | 'c\.t' match any three letter word beginning with c and ending with t.
^ | Match at the start of the line. | '^p' will match any line that starts with the letter p. Note: this must go at the beginning of the regular expression.
$ | Match at the end of the line. | 'Bob$' will match any line that ends with the letters Bob in that order. Note: this must go at the end of the regular expression.
\d | any digit 0 to 9  | \d\d will match any 2 digit number.
\s | any whitespace character. | '.\sBob' will match any letter, followed by a single space and the letters Bob
\D | any non digit character. | '\d\d\D\d\d' will match any 4 digits seperated by a non digit like '12A34'
\S | any non whitespace character. | 'a\Sb' will match the letters a, and b seperated by a non white space character. 
\+ | match one or more of previous character. |'a+' will find words that have one or more 'a' in them. 
\* | match zero or more of previous character. | 'This.\*Rocks' will match the words This and Rocks separated by any number of characters.
{...} | can be used to specify number of matches | p{3} will match words with exactly 3 p's.
(...) | specify a group of characters to match. | A(nt\|pple) will match Ant or Apple. This differs from [...] in that [...] matches individual characters while (...) matches groups of characters.
[...] | match one of the characters in the brackets. | [bc]at will match cat and bat.
[^...] | match a charcter NOT in the bracket. | [^e] will give words that do not contain the letter e.
\| | acts like an OR operand | 22\|33 will match the string '22' or '33'
\- | allows us to specify a range | 'p{3-5}' will match words with 3, 4, or 5 p's. Works with letters too a[a-z]g will match any three letter word starting with a and ending with g.

These are just a few of the special characters but these will let us do a lot. Let's breakdown my expression from earlier '^p' according to the table the '^' character means start of the line and the p is the character that should start the line. So since our list.txt file contains only one word per line this is equilivent to "find words that begin with the letter p". This would not work in general though.

One other thing we should take note of is: most of these special characters will not work with just regular grep. A quick look at the man page reveals this option:

```
       -E, --extended-regexp
              Interpret PATTERN as  an  extended  regular  expression  (ERE,  see
              below).
              ...
                 Basic vs Extended Regular Expressions
       In basic regular expressions the meta-characters ?, +, {, |, (, and ) lose their special meaning; instead  use
       the backslashed versions \?, \+, \{, \|, \(, and \).
 
```

Meaning we either need the -E option or remember to put backslashes in front of these special characters. The following two commands are equivalent:

```
grep -E 'A(nt|pple)' data/list.txt

grep 'A\(nt\|pple\)' data/list.txt
```
# Regular Expression Practice Problems
## Example of using Regular Expressions in Bioinformatics: Restriction Enzyme Sites.
To try to tie these principles into biology, let's take a look at using regular expressions and grep to locate and count restriction enzyme sites in a bacterial genome. Restriction enzymes are enzymes that cut DNA at very specific sequences. *Acinetobacter baumannii* is an opportunistic pathogen and a species I used to work with as an undergrad. I have downloaded its entire genome from NCBI and placed it into the data folder with the file name `AbaumanniiGenome.fasta`. 

EcoN1 is a restriction enzyme that cuts the following sequence:

```
CCTNNNNNAGG
```

The N's represent any nucleotide A, T, C, or G. Using what we know about regular expressions and other commands, how many EcoN1 sites are there in the *A. baumannii* genome?

## Naive Gene Finding
One way to find potential genes is to look for sequences that start with the letters ATG, followed by any number of characters, then end with either TAG, TGA, or TAA (I should probably point out this is not always a *good* way to find genes, but it is easy.). Using grep and regular expressions as well as your knowledge of other commands: how many genes could there be in *A. baumannii*?
