import random
import string
n = 0
while True:
    n = n-1
    password_length = n

    characters = string.ascii_letters + string.digits + string.punctuation

    password = ""   

    for index in range(password_length):
        password = password + random.choice(characters)

    print(password)