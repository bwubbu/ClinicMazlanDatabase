REM   Script: Revised
REM   revised

CREATE TABLE PATIENT (  
    patient_id INT,  
    patient_name VARCHAR(50) NOT NULL,  
    patient_contact VARCHAR(13) NOT NULL,  
  
    CONSTRAINT Patient_PK  
    	PRIMARY KEY (patient_id)  
);

INSERT INTO PATIENT(patient_id, patient_name, patient_contact)     
VALUES (1001, 'Ahmad Apen bin Wafiq', '60134477122');

INSERT INTO PATIENT(patient_id, patient_name, patient_contact)     
VALUES (1002, 'Syamil Akil bin Hazbullah', '601116622512');

INSERT INTO PATIENT(patient_id, patient_name, patient_contact)     
VALUES (1003, 'John Kazuya', '60167865432');

SELECT * FROM PATIENT;

CREATE TABLE EMPLOYEE (  
    employee_id INT,  
    employee_name VARCHAR(50) NOT NULL,  
    employee_contact VARCHAR(13) NOT NULL, 
 
    CONSTRAINT Employee_PK 
	PRIMARY KEY (employee_id) 
);

INSERT INTO EMPLOYEE (employee_id, employee_name, employee_contact)   
VALUES (1, 'Dr Kamal Aminuddin', '6013686981' );

INSERT INTO EMPLOYEE (employee_id, employee_name, employee_contact)   
VALUES (2, 'Hamidah binti Che Husain', '6013227162' );

INSERT INTO EMPLOYEE (employee_id, employee_name, employee_contact)   
VALUES (3, 'Chee Yaw Shern Shawn', '6011227611' );

SELECT * FROM EMPLOYEE;

CREATE TABLE APPOINTMENT(  
    appointment_id INT,  
    appointment_date_time TIMESTAMP,  
    patient_id INT NOT NULL,  
    doctor_id INT NOT NULL,
    receptionist_id INT NOT NULL,
  
    CONSTRAINT Appointment_PK  
    	PRIMARY KEY (appointment_id),  
  
    CONSTRAINT Appointment_Patient_FK  
    	FOREIGN KEY (patient_id)  
    	REFERENCES PATIENT(patient_id),  
  
    CONSTRAINT Appointment_Employee_Doctor_FK  
    	FOREIGN KEY (doctor_id)  
    	REFERENCES EMPLOYEE(employee_id), 
        
    CONSTRAINT Appointment_Employee_Receptionist_FK
        FOREIGN KEY (receptionist_id)
        REFERENCES EMPLOYEE(employee_id)
);

INSERT INTO APPOINTMENT (appointment_id, appointment_date_time, patient_id, doctor_id, receptionist_id) 
VALUES (7001, TIMESTAMP '2024-01-02 10:00:00', 1001, 1, 2);

SELECT * FROM APPOINTMENT 
;

CREATE TABLE INVOICE( 
    invoice_id INT, 
    invoice_date_time TIMESTAMP, 
    invoice_payment FLOAT, 
    appointment_id INT NOT NULL, 
    receptionist_id INT NOT NULL, 
 
    CONSTRAINT Invoice_PK 
    	PRIMARY KEY (invoice_id), 
 
    CONSTRAINT Invoice_Appointment_FK 
    	FOREIGN KEY (appointment_id) 
    	REFERENCES APPOINTMENT(appointment_id), 
 
    CONSTRAINT Invoice_Employee_Receptionist_FK 
    	FOREIGN KEY (receptionist_id) 
    	REFERENCES EMPLOYEE(employee_id) 
) ;

INSERT INTO INVOICE(invoice_id, invoice_date_time, invoice_payment, appointment_id, receptionist_id) 
VALUES (8001, TIMESTAMP '2024-01-02 13:00:00', 15.00, 7001, 2);

INSERT INTO APPOINTMENT (appointment_id, appointment_date_time, patient_id, doctor_id, receptionist_id)  
VALUES (7002, TIMESTAMP '2024-01-03 12:00:00', 1002, 1, 3);

INSERT INTO INVOICE(invoice_id, invoice_date_time, invoice_payment, appointment_id, receptionist_id)  
VALUES (8002, TIMESTAMP '2024-01-03 13:00:00', 15.00, 7002, 3);

SELECT * FROM INVOICE;

CREATE TABLE MEDICINE( 
    medicine_id INT, 
    medicine_name VARCHAR(50), 
    medicine_type VARCHAR(50), 
    medicine_description VARCHAR(50), 
    stock_quantity INT, 
 
	CONSTRAINT Medicine_PK 
    	PRIMARY KEY (medicine_id) 
);

INSERT INTO MEDICINE(medicine_id, medicine_name, medicine_type, medicine_description, stock_quantity) 
VALUES(13001, 'Paracetemol', 'Pills', 'Eat 2-3 times a day after eating', 300);

INSERT INTO MEDICINE(medicine_id, medicine_name, medicine_type, medicine_description, stock_quantity) 
VALUES(13003, 'Antacids', 'Liquid', 'Drink 3 times a day in an interval of 8 hours', 15);

INSERT INTO MEDICINE(medicine_id, medicine_name, medicine_type, medicine_description, stock_quantity) 
VALUES(13002, 'Antitussives', 'Liquid', 'Drink when neck felt dry', 80);

SELECT * FROM MEDICINE;

CREATE TABLE PRESCRIPTION( 
    presc_id INT, 
    presc_description VARCHAR(100), 
    presc_amount INT, 
    appointment_id INT NOT NULL, 
    medicine_id INT NOT NULL, 
 
    CONSTRAINT Prescription_PK 
    	PRIMARY KEY (presc_id), 
 
    CONSTRAINT Prescription_Appointment_FK 
    	FOREIGN KEY	(appointment_id) 
    	REFERENCES APPOINTMENT(appointment_id), 
 
    CONSTRAINT Prescription_Medicine_FK 
    	FOREIGN KEY (medicine_id) 
    	REFERENCES MEDICINE(medicine_id) 
);

CREATE TABLE SUPPLIER( 
    supplier_id INT, 
    supplier_name VARCHAR(50), 
    supplier_contact VARCHAR(13), 
    supplier_address VARCHAR(100), 
 
    CONSTRAINT Supplier_PK 
    	PRIMARY KEY (supplier_id) 
);

CREATE TABLE RESTOCK( 
    restock_id INT, 
    restock_quantity INT NOT NULL, 
    restock_date_time TIMESTAMP, 
    restock_payment FLOAT, 
    medicine_id INT NOT NULL, 
    supplier_id INT NOT NULL, 
 
    CONSTRAINT Restock_PK 
    	PRIMARY KEY (restock_id), 
 
    CONSTRAINT Restock_Medicine_FK 
    	FOREIGN KEY (medicine_id) 
    	REFERENCES MEDICINE(medicine_id), 
 
    CONSTRAINT Restock_Supplier_FK 
    	FOREIGN KEY (supplier_id) 
    	REFERENCES SUPPLIER(supplier_id) 
);

CREATE TABLE MEDICINE_SUPPLIER( 
    supplier_id INT, 
    medicine_id INT, 
    price FLOAT,
    CONSTRAINT Medicine_Supplier_PK PRIMARY KEY (supplier_id, medicine_id), 
    CONSTRAINT Medicine_Supplier_Sup_FK FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id), 
    CONSTRAINT Medicine_Supplier_Med_FK FOREIGN KEY (medicine_id) REFERENCES MEDICINE(medicine_id) 
);

