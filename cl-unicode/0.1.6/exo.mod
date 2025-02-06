(
	:exo-version 1.0
	:description "Portable Unicode Library"
	:module (
		:id :cl-unicode
		:version "0.1.6"
		:use (:cl)
		:run-build :build@create-source-files
		:test-all :test/tests@run-all-tests
		:dependencies (
			:cl-ppcre "2.1.1"
			:flexi-streams "1.0.19"
		)
		:signature (
			:key "RWR4D8s/solf7bEoPwXvsebrYebN+LLizUhK2BchkMj6PJ4apy7stzjb"
		)
	)
	:about (
		:author "Dr. Edi Weitz"
		:license "BSD-2-Clause"
	)
)