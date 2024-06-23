import json
import logging
from common.utils import sample_function

def lambda_handler(event, context):
    logging.info('Lambda function one has been called.')

    # Call the utility function from the common package
    sample_result = sample_function()

    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Hello from Lambda function one!',
            'sample_function_result': sample_result
        })
    }
