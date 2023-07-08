import json
import argparse
import os
import boto3

# Use python populate.py --help to see a summary of usage.



def validate_and_return_json_files(directory):
    try:
        lista = os.listdir(directory)
        
    except Exception as e:
        print("Could not locate the files. Review the directory provided.")
    
    lista_jsons = [f for f in lista if f.endswith(".json")]
    print(f"Files to populate: {lista_jsons} in {directory}")
    
    return lista_jsons

def create_parser():
    parser = argparse.ArgumentParser()
    parser.description = "Populates the selected environment with the data in the directory passed an argument."
    parser.add_argument("env", help="environment to deploy", choices=["prod", "dev", "local"])
    parser.add_argument("dir", help="directory containing json files with the names of the tables")
    return parser

def populate(dynamodb, table_name: str, json_file: str) -> None:
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
    # 1. Create parser
    args = create_parser().parse_args()

    # 2. Set environment and api
    if args.env in ["prod", "dev"]:
        dynamodb = boto3.resource('dynamodb')
        print("Populating to the cloud.")
    if args.env == "local":
        dynamodb = boto3.resource('dynamodb', endpoint_url="https://localhost.localstack.cloud:4566")
        print("Populating to the local environment.")  
    
    
    
    # 3. Get available tables:
    table_names = [table.name for table in dynamodb.tables.all()]
    print(f"Available tables: {table_names}")
    
    if not table_names:
        print("No tables available. Exiting...")
        exit(1)
    
    # 4. Validate directory and return json files
    json_files = validate_and_return_json_files(directory=args.dir)
    
    # 5. Check if tables are in the list of available tables
    for json_file in json_files:
        table_name = f"{args.env}-{json_file.split('.')[0]}"
        if table_name not in table_names:
            print(f"Table '{table_name}' not in available tables.")
            print("Exiting...")
            exit(1)
    
    # 6. Populate tables
    for json_file in json_files:
        table_name = f"{args.env}-{json_file.split('.')[0]}"
        populate(dynamodb=dynamodb, table_name=table_name, json_file=f"{args.dir}/{json_file}")