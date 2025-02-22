import json


def lambda_handler(event, context):
    """
    Рассчитывает стоимость доставки на основе веса и адреса.
    """
    order = json.loads(event["body"])
    weight = order["weight"]
    destination = order["destination"]

    # Простая логика расчета доставки
    shipping_cost = weight * 2 + 10

    return {"statusCode": 200, "body": json.dumps({"shipping_cost": shipping_cost})}
