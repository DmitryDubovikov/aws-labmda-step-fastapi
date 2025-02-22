#!/bin/bash

# Ждем, пока LocalStack будет готов
echo "Waiting for LocalStack to be ready..."
until awslocal stepfunctions list-state-machines; do
    sleep 1
done

# Параметры
STATE_MACHINE_NAME="OrderProcessingStateMachine"
DEFINITION_FILE="/stepfunctions/order_processing.json"
ROLE_ARN="arn:aws:iam::000000000000:role/DummyRole"

# Проверка существования файла с определением машины состояний
if [ ! -f "$DEFINITION_FILE" ]; then
  echo "Файл определения машины состояний не найден: $DEFINITION_FILE"
  exit 1
fi

# Создание машины состояний с помощью awslocal
echo "Создание машины состояний '$STATE_MACHINE_NAME'..."
awslocal stepfunctions create-state-machine \
  --name "$STATE_MACHINE_NAME" \
  --definition file://"$DEFINITION_FILE" \
  --role-arn "$ROLE_ARN"

if [ $? -eq 0 ]; then
  echo "Машина состояний '$STATE_MACHINE_NAME' успешно создана."
else
  echo "Ошибка при создании машины состояний '$STATE_MACHINE_NAME'."
fi
