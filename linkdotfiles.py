import os


dirname, filename = os.path.split(os.path.abspath(__file__))
filelist = os.listdir(dirname)
print(filelist)
