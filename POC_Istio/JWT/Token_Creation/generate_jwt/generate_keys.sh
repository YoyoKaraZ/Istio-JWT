openssl genrsa -des3 -out private_encrypted.pem 2048
openssl rsa -pubout -in private_encrypted.pem -out public.pem
openssl rsa -in private_encrypted.pem -out private.pem -outform PEM

