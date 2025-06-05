import networkx as nx
import matplotlib.pyplot as plt

# Initialize directed graph
G = nx.DiGraph()

# Define nodes (collections)
collections = [
    "patients", "rooms", "appointments", "billing",
    "test_reports", "employees", "doctors", "nurses"
]

# Add all collections as nodes
G.add_nodes_from(collections)

# Define relationships (edges) based on references/embeddings
relationships = [
    ("patients", "rooms"),              # Embedded room info
    ("patients", "appointments"),       # Embedded appointments
    ("patients", "billing"),            # Embedded bills
    ("patients", "test_reports"),       # Embedded test reports
    ("appointments", "doctors"),        # doctor_eid reference
    ("doctors", "employees"),           # Inherited from employee
    ("nurses", "employees"),            # Inherited from employee
    ("rooms", "nurses")                 # via governs table
]

# Add edges to the graph
G.add_edges_from(relationships)

# Draw the graph
plt.figure(figsize=(10, 7))
pos = nx.spring_layout(G, seed=42)
nx.draw(G, pos, with_labels=True, node_size=3000, node_color="lightgreen", font_size=10, font_weight="bold", arrows=True)
plt.title("MongoDB Schema Structure: Collection Relationships")
plt.show()
