from random import randrange

test = True
numb = randrange(100)
while test:
    i = input("enter a number: ")
    try:
        if int(i) > numb:
            print("too high")
        elif int(i) < numb:
            print("too low")
        elif int(i) == numb:
            print("congrat !!")
            test = False
    except:
        print("not a number")
