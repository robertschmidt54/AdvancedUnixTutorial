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
```
man \<command\>
```
or
```
\<command\> -h
```
Where you can replace \<command\> with any command you know. Not all commands will work with the -h option, but most basic unix commands will work with man. The man (short for manual) command will bring up the documentation (also called the man page) for the command. Very useful if you ever forget what a commmand is suposed to do or the options to that command.

I should remind you: **rm -r can be a very dangerous command** Always be sure you are using it properly. 

# grep and the Power of Regular Expressions.
![xkcd208](Images/xkcd208.png)

*Source: Randal Monroe(https://xkcd.com/208/)*

Often we find ourselves in the unenviable position of needing to search large bodies of text for something important. This could be an address, a name, a particular gene, or gene family. We could manually go line by line and search for what we want, but that sounds very boring, and prone to error. Luckily for us Unix provides a very powerful command for searching files for what we want: 
```
grep
```

grep (short for **g**lobally search for a **r**egular **e**xpression and **p**rint matching lines) acts like the find function in many programs. You provide it some text and it will search a file for that text and return matching results. Let's give it a try now. I have in the data directory a text file containing a list of different words (conviently called ```list.txt```:

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

Output:
```
GREP(1)                           User Commands                           GREP(1)

NAME
       grep, egrep, fgrep, rgrep - print lines matching a pattern

SYNOPSIS
       grep [OPTIONS] PATTERN [FILE...]
       grep [OPTIONS] -e PATTERN ... [FILE...]
       grep [OPTIONS] -f FILE ... [FILE...]

DESCRIPTION
       grep searches for PATTERN in each FILE.  A FILE of “-” stands for standard
       input.  If no FILE  is  given,  recursive  searches  examine  the  working
       directory,  and  nonrecursive  searches  read standard input.  By default,
       grep prints the matching lines.

       In addition, the variant programs egrep, fgrep and rgrep are the  same  as
       grep -E,   grep -F,   and   grep -r,  respectively.   These  variants  are
       deprecated, but are provided for backward compatibility.

OPTIONS
   Generic Program Information
       --help Output a usage message and exit.

       -V, --version
              Output the version number of grep and exit.

   Matcher Selection
       -E, --extended-regexp
              Interpret PATTERN as  an  extended  regular  expression  (ERE,  see
              below).

       -F, --fixed-strings
              Interpret  PATTERN  as  a list of fixed strings (instead of regular
              expressions), separated by newlines, any of which is to be matched.

       -G, --basic-regexp
              Interpret PATTERN as a basic regular expression (BRE,  see  below).
              This is the default.

       -P, --perl-regexp
              Interpret  the  pattern  as  a  Perl-compatible  regular expression
              (PCRE).  This is experimental and grep -P may warn of unimplemented
              features.

   Matching Control
       -e PATTERN, --regexp=PATTERN
              Use  PATTERN as the pattern.  If this option is used multiple times
              or is combined with the -f (--file) option, search for all patterns
              given.  This option can be used to protect a pattern beginning with
              “-”.

       -f FILE, --file=FILE
              Obtain patterns from FILE, one per line.  If this  option  is  used
              multiple times or is combined with the -e (--regexp) option, search
              for all patterns given.  The empty file contains zero patterns, and
              therefore matches nothing.

       -i, --ignore-case
              Ignore  case  distinctions,  so that characters that differ only in
              case match each other.

       -v, --invert-match
              Invert the sense of matching, to select non-matching lines.
...
```
 I have omitted some of the output to save some space. But we can see there is a -i option that is for ignoring case. Let's give it a go:
 
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
these are the words that have a the letter 'p' *anywhere* in the word.  We can alter it easily:

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
\* | match zero or more of previous character. | 'This.\*Rocks' will match the words This and Rocks seperated by any number of characters.
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

Meaning we either need the -E option or remember to put backslashes infront of these special characters. The following two commands are equilivent:

```
grep -E 'A(nt|pple)' data/list.txt

grep 'A\(nt\|pple\)' data/list.txt
```

## Example of using Regular Expressions in bioinformatics: Restriction Enzyme sites.
To try to tie these principles into biology let's take a look at using regular expressions and grep to locate and count restriction enzyme sites in a bacterial genome. Restriction enzymes are enzymes that cut DNA at very specific sequences. *Acinetobacter baumannii* is an opportunstic pathogen and a bacteria I used to work with as an undergrad. I have downloaded its entire genome from NCBI and placed it into the data folder with the file name ```AbaumanniiGenome.fasta```. 

EcoN1 is a restriction enzyme that cuts the following sequence:
```
CCTNNNNNAGG
```
The N's represent any nucleotide A, T, C, or G. Using what we know about regular expressions and other commands how many EcoN1 sites are there in the *A. baumannii* genome?

## Naive gene finding
One way to find potential genes is to look for sequences that start with the letters ATG, have any number of characters between them, then end with either TAG, TGA, or TAA. Using grep and regular expressions as well as you knowledge of other commands: how many genes could there by in *A. baumannii*?
