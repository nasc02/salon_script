# salon_script

Overview
The code is a script named salon.sh that simulates a salon management system. It interacts with a PostgreSQL database named salon to handle customer appointments and services, it is a challenge necessary to complete the relational database course of FreeCodeCamp.

Requirements
To run the script, you need to have PostgreSQL installed and a database named salon. The script should have executable permissions, which can be set using chmod +x salon.sh.

You can rebuild the database by entering psql -U postgres < salon.sql

    Database Setup
The script connects to the PostgreSQL database using the username freecodecamp. Inside the database, it creates three tables: customers, appointments, and services. Each table has a primary key column named table_name_id that automatically increments. The appointments table has foreign keys customer_id and service_id referencing the corresponding columns from the customers and services tables.

Script Execution
The script starts by displaying a welcome message and a numbered list of services available in the salon. The list is fetched from the services table in the database.

The user is prompted to enter the service ID they want to avail of. If an invalid service ID is provided, the script displays an error message and goes back to the main menu.

After choosing a service, the user is prompted to enter their phone number.

If the phone number is not found in the customers table, the script asks for the customer's name and inserts a new row into the customers table with the provided phone number and name.

Next, the user is asked for the appointment time.

The script then inserts a new row into the appointments table, which includes the customer_id, service_id, and time for the appointment.

If the appointment insertion is successful, the script displays a confirmation message that includes the service, time, and customer name.

If the phone number provided already exists in the customers table, the script directly proceeds to ask for the appointment time and inserts a new row into the appointments table.
