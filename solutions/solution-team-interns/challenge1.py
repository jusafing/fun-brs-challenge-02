__author__ = 'Fabian'

import tools
import re
from operator import itemgetter
from datetime import datetime

path = "input/randomdata.txt"
randomdata = open("input/randomdata.txt", "r")

sequences = ["abc", "abd", "acd", "bcd"]
occurrences = []
regex = "x[\d]-#(.*)"

print "Welcome to the amazing program which solves brs-challenge-002!!"
for sequence in sequences:
    print "Finding the combination that appears the most in sequence: " + sequence
    possible_key = tools.find_max_occurrences(tools.split_text(path, sequence))[0]
    occurrences.append(possible_key)
    print "Done, in " + sequence + " the combination that appears the most is: " + possible_key[0] + " with a count of " + str(possible_key[1])
print "The key is: " + max(occurrences, key=itemgetter(1))[0]


print "Have fun reassembling the message :D!!!"
for matches in re.findall(regex, randomdata.read()):
    print matches


















