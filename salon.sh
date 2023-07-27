#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU(){
    echo -e "\nWelcome to My Salon, how can I help you?\n"
    OUTPUT=$($PSQL "SELECT service_id, services.name FROM services")

    while read -r SERVICE_ID SERVICE_NAME; do
        echo "$SERVICE_ID)$SERVICE_NAME"
    done <<< "$OUTPUT" | sed "s/|//g"

    SERVICES
}

SERVICES(){
    read SERVICE_ID_SELECTED
    SERVICE_ID_QUERY=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED")

    if [[ -z $SERVICE_ID_QUERY ]]
    then
        echo -e "\nI could not find that service."
        MAIN_MENU
    else
        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE
        CUSTOMER_PHONE_QUERY=$($PSQL "SELECT phone FROM customers WHERE phone = '$CUSTOMER_PHONE'")
        if [[ -z $CUSTOMER_PHONE_QUERY ]]
        then
            echo -e "\nI don't have a record for that phone number, what's your name?"
            read CUSTOMER_NAME
            INSERTED_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
            CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
            SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
            echo -e "\nWhat time would you like your$SERVICE_NAME, $CUSTOMER_NAME?"
            read SERVICE_TIME
            APPOINTMENT_INSERT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
            if [[ -z $APPOINTMENT_INSERT ]]
            then
                echo error
            else
                echo -e "\nI have put you down for a$SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
            fi
        else
            CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
            CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
            SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
            echo -e "\nWhat time would you like your$SERVICE_NAME,$CUSTOMER_NAME?"
            read SERVICE_TIME
            APPOINTMENT_INSERT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
            if [[ -z $APPOINTMENT_INSERT ]]
            then
                echo error
            else
                echo -e "\nI have put you down for a$SERVICE_NAME at $SERVICE_TIME,$CUSTOMER_NAME."
            fi
        fi                  
    fi
}

MAIN_MENU
