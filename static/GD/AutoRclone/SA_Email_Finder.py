import re
import sys
import os,glob
import datetime

WORK_DIR = os.getcwd()
PJ_NAME = "sa_emails"
ACCOUNTS_PATH =  WORK_DIR + "/accounts/"
EMAIL_FILE = WORK_DIR + "/email/" + PJ_NAME + ".txt"
fout = open(EMAIL_FILE, 'w+', encoding="utf-8")
os.chdir(ACCOUNTS_PATH)
for filename in os.listdir(ACCOUNTS_PATH):
    fs = open(filename, 'r+')
    for line in fs.readlines():
        mylist_1 = line.split(":")
        if mylist_1[0] == '  "client_email"':
            mylist_2 = mylist_1[1].split(":")
            email = mylist_2[0]
            a = len(email)
            b = a - 3
            fout.write(email[2:b] + '\n')
fout.close()
print("SA邮箱提取完成：" + EMAIL_FILE)
