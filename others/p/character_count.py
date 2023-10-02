string = "anantaa"
x = list(string)
count = 0
new_set = set()
for elements in string:
    for i in range(len(x)):
        if x[i] == elements:
            count += 1
    if elements not in new_set:
        print(elements, "     ", str(count))
    new_set.add(elements)
    count = 0