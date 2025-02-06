(
	:exo-version 1.0
	:description "Tests for Alexandria, which is a collection of portable public domain utilities"
	:module (
		:id :alexandria-test
		:version "1.0.1"
		:use (:cl)
		:run :tests
		:dependencies (
			:alexandria "1.0.1"
		)
		:signature (
			:key "RWR4D8s/solf7bEoPwXvsebrYebN+LLizUhK2BchkMj6PJ4apy7stzjb"
		)
	)
	:about (
		:author "Nikodemus Siivola <nikodemus@sb-studio.net>, and others."
		:licence "Public Domain / 0-clause MIT"
	)
)