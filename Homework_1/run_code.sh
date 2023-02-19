import pandas as pd
from collections import OrderedDict 
import numpy as np
import itertools
from operator import itemgetter

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
total_items = 0

#loop through the file and find the frequency of all the ids
with open("./browsing-data-copy.txt") as file:
#with open("test_data.txt") as file:
#with open("browsingdata_50baskets.txt") as file:
    line_ids = list()
    for line in file:
        line_ids = line.split()

        for item in line_ids:
            #if an item is present, incerament its frequency. Otherwise add it to the list
            freq_items[item] = freq_items.get(item, 0) + 1

total_items = len(freq_items)
#print(total_items, "tot items")
#create a list of keys to delete
keys_to_del = [key for key in freq_items if freq_items[key] < support]

#delete those items
for key in keys_to_del:
    del freq_items[key]

#print("freq_items", freq_items)
#print("freq_itemstype", type(freq_items),len(freq_items))




# #* Getting the canidate pairs   
#print("canidate pairs")
#"
#("/home/isaac/Repos/Data_Mining/Homework_1/browsing-data.txt") create a list of canidate pairs from the frequent items
canidate_pairs = list(itertools.combinations(freq_items.keys(), 2))
canidate_pairs_sorted = list()

for key in canidate_pairs:
    if key[1] < key[0]:
        newtup = (key[1], key[0])
        canidate_pairs_sorted.append(newtup)
        #print("true", key, newtup)

    else:
        canidate_pairs_sorted.append(key)

#print(canidate_pairs_sorted)
        




# create a dictionary called frequent paris based on canidate_pairs
freq_pairs =  {key: None for key in canidate_pairs_sorted}
# set every value to zero
freq_pairs = dict.fromkeys(freq_pairs, 0)

# print("canidate_pairstype",(type(canidate_pairs)))
# print(("canidate_pairs",canidate_pairs))
# print("len",len(canidate_pairs))


#* Getting the freqent pairs
#print("begin freq pairs")
#"
# loop through the file and for every line generate the pairs present on that line.
# then if a pair is in the canidate paris increment the frequency
with open("./browsing-data-copy.txt") as file:
#with open("browsingdata_50baskets.txt") as file:
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

#print("freq pairs", freq_pairs)

#* FIND CANIDATE TRIPLES

#print("Generating triples")
#"


# generate list of items in the frequent pairs
# *items = set()

# *for tuple in freq_pairs:
#  *   items.add(tuple[0])
#   *  items.add(tuple[1])

canidate_triples = list()

for tuple in freq_pairs:
    for item in freq_items:
        canidate_triples.append((tuple[0], tuple[1], item))
    
#print(items)


#first generate all possible triples
#*canidate_triples = list(itertools.combinations(items, 3))

#"

triples_to_del = list()
dic_canidate_triples = dict()

# identify non canidate triples
for triple in canidate_triples:
    # generate pairs from triple
    sub_pairs = list(itertools.permutations(triple, 2))
    
    # check to see if the subpairs are frequent
    count = 0
    for pair in sub_pairs:
        if freq_pairs.get(pair) != None:
            #print("correct pair", pair) #"
            count += 1

    # if the triple's subpairs are present, add it to a dictionary
    if count == 3:
        #print("To be removed: ", triple)#"
        #canidate_triples.remove(triple)
        dic_canidate_triples[triple] = dic_canidate_triples.get(triple, 0)

#print("Got canidate triples!")#"
#print(dic_canidate_triples)

#* FIND FREQUENCY OF TRIPLES

with open("./browsing-data-copy.txt") as file:
#with open("browsingdata_50baskets.txt") as file:
#with open("test_data.txt") as file:

    line_ids = list()

    for line in file:
        line_ids = line.split()
        #print(ids)
        line_triples = list(itertools.permutations(line_ids, 3))  
        #print(line_pairs)

        for item in line_triples:
            if dic_canidate_triples.get(item) != None:
                dic_canidate_triples[item] += 1
                #print("added 1")

#"
#print("counted canidate triples")#"


#print(canidate_triples)

#iterate over data

