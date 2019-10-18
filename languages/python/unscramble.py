# unscramble.py

import sys

#file = open("/usr/share/dict/words",'r')
#print(file.read())

input = str(sys.argv[1])

with open("/usr/share/dict/words") as f:
    words = f.readlines()
words = [x.strip() for x in words]

matches = [x for x in words if sorted(x.lower()) == sorted(input.lower())]
print(matches)
