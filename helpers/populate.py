import json

def populate(table_name: str, json_file: str) -> None:
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(table_name)

    json_data = read_json_file(file_path=json_file)

    print(f"Loading '{json_file}' into '{table_name}'...")

    with table.batch_writer() as batch:
        for item in json_data:
            batch.put_item(Item=item)

    print(f"Loaded successfully.")
    
def read_json_file(file_path):
    with open(file_path, 'r') as json_file:
        data = json.load(json_file)
    return data


if __name__ == '__main__':

    tables_files = [[f"{name}", f"data/serviciozulet/{name}.json"] for name in ["restrictions", "workers", "shifts", "workers"]]
    
    if True:
        import localstack_client.session as boto3
    else:
        import boto3
    
    for table_name, json_file in tables_files:
        populate(table_name=table_name, json_file=json_file)