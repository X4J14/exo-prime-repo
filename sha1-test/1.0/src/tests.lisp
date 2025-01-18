(exo
	(:import
		:extern #:sha1 #:base64
		:runtime
			(#:exo-utils (#:pfmtl #:pfmt #:fmt #:string+)))
	(:export :intern #:test-all))

(defconstant +test-data+
	"The quick brown fox jumps over the lazy dog")

(defun run-test (fn &rest args)
	(pfmt "~(~s~): ~(~s~) .. " fn args)
	(apply fn args)
	(pfmtl "OK"))

(defun test-sha1-digest (data result-bytes)
	(assert (equal (sha1-digest data) result-bytes)))

(defun test-sha1-hex (data result-sha1)
	(assert (string-equal (sha1-hex data) result-sha1)))

(defun test-sha1-base64 (data result-base64)
	(assert (string= (sha1-base64 data #'base64-encode) result-base64)))

(defun test-hmac-sha1-hex (data result-sha1)
	(assert (string-equal (hmac-sha1-hex "key" data) result-sha1)))

(defun test-sha1-hex-stream (mod-path file-name result-sha1)
	(with-open-file (stream (string+ mod-path "data/" file-name) :element-type '(unsigned-byte 8))
		(assert (string-equal (sha1-hex-stream stream) result-sha1))
	))

(defun test-sha1-hex-file (mod-path file-name result-sha1)
	(assert (string-equal (sha1-hex-file (string+ mod-path "data/" file-name)) result-sha1)))

(defun test-all (mod-path mod-props)
	(declare (ignore mod-props))
	(pfmtl "Start SHA1 tests...")
	(handler-case
		(progn
			(run-test 'test-sha1-digest "" '(218 57 163 238 94 107 75 13 50 85 191 239 149 96 24 144 175 216 7 9))
			(run-test 'test-sha1-hex      +test-data+ "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12")
			(run-test 'test-sha1-base64   +test-data+ "L9ThxnotKPzthJ7hu3bnORuT6xI=")
			(run-test 'test-hmac-sha1-hex +test-data+ "de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9")
			(run-test 'test-sha1-hex-stream mod-path "0b"   "da39a3ee5e6b4b0d3255bfef95601890afd80709")
			(run-test 'test-sha1-hex-stream mod-path "64b"  "ee3875466b1096773df35d681f84d8f1cc1163ac")
			(run-test 'test-sha1-hex-stream mod-path "512b" "aa727421906cf93abac47bebfb76eab7b71687ec")
			(run-test 'test-sha1-hex-file mod-path "1kib" "826cc5217253d928609b7942ef79a151aac040cd")
			(run-test 'test-sha1-hex-file mod-path "5kb"  "d7f9ced26f6f389496402628c596420d126c4c8b")
			(pfmtl "SHA1 tests succesfully completed."))
	(error (c)
		(error "Test SHA1 failed: ~a" c))
	))