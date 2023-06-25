from uuid import uuid4
from boto3.dynamodb.types import TypeDeserializer, TypeSerializer

# ARGS EXAMPLE
# service_name = "Servicio de Zulet"

# workers_with_restrictions = {
#     'Rocio': ["2023/03/02", "2023/03/03", "2023/03/04", "2023/03/05"],
#     'Maria': ["2023/03/12", "2023/03/13", "2023/03/14", "2023/03/15"],
#     'Pablo': ["2023/03/22", "2023/03/23", "2023/03/24", "2023/03/25"], 
#     'Ines': ["2023/03/06", "2023/03/07", "2023/03/08", "2023/03/09"],
#     'Ric': ["2023/03/16", "2023/03/17", "2023/03/18", "2023/03/19"],
#     'Ravi': ["2023/03/26", "2023/03/27", "2023/03/28", "2023/03/29"],
#     }

# shifts_dates_list = [f"2023/03/{day}" for day in range(1, 31)]


def generate_resources(service_name, workers_with_restrictions, shifts_dates_list):
    services = [
        {
        "name": service_name,
        "id": str(uuid4())
        }
        ]

    service_id = services[0]["id"]

    workers = []
    restrictions = []
    for name in workers_with_restrictions:
        worker = {
            "name": name,
            "id": str(uuid4()),
            "service_id": service_id
        }
        workers.append(worker)
        for date in workers_with_restrictions[name]:
            restriction = {
                "id": str(uuid4()),
                "worker_id": worker["id"],
                "service_id": service_id,
                "name": "Sin nombre",
                "description": "Sin descripcion",
                "datetime": date,
            }
            restrictions.append(restriction)
    
    shifts = []
    for shift_date in shifts_dates_list:
        shift = {
            "id": str(uuid4()),
            "service_id": service_id,
            "datetime": shift_date,
            "name": "Sin nombre",
            "description": "Sin descripcion"
            }
        shifts.append(shift)

    resources = {
        "services": services,
        "workers": workers,
        "restrictions": restrictions,
        "shifts": shifts
    }
    
    return resources


def generate_dynamodb_items(list_of_dicts):
    type_serializer = TypeSerializer()

    items = []
    for item in list_of_dicts:
        item_dict = {}
        for key in item:
            item_dict[key] = type_serializer.serialize(item[key])
        items.append(item_dict)
    
    return items