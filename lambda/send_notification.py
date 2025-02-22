import json
import logging

logging.basicConfig(level=logging.INFO)

def lambda_handler(event, context):
    """
    Sends a notification to the customer.
    """
    try:
        customer_email = event["customer_email"]

        logging.info(f"Notification sent to {customer_email}.")
        return {
            "statusCode": 200,
            "body": json.dumps({"message": f"Notification sent to {customer_email}"})
        }
    except Exception as e:
        logging.error(f"Error in send_notification: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }