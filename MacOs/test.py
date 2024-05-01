uninstallRequirement = ["--UNINSTALL", "--uninstall"]
FIX = ["--FIX", "--fix"]

combined_arguments = []

for uninstall_arg in uninstallRequirement:
    for fix_arg in FIX:
        combined_arguments.append(uninstall_arg + " " + fix_arg)

print(combined_arguments)

