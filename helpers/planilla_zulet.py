from generators import generate_resources
import json
import os

service_name = "servicio-Zulet"

workers_with_restrictions = {
    'Rocio': ["2023/03/02", "2023/03/03", "2023/03/04", "2023/03/05"],
    'Maria': ["2023/03/12", "2023/03/13", "2023/03/14", "2023/03/15"],
    'Pablo': ["2023/03/22", "2023/03/23", "2023/03/24", "2023/03/25"], 
    'Ines': ["2023/03/06", "2023/03/07", "2023/03/08", "2023/03/09"],
    'Ric': ["2023/03/16", "2023/03/17", "2023/03/18", "2023/03/19"],
    'Ravi': ["2023/03/26", "2023/03/27", "2023/03/28", "2023/03/29"],
    }

shifts_dates_list = [f"2023/03/{day}" for day in range(1, 31)]

resources = generate_resources(service_name, workers_with_restrictions, shifts_dates_list)

path = f"data/{service_name}-json"
if not os.path.exists(path):
    os.mkdir(path)
    
for resource, items in resources.items():
    with open(f"{path}/{resource}.json", "w") as file:
        json.dump(items, file, indent=4)