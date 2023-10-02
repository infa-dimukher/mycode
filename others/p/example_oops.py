# from random import shuffle
# class Book():
#     def __init__(self, name, author, pages):
#         self.name = name
#         self.author = author
#         self.pages = pages
    
#     def __str__(self):
#         return f"{self.name} by {self.author}"
#     def __len__(self):
#         return self.pages
#     def __del__(self):
#         print('A book object has been deleted!')

# new_book = Book('Summer of 69','Brayn Adams',400)

# print(new_book)

# print('new_string'[::-1])

# str1 = "My name is Aditya"
# x = str1.split()
# new_string = x[::-1]
# print(' '.join(new_string))

# members = ["Ananya", "Sahil", "Dib", "Phani", "Asmita"]
# shuffle(members)
# pods = ['usw1','use2','usw3','use4','usw5']
# shuffle(pods)

# print(list(zip(members,pods)))

# class Line():
#     def __init__(self, co1,co2):
#         self.co1 = co1
#         self.co2 = co2
    
#     def distance(self):
#         x1,y1 = self.co1
#         x2,y2 = self.co2
#         return ((x2 - x1)**2 + (y2 - y1)**2)**0.5
    
#     def slope(self):
#         x1,y1 = self.co1
#         x2,y2 = self.co2
#         return (x2 -x1) / (y2 - y1)
    
# c1 = (3,2)
# c2 = (8,10)

# myline = Line(c1,c2)
# print(myline.distance())
# print(myline.slope())

# while True:
#     try:
#         num = int(input('Enter a number: '))
#     except:
#         print('Its not a number')
#         continue
#     else:
#         # print(num ** 2)
#         with open('result.txt','a') as f:
#             f.write("\nSqare of the number is: " + str(num ** 2))
#         break

# import random

# def custom_gen(low,high,n):
#     for i in range(n):
#         yield random.randint(low,high)

# for num in custom_gen(1,10,12):
#     print(num)

# mylist = [1,1,1,1,2,2,2,2,2,2,3,4,5,6,6,6,7,7,3,4,4,4]
# new_set = set(mylist)
# count = 0
# for item in new_set:
#     for j in range(len(mylist)):
#         if item == mylist[j]:
#             count += 1
#     print(f"{item}         {count}")
#     count = 0

# import os,shutil

# # shutil.make_archive(base_name='work_log_example', format='zip', root_dir='/Users/dimukher/Downloads/',base_dir='work_logs',)

# shutil.make_archive('/Users/dimukher/Downloads/work_log_example','zip','/Users/dimukher/Downloads/work_logs')

import shutil,re,os

shutil.unpack_archive('/Users/dimukher/Downloads/Complete-Python-3-Bootcamp/12-Advanced Python Modules/08-Advanced-Python-Module-Exercise/unzip_me_for_instructions.zip','','zip')

def my_search(filename, pattern = r'\d{3}-\d{3}-\d{4}'):
    with open(filename) as f:
        text = f.read()
    if re.search(pattern,text):
        return re.search(pattern,text)
    else:
        return ""
result = []   
for folder,sub_folder,files in os.walk(os.getcwd()+'/extracted_content'):
    for f in files:
        full_path = folder + '/' + f
        result.append(my_search(full_path))

for s in result:
    if s != '':
        print(s.group())
