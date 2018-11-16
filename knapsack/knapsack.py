# Given a set of n items numbered from 1 up to n, each with a weight w[i]
# and a value v[i] and a maximum weight W
# maximize sum(v[i] * x[i]), i = 1..n
# subject to sum(w[i] * x[i]) <= W, x[i] is {0, 1}
#
# maximize the sum of the values of the items thjat fit the knapsack weight capacity

# def knapsack(v, w, W):

class Item(object):
    def __init__(self, n, v, w):
        self.name = n
        self.value = v
        self.weight = w

    def density(self):
        return self.value / self.weight

    def __str__(self):
        return "{0}: {1}, {2}".format(self.name, self.value, self.weight)



items = []
items.append(Item("rock", 1, 200))
items.append(Item("gold ring", 1500, 20))
items.append(Item("crowbar", 10, 1500))
items.append(Item("coin", 10, 50))
items.append(Item("shoebox", 30, 250))
items.append(Item("watch", 100, 100))
items.append(Item("notebook", 900, 1200))
