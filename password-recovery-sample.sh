API_ENDPOINT="https://localhost:9443/api/identity/recovery/v0.9"
AUTH_HEADER_VALUE="YWRtaW46YWRtaW4="

case "$1" in
  "get-question")
    printf "\n\nAPI Response.\n\n"
    curl -k -X GET -H "Authorization: Basic $AUTH_HEADER_VALUE" -H "Content-Type: application/json"  "$API_ENDPOINT/security-question?username=$2"
    printf "\n\nWhat's next ?\n\n"
    printf "\t./password-recovery-sample.sh answer-question <key> <question-set-id> <answer>\n\n"
    ;;
  "answer-question")
    printf "\n\nAPI Response.\n\n"
    curl -k -X POST -H "Authorization: Basic $AUTH_HEADER_VALUE" -H "Content-Type: application/json" -d '{"key": "'$2'","answers": [{ "question-set-id": "'$3'","answer": "'$4'"}],"properties": []}' "$API_ENDPOINT/validate-answer"
    printf "\n\nWhat's next ?\n\n"
    printf "\tIf more questions are there ... \n\t\t./password-recovery-sample.sh answer-question <key> <question-set-id> <answer>\n\n"
    printf "\tIf all the questions has been answered ... \n\t\t./password-recovery-sample.sh reset-password <key> <new-password>\n\n"
    ;;
  "reset-password")
    curl -k -X POST -H "Authorization: Basic $AUTH_HEADER_VALUE" -H "Content-Type: application/json" -d '{"key": "'$2'", "password": "'$3'","properties": []}' "$API_ENDPOINT/set-password"
    printf "\n\n"
    ;;
  *)
    printf "\n\nRecovery API Endpoint : $API_ENDPOINT"
    printf "\n\nWhat's next ?\n\n"
    printf "./password-recovery-sample.sh get-question <username>\n\n"
    ;;
esac
