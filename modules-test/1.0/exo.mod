(
	:exo-version 1.0
	:description "Test modules of this repository"
	:module (
		:id :modules-test
		:version "1.0"
		:run :test
		:use (:cl)
		:dependencies (
			:trivial-gray-streams-test "2.0"
			:flexi-streams-test "1.0.19"
			:cl-unicode "0.1.6"
			:cl-unicode-test "0.1.6"
			:cl-ppcre-test "2.1.1"
			:sha1-test "1.0"
			:base64-test "1.0"
		)
		:signature (
			:key "RWR4D8s/solf7bEoPwXvsebrYebN+LLizUhK2BchkMj6PJ4apy7stzjb"
		)
	)
)