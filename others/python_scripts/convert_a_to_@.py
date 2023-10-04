string1 = "javaautomation"
new_string = ""
count = 0
for letter in string1:
    if letter != 'a':
        new_string+=letter
    elif letter == 'a':
        count += 1
        new_string+= count * '@'
    else:
        print('Invalid letter')
print(new_string)