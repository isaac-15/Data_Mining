import pandas as pd
import numpy as np
import itertools

support = 100


#rawFrame = pd.read_table('/home/isaac/Repos/Data_Mining/Homework_1/browsing-data.txt', sep = ' ', header = None, names = range(38))
#rawFrame = pd.read_table('test_data.txt', sep = ' ', header = None, names = range(38))
# rawFrame = rawFrame.transpose()


#* FINDING FREQUENT ITEMS
# for row, key in rawFrame.iterrows():
#     #print (row)
    
#     if not (key[1] == np.nan):  
#         #if an item is present, add one to the frequency
#         #else create the item in the dictionary and add 1
#         freq_items[key[1]] = freq_items.get(key[1], 0) + 1

freq_items = dict()

#loop through the file and find the frequency of all the ids
with open("/home/isaac/Repos/Data_Mining/Homework_1/browsing-data.txt") as file:
#with open("test_data.txt") as file:
    line_ids = list()
    for line in file:
        line_ids = line.split()

        for item in line_ids:
            #if an item is present, incerament its frequency. Otherwise add it to the list
            freq_items[item] = freq_items.get(item, 0) + 1


#create a list of keys to delete
keys_to_del = [key for key in freq_items if freq_items[key] < support]

#delete those items
for key in keys_to_del:
    del freq_items[key]

#print("freq_items", freq_items)
#print("freq_itemstype", type(freq_items),len(freq_items))




# #* Getting the canidate pairs   
print("canidate pairs")
#"
# create a list of canidate pairs from the frequent items
canidate_pairs = list(itertools.combinations(freq_items.keys(), 2))
# create a dictionary called frequent paris based on canidate_pairs
freq_pairs =  {key: None for key in canidate_pairs}
# set every value to zero
freq_pairs = dict.fromkeys(freq_pairs, 0)



# print("canidate_pairstype",(type(canidate_pairs)))
# print(("canidate_pairs",canidate_pairs))
# print("len",len(canidate_pairs))


#* Getting the freqent pairs
print("begin freq pairs")
#"
# loop through the file and for every line generate the pairs present on that line.
# then if a pair is in the canidate paris increment the frequency
with open("/home/isaac/Repos/Data_Mining/Homework_1/browsing-data.txt") as file:
#with open("test_data.txt") as file:

    line_ids = list()

    for line in file:
        line_ids = line.split()
        #print(ids)
        line_pairs = list(itertools.permutations(line_ids, 2))  
        #print(line_pairs)

        for item in line_pairs:
            if (item in freq_pairs):
                freq_pairs[item] += 1
                #print("added 1")

#"
#create a list of keys to delete
keys_to_del = [key for key in freq_pairs if freq_pairs[key] < support]
#print("keys to delete", keys_to_del)


#delete those items
for key in keys_to_del:
    del freq_pairs[key]

#print(freq_pairs)

#* finding canidate triples

print("Generating triples")
#"


# generate list of items in the frequent pairs
items = set()

for tuple in freq_pairs:
    items.add(tuple[0])
    items.add(tuple[1])
    
#print(items)


#first generate all possible triples
canidate_triples = list(itertools.combinations(items, 3))
#print(canidate_triples)

print("Removing non-canidate triples")
#"

triples_to_del = list()

# identify non canidate triples
for triple in canidate_triples:
    # generate pairs from triple
    sub_pairs = list(itertools.permutations(triple, 2))
    
    # check to see if the subpairs are frequent
    count = 0
    for pair in sub_pairs:
        if pair in freq_pairs.keys():
            #print("correct pair", pair) #"
            count += 1

    if count != 3:
        #print("To be removed: ", triple)#"
        canidate_triples.remove(triple)

# remove non canidate triples
# for item in triples_to_del:
#     canidate_triples.remove(item)

print(canidate_triples)

#iterate over data