import networkx as nx
import matplotlib.pyplot as plt


def plot_graph(graph, weight_name=None):
    plt.figure()
    pos = nx.spring_layout(graph)

    if weight_name:
        labels = nx.get_edge_attributes(graph, weight_name)
        nx.draw_networkx_edge_labels(graph, pos, edge_labels=labels)
        nx.draw(graph, pos)
    else:
        nx.draw(graph, pos)
    plt.show()


open_file = open("email_network.txt", "r")
file_text = open_file.read()
open_file.close()
print(file_text)
print()

# 1ο Ερώτημα.
graph = nx.read_edgelist("email_network.txt",
                         data=[('time', int)],
                         create_using=nx.MultiDiGraph())
# plot_graph(graph)

# 2ο Ερώτημα.
numEmails = len(graph.edges())
numEmployees = len(graph.nodes())
print("Number of emails: ", numEmails)
print("Number of employees: ", numEmployees)
print()


# 3ο Ερώτημα.
strong = nx.is_strongly_connected(graph)
weak = nx.is_weakly_connected(graph)

print("Is the graph strongly connected? ", strong)
print("Is the graph weakly connected? ", weak)
print()


# 4o Ερώτημα.
max_numweak = max(nx.weakly_connected_components(graph), key=len)
print(len(max_numweak))
print()

# 5o Ερώτημα.
max_numstrong = max(nx.strongly_connected_components(graph), key=len)
print(len(max_numstrong))
print()

# 6o Ερώτημα.
g = max(nx.strongly_connected_components(graph), key=len)
gsc = graph.subgraph(g)
# plot_graph(gsc)


# 7o Ερώτημα.
print("Average distance between nodes: ", nx.average_shortest_path_length(gsc))
print()

# 8o Ερώτημα.
print("Diameter of the graph: ", nx.diameter(gsc))
print()

# 9o Ερώτημα.
print("Nodes with eccentricity equal to the diameter:", nx.periphery(gsc))
print()

# 10o Ερώτημα.
print("Nodes with eccentricity equal to the radius:", nx.center(gsc))
print()

# 11o Ερώτημα.
peri = nx.periphery(gsc)
diam = nx.diameter(gsc)

numPathsDiam = {}

for node in peri:
    sp = nx.shortest_path(G=gsc, source=node)
    pathsLengthDiam = [
        path for path in sp.values() if (len(path) - 1 == diam)]
    numPathsDiam[node] = len(pathsLengthDiam)

key = list(numPathsDiam.keys())
values = list(numPathsDiam.values())
resultKey = key[values.index(max(values))]

print("Node with the most number of shortest paths equal to the diameter: ",
      resultKey, "Paths: ", numPathsDiam[resultKey])
print()

# 12o Ερώτημα.
n = resultKey
c = nx.center(gsc)[0]
conn = nx.node_connectivity(gsc, s=c, t=n)
print("Number of nodes required to be removed in order to disconnect the center from the node: ", conn - 1)
print()

# 13o Ερώτημα.
un = gsc.to_undirected()
plot_graph(nx.Graph(un))

# 14o Ερώτημα.
g = nx.Graph(un)
print("Transitivity of the graph: ", nx.transitivity(g))
print("Average clustering coefficient of the graph: ", nx.average_clustering(g))
print()
