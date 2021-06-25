import csv

inputFilename = "PurchaseOrders.csv"
tableName = 'PurchaseOrders'

openInFile = open(inputFilename, 'r')

csvFile = csv.reader(openInFile)
header = next(csvFile)
headers = map((lambda x: f"`{x}`"), header)
insert = f"INSERT INTO {tableName} ({', '.join(headers)}) VALUES "

for row in csvFile:
    values = map((lambda x: f'"{x}"'), row)
    print(insert + f"({', '.join(values)});")

openInFile.close()
