import os


dirname, filename = os.path.split(os.path.abspath(__file__))
filelist = os.listdir(dirname)
print(filelist)

for file in filelist:
   if file[0] == '.' and '.swp' not in file:
      print('ln -s'+dirname+'/'+file)
      os.system('ln -s'+dirname+'/'+file+' '+'~/'+file)
