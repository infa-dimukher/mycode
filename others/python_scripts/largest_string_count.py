string = input('Enter string: ')
var = string.split()
count = 0
max_count = 0
new_str = ""
for ele in var:
    count = len(ele)
    if max_count < count:
        max_count = count
        new_str = ele
print(new_str, "   ", max_count)