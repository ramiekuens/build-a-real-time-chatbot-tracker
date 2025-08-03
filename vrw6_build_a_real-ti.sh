#!/bin/bash

# Configurations
CHATBOT_API_URL="https://your-chatbot-api.com/track"
CHATBOT_API_KEY="your-api-key"
CHATBOT_ROOM_ID="your-room-id"

# Function to send request to chatbot API
send_request() {
  curl -X POST \
    $CHATBOT_API_URL \
    -H 'Authorization: Bearer '$CHATBOT_API_KEY \
    -H 'Content-Type: application/json' \
    -d '{"room_id": "'$CHATBOT_ROOM_ID'","message": "'$1'"}'
}

# Function to track and display chatbot messages
track_messages() {
  while true
  do
    # Get latest messages from chatbot API
    responses=$(curl -X GET \
      $CHATBOT_API_URL'/'$CHATBOT_ROOM_ID \
      -H 'Authorization: Bearer '$CHATBOT_API_KEY)

    # Extract and display message texts
    for response in $responses; do
      message=$(echo $response | jq '.message')
      echo "[$(date +'%H:%M:%S')] $message"
    done

    # Sleep for 1 second before next poll
    sleep 1
  done
}

# Main program
echo "Starting chatbot tracker..."
track_messages