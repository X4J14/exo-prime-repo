(
	:exo-version 1.0
	:name "Test Trivial Gray Streams"
	:description "Compatibility layer for Gray Streams (see http://www.cliki.net/Gray%20streams)"
	:module (
		:id :trivial-gray-streams-test
		:version "2.0"
		:use ((:cl :method))
		:run :test@run-tests
		:dependencies (
			:trivial-gray-streams "2.0"
		)
		:signature (
			:key "RWR4D8s/solf7bEoPwXvsebrYebN+LLizUhK2BchkMj6PJ4apy7stzjb"
		)
	)
)