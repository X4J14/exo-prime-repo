(
	:exo-version 1.0
	:name "The Common Lisp (Benchmarks Game) measure performance suite"
	:description "https://benchmarksgame-team.pages.debian.net/benchmarksgame/measurements/sbcl.html"
	:module (
		:id :benchmarks-game
		:version "0.1"
		:run :@exo-run-menu
		:run-all :@exo-run-all
		:run-clean-output :@exo-run-clean-output
		:require (:sb-concurrency)
		:use (:cl)
		;:use ((:cl #:read-from-string #:write-to-string))
		:dependencies (
			:cl-ppcre "2.1.1"
			:sha1 "1.0"
		)
		:signature (
			:key "RWR4D8s/solf7bEoPwXvsebrYebN+LLizUhK2BchkMj6PJ4apy7stzjb"
		)
	)
)