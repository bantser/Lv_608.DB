import csv

inputFilename = "PurchaseOrderDetails.csv"
outputFilename = "PurchaseOrderDetails.sql"
tableName = 'PurchaseOrderDetails'

openInFile = open(inputFilename, 'r')
openOutFile = open(outputFilename, 'w')

csvFile = csv.reader(openInFile)
header = next(csvFile)
headers = map((lambda x: f"`{x}`"), header)
headers_without_id = list(headers)[1:]
insert = f"INSERT INTO {tableName} ({', '.join(headers_without_id)}) VALUES"

openOutFile.write(insert + '\n')
for row in csvFile:
    values = row[1:]
    
    val_statement = f"({', '.join(values)}),"
    openOutFile.write(val_statement + '\n')
    print(val_statement)

openInFile.close()
openOutFile.close()
print(f"Done! Saved in {outputFilename}")