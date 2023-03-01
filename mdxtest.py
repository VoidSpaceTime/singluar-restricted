import os
# fdata = pd.read_csv(fpath,encoding='gb18030')
f = open( 'E:\\Games\\war3map\\singluar_J\\assets\\war3mapModel\\buff\\Echo.mdx', 'r',encoding = 'ISO-8859-1' )
# print(f.read())
char = f.read()
# int_ = int(char,16)

# def str_2_bin(str):
#     """
#     字符串转换为二进制
#     """
#     return ' '.join([bin(ord(c)).replace('0b', '') for c in str])

a = 'sadf'

print(hex(ord('~'))[2:]) 

index = 0
for s in a :
    if s == 'd':
        print(s)

    
    index += 1