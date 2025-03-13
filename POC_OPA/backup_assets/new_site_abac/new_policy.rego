package istio.authz

default allow := false

jwks = {
	"keys": [
		{
			"kid": "5RJZx90NM5YAy6k3_MkHZOmsDS1X2c9_yQlVXCm5LWQ",
			"kty": "RSA",
			"alg": "RSA-OAEP",
			"use": "enc",
			"x5c": [
				"MIICqzCCAZMCBgGVZvkRLDANBgkqhkiG9w0BAQsFADAZMRcwFQYDVQQDDA5uZXdfc2l0ZV9yZWFsbTAeFw0yNTAzMDUxNTQwNTNaFw0zNTAzMDUxNTQyMzNaMBkxFzAVBgNVBAMMDm5ld19zaXRlX3JlYWxtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyVfCwuy6FBvBIlEXByRz0fOGCBbWvhchO9UQefVWQaaWHNLYu4yrMocAq/h6gcDZbW3kurXGCpq64XJ3397Mw54iTQw00XKQlMhVoWdGY77Zwg9Uei5r5thnwhIR0nbQSsIDtGRE+lBi8ozrPhJaBd148qzHCq332ITPiuxqXyNsqsV1HZ4wQcNBwifH7LkyiuJbbvdw3XJsA+yVy5ubJ4D01kYpTRpSKLiQgwIAd/2lS29qViXFuJED2a0lBGLkJCnKgqRTNtbJ6GiCHtboHfd0DQrZyxp2VcjXzWs8rCg73GLMdzT2YYyjFsn16g5qqdxQdch/Bt1IaIdtWn+brQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAaFE7zqudd1+OFT+U63xlPN8/W4V+c2uaX2mHuwkDE9Y50iBeWf8RZtcdPTCrVc7HKm040DVJWiM0VqwD9VfBSToOnQRRPZ3ynKY15THsul4eoBWLmtpm1Cs92NOGYwiJDhKXdiuBYzjO6xLOHrK2PGtP6WZQGE4/ecL++64LlM3d9CXBMa5/6Cw1q8IL0yjRivkdhZrNcjKpG/VQeSeqxV+kSl8p2Ri8QEgwI4nPB0hRBZUjvKloy8UHjie2tiDG+flHxBHURWwqXN72i4cXZCUCloBUizW/RVHvolsA21EvLUCNtsCJFuBBNpHM9EOo4l59dT1jC5iykGv+fi411"
			],
			"x5t": "J5P4_r3UMFd5gdXcfGQGABtsgvU",
			"x5t#S256": "T1AQbD4kRjRxTWGgzo-sGpAmt1Z9ge2P3veAqfdbnOo",
			"n": "yVfCwuy6FBvBIlEXByRz0fOGCBbWvhchO9UQefVWQaaWHNLYu4yrMocAq_h6gcDZbW3kurXGCpq64XJ3397Mw54iTQw00XKQlMhVoWdGY77Zwg9Uei5r5thnwhIR0nbQSsIDtGRE-lBi8ozrPhJaBd148qzHCq332ITPiuxqXyNsqsV1HZ4wQcNBwifH7LkyiuJbbvdw3XJsA-yVy5ubJ4D01kYpTRpSKLiQgwIAd_2lS29qViXFuJED2a0lBGLkJCnKgqRTNtbJ6GiCHtboHfd0DQrZyxp2VcjXzWs8rCg73GLMdzT2YYyjFsn16g5qqdxQdch_Bt1IaIdtWn-brQ",
			"e": "AQAB"
		},
		{
			"kid": "XFYummyRxnZ7GIejtqLNqVni9AU0rI3hQhfx6ihQ4fQ",
			"kty": "RSA",
			"alg": "RS256",
			"use": "sig",
			"x5c": [
				"MIICqzCCAZMCBgGVZvkPwzANBgkqhkiG9w0BAQsFADAZMRcwFQYDVQQDDA5uZXdfc2l0ZV9yZWFsbTAeFw0yNTAzMDUxNTQwNTNaFw0zNTAzMDUxNTQyMzNaMBkxFzAVBgNVBAMMDm5ld19zaXRlX3JlYWxtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzMZF5nMBT6zysah26cqHBSX7OG+q87Ago1/G6lfKb7BttC0ZjbIWmJsPpF4dMSFdavWvD6eD34/SNMWO/asujzrW+q6QRE1KnMKUR1JpLURRIO/vkWVyliVGeHi92kjUJOOSU2Ev9UbzZxulLgK9iy/ZLG/KQdG6kO2H+eQy2QG4z+gJeAbfp9m4OxKpzDnuYQm9QWmMZjTSwj0Y2XDqsj4H8SbR86ZdujfjHGUM1bXsQLAA/gkAtew+cz4v2uDJuHp2a62qlZhHhNCJhiIPaR7lKgNfAmV82lF/6trcIT04Y2ZXhq8n+D0vRNhSqg1lwIstPxSDnC8T+gonYjGPywIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBjIOd4f3fIv5fV/n/qxMl6LL63W+l4/xa9X4mFtK7+AalVM3za8SUQtNqHHzzVgHc3gG0yMVd/WehTHB+QL3WmSMMhsbFX0br36i6h+/nRNEUr3z57ma8Z+sdI2EhWnegvFXty+cOen9g742n0VMHmovH+Li7T46dznZ8Hmbm/9g/3NwrAolkigulimWrTSoZnLEuN7CsBfsQD7CcyFpWNXC16Oc08cY6r+tXjbV/EIfdaMFdxnWtSQHZEtBu8A8Hlg1euyhVpwuCcHC2bv7Dve7hIqn7tTTS4GzkZjVQJ0OlEprrBI15nVST4acCz7bIWIBmoNnqq3NA2VTsn/gYy"
			],
			"x5t": "n_zDkU8jvVgDbiGc86et5pn6CQQ",
			"x5t#S256": "3yOp7MMZejuKd9flgTB_Y7rZ-e9AGQrDsOrT8p15rpc",
			"n": "zMZF5nMBT6zysah26cqHBSX7OG-q87Ago1_G6lfKb7BttC0ZjbIWmJsPpF4dMSFdavWvD6eD34_SNMWO_asujzrW-q6QRE1KnMKUR1JpLURRIO_vkWVyliVGeHi92kjUJOOSU2Ev9UbzZxulLgK9iy_ZLG_KQdG6kO2H-eQy2QG4z-gJeAbfp9m4OxKpzDnuYQm9QWmMZjTSwj0Y2XDqsj4H8SbR86ZdujfjHGUM1bXsQLAA_gkAtew-cz4v2uDJuHp2a62qlZhHhNCJhiIPaR7lKgNfAmV82lF_6trcIT04Y2ZXhq8n-D0vRNhSqg1lwIstPxSDnC8T-gonYjGPyw",
			"e": "AQAB"
		}
	]
}

