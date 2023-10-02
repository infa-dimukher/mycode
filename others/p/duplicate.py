def check_duplicate(dup):
    final_list = []
    string = ""
    for i in dup:
        if i not in final_list:
            final_list.append(i)
    for elelment in final_list:
        string += elelment
    return string
user_input = input('Enter string: ')
print(check_duplicate(user_input))