#* DELETE UNSUPPORTED TRIPPLES

#create a list of keys to delete
keys_to_del = [key for key in dic_canidate_triples if dic_canidate_triples[key] < support]
#print("keys to delete", keys_to_del)


#delete those items
for key in keys_to_del:
    del dic_canidate_triples[key]

#print("Suported triples") #"

#* FIND ASSOSIATIONS

item_assosiation = dict()
pair_assosiation = dict()


for pair in freq_pairs:
    item = freq_items[pair[0]]
    item2 = freq_items[pair[1]]
    pair2 = (pair[1],pair[0])

    item_assosiation[pair2] = item_assosiation.get(pair2, (freq_pairs[pair]/(item2)))
    item_assosiation[pair] = item_assosiation.get(pair, (freq_pairs[pair]/item))

#sort item assosiation
# keys = list(item_assosiation.keys())
# values = list(item_assosiation.values())
# sorted_value_index = np.argsort(values)
# item_assosiation_sorted = {keys[i] : values[i] for i in sorted_value_index}

# print("---------------------------------")
# print(item_assosiation_sorted)

# print("---------------------------------")



pair_assosiation = dict()
#print(dic_canidate_triples)


for triple in dic_canidate_triples:
    #print(triple) 
    x =triple[0]
    y =triple[1]
    z =triple[2]
    #print(x,", ",y, ", ",z)#" 
    
    xy = (x, y)
    yx = (y, x)

    yz = (y, z)
    zy = (z, y)

    xz = (x, z)
    zx = (z, x)

    xyz = (x, y, z)
    yxz = (y, z, z)

    yzx = (y, z, x)
    zyx = (z, y, x)

    xzy = (x, z, y)
    zxy = (z, x, y)
    

    if freq_pairs.get(xy) != None:
        #print("xy")
        pair_assosiation[xyz] = pair_assosiation.get(xyz, (dic_canidate_triples[triple]/freq_pairs[xy]))
 
    if freq_pairs.get(yx) != None:
        pair_assosiation[yxz] = pair_assosiation.get(yxz, (dic_canidate_triples[triple]/freq_pairs[yx]))
        #print("yx")

    if freq_pairs.get(yz) != None:
        pair_assosiation[yzx] = pair_assosiation.get(yzx, (dic_canidate_triples[triple]/freq_pairs[yz]))
        #print("yz")
        #print(pair_assosiation[yz])

    if freq_pairs.get(zy) != None:
        pair_assosiation[zyx] = pair_assosiation.get(zyx, (dic_canidate_triples[triple]/freq_pairs[zy]))
        #print("zy")

    if freq_pairs.get(xz) != None:
        pair_assosiation[xzy] = pair_assosiation.get(xzy, (dic_canidate_triples[triple]/freq_pairs[xz]))
        
        #print("xz")

    if freq_pairs.get(zx) != None:
        pair_assosiation[zxy] = pair_assosiation.get(zxy, (dic_canidate_triples[triple]/freq_pairs[zx]))
        #print("zx")

    #print(pair_assosiation)
    
    # yz = (triple[1] ++ triple[2])
    # xz = (triple[1] ++ triple[2])

    #xy_freq = freq_pairs[xy]
    #print(xy_freq)
    # yz_freq = freq_pairs[yz]
    # xz_freq = freq_pairs[xz]

    #pair_assosiation[xy] = pair_assosiation.get(xy, (dic_canidate_triples[triple], ))

with open('./output.txt', 'w') as f:

    res = list(sorted(item_assosiation.items(), key = itemgetter(1), reverse = True)[:5])
    f.write("OUTPUT A\n")
    for item in res:
        string = str() #"
        string = str(item[0]) + " " + str(item[1]) + "\n"
        f.write(string)


    f.write("\n")

    res2 = list(sorted(pair_assosiation.items(), key = itemgetter(1), reverse = True)[:15])

    res2 = sorted(res2)

    res2 = res2[0:5]

    f.write("OUTPUT B\n")
    for item in res2:
        string = str()
        string = str(item[0]) + " " + str(item[1]) + "\n"
        f.write(string)
