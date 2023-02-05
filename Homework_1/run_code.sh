import pandas as pd
import numpy as np

support = 100

#* importing the file
#pd.read_table('./test.txt', sep="  ", header=None)
# reads the file data into a table with 38 rows
dFrame = pd.read_table('/home/isaac/Repos/Data_Mining/Homework_1/browsing-data.txt', sep = ' ', header = None, names = range(38))
print(dFrame)

#* finding frequent items
#notice: python dictionaries are hashtables
freq_items = dict()

for row, key in dFrame.iterrows():
    
    if not (key[1] == "NaN"):  
        #if an item is present, add one to the frequency
        #else create the item in the dictionary and add 1
        freq_items[key[1]] = freq_items.get(key[1], 0) + 1

#create a list of keys to delete
keys_to_del = [key for key in freq_items if freq_items[key] < support]

#delete those items
for key in keys_to_del:
    del freq_items[key]

print(freq_items)