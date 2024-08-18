#!/bin/bash

# Variables
DB_NAME="${HOME}/Documents/FCC/all_hams.db"
TABLE_NAME="as_of_2024_08_18"
FILE_PATH=$(mktemp -p ${HOME}/Downloads fcc.XXXXXX)
downloadFile="${HOME}/Downloads/UL20247181244764.txt"
randomSequence=$(cat /dev/urandom | base64 | tr -dc '0-9a-zA-Z' | head -c6)

hdFile=${HOME}/Downloads/hd.${randomSequence}.fcc
enFile=${HOME}/Downloads/en.${randomSequence}.fcc
amFile=${HOME}/Downloads/am.${randomSequence}.fcc

grep ^HD ${downloadFile} > ${hdFile}
grep ^EN ${downloadFile} > ${enFile}
grep ^AM ${downloadFile} > ${amFile}

FILE_PATH=${hdFile}
TABLE_NAME="hd_2024_08_18"
export TABLE_NAME
rm ${DB_NAME}
# Create the SQLite database (if it doesn't exist) and import the file
sqlite3 $DB_NAME <<EOF
-- Create the table with appropriate columns and types
CREATE TABLE IF NOT EXISTS $TABLE_NAME (
    type TEXT,
    column2 INTEGER,
    column3 INTEGER,
    column4 TEXT,
    call_sign TEXT,
    column6 TEXT,
    radio_service TEXT,
    issue_date TEXT,
    expire_date TEXT,
    column10 TEXT,
    column11 TEXT,
    column12 TEXT,
    column13 TEXT,
    column14 TEXT,
    column15 TEXT,
    column16 TEXT,
    column17 TEXT,
    column18 TEXT,
    column19 TEXT,
    column20 TEXT,
    column21 TEXT,
    column22 TEXT,
    column23 TEXT,
    column24 TEXT,
    column25 TEXT,
    column26 TEXT,
    column27 TEXT,
    column28 TEXT,
    column29 TEXT,
    column30 TEXT,
    name_first TEXT,
    name_middle TEXT,
    name_last TEXT,
    column34 TEXT,
    name_title TEXT,
    column36 TEXT,
    column37 TEXT,
    column38 TEXT,
    column39 TEXT,
    column40 TEXT,
    column41 TEXT,
    column42 TEXT,
    issue_date2 TEXT,
    issue_date3 TEXT,
    column45 TEXT,
    column46 TEXT,
    column47 TEXT,
    column48 TEXT,
    column49 TEXT,
    column50 TEXT,
    column51 TEXT,
    column52 TEXT,
    column53 TEXT,
    column54 TEXT,
    column55 TEXT,
    column56 TEXT,
    column57 TEXT,
    column58 TEXT,
    column59 TEXT
);

-- Import the pipe-delimited file into the table
.separator "|"
.import $FILE_PATH $TABLE_NAME

EOF

FILE_PATH=${enFile}
TABLE_NAME="en_2024_08_18"
export TABLE_NAME


# Create the SQLite database (if it doesn't exist) and import the file
sqlite3 $DB_NAME <<EOF
-- Create the table with appropriate columns and types
CREATE TABLE IF NOT EXISTS $TABLE_NAME (
    type TEXT,
    column2 INTEGER,
    column3 INTEGER,
    column4 TEXT,
    call_sign TEXT,
    column6 TEXT,
    licensee_id TEXT,
    name_full TEXT,
    name_first TEXT,
    name_middle TEXT,
    name_last TEXT,
    name_additional TEXT,
    column13 TEXT,
    column14 TEXT,
    column15 TEXT,
    address_street1 TEXT,
    address_city TEXT,
    address_state TEXT,
    address_zip TEXT,
    address_po_box TEXT,
    name_prefered TEXT,
    column22 TEXT,
    frn TEXT,
    column24 TEXT,
    column25 TEXT,
    column26 TEXT,
    column27 TEXT,
    column28 TEXT,
    column29 TEXT,
    column30 TEXT
);

-- Import the pipe-delimited file into the table
.separator "|"
.import $FILE_PATH $TABLE_NAME

EOF

FILE_PATH=${amFile}
TABLE_NAME="am_2024_08_18"
export TABLE_NAME


# Create the SQLite database (if it doesn't exist) and import the file
sqlite3 $DB_NAME <<EOF
-- Create the table with appropriate columns and types
CREATE TABLE IF NOT EXISTS $TABLE_NAME (
    type TEXT,
    column2 INTEGER,
    column3 INTEGER,
    column4 TEXT,
    call_sign TEXT,
    class_code TEXT,
    group_code TEXT,
    column8 TEXT,
    trustee_call_sign TEXT,
    column10 TEXT,
    column11 TEXT,
    column12 TEXT,
    column13 TEXT,
    column14 TEXT,
    column15 TEXT,
    previous_call_sign TEXT,
    previous_class_code TEXT,
    trustee_name TEXT
);

-- Import the pipe-delimited file into the table
.separator "|"
.import $FILE_PATH $TABLE_NAME

EOF

rm ${HOME}/Downloads/*.${randomSequence}.fcc