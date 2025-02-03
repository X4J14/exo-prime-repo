(exo
	(:import
		:extern #:sha1
		:runtime (#:exo-utils (
			#:lets #:let-if #:let-when
			#:fmt #:pfmt #:pfmtl
			#:string+
			#:read-from-string
			#:write-to-string)))
	(:export :intern
		#:exo-run-clean-output
		#:exo-run-menu
		#:exo-run-benchmark
		#:exo-run-suite
		#:exo-run-all))

;(declaim (optimize (speed 0) (debug 3) (safety 3)))

(defstruct benchmark
	(name nil :type string)
	(set nil :type cons)
	(value nil :type integer)
	(value-type nil :type cons)
	(prepare-fn nil :type (or null function))
	(output-type nil :type (or cons symbol function))
	(output-sha1 nil :type simple-string))

(declaim (inline output-file-path))
(defun output-file-path (output-dir name value)
	(string+ output-dir name "_" (write-to-string value) ".out"))

(defun prepare-fasta (b value output-dir)
	(lets (file-path (output-file-path output-dir "fasta-2" value))
		(unless (probe-file file-path)
			(pfmtl "~s requires Fasta (~s) output.~%Running Fasta...~%" (benchmark-name b) value)
			(call-benchmark-fn file-path 'character nil "fasta-2" value)
			(pfmtl "Fasta generated: ~s~%" file-path))
		file-path
	))

(defvar %benchmarks%
	(list
		(make-benchmark
			:name "Binary trees"
			:set '(
				(btree-1 #:binary-trees-1)
				(btree-3 #:binary-trees-3))
			:value 21
			:value-type '(integer 1 100)
			:output-sha1 "c264c38daebdb60b57a72ad45c20fc1d66e28c97")
		(make-benchmark
			:name "Fannkuch-redux"
			:set '(
				(fredux-2 #:fannkuch-redux-2)
				(fredux-3 #:fannkuch-redux-3)
				(fredux-4 #:fannkuch-redux-4)
				;; todo: sometimes test failed.
				;; Very strange bug reproduces while running by Exo only.
				;; But not reproduces always.
				(fredux-5 #:fannkuch-redux-5)
			)
			:value 12
			:value-type '(integer 1 100)
			:output-sha1 "6c902a7d02501f5ce13852b4389767e44e922d84")
		(make-benchmark :name "Fasta"
			:set '(
				(fasta-1 #:fasta-1)
				(fasta-2 #:fasta-2)
				(fasta-3 #:fasta-3)
				(fasta-6 #:fasta-6))
			:value 25000000
			:value-type '(integer 1 1000000000)
			:output-sha1 "f6c8097bd968359f8c98ed6b7dc47368413a66ad")
		(make-benchmark
			:name "K-nucleotide"
			:set '(
				(knucl-1 #:k-nucleotide-1)
				(knucl-2 #:k-nucleotide-2)
				(knucl-3 #:k-nucleotide-3)
				(knucl-4 #:k-nucleotide-4)
				(knucl-5 #:k-nucleotide-5)
				(knucl-6 #:k-nucleotide-6))
			:value 25000000
			:value-type '(integer 1 1000000000)
			:prepare-fn #'prepare-fasta
			:output-sha1 "54b277501242ae53cfac4807c4d2b9393ce33de0")
		(make-benchmark
			:name "Mandelbrot"
			:set '(
				(mandel-1 #:mandelbrot-1)
				(mandel-3 #:mandelbrot-3)
				(mandel-4 #:mandelbrot-4))
			:value 16000
			:value-type '(integer 1 1000000000)
			:output-type '(unsigned-byte 8)
			:output-sha1 "c3be0fca30ea96f7e769af280953acee1c49a919")
		(make-benchmark
			:name "N-body"
			:set '(
				(nbody-1 #:nbody-1)
				(nbody-2 #:nbody-2))
			:value 50000000
			:value-type '(integer 1 1000000000)
			:output-sha1 "c20fec9acab14a92777c05113eef5323c5cb898c")
		(make-benchmark
			:name "Pidigits"
			:set '(
				(pidig-2 #:pidigits-2)
				(pidig-3 #:pidigits-3)
				(pidig-4 #:pidigits-4))
			:value 10000
			:value-type '(integer 1 1000000000)
			:output-sha1 "bf766455295f5d1a2fc2f633c8d7de86ca508a3c")
		(make-benchmark
			:name "Reverse-complement"
			:set '(
				(rcomp-1 #:reverse-complement-1)
				(rcomp-2 #:reverse-complement-2))
			:value 100000001
			:value-type '(integer 1 1000000000)
			:prepare-fn #'prepare-fasta
			:output-type (lambda (name)
				(cond
					((string= name "rcomp-1") '(unsigned-byte 8))
					(t 'base-char)
				))
			:output-sha1 "c620723cf16de2074c451ecd0c25ab76d2633d0c")
		(make-benchmark
			:name "Spectral-norm"
			:set '(
				(snorm-1 #:spectral-norm-1)
				(snorm-2 #:spectral-norm-2)
				(snorm-3 #:spectral-norm-3)
				(snorm-6 #:spectral-norm-6)
				(snorm-7 #:spectral-norm-7)
				(snorm-9 #:spectral-norm-9))
			:value 5500
			:value-type '(integer 1 100000)
			:output-sha1 "3a27108a19570b0fac668d76ec86cbd389d4144b")
		(make-benchmark
			:name "Regex redux"
			:set '(
				(regred-4 #:regex-redux-4))
			:value 5000000
			:value-type '(integer 1 1000000000)
			:prepare-fn #'prepare-fasta
			:output-sha1 "af20dc077f266c85c5e253787194ca677ea8a8d4")
	))

(defconstant +output-directory+ ".output")

(define-condition <benchmark-error> (error)
	((message :initarg :message :initform nil :reader .message))
	(:report (lambda (cond stream)
		(format stream "~a" (.message cond))
	)))

(defmacro benchmark-error (msg &rest args)
	`(error '<benchmark-error> :message (fmt ,msg ,@args)))


(defmacro call-fn (fn output-file output-type args)
	`(if ,output-file
		(with-open-file (*standard-output* ,output-file
				:direction :output :if-exists :supersede :element-type ,output-type)
			(apply ,fn ,args))
		(apply ,fn ,args)
	))

(defun find-benchmark (name)
	(dolist (b %benchmarks%)
		(dolist (lst (benchmark-set b))
			(when (string-equal name (first lst))
				(return-from find-benchmark b))
		))
	(benchmark-error "Invalid benchmark name: ~s" name))

(defun find-benchmark-file (name)
	(lets (b (find-benchmark name))
		(dolist (lst (benchmark-set b))
			(when (string-equal name (first lst))
				(return-from find-benchmark-file (second lst))
			))))

(defun call-benchmark-fn (output-file output-type measure-time name &rest args)
	(lets (*package* (find-package (package-name *package*)))
		(exo:exo
			(list :import :intern
				(list
					(find-benchmark-file name)
					(make-symbol (string-upcase name)))))
		(lets (fn (symbol-function (read-from-string (string+ name ":main"))))
			(pfmtl "Call ~(~s~) ~s" fn args)
			(when (functionp output-type)
				(setf output-type (funcall output-type name)))
			(if measure-time
				(with-open-file (*trace-output* (string+ output-file ".time")
						:direction :output :if-exists :supersede)
					(time (call-fn fn output-file output-type args)))
				(call-fn fn output-file output-type args)
			))))

(defun convert-value (value full-type)
	(lets (type
				(typecase full-type
					(cons (first full-type))
					(symbol full-type)
					(otherwise (error "Unexpected type of full type: ~s" full-type))))
		(case type
			(integer
				(handler-case
					(let-if (value (parse-integer value)) (typep value full-type)
						value
						(error "Could't parse integer. Expected: ~s" full-type))
				(error (c)
					(benchmark-error "Could't convert value ~s to ~(~s~): ~a" value type c))
				))
			(string value)
			(otherwise (error "Unexpected type: ~s" type))
		)))

(defun get-value (user-value default-value value-type)
	(if (zerop (length user-value))
		default-value
		(convert-value user-value value-type)
	))

(defun run-benchmark (b name value output-dir &optional output-file output-type)
	(pfmtl "~%Run ~s (~s)...~%" name value)
	(if (benchmark-prepare-fn b)
		(let-when (value (funcall (benchmark-prepare-fn b) b value output-dir)) value
			(call-benchmark-fn output-file output-type t name value))
		(call-benchmark-fn output-file output-type t name value))
	(when output-file
		(pfmtl "Output saved to: ~s" output-file)
		(pfmt "Checking output result ..")
		(if (string-equal (benchmark-output-sha1 b) (sha1-hex-file output-file))
			(pfmtl " OK")
			(error "Output result file ~s is mismatch to expected SHA1: ~s"
				output-file (benchmark-output-sha1 b))
		)))

(defun exo-run-clean-output (mod-path mod-props
		&aux (output-path (probe-file (string+ mod-path +output-directory+ "/"))))
	(declare (ignore mod-props))
	(pfmtl "Clean output directory: ~s" output-path)
	(when output-path
		(exo-fs:directory-delete-content output-path)
	))

(defun exo-run-menu (mod-path mod-props &optional is-clean-output)
	(when is-clean-output (exo-run-clean-output mod-path mod-props))
	(pfmtl "Welcome to Benchmarks game!")
	(dolist (b %benchmarks%)
		(pfmtl "~a (~(~s~)):" (benchmark-name b) (benchmark-value b))
		(dolist (s (benchmark-set b))
			(pfmtl "  ~(~a~)" (first s))))
	(pfmtl "Please type name from the list above:")
	(handler-case
		(lets (name (read-line) b (find-benchmark name))
			(pfmtl "Type new value or press Enter to use default: ~(~s~)" (benchmark-value b))
			(lets (
					value (get-value (read-line) (benchmark-value b) (benchmark-value-type b))
					output-dir (ensure-directories-exist (string+ mod-path +output-directory+ "/")))
				(run-benchmark b name value output-dir
					(output-file-path output-dir name value)
					(benchmark-output-type b))
			))
		(<benchmark-error> (c)
			(pfmtl "~a" c))
	))

(defun exo-run-benchmark (mod-path mod-props name &optional value is-clean-output)
	(check-type name (or string symbol))
	(check-type value (or null integer))
	(when is-clean-output (exo-run-clean-output mod-path mod-props))
	(typecase name
		(symbol (setf name (string-downcase name))))
	(handler-case
		(lets (
			b (find-benchmark name)
			value (get-value (write-to-string value) (benchmark-value b) (benchmark-value-type b))
			output-dir (ensure-directories-exist (string+ mod-path +output-directory+ "/")))
		(run-benchmark b name value output-dir
			(output-file-path output-dir name value)
			(benchmark-output-type b)))
	(<benchmark-error> (c)
		(pfmtl "~a" c))
	))

(defun exo-run-suite (mod-path mod-props lst &optional is-clean-output)
	(check-type lst cons)
	(pfmtl "Run suite: ~s" lst)
	(dolist (value lst)
		(typecase value
			(cons
				(exo-run-benchmark mod-path mod-props (first value) (second value) is-clean-output))
			((or string symbol)
				(exo-run-benchmark mod-path mod-props value nil is-clean-output))
			(otherwise (error "Unexpected type of value: ~s" value)))
	))

(defun exo-run-all (mod-path mod-props &optional is-clean-output)
	(exo-run-suite mod-path mod-props
		(loop for b in %benchmarks%
			nconc (loop for s in (benchmark-set b) collect (cons (string-downcase (first s)) nil)))
		is-clean-output
	))
