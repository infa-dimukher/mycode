string = input()
var = string.split()
updated_str = list(reversed(var))
s = ""
for ele in updated_str:
    if s != "":
        s = s + " " + ele
    else:
        s = s + ele
print(s)