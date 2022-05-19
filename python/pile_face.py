from random import choice

side = ["pile", "face"]
user_point = 0
pc_point = 0 

while True:

    user = input("pile ou face? ")
    pc = choice(side)
    print("pc bet " + pc)

    res = choice(side)

    print("------------")

    if user == res and pc == res:
        print("resultat: " + res)
        print("you both won !")
        user_point += 1
        pc_point +=1
    elif user == res and pc != res:
        print("resultat: " + res)
        print("you won !")
        user_point += 1
    elif user != res and pc == res:
        print("resultat: " + res)
        print("you loose !")
        pc_point += 1

    print("your points: " + str(user_point))
    print("pc points: " + str(pc_point))

    print("------------")