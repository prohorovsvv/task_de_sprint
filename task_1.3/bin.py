number1 = '111'
number2 = '101'
intSum = int(number1, 2) * int(number2, 2)
result = bin(intSum)[2:]
print(result)