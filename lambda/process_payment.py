import json


def lambda_handler(event, context):
    """
    Эмулирует обработку платежа.
    """
    order = json.loads(event["body"])
    amount = order["amount"]

    if amount <= 0:
        return {"statusCode": 400, "body": json.dumps({"message": "Invalid amount"})}

    return {"statusCode": 200, "body": json.dumps({"message": "Payment processed successfully"})}
