;; This module is *excessive* due to the cl-unicode module has tests too.
;; The cl-unicode generates some data files (by :run-build) for tests also.
;; So, a good idea to separate test code from the main module, but it is unsuitable in this case.
(
	:exo-version 1.0
	:description "Test portable Unicode Library"
	:module (
		:id :cl-unicode-test
		:version "0.1.6"
		:use (:cl)
		:run :tests@run-all-tests
		:dependencies (
			:cl-unicode "0.1.6"
		)
		:signature (
			:key "RWR4D8s/solf7bEoPwXvsebrYebN+LLizUhK2BchkMj6PJ4apy7stzjb"
		)
	)
)