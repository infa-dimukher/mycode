def array_fun(int_array,steps):
    array_length = len(int_array) - 1
    temp_array = []
    for i in range(steps):
        temp_array.append(int_array[array_length])
        temp_array.append(" ")
        del int_array[array_length]
        for e in int_array:
            temp_array.append(e)
        int_array = temp_array
        temp_array = []
    string = ""
    for j in int_array:
        string += j
    return string
for count in range(int(input())):
    elements,rotation = [int(elements) for elements in input().split()]
    array_string = input()
    array = list(array_string)
    print(array_fun(array,rotation))