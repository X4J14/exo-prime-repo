(exo
	(:import
		:extern #:base64
		:runtime
			(#:exo-utils (#:pfmtl)))
	(:export :intern #:test-all))

(defconstant +decoded-data+ "Man is distinguished")
(defconstant +encoded-data+ "TWFuIGlzIGRpc3Rpbmd1aXNoZWQ=")

(defun test-encode ()
	(unless (equal (base64-encode +decoded-data+) +encoded-data+)
		(error "test-encode")
	))

(defun test-decode ()
	(unless (equal (base64-decode +encoded-data+) +decoded-data+)
		(error "test-decode")
	))

(defun test-all (mod-path mod-props)
	(declare (ignore mod-path mod-props))
	(handler-case
		(progn
			(test-encode)
			(test-decode)
			(pfmtl "Base64 tests succesfully completed."))
		(error (c)
			(error "Test Base64 failed: ~a" c))
	))