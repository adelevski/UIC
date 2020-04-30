import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import copy
from sklearn.cluster import KMeans


data = pd.read_excel('D:\Python\School\ECE407\HW6\Q1-Data(HW6)(1).xlsx', index_col='Id')
df = pd.DataFrame(data)
df.pop('L')

kmeans = KMeans(n_clusters=4)
kmeans.fit(df)

labels = kmeans.predict(df)
centroids = kmeans.cluster_centers_
colmap = {1: 'r', 2: 'g', 3: 'b', 4: 'y'}

fig = plt.figure(figsize=(5, 5))
colors = map(lambda x: colmap[x+1], labels)

plt.scatter(df['x'], df['y'], alpha=0.5, edgecolor='k')
for idx, centroid in enumerate(centroids):
    plt.scatter(*centroid, color=colmap[idx+1])
plt.show()

print(centroids)