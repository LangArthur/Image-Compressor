#!/usr/bin/python3
# -*-coding:Utf-8 -*

import re
import sys

from PIL import Image

path = "./new_img"

def getCentroid(line):
    res = ()
    line = line.replace("(", "").replace(")", "").split(',')
    r = int(line[0])
    g = int(line[1])
    b = int(line[2])
    return (r, g, b)

def getCoor(line):
    return (line.split(" ")[0])

def creatKey(i, j):
    return "(" + str(i) + "," + str(j) + ")"

def getPointArray(points):
    res = [];
    i = 0
    j = 0
    line = []
    key = creatKey(i, j)
    while (key in points):
        while (key in points):
            line.append(points[key])
            j += 1
            key = creatKey(i, j)
        res.append(line)
        line = []
        j = 0
        i += 1
        key = creatKey(i, j)
    return(res)


def treatContent(content):
    file = content.split('\n')
    points = {};
    i = 0;
    while(file[i]):
        if (file[i] == "--" and file[i + 1]):
            centroid = getCentroid(file[i + 1])
        elif(file[i] != "-"):
            points[getCoor(file[i])] = centroid
        i += 1
    return getPointArray(points)

def main():
    av = sys.argv
    f = open(path, "r")
    content = treatContent(f.read())
    img = Image.new("RGB", (len(content), len(content[0])))
    pix = img.load()
    x = 0;
    y = 0;
    for line in content:
        for point in line:
            pix[y, x] = point
            y += 1;
        y = 0;
        x += 1;
    img.save(av[1].split(".")[0] + "_compressed.jpg")
    return(0)

if __name__ == '__main__':
    main()