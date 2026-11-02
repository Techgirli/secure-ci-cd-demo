#!/bin/bash
TARGET_URL=$1
MAX_RETRIES=5
RETRY_INTERVAL=10

echo "Verifying application health at $TARGET_URL..."

for ((i=1; i<=MAX_RETRIES; i++)); do
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET_URL/health")
    
    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo "✅ Health check passed! Application is live."
        exit 0
    fi
    
    echo "Attempt $i/$MAX_RETRIES: Received HTTP status $HTTP_STATUS. Retrying in ${RETRY_INTERVAL}s..."
    sleep $RETRY_INTERVAL
done

echo "❌ Health check failed after $MAX_RETRIES attempts. Triggering automated rollback..."
# In a real pipeline, you would trigger a Terraform rollback, 
# AWS ECS task reversion, or docker tag revert here.
exit 1
