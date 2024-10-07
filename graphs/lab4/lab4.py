import matplotlib.pyplot as plt
import networkx as nx

# Preferential attachment model.
g = nx.barabasi_albert_graph(1000000, 1)
degrees = dict(g.degree())
degree_values = sorted(set(degrees.values()))
histogram = [list(degrees.values()).count(
    i)/float(nx.number_of_nodes(g)) for i in degree_values]

plt.plot(degree_values, histogram, 'o')
plt.xlabel('Degree')
plt.ylabel('Fraction of Nodes')
plt.xscale('log')
plt.yscale('log')
plt.show()


# Small-world Problem.
g = nx.watts_strogatz_graph(1000, 6, 0.04)
degrees = dict(g.degree())
degree_values = sorted(set(degrees.values()))
histogram = [list(degrees.values()).count(
    i)/float(nx.number_of_nodes(g)) for i in degree_values]
plt.bar(degree_values, histogram)
plt.xlabel('Degree')
plt.ylabel('Fraction of Nodes')
plt.show()
