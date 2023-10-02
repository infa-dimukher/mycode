vowel = ['A', 'E', 'I', 'O', 'U', 'Y']
num_list = []
def check_tag(string):
    for i in string:
        if i not in vowel:
            num_list.append(i)
        else:
            print('invalid')
            exit()
    for e in range(len(num_list)):
        try:
            sum = int(num_list[e]) + int(num_list[e+1])
        except:
            e += 1
        if sum % 2 == 0:
            sum = 0
            continue
        else:
            print('invalid')
            exit()
    print('valid')
input_tag = input('Enter tag value: ')
check_tag(input_tag)