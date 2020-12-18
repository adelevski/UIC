import numpy as np
import random as rd
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_excel('D:\Python\School\ECE407\HW6\Q1-Data(HW6)(1).xlsx', index_col='Id')
df = pd.DataFrame(data)
df.pop('L')

m = df.shape[0] # number of examples (100)
n = df.shape[1] # number of features (2; x and y coordinates)

n_iter = 100    # number of iterations
K = 4           # number of clusters

s = (K, n)
centers = np.random.randint(0, 10, (s))




cluster1 = []
cluster2 = []
cluster3 = []
cluster4 = []

for x, y in zip(df['x'], df['y']):
    actual_dist = 0
    for i in range(K):
        temp_dist = np.sqrt(np.square(x-centers[i][0])+np.square(y-centers[i][1]))
        if temp_dist < actual_dist:
            actual_dist = temp_dist
            print







#
# test_x = 4.9
# test_y = 6.2
#
# plt.scatter(test_x, test_y, label='Test')
# plt.title('Q1-Data(HW6)')
# plt.xlabel('X')
# plt.ylabel('Y')
# plt.legend()
# plt.show()


# ds1 = df[:50] # Class 0
# ds1x = ds1['x']
# ds1y = ds1['y']

# ds2 = df[50:] # Class 1
# ds2x = ds2['x']
# ds2y = ds2['y']

# plt.scatter(ds1x, ds1y, label='Class 0')
# plt.scatter(ds2x, ds2y, label='Class 1')
