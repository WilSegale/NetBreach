import random
import string


# maximum length of password needed
# this can be changed to suit your password length
textFile = open("rockyou.txt","a")
MAX_LEN = int(input(">>> "))

def generate_password(length=MAX_LEN):
    # Define the character set to be used in the password
    chars = string.ascii_letters + string.digits + string.punctuation

    # Generate a random password using the defined character set
    password = ''.join(random.choice(chars) for _ in range(length))

    # Return the password
    return password

# Example usage: generate a password with a length of 12 characters
password = generate_password(MAX_LEN)
print(password,file=textFile)
print(password)