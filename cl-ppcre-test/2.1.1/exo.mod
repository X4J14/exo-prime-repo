(
	:exo-version 1.0
	:description "Test Perl-compatible regular expression library"
	:module (
		:id :cl-ppcre-test
		:version "2.1.1"
		:use (:cl)
		:run :tests@run-all-tests
		:run-unicode :tests@unicode-test
		:dependencies (
			:cl-ppcre "2.1.1"
			:cl-ppcre-unicode "2.1.1"
			:flexi-streams "1.0.19"
		)
		:signature (
			:key "RWR4D8s/solf7bEoPwXvsebrYebN+LLizUhK2BchkMj6PJ4apy7stzjb"
		)
	)
	:about (
		:author "Dr. Edi Weitz"
		:license "BSD"
	)
)