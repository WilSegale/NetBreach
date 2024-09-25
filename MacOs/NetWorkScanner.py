from DontEdit import *
# Function to scan a specific port on an IP address
def scan_port(ip, port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(0.5)  # Set timeout for the connection
        result = sock.connect_ex((ip, port))  # Try to connect to the port
        sock.close()
        return result == 0  # Port is open if result is 0
    except socket.error:
        return False

# Function to scan a range of IP addresses and ports with ETA
def network_scan_with_eta(network, port_range):
    open_ports = []
    ip_list = list(ipaddress.IPv4Network(network, strict=False))
    total_ips = len(ip_list)
    total_ports = len(port_range)
    total_tasks = total_ips * total_ports
    start_time = time.time()

    tasks_done = 0
    for ip in ip_list:
        for port in port_range:
            tasks_done += 1
            if scan_port(str(ip), port):
                print(f"[+] {ip}:{port} is open")
                open_ports.append(f"{ip}:{port}")

            # Calculate and print ETA
            elapsed_time = time.time() - start_time
            avg_time_per_task = elapsed_time / tasks_done
            tasks_left = total_tasks - tasks_done
            eta = avg_time_per_task * tasks_left

            print(f"Progress: {tasks_done}/{total_tasks}, ETA: {time.strftime('%H:%M:%S', time.gmtime(eta))}", end='\r')

    return open_ports

# Function to save results to a text file
def save_message_to_txt(data, file_format="txt"):
    file_path = f'output.{file_format}'
    try:
        if file_format == "txt":
            with open(file_path, 'w') as txt_file:
                txt_file.write(f"Network: {data['network']}\n")
                txt_file.write(f"Port Range: {data['port_range']}\n")
                txt_file.write("Open Ports:\n")
                for port in data['open_ports']:
                    txt_file.write(f"{port}\n")
        elif file_format == "json":
            with open(file_path, 'w') as json_file:
                json.dump(data, json_file, indent=4)
        print(f"Results saved to {file_path}")
    except IOError as e:
        print(f"Error saving to file: {e}")

# Function to parse the port range input (e.g., 20-1024)
def parse_port_range(port_range_str):
    try:
        start, end = map(int, port_range_str.split('-'))
        return list(range(start, end + 1))
    except ValueError:
        print("Invalid port range format. Please enter a valid range (e.g., 20-1024).")
        return []

try:
    # Get user input for network and port range
    print("Enter the network range (e.g., 192.168.1.0/24):")
    network = input(">>> ")  # Store the network range as a string
    port_range_input = input("Enter the port range (e.g., 20-1024) or 'all' to scan all ports:\n>>> ")

    if port_range_input == "*" or port_range_input == "all":
        port_range = list(range(1, 65536))  # All ports from 1 to 65535
    else:
        port_range = parse_port_range(port_range_input)

    if not port_range:
        print("Invalid port range. Exiting.")
    else:
        # Run the network scanner
        if __name__ == "__main__":
            open_ports = network_scan_with_eta(network, port_range)

            # Save the results to a file if open ports are found
            if open_ports:
                data = {
                    "network": network,
                    "port_range": port_range_input,
                    "open_ports": open_ports
                }
                save_message_to_txt(data, file_format="txt")  # Save as plain text
            else:
                print("[-] No open ports found.")

except KeyboardInterrupt:
    print("\n[-] Exiting")
