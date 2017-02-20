__author__ = 'Fabian'

import collections


def find_max_occurrences(list):
    """
    Returns the element that appears the most in a list in the form of a tuple in a list
    :rtype : list(tuple)
    """
    return collections.Counter(list).most_common(1)

def split_text(file, sequence):
    """
    Return the text in a list formatted according to the specified sequence
    This is done in order to find out which character is dynamic in using the format abcd

    For example abd means selecting the first two characters and the last character.
    This is done in order to find out which character is dynamic by feeding that list then into find_max_occurrences
    :rtype : list
    """
    list = []
    if sequence == "abc":
        with open(file) as f:
            for line in f:
                list.append(line[0:3])
    elif sequence == "abd":
        with open(file) as f:
            for line in f:
                chars = line[0:2] + line[3:4]
                list.append(chars)
    elif sequence == "acd":
        with open(file) as f:
            for line in f:
                chars = line[0:1] + line[2:4]
                list.append(chars)
    elif sequence == "bcd":
        with open(file) as f:
            for line in f:
                list.append(line[1:4])
    else:
        raise AssertionError("Error input not recognised!")
    return list

