import csv

inputFilename = "PurchaseOrderDetails.csv"
outputFilename = "PurchaseOrderDetails.sql"
tableName = 'PurchaseOrderDetails'
chunksize = 1000

openInFile = open(inputFilename, 'r')
openOutFile = open(outputFilename, 'w')

csvFile = csv.reader(openInFile)
header = next(csvFile)
headers = list(header)
headers_without_id = list(headers)[1:]
insert = f"INSERT INTO {tableName} ({', '.join(headers_without_id)}) VALUES"

openOutFile.write(insert + '\n')
cntr = 0
for row in csvFile:
    values = row[1:]
    if cntr < chunksize-1:
        val_statement = f"({', '.join(values)}),"
        openOutFile.write(val_statement + '\n')
    
        cntr += 1
    else:
        val_statement = f"({', '.join(values)});"
        openOutFile.write(val_statement + '\n')
        openOutFile.write(insert + '\n')
        
        cntr = 0

openInFile.close()
openOutFile.close()
print(f"Done! Saved in {outputFilename}")