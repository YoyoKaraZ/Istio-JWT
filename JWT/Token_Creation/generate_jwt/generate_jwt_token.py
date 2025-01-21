from authlib.jose import jwt, jwk

header = {'alg': 'RS256'}
payload = {'iss': 'yoyo@yoyo.com', 'sub': 'admin', 'exp': 1685505001}
private_key = open('private.pem', 'r').read()
bytes = jwt.encode(header, payload, private_key)


print(f"The JWT token generated is :\n\n{bytes.decode('utf-8')}\n\n")


public_key = open('public.pem', 'r').read()
key = jwk.dumps(public_key, kty='RSA')
print(f"The JWK generated is \n\n{key}")
