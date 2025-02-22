import json
import logging

logging.basicConfig(level=logging.INFO)

def lambda_handler(event, context):
    """
    Checks inventory for the product.
    """
    try:
        logging.info(f"Inventory checked for order: {event}")
        return {
            "statusCode": 200,
            "body": json.dumps(event)  # Возвращаем заказ без изменений
        }
    except Exception as e:
        logging.error(f"Error in check_inventory: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }