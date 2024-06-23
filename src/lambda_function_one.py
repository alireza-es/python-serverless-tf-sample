import json
import logging
import numpy as np
import pandas as pd
# from common.utils import sample_function

def lambda_handler(event, context):
    logging.info('Lambda function one has been called.')

    # Verify numpy and pandas
    arr = np.array([1, 2, 3, 4, 5])
    df = pd.DataFrame({'col1': [1, 2], 'col2': [3, 4]})

    # Sample function from common module
    # sample_result = sample_function()

    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Hello from Lambda function one!',
            'numpy_array': arr.tolist(),
            'pandas_dataframe': df.to_dict(),
            'sample_function_result': sample_result
        })
    }
