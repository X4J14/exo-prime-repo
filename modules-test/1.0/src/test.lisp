(exo
	(:export :intern #:exo-run))

(defun exo-run (mod-path mod-props)
	(declare (ignore mod-path mod-props))

	(exo:run (:trivial-gray-streams-test "2.0"))
	(exo:run (:flexi-streams-test "1.0.19"))

	(exo:run (:cl-unicode "0.1.6") :run-build)
	(exo:run (:cl-unicode "0.1.6") :test-all)
	(exo:run (:cl-unicode-test "0.1.6")) ; static test files

	(exo:run (:cl-ppcre-test "2.1.1"))
	(exo:run (:cl-ppcre-test "2.1.1") :run-unicode)

	(exo:run (:sha1-test "1.0"))
	(exo:run (:base64-test "1.0"))
	(exo:run (:alexandria-test "1.0.1")))
