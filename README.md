# aws-labmda-step-fastapi

# Order Processing System with Step Functions

This project demonstrates an order processing system using AWS Step Functions and Lambda functions. The system allows for the creation of orders, which are then processed through a series of Lambda functions coordinated by Step Functions.

## Key Features:
- **Step Functions**: Orchestrates the workflow of order processing, triggering multiple Lambda functions.
- **Lambda Functions**: Each function performs a specific task, such as checking inventory, processing payment, and sending notifications.
- **FastAPI**: Provides an HTTP API for creating orders and interacting with the system.
- **LocalStack**: Used for local testing and development of AWS services, including Step Functions and Lambda.
- **Docker**: All components are containerized using Docker and Docker Compose for easy setup and scalability.

## Technologies Used:
- **AWS Step Functions**
- **AWS Lambda**
- **FastAPI**
- **LocalStack (for local AWS service emulation)**
- **Docker / Docker Compose**

## How It Works:
1. **Order Creation**: A user sends a POST request to create a new order, providing necessary details (product, weight, destination, etc.).
2. **State Machine Execution**: The order is passed to a state machine which triggers a series of Lambda functions to process the order.
3. **Results**: The system returns an `executionArn` which can be used to track the status of the order processing.

## Local Setup:

1. **Build the project:**
   ```shell
   docker compose build
    ```
2. **Start the services:**
    ```shell
    docker compose up -d
    ```
3. **Run the script to create the state machine:**
    ```shell
    docker exec -it localstack_main bash -c "cd /stepfunctions && chmod +x create_state_machine.sh && ./create_state_machine.sh && exit"
    ```
4. **Swagger UI:**
http://localhost:8000/docs

    example order:
    ```json
    {
      "product_id": "123",
      "weight": 2.5,
      "destination": "New York",
      "amount": 100.0,
      "customer_email": "customer@example.com"
    }
    ```
5. **Or curl:**
    ```shell
    
    curl -X 'POST' \
      'http://localhost:8000/create_order/' \
      -H 'accept: application/json' \
      -H 'Content-Type: application/json' \
      -d '{
      "product_id": "123",
      "weight": 2.5,
      "destination": "New York",
      "amount": 100.0,
      "customer_email": "customer@example.com"
    }
    '
    ```