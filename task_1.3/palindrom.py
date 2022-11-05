def palindrom(x):
    x = x.replace(" ", "")
    if x[::-1] == x:
        print(True)
    else:
        print(False)

palindrom('taco cat')
palindrom('black cat')