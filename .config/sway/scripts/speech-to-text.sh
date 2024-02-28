#!/bin/bash

# REQUIRED audio-recorder PACKAGE (aur)
# TO GENERATE FREE API KEY VISIT: https://www.assemblyai.com/app/account
# SET YOUR 'audio-recorder' OUTPUT FILENAME AND FORMAT TO 'rec.mp3'

#----------------
# CHANGE TO YOUR VALUES
ASSEMBLY_LANG="ru"
API_KEY="3397c20fdaab49b99fc5904ed6f8af5c"
#----------------

API_HOST="https://api.assemblyai.com/v2"
AUDIO_RECORD_FILE="$HOME/Audio/rec.mp3"
CURL="curl -s"

POSITIONAL_ARGS=()
DEBUG="0"

while [[ $# -gt 0 ]]; do
  case $1 in
    -a|--api-key)
      API_KEY="$2"
      shift 
      shift 
      ;;
    -l|--lang-code)
      ASSEMBLY_LANG="$2"
      shift
      shift 
      ;;
    -f|--file)
      AUDIO_RECORD_FILE="$2"
      shift 
      shift 
      ;;
    -d|--debug)
      DEBUG="1"
      shift 
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift 
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" 

if [ $DEBUG = "1" ]; then CURL="curl"; fi

debug() {
    if [ $DEBUG = "1" ]; then echo $1; fi
}

notifyTransciptionStatus() {
    notify-send -t 3000 "Speech transciption status:" $1
}

notifyTransciptionStatus "executing..."

UPLOAD_URL=$($CURL -X POST -F "data=@$AUDIO_RECORD_FILE" -H "Content-Type: multipart/form-data" -H "Authorization: $API_KEY" "$API_HOST/upload" | jq -r '.[]')
debug "Upload assemblyai upload url: $UPLOAD_URL"

TRANSCRIPT_ID=$($CURL -X POST -d "{\"audio_url\": \"$UPLOAD_URL\", \"language_code\": \"$ASSEMBLY_LANG\"}" -H "Authorization: $API_KEY" -H "content-type: application/json" "$API_HOST/transcript" | jq -r '.id')
debug "Current transaction id: $TRANSCRIPT_ID"

POLLING_STATUS="undefined"

POLLING_ENDPOINT="$API_HOST/transcript/$TRANSCRIPT_ID"

while [ $POLLING_STATUS != "completed" ]
do
    sleep 3
    POLLING_RESPONSE=$($CURL -X GET -H "Authorization: $API_KEY" -H "content-type: application/json" $POLLING_ENDPOINT)
    POLLING_STATUS=$(echo $POLLING_RESPONSE | jq -r '.status')
    notifyTransciptionStatus "$POLLING_STATUS"
    debug "Current polling status: $POLLING_STATUS"
    if [[ $POLLING_STATUS = "error" || $POLLING_STATUS = "null" ]]
    then
        echo "error occures!: $(echo $POLLING_RESPONSE | jq '.error')"
        exit 1
    fi
    sleep 1
done

RESULT=$(echo $POLLING_RESPONSE | jq -r '.words | .[] | .text' | sed '1h;1!H;$!d;x;s/\n/\ /g')

echo $RESULT | wl-copy
echo $RESULT
notify-send -t 5000 "Speech transciption" "$RESULT"
