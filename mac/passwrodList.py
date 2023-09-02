import random
import string

# maximum length of password needed
# this can be changed to suit your password length
textFile = open("rockyou2.0.txt", "a")
MAX_LEN = int(input("Enter the desired password length: "))

def generate_password(length=MAX_LEN):
    # Define the character set to be used in the password
    chars = string.ascii_letters + string.digits + string.punctuation

    # Generate a random password using the defined character set
    password = ''.join(random.choice(chars) for _ in range(length))

    # Return the password
    return password

# Initialize a counter to keep track of generated passwords
num_generated = 0

# Example usage: generate passwords until the user stops
try:
    while True:
        password = generate_password(MAX_LEN)
        print(password, file=textFile)
        print(password)

        # Increment the counter
        num_generated += 1
        print(f"Number of passwords generated: {num_generated}")

        # Ask the user if they want to continue
        
except KeyboardInterrupt:
    print(f"Total number of passwords generated: {num_generated}")


