import pandas as pd
import numpy as np
import itertools

support = 100

#* importing the file
#pd.read_table('./test.txt', sep="  ", header=None)
# reads the file data into a table with 38 rows
rawFrame = pd.read_table('/home/isaac/Repos/Data_Mining/Homework_1/browsing-data.txt', sep = ' ', header = None, names = range(38))


# rawFrame = rawFrame.transpose()
# print(rawFrame)
#* finding frequent items

# column_names = ["Freq"]
# numFrame = rawFrame.apply(pd.Series.value_counts).transpose()
# numFrame = numFrame.sum()
# numFrame = pd.DataFrame(numFrame, columns = column_names)
# print(numFrame)
# freqItems = numFrame[numFrame['Freq'] > 99]
# print(freqItems)



#notice : python dictionaries are hashtables
freq_items = dict()

for row, key in rawFrame.iterrows():
    #print (row)
    
    if not (key[1] == np.nan):  
        #if an item is present, add one to the frequency
        #else create the item in the dictionary and add 1
        freq_items[key[1]] = freq_items.get(key[1], 0) + 1

#create a list of keys to delete
keys_to_del = [key for key in freq_items if freq_items[key] < support]

#delete those items
for key in keys_to_del:
    del freq_items[key]

print("freq_items", freq_items)
print("freq_itemstype", type(freq_items),len(freq_items))
# #* Getting the canidate pairs   
# # #a list of the combinations of frequent items. These combinations are tuples

canidate_pairs = list(itertools.combinations(freq_items, 2))
freq_pairs =  {key: None for key in canidate_pairs}
freq_pairs = dict.fromkeys(freq_pairs, 0)
#print(freq_pairs)

print("canidate_pairstype",(type(canidate_pairs)))
print(("canidate_pairs",canidate_pairs[0:3]))
print("len",len(canidate_pairs))
# # print(rawFrame.notna().mean())
# # #print(canidate_pairs)
# # #print(rawFrame)
# #print(rawFrame)
# #print(rawFrame.notna().mean())

#for pair in canidate_pairs().key


# #* remove the non frequent items from the data 
# for row, col in rawFrame.iterrows():
#     if col[1] not in freq_items.keys():
#         col[1] = np.nan

with open("/home/isaac/Repos/Data_Mining/Homework_1/browsing-data.txt") as file:
    for line in file:
        ids = line.split()
        #print(ids)
        line_pairs = list(itertools.combinations(ids, 2))  

        for item in line_pairs:
            if (item in freq_pairs):
                freq_pairs[item] += 1


#create a list of keys to delete
keys_to_del = [key for key in freq_pairs if freq_pairs[key] < support]

#delete those items
for key in keys_to_del:
    del freq_pairs[key]





print(freq_pairs)
print("fin")


# #* Finding frequent pairs
#iterate over rawFrame checking if each basket contains a pair
# for basket in rawFrame.iterrows():
#     print(basket[1])
# # # #           
# # canidate_pairs_dict = dict(canidate_pairs)