class HashTable:
    def __init__(self, size):
        self.MAX = size
        self.arr = [None for i in range(self.MAX)]

    def get_hash(val):
        return val[0] *val[1] % 11

    def add(self, val):
        key = self.get_hash(val)
        self.arr[key] = val