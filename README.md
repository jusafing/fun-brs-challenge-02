* Challenge Series BRS v2017.2.2
* Category: Scripting
* Level   : Basic

There is a hidden "quote" within all this garbage retrieved from /dev/urandom


In order to find the obfuscated quote you *may* need *some* of these hints:
(or not)

1. The message is split in "n" chunks
2. If each chunk "were a BIT" , then there are FIVE BYTES of 
   chunks (in number of bits)
3. The first "FOUR BYTES" of each line can be used as the "key" to
   filter out the chunks containing the message
4. Of these, "THREE CHARACTERS" are always fixed (same value same position). 
   Only ONE CHARACTER is dynamic (does it matter?)
5. Finding the chunks is not enough. They need to be sorted out to reassembly
   the message. How? It is easy if you see the chunks.


##### Please answer:

* 1) What is the hidden quote?
* 2) Who is the Author?

##### Solution:
   - Submit your solution with code to jusafing@gmail.com
     Before Feb 20th 2017 00:00 GMT

##### Winner:
   - Most "elegant" and/or efficient solution.

   - It will be checked with:
    
     $ time ./script_name 

##### PRIZE
   - Knowledge and a pizza|beer|cake

##### Solutions accepted:
- code something!!!! otherwise...
- prepare yourself to scroll millions of lines down looking for "patterns"


HaV3 fUN!

----
JUSA

