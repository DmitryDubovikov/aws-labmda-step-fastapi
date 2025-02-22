import json
import logging

logging.basicConfig(level=logging.INFO)

def lambda_handler(event, context):
    """
    Calculates the shipping cost based on weight and destination.
    """
    try:
        weight = event["weight"]
        destination = event["destination"]

        shipping_cost = weight * 2 + 10
        event["shipping_cost"] = shipping_cost

        logging.info(f"Calculated shipping cost: {shipping_cost} for weight: {weight}, destination: {destination}")
        return {
            "statusCode": 200,
            "body": json.dumps(event)  # Возвращаем заказ с добавленной стоимостью доставки
        }
    except Exception as e:
        logging.error(f"Error in calculate_shipping: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }