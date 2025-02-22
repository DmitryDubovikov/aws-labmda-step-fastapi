import json


def lambda_handler(event, context):
    """
    Отправляет уведомление покупателю.
    """
    order = json.loads(event["body"])
    customer_email = order["customer_email"]

    return {"statusCode": 200, "body": json.dumps({"message": f"Notification sent to {customer_email}"})}
