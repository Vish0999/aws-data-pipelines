import boto3
import sys
import pymysql

def read_from_s3(bucket_name, file_key):
    s3 = boto3.client('s3')
    try:
        response = s3.get_object(Bucket=bucket_name, Key=file_key)
        data = response['Body'].read().decode('utf-8')
        print("Data fetched from S3:", data)
        return data
    except Exception as e:
        print(f"Error reading from S3: {e}")
        sys.exit(1)

def push_to_rds(data, db_params):
    try:
        import pymysql
        connection = pymysql.connect(
            host=db_params['host'],
            user=db_params['user'],
            password=db_params['password'],
            database=db_params['database']
        )
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO my_table (data) VALUES (%s)", (data,))
        connection.commit()
        print("Data pushed to RDS successfully")
    except Exception as e:
        print(f"Error pushing to RDS: {e}")
        return False
    return True

def push_to_glue(data, db_name, table_name):
    glue = boto3.client('glue')
    try:
        response = glue.batch_create_partition(
            DatabaseName=db_name,
            TableName=table_name,
            PartitionInputList=[{'Values': [data]}]
        )
        print("Data pushed to Glue:", response)
    except Exception as e:
        print(f"Error pushing to Glue: {e}")
        sys.exit(1)

if __name__ == "__main__":
    s3_bucket = "mybucket-123"
    s3_key = "mybucket.txt"
    data = read_from_s3(s3_bucket, s3_key)

    rds_params = {
        'host': 'mydatabase.abj123xyz.eu-north-1.rds.amazonaws.com',
        'user': 'admin',
        'password': 'password123',
        'database': 'mydatabase'
    }

    if not push_to_rds(data, rds_params):
        push_to_glue(data, 'glue_database', 'glue_table')
