from fastapi import FastAPI, HTTPException
import boto3
import json
import os

app = FastAPI()

# Инициализация клиента AWS Step Functions
client = boto3.client("stepfunctions", endpoint_url="http://aws-localstack:4566", region_name="us-east-1")

# Step Functions State Machine ARN (будем настраивать позже)
STATE_MACHINE_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessingStateMachine"


@app.post("/create_order/")
async def create_order(order: dict):
    """
    Создает заказ и запускает его обработку через Step Functions.
    """
    try:
        response = client.start_execution(
            stateMachineArn=STATE_MACHINE_ARN, input=json.dumps(order)  # Передаем данные заказа в виде JSON
        )
        return {"executionArn": response["executionArn"]}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
