import sys
import getpass
import os
import hashlib

banner = """
8888888b.                                                          888 
888   Y88b                                                         888 
888    888                                                         888 
888   d88P 8888b. .d8888b .d8888b 888  888  888 .d88b. 888d888 .d88888 
8888888P"     "88b88K     88K     888  888  888d88""88b888P"  d88" 888 
888       .d888888"Y8888b."Y8888b.888  888  888888  888888    888  888 
888       888  888     X88     X88Y88b 888 d88PY88..88P888    Y88b 888 
888       "Y888888 88888P' 88888P' "Y8888888P"  "Y88P" 888     "Y88888 
                                                                                                                                                                                                                     
888b     d888                888                   
8888b   d8888                888                   
88888b.d88888                888                   
888Y88888P888 8888b. .d8888b 888888 .d88b. 888d888 
888 Y888P 888    "88b88K     888   d8P  Y8b888P"   
888  Y8P  888.d888888"Y8888b.888   88888888888     
888   "   888888  888     X88Y88b. Y8b.    888     
888       888"Y888888 88888P' "Y888 "Y8888 888

----------------------------------------------
|              Password Master               |
|--------------------------------------------|
|      [*] Version : 2.8                     |
|      [*] Author  : Agung Ichiruki          |
|      [*] Github  : github.com/xxxHolic3    |
----------------------------------------------

"""

def registerUser():
    os.system("clear")
    print (banner)
    print ("== Register ==>")
    username = input("| [i] Username         : ")
    passwd = getpass.getpass("| [i] Password         : ")
    repasswd = getpass.getpass("| [i] re-type Password : ")

    if passwd == repasswd:
        hashing = hashlib.md5(passwd.encode())
        passwd = hashing.hexdigest()

        f = open(".passmaster_data/{}.con".format(username), "w")
        f.write("{}\n{}".format(username, passwd))
        f.close()
        startApp()
    else:
        registerUser()

def loginUser():
    os.system("clear")
    print (banner)
    username = input("| [i] Username : ")
    passwd = getpass.getpass("| [i] Password : ")
    
    hashing = hashlib.md5(passwd.encode())
    passwd = hashing.hexdigest()

    try:
        f = open(".passmaster_data/{}.con".format(username))
        lines = f.readlines()
        uname = lines[0].rstrip()
        pword = lines[1].rstrip()
    except:
        loginUser()

    if username == str(uname) and passwd == str(pword):
        mainApp(username)

def mainApp(username):
    os.system("clear")
    print (banner)
    try:
        f = open(".passmaster_data/{}.data".format(username), "r")
    except Exception as err:
        if str(err) == "[Errno 2] No such file or directory: '.passmaster_data/{}.data'".format(username):
            print ("[!] File {}.data not found.".format(username)) 
            print ("create new one... \n")
            f = open(".passmaster_data/{}.data".format(username), "w")
        else:
            print ("[Warning] : {}".format(err))
    print ("[:D] Welcome {}".format(username))
    print ("== Menu =======================")
    print ("| [1]. Add new password       |")
    print ("| [2]. See password           |")
    print ("| [3]. Log-out                |")
    print ("===============================")
    choice = input("\nInput : ")

    if int(choice) == 1:
        addRecord(username)
    elif int(choice) == 2:
        seeRecord(username)
    elif int(choice) == 3:
        startApp()
    else:
        mainApp(username)

def addRecord(username):
    os.system("clear")
    print (banner)
    akun   = input("[i] Jenis akun : ")
    usernm = input("[i] Username   : ")
    mail   = input("[i] Email      : ")
    passwd = input("[i] Password   : ")

    f = open(".passmaster_data/{}.data".format(username), "a")
    f.write("Akun     : {}\nUsername : {}\nEmail    : {}\nPassword : {}\n\n".format(akun,usernm,mail,passwd))
    f.close()

    mainApp(username)

def seeRecord(username):
    os.system("clear")
    f = open(".passmaster_data/{}.data".format(username), "r")
    isi = f.read()
    print ("=== Start ======================================\n")
    print (isi)
    input("Press enter to return back to main menu...")
    mainApp(username)


def exitApp():
    print ("Bye... bye...")
    sys.exit()
        

def startApp():
    os.system("clear")
    print (banner)
    print ("== Menu =======================")
    print ("| [1]. Login                  |")
    print ("| [2]. Register as new user   |")
    print ("| [3]. Exit                   |")
    print ("===============================")
    choice = input("\nInput : ")
    
    if int(choice) == 1:
        loginUser()
    elif int(choice) == 2:
        registerUser()
    elif int(choice) == 3:
        exitApp()
    else:
        startApp()


try:
    os.mkdir(".passmaster_data")
except:
    pass

startApp()