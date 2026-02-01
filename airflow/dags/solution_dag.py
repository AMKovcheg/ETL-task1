from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from datetime import datetime, timedelta

with DAG(
    'extract',
    schedule_interval=timedelta(minutes=30),
    start_date=datetime(2025, 1, 1),
    catchup=False,
) as dag:
    history = PostgresOperator(
        task_id='extract_json',
        postgres_conn_id='airflow_db',
        sql="""
        DROP TABLE IF EXISTS extract_demo.data_from_json;
        
        CREATE TABLE extract_demo.data_from_json AS
        SELECT
            post.value->>'name' AS name,
            post.value->>'species' AS species,
            post.value->>'favFoods' AS favFoods,
            (post.value->>'birthYear')::INTEGER AS birthYear,
            TRIM(post.value->>'photo') AS photo
        FROM extract_demo.json_content,
        LATERAL jsonb_array_elements(json_data->'pets') AS post(value)
        WHERE id = 1;
        """
    )