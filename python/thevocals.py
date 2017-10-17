import random
import words
import groups

wordlist = words.parts
grouplist = groups.bands


def generateGroup(x):
    """
    wordlist (list): list of common words (strings)
    returns a word from wordlist at random,
    turns it into a fake vocal group
    """
    fakeGroup = random.choice(x) + "s"
    return "The " + fakeGroup.capitalize()


def pickGroup(x):
    """
    grouplist (list): list of real vocal groups words (strings)
    returns a group from grouplist at random
    """
    return random.choice(x)


real = random.choice([True, False])
if real == True:
    groupName = pickGroup(grouplist)
else:
    groupName = generateGroup(wordlist)
print("Welcome, mortal!")
print("Have you heard of this 20th century vocal group? \n" + groupName)
guess = input("y/n: ")
if guess == 'y' and real:
    print("You're right, " + groupName + " did exist at some point.")
elif guess == 'n' and real:
    print("Nope, " + groupName + " are a real vocal group.")
elif guess == 'n' and not real:
    print("Fine... We made that one up!")
elif guess == 'y' and not real:
    print("Fooled 'ya!")
else:
    raise ValueError("Please input 'y' or 'n' :)")


# Features!
# * Error when bad input
# * Better fake bands (2 words? plural words?) [also consider "xxx and The xs" as a fun format, maybe in the response]
# * Fake bands! write helper function, find bands with "the", remove duplicates [list]
# * Fun messages
# * Looping and keeping score!
