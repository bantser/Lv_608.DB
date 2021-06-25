import csv

inputFilename = "PurchaseOrders.csv"
outputFilename = "PurchaseOrders.sql"
tableName = 'PurchaseOrders'

openInFile = open(inputFilename, 'r')
openOutFile = open(outputFilename, 'w')

csvFile = csv.reader(openInFile)
header = next(csvFile)
headers = map((lambda x: f"`{x}`"), header)
headers_without_id = list(headers)[1:]
insert = f"INSERT INTO {tableName} ({', '.join(headers_without_id)}) VALUES "

for row in csvFile:
    values = row[1:3]
    values.append(f'"{row[3]}"')
    statement = insert + f"({', '.join(values)});"
    print(statement)
    openOutFile.write(statement + '\n')
    
closing = ")"

openInFile.close()
openOutFile.close()