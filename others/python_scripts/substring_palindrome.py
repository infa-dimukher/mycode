string = "malayalam"

def reverse(rev_string):
    rev_string = rev_string[::-1]
    return rev_string

def check_palindrome(s):
    if s == reverse(s):
        return True
    else:
        return False

for i in range(len(string)):
    new_str = string[i:]
    check_str = ""
    for ele in new_str:
        if len(check_str) < 2:
            check_str += ele
        else:
            check_str += ele
            if check_palindrome(check_str):
                print(check_str)