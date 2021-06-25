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
insert = f"INSERT INTO {tableName} ({', '.join(headers_without_id)}) VALUES"

openOutFile.write(insert + '\n')
for row in csvFile:
    values = row[1:3]
    values.append(f'"{row[3]}"')
    
    val_statement = f"({', '.join(values)}),"
    openOutFile.write(val_statement + '\n')
    print(val_statement)

openInFile.close()
openOutFile.close()
print(f"Done! Saved in {outputFilename}")