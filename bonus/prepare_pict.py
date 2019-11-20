#!/usr/bin/python3
# -*-coding:Utf-8 -*

import sys
from PIL import Image

def main():
    av = sys.argv
    img = Image.open(av[1])
    array = img.load()
    size = img.size
    output = open("./convert_img", "w")
    for i in range(0, size[1] - 1):
        for j in range(0, size[0] - 1):
            output.write("({},{}) ({},{},{})\n".format(i, j, array[j, i][0], array[j, i][1], array[j, i][2]));
    return 0

if __name__ == '__main__':
    main()