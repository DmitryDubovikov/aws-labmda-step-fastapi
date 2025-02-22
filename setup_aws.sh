#!/bin/bash

# Wait for LocalStack to be ready
echo "Waiting for LocalStack to be ready..."
until awslocal stepfunctions list-state-machines; do
    sleep 1
done

# Parameters for state machine
STATE_MACHINE_NAME="OrderProcessingStateMachine"
DEFINITION_FILE="/stepfunctions/order_processing.json"
ROLE_ARN="arn:aws:iam::000000000000:role/DummyRole"

# Check if the state machine definition file exists
if [ ! -f "$DEFINITION_FILE" ]; then
  echo "State machine definition file not found: $DEFINITION_FILE"
  exit 1
fi

# Create the state machine using awslocal
echo "Creating state machine '$STATE_MACHINE_NAME'..."
awslocal stepfunctions create-state-machine \
  --name "$STATE_MACHINE_NAME" \
  --definition file://"$DEFINITION_FILE" \
  --role-arn "$ROLE_ARN"

if [ $? -eq 0 ]; then
  echo "State machine '$STATE_MACHINE_NAME' created successfully."
else
  echo "Error creating state machine '$STATE_MACHINE_NAME'."
  exit 1
fi

# Create Lambda functions using ROLE_ARN

echo "Creating Lambda functions..."

# Shipping Calculation Lambda
if [ ! -f "/lambda/calculate_shipping.zip" ]; then
  echo "File /lambda/calculate_shipping.zip not found!"
  exit 1
fi
awslocal lambda create-function --function-name calculate_shipping --runtime python3.10 --role "$ROLE_ARN" --handler calculate_shipping.lambda_handler --zip-file fileb:///lambda/calculate_shipping.zip
if [ $? -eq 0 ]; then
  echo "Lambda function 'calculate_shipping' created successfully."
else
  echo "Error creating 'calculate_shipping' Lambda function."
fi

# Inventory Check Lambda
if [ ! -f "/lambda/check_inventory.zip" ]; then
  echo "File /lambda/check_inventory.zip not found!"
  exit 1
fi
awslocal lambda create-function --function-name check_inventory --runtime python3.10 --role "$ROLE_ARN" --handler check_inventory.lambda_handler --zip-file fileb:///lambda/check_inventory.zip
if [ $? -eq 0 ]; then
  echo "Lambda function 'check_inventory' created successfully."
else
  echo "Error creating 'check_inventory' Lambda function."
fi

# Payment Processing Lambda
if [ ! -f "/lambda/process_payment.zip" ]; then
  echo "File /lambda/process_payment.zip not found!"
  exit 1
fi
awslocal lambda create-function --function-name process_payment --runtime python3.10 --role "$ROLE_ARN" --handler process_payment.lambda_handler --zip-file fileb:///lambda/process_payment.zip
if [ $? -eq 0 ]; then
  echo "Lambda function 'process_payment' created successfully."
else
  echo "Error creating 'process_payment' Lambda function."
fi

# Notification Sending Lambda
if [ ! -f "/lambda/send_notification.zip" ]; then
  echo "File /lambda/send_notification.zip not found!"
  exit 1
fi
awslocal lambda create-function --function-name send_notification --runtime python3.10 --role "$ROLE_ARN" --handler send_notification.lambda_handler --zip-file fileb:///lambda/send_notification.zip
if [ $? -eq 0 ]; then
  echo "Lambda function 'send_notification' created successfully."
else
  echo "Error creating 'send_notification' Lambda function."
fi