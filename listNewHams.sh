# Variables
DB_NAME="${HOME}/Documents/FCC/all_hams.db"
EN_TABLE="en_2024_08_18"
HD_TABLE="hd_2024_08_18"
AM_TABLE="AM_2024_08_18"
CSV_FILE="${HOME}/Downloads/new_2024_08_18.csv"

sqlite3 $DB_NAME <<EOF
.headers on
.mode csv
.output $CSV_FILE
SELECT 
    en.call_sign, 
    en.name_full,
    CASE 
        WHEN en.address_po_box IS NOT NULL AND en.address_po_box != '' 
        THEN 'PO Box ' || en.address_po_box 
        ELSE en.address_street1 
    END AS address_street1, 
    en.address_city, 
    en.address_state, 
    en.address_zip, 
    hd.issue_date
FROM 
    en_2024_08_18 en
JOIN 
    hd_2024_08_18 hd 
ON 
    en.call_sign = hd.call_sign
JOIN 
    am_2024_08_18 am
ON 
    en.call_sign = am.call_sign

	WHERE (en.address_zip BETWEEN '92500' and '92522'
   OR en.address_zip = '91752'
   OR en.address_zip = '92860')
   AND am.class_code = 'T';
.output stdout
EOF