correct_port if input.attributes.destination.address.socketAddress.portValue == 5000

# Endpoint management
endpoint := input.parsed_path[0]

correct_endpoint if endpoint == claims.location

correct_endpoint if endpoint == ""

allow if {
	correct_port
	correct_endpoint
}

# JWT handling

claims := payload if {
	# Verify the signature on the Bearer token. In this example the secret is
	# hardcoded into the policy however it could also be loaded via data or
	# an environment variable. Environment variables can be accessed using
	# the `opa.runtime()` built-in function.

	# FIX ME
	# io.jwt.verify_rs256(bearer_token, "MIICqzCCAZMCBgGVR4GOWzANBgkqhkiG9w0BAQsFADAZMRcwFQYDVQQDDA5uZXdfc2l0ZV9yZWFsbTAeFw0yNTAyMjcxMzAyMDdaFw0zNTAyMjcxMzAzNDdaMBkxFzAVBgNVBAMMDm5ld19zaXRlX3JlYWxtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAph88JkQTRsncm87z9+q3MmxXUPswSQh0WKsZMAfH4Go3BLlB5nE8BMfuxT4oBy++KIyyd7lp4zSynxueSYJc6HYJo8OpbBHvhd5S86B1a/TeXJHNhtr5tSp7DD2vZK42MPlzAoEjWrwYeJWFtCZEfDJoO65dp+XB3zTICf8/UO7eIzFYjf+cl9ULH9XZoT4SUayW54xAaJeyrzDn/8XhBnLo7+28CbbbVRfKO+V5Rb1M+8cIbdtPwy3bdvypn8z1lAsmDM73vDXbQvQPrEtpQqOiRzurY5fpnm1H+rOK05Mlemq3nUyIdngu6vyVpPcu2yIjUZlw0jTwPnoN/oMvpwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQB5R3gZmIHBt+Yf7fJWY8Chdq8QyZKLmQZQynUkLjv9GrRn/yaUowdh2s4mZKEl4qScSUk70wrCVWnR+cym1kHnt/6zS8vHstne2W0bhu7nI4gMP155pEauqLpzI4Z92tTpDHR/E9zzHRKEBICWHvb8cbNb4lVajY8yPJ68mtK0vo/Gp1tr0O3g/w4ETnoo713s3ydJeNNd7BNlzne4wCQ94mibZsM+RhdXiCFpBcIpEqWO5220CVN19M/hpuPMxWkvMKqHL+1fxA5imjuyQVRmDL9vq1LtrLZTOlVKtqeG4n+posSMlXIdzRTxqUH8dFUhJ6caaerP5k69HM52zhhq")

	# This statement invokes the built-in function `io.jwt.decode` passing the
	# parsed bearer_token as a parameter. The `io.jwt.decode` function returns an
	# array:
	#
	#	[header, payload, signature]
	#
	# In Rego, you can pattern match values using the `=` and `:=` operators. This
	# example pattern matches on the result to obtain the JWT payload.
	[_, payload, _] := io.jwt.decode(bearer_token)
}

bearer_token := t if {
	# Bearer tokens are contained inside of the HTTP Authorization header. This rule
	# parses the header and extracts the Bearer token value. If no Bearer token is
	# provided, the `bearer_token` value is undefined.
	v := input.attributes.request.http.headers.authorization
	startswith(v, "Bearer ")
	t := substring(v, count("Bearer "), -1)
}
