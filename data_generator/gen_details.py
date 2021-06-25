import csv
import random

records = 1000000
fieldnames = ['PurchaseOrderDetailID','PurchaseOrderID','ProductID','Quantity','Price']
filename = "PurchaseOrderDetails.csv"
print(f"Making {records} records for {fieldnames}")

writer = csv.DictWriter(open(filename, "w"), fieldnames=fieldnames, lineterminator='\n')

writer.writerow(dict(zip(fieldnames, fieldnames)))
for i in range(1, records+1):
  writer.writerow(dict([
    (fieldnames[0], i),
    (fieldnames[1], i),
    (fieldnames[2], str(random.randint(0,1000000))),
    (fieldnames[3], str(random.randint(0,1000))),
    (fieldnames[4], str(round(random.uniform(500,10000), 2)))
    ]))

print(f"Done! Saved in {filename}")