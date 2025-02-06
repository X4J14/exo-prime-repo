(
	:exo-version 1.0
	:description "Test SHA1 Digest and HMAC for Common Lisp"
	:module (
		:id :sha1-test
		:version "1.0"
		:use (:cl)
		:run :tests@test-all
		:dependencies (
			:sha1 "1.0"
			:base64 "1.0"
		)
		:signature (
			:key "RWR4D8s/solf7bEoPwXvsebrYebN+LLizUhK2BchkMj6PJ4apy7stzjb"
		)
	)
	:about (
		:author "X4J14 Project"
		:license "MIT-0"
	)
)