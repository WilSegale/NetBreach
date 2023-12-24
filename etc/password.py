import random
import string
textFile = open("rockyou.txt","a")

try:
    password_count = 0  # Initialize the password count

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

        print(f"{password}",file=textFile)
        print(f"{password}")

        password_count += 1  # Increment the password count

except KeyboardInterrupt:
    print(f"Generated and printed {password_count:,.2f} passwords.")
