import sys

def process_arguments(args):
    fix_flag = '--fix' in args
    global_flag = '--global' in args
    
    if fix_flag and global_flag:
        print("Both --fix and --global flags are provided.")
        # Add your logic here for handling both flags together, if needed
    
    return fix_flag, global_flag

def main():
    fix_flag, global_flag = process_arguments(sys.argv)
    print("Fix:", fix_flag)
    print("Global:", global_flag)

if __name__ == "__main__":
    main()
