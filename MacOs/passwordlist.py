import time
f = open('passwords.txt', 'w')
startNumber = int(input("Enter the starting number: "))
endNumber = int(input("Enter the ending number: "))
ChoicesWord = str(input("Enter the word to use: "))
try:
    start_time = time.time()
    num_generated = 0
    for i in range(startNumber, endNumber):
        num_generated += 1
        print(f"{ChoicesWord}{i}", file=f)
    # Calculate total elapsed time when interrupted
    end_time = time.time()
    elapsed_time = end_time - start_time
    print(f"Total number of passwords generated: {num_generated}")
    print(f"Total time elapsed: {elapsed_time:.2f} seconds")

except KeyboardInterrupt:
    # Calculate total elapsed time when interrupted
    end_time = time.time()
    elapsed_time = end_time - start_time
    print(f"Total number of passwords generated: {num_generated}")
    print(f"Total time elapsed: {elapsed_time:.2f} seconds")
