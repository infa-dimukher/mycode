string = "Ninja Art"
new_str = ""
for i in range(len(string) - 1):
    new_str += string[(len(string) - 1) - i]
print(new_str)