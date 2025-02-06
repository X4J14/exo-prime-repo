(
	:exo-version 1.0
	:name "Test Flexi streams"
	:description "Test flexible bivalent streams for Common Lisp"
	:module (
		:id :flexi-streams-test
		:version "1.0.19"
		:use ((:cl :defconstant))
		:run :test@run-all-tests
		:dependencies (
			:flexi-streams "1.0.19"
		)
		:signature (
			:key "RWR4D8s/solf7bEoPwXvsebrYebN+LLizUhK2BchkMj6PJ4apy7stzjb"
		)
	)
	:about (
		:author "Dr. Edmund Weitz"
		:license "BSD-2-Clause"
	)
)