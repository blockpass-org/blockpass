FILE_NAME=$1
PRIVATE_KEY=${FILE_NAME}_private.pem
PUBLIC_KEY=${FILE_NAME}_public.pem
BITCOIN_PRIVATE_KEY=bitcoin_${FILE_NAME}_private.key
BITCOIN_PUBLIC_KEY=bitcoin_${FILE_NAME}_public.key

echo "1. Generating private key"
openssl ecparam -genkey -name secp256k1 -out $PRIVATE_KEY

echo "2. Generating public key"
openssl ec -in $PRIVATE_KEY -pubout -out $PUBLIC_KEY

echo "3. Generating BitCoin private key"
openssl ec -in $PRIVATE_KEY -outform DER|tail -c +8|head -c 32|xxd -p -c 32 > $BITCOIN_PRIVATE_KEY

echo "4. Generating BitCoin public key"
openssl ec -in $PRIVATE_KEY -pubout -outform DER|tail -c 65|xxd -p -c 65 > $BITCOIN_PUBLIC_KEY

echo "5. Create Compressed Address using online tool"
echo "   5.1 Open https://iancoleman.io/bitcoin-key-compression/"
echo "   5.2 Copy content of '${BITCOIN_PUBLIC_KEY}' into Input Key"
echo "   5.4 Your Compressed Address show under Output"

echo "---------------------------------------"
echo "Your key pair for certificate sign are:"
echo "  CERTIFICATE_PRIVATE_WIF_KEY=<content of ${BITCOIN_PRIVATE_KEY}>"
echo "  CERTIFICATE_PUBLIC_WIF_KEY=<Step5>"

