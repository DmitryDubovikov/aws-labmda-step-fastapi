import json


def lambda_handler(event, context):
    """
    Проверяет, есть ли товар в наличии.
    """
    order = json.loads(event["body"])
    product_id = order["product_id"]

    # Псевдопроверка
    if product_id == "out_of_stock":
        return {"statusCode": 400, "body": json.dumps({"message": "Product out of stock"})}
    return {"statusCode": 200, "body": json.dumps({"message": "Product in stock"})}
