package istio.authz

default allow := false

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
