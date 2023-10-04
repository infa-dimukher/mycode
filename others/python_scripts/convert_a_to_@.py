string1 = "javaautomation"
new_string = ""
count = 0
for letter in string1:
    if letter == 'a':
        count += 1
        new_string+= count * '@'
    else:
        new_string+=letter
print(new_string)