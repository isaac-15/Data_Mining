import pandas as pd


#* importing the file
#pd.read_table('./test.txt', sep="  ", header=None)
dFrame = pd.read_table('/home/isaac/Repos/Data_Mining/Homework_1/browsing-data.txt', sep = ' ', header = None, names = range(38))
print(dFrame)
