import random
import string
import time

# Prompt the user to choose the type of characters for the password
try:
    choice = int(input("""
Choose the type of password:
1. Random numbers and letters
2. Numbers only
3. Letters, numbers, and special characters
4. Custom word and random numbers
Enter your choice (1-4): 
"""))

    if choice not in [1, 2, 3, 4]:
        print("Invalid choice. Please run the program again and select a valid option.")
        exit()

except ValueError:
    print("Invalid input. Please enter a number between 1 and 4.")
    exit()

# Function to generate a password based on user choice
def generate_password(length, choice):
    if choice == 1:
        chars = string.ascii_letters + string.digits
    elif choice == 2:
        chars = string.digits
    elif choice == 3:
        chars = string.ascii_letters + string.digits + string.punctuation
    elif choice == 4:
        word = input("Enter a custom word: ")
        chars = word + string.digits
    else:
        print("Invalid choice.")
        return None

    # Generate a random password using the defined character set
    password = ''.join(random.choice(chars) for _ in range(length))
    return password

# Main function to start the password generation process
def start():
    # Ask for the file name to save passwords
    password_list = input("Enter the name of the file to save passwords: ")
    
    # Open the file in append mode
    with open(password_list, "a") as text_file:
        # Ask for the desired length of the password
        max_len = int(input("Enter the desired password length: "))

        # Initialize a counter to keep track of generated passwords
        num_generated = 0
        
        # Record the start time
        start_time = time.time()
        
        # Generate passwords in a loop until stopped by the user
        try:
            while True:
                password = generate_password(max_len, choice)
                if password is None:
                    break

                # Save the password to the file and print it to the console
                print(password, file=text_file)
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

# Call the start function to begin
start()
