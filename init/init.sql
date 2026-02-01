CREATE SCHEMA IF NOT EXISTS extract_demo;

CREATE TABLE IF NOT EXISTS extract_demo.json_content (
    id serial primary key,
    json_data jsonb
);

INSERT INTO extract_demo.json_content (id, json_data)
SELECT 1, '{
  "pets": [
    {
      "name": "Purrsloud",
      "species": "Cat",
      "favFoods": ["wet food", "dry food", "<strong>any</strong> food"],
      "birthYear": 2016,
      "photo": "https://learnwebcode.github.io/json-example/images/cat-2.jpg  "
    },
    {
      "name": "Barksalot",
      "species": "Dog",
      "birthYear": 2008,
      "photo": "https://learnwebcode.github.io/json-example/images/dog-1.jpg  "
    },
    {
      "name": "Meowsalot",
      "species": "Cat",
      "favFoods": ["tuna", "catnip", "celery"],
      "birthYear": 2012,
      "photo": "https://learnwebcode.github.io/json-example/images/cat-1.jpg  "
    }
  ]
}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM extract_demo.json_content WHERE id = 1);

GRANT ALL ON SCHEMA extract_demo TO airflow;
GRANT ALL ON ALL TABLES IN SCHEMA extract_demo TO airflow;
GRANT ALL ON ALL SEQUENCES IN SCHEMA extract_demo TO airflow;