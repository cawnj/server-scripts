#!/usr/bin/python3

import sys
import subprocess

# get links from file
print("\naria-dl.py: Getting links...")
file = sys.argv[1]
with open(file) as f:
	links = [x.strip() for x in f.readlines()]

# download links
for link in links:
	# run download command
	print("\naria-dl.py: Downloading link:\n" + link)
	subprocess.run(["aria2c", "-c", "-d download", link], check=True)
	# remove link from file on completion
	with open(file, "r") as f:
		lines = f.readlines()
	with open(file, "w") as f:
		for line in lines:
			if line.strip("\n") != link:
				f.write(line)

# we done
print("\naria-dl.py: Done!")
