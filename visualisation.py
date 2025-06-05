from pymongo import MongoClient
import networkx as nx
import matplotlib.pyplot as plt

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client["Hospital"]

# Create a graph
G = nx.DiGraph()

# Loop through each collection
for col_name in db.list_collection_names():
    collection = db[col_name]
    doc = collection.find_one()

    if doc:
        # Add collection node
        G.add_node(col_name, color='skyblue', size=2000)

        for field in doc:
            field_node = f"{col_name}.{field}"
            G.add_node(field_node, color='lightgreen', size=1000)
            G.add_edge(col_name, field_node)

# Draw the graph
colors = [nx.get_node_attributes(G, 'color').get(node, 'grey') for node in G.nodes]
sizes = [nx.get_node_attributes(G, 'size').get(node, 800) for node in G.nodes]

plt.figure(figsize=(12, 10))
pos = nx.spring_layout(G, k=0.5)
nx.draw(G, pos, with_labels=True, node_color=colors, node_size=sizes, edge_color='gray', font_size=8)
plt.title("MongoDB Hospital Database Structure", fontsize=14)
plt.show()
