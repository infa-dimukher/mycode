def compress_string(input_str):
    if not input_str:
        return ""

    compressed_str = ""
    current_char = input_str[0]
    char_count = 1

    for i in range(1, len(input_str)):
        if input_str[i].isalpha():
            if input_str[i] == current_char:
                char_count += 1
            else:
                compressed_str += current_char + str(char_count)
                current_char = input_str[i]
                char_count = 1

    compressed_str += current_char + str(char_count)

    return compressed_str

input_str = input('Enter String: ')
compressed_output = compress_string(input_str)
print(compressed_output)
