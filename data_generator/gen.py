import csv
import random
from faker import Faker

records=1000000
fieldnames=['PurchaseOrderID','SuplierID','EmployeeID','DeliveryDate']
filename = "data.csv"
fake = Faker()
print(f"Making {records} records for {fieldnames}")

writer = csv.DictWriter(open(filename, "w"), fieldnames=fieldnames, lineterminator='\n')

writer.writerow(dict(zip(fieldnames, fieldnames)))
for i in range(1, records+1):
  writer.writerow(dict([
    (fieldnames[0], i),
    (fieldnames[1], str(random.randint(0,1000000))),
    (fieldnames[2], str(random.randint(0,1000000))),
    (fieldnames[3], fake.date_between(start_date='-5y', end_date='today'))]))

print(f"Done! Saved in {filename}")