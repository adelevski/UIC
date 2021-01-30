import pandas as pd

read_file = pd.read_csv ('breast-cancer.txt', header = None)
read_file.columns = ['Class', 'Age', 'menopause', 'tumor-size', 'inv-nodes', 'node-caps', 'deg-malig', 'breast', 'breast-quad', 'irradiat']
read_file.to_csv ('breast-cancer.csv', index=None)