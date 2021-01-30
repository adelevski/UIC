import pandas as pd

data = pd.read_excel('D:\Python\School\ECE407\HW8\data2.xlsx')
df = pd.DataFrame(data)

x = df.cov()
print(x)


