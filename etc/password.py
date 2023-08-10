import random
import string
while True:
    # Set the desired password length
    password_length = 12  # You can replace this with your desired length

    characters = string.ascii_letters + string.digits + string.punctuation

    # Using a list to accumulate characters
    password_list = []   

    for _ in range(password_length):
        password_list.append(random.choice(characters))

    # Join the characters to form the password string
    password = ''.join(password_list)

    print(password)
