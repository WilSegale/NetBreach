import random
import time
FilePassword = open('rockyou.txt', 'a')
rangeOfPasswords = int(input("Enter the number of passwords you want to generate: "))
start_time = time.time()
try:
    for i in range(rangeOfPasswords):
        password = ''.join(random.choices('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', k=8))
        FilePassword.write(password + '\n')

        # Calculate total elapsed time when interrupted
        end_time = time.time()
        elapsed_time = end_time - start_time
    print(f"Total time elapsed: {elapsed_time:.2f} seconds")
except KeyboardInterrupt:
    # Calculate total elapsed time when interrupted
    end_time = time.time()
    elapsed_time = end_time - start_time
    print(f"Total time elapsed: {elapsed_time:.2f} seconds")
