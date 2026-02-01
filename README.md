# ETL-task1

Задание выполнил: Дундуков Николай

Запуск:
1. docker-compose up -d postgres
2. docker-compose up -d
3. docker-compose exec airflow-webserver airflow connections delete airflow_db 2>/dev/null || true
4. docker-compose exec airflow-webserver airflow connections add 'airflow_db' \
  --conn-type 'postgres' \
  --conn-host 'postgres' \
  --conn-schema 'airflow' \
  --conn-login 'airflow' \
  --conn-password 'airflow' \
  --conn-port 5432

После этого можно запустить dag extract. Приложены скриншоты логов и результата