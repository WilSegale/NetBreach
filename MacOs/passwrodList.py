import random
import string
import time

# Open the file to save passwords
textFile = open("rockyou.txt", "a")

# Maximum length of password needed
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

# Record the start time
start_time = time.time()

# Example usage: generate passwords until the user stops
try:
    while True:
        password = generate_password(MAX_LEN)
        print(password, file=textFile)
        print(password)

        # Increment the counter
        num_generated += 1

        # Print the number of generated passwords
        print(f"Number of passwords generated: {num_generated}")

        # Optionally, print elapsed time every 10 passwords
        if num_generated % 10 == 0:
            current_time = time.time()
            elapsed_time = current_time - start_time
            print(f"Elapsed time: {elapsed_time:.2f} seconds")

except KeyboardInterrupt:
    # Calculate total elapsed time when interrupted
    end_time = time.time()
    elapsed_time = end_time - start_time
    print(f"Total number of passwords generated: {num_generated}")
    print(f"Total time elapsed: {elapsed_time:.2f} seconds")

# Close the file when done
textFile.close()
