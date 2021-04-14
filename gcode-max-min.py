#!/usr/bin/env python3
# gcode-max-min.py
# 
# Calculate the bounding-box for a GCode file
# Usage:
#   gcode-max-min.py input.gcode
#
# Prints GCode to move round the bounding box of `input.gcode`, 
# prefixed with a comment giving the [top, left] and [bottom, right] coordinates

import fileinput
import re

left = None
right = None
top = None
bottom = None

# This is a very naive matching, and might hit problems with more advanced gcode
x = re.compile("X([\d.-]+)")
y = re.compile("Y([\d.-]+)")

for line in fileinput.input():
  if x.search(line):
    # Found an x-coord
    x_coord = float(x.search(line)[1])
    if (left == None) or (x_coord < left):
      left = x_coord
    if (right == None) or (x_coord > right):
      right = x_coord
  if y.search(line):
    # Found an y-coord
    y_coord = float(y.search(line)[1])
    if (top == None) or (y_coord > top):
      top = y_coord
    if (bottom == None) or (y_coord < bottom):
      bottom = y_coord

print("( Bounding box: [%.8f, %.8f] to [%.8f, %.8f] )" % (left,top,right,bottom))
print("G1 X%.8f Y%.8f;" % (left, top))
print("G1 X%.8f Y%.8f;" % (right, top))
print("G1 X%.8f Y%.8f;" % (right, bottom))
print("G1 X%.8f Y%.8f;" % (left, bottom))
print("G1 X%.8f Y%.8f;" % (left, top))
