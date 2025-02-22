import json
import logging

logging.basicConfig(level=logging.INFO)

def lambda_handler(event, context):
    """
    Simulates the payment processing.
    """
    try:

        amount = event["amount"]

        if amount <= 0:
            logging.error(f"Invalid payment amount: {amount}")
            return {"statusCode": 400, "body": json.dumps({"message": "Invalid amount"})}

        event["payment_status"] = "Processed"
        logging.info(f"Payment of {amount} processed successfully.")
        return {
            "statusCode": 200,
            "body": json.dumps(event)  # Возвращаем заказ с подтверждением оплаты
        }
    except Exception as e:
        logging.error(f"Error in process_payment: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }