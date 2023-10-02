def compress_string(input_str):
    if not input_str:
        return ""
    char_count = 1
    tmp_char = input_str[0]
    compress_str = ""
    for i in range(1, len(input_str)):
        if input_str[i].isalpha():
            if input_str[i] == tmp_char:
                char_count += 1
            else:
                compress_str += tmp_char + str(char_count)
                tmp_char = input_str[i]
                char_count = 1
    compress_str += compress_str + str(char_count)
    return compress_str
input_string = input('Enter String: ')
print(compress_string(input_string))