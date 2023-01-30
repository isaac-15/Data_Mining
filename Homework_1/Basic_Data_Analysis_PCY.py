import pandas as pd
import itertools

from HashTable import HashTable

support_threshold = 4

#* importing the file
dFrame = pd.read_csv("/home/isaac/Repos/Data_Mining/Homework_1/PCY_Data_2.csv")
print(dFrame)

hTable = HashTable(11)



#* to create a list of all the baskets
data_list = list()
for i in dFrame.index:
  num1 = dFrame.at[i, 'Data1']
  num2 = dFrame.at[i, 'Data2']
  num3 = dFrame.at[i, 'Data3']
  data_list.append([num1,num2,num3])
#print(data_list)

#* to get the pairs from the baskets
for sublist in data_list:
  perm = set(itertools.permutations(sublist, 2))
  #TODO for every permutation I want to hash it

  print(perm)

#* to identify the frequency of the individual items
#concatinates all of the data columns and removes their index columns
all_data = pd.concat([dFrame['Data1'],dFrame['Data2'],dFrame['Data3']], ignore_index=True)
#gets the freq of the data from the concatenated data and then sorts the key values
freq = all_data.value_counts().sort_index()

#print(all_data)
print(freq)
