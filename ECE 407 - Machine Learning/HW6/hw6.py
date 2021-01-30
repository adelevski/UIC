import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_excel('Q1-Data(HW6)(1).xlsx', index_col='Id')
df = pd.DataFrame(data)

ds1 = df[:50] # Class 0
ds1x = ds1['x']
ds1y = ds1['y']

ds2 = df[50:] # Class 1
ds2x = ds2['x']
ds2y = ds2['y']

test_x = 4.9
test_y = 6.2

plt.scatter(ds1x, ds1y, label='Class 0')
plt.scatter(ds2x, ds2y, label='Class 1')
plt.scatter(test_x, test_y, label='Test')
plt.title('Q1-Data(HW6)')
plt.xlabel('X')
plt.ylabel('Y')
plt.legend()
plt.show()

# print(ds2)

# x = df.loc[:, 'x']
# y = df.loc[:, 'y']
#
# plt.scatter(x, y)
# plt.show()

