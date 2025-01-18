(defparameter *this-file*
  (load-time-value (or #.*compile-file-pathname* *load-pathname*)))

(defun check-files (filenames)
  (format t "Check files: ~(~s~)~%" filenames)
  (dolist (filename filenames)
    (unless (probe-file (make-pathname :name filename
                                       :type nil :version nil
                                       :defaults *this-file*))
      (format t "File ~s does't exist.~%" filename)
      (return-from check-files))
  )t)

(unless (check-files '("lists.lisp" "methods.lisp" "hash-tables.lisp"))
  (exo (:import :intern #:build))
  (funcall (find-symbol "CREATE-SOURCE-FILES")))

(exo
  (:import
    :extern
      (#:cl-ppcre #:ppcre)
      (#:cl-ppcre (
        #:*standard-optimize-settings*
        #:with-rebinding)))
  (:export :extern
    #:+code-point-limit+
    #:*scripts-to-try*
    #:*try-abbreviations-p*
    #:*try-hex-notation-p*
    #:*try-lisp-names-p*
    #:*try-unicode1-names-p*
    #:age
    #:bidi-class
    #:bidi-classes
    #:bidi-mirroring-glyph
    #:binary-properties
    #:canonicalize-name
    #:character-named
    #:code-block
    #:code-blocks
    #:combining-class
    #:disable-alternative-character-syntax
    #:enable-alternative-character-syntax
    #:general-categories
    #:general-category
    #:has-binary-property
    #:has-property
    #:list-all-characters
    #:lowercase-mapping
    #:numeric-type
    #:numeric-value
    #:property-name
    #:property-symbol
    #:property-test
    #:recognized-properties
    #:script
    #:scripts
    #:titlecase-mapping
    #:word-break
    #:unicode-error
    #:unicode-name
    #:unicode1-name
    #:uppercase-mapping
    #:case-fold-mapping
    #:idna-mapping
    #:canonical-decomposition
    #:normalization-form-c
    #:normalization-form-d
    #:normalization-form-k-c
    #:normalization-form-k-d
  ; for tests
  :intern
    #:*scripts-to-try*
    #:*try-abbreviations-p*
    #:*try-hex-notation-p*
    #:*try-lisp-names-p*
    #:*try-unicode1-names-p*
    #:general-category
    #:age
    #:binary-properties
    #:bidi-class
    #:bidi-mirroring-glyph
    #:combining-class
    #:code-block
    #:has-binary-property
    #:has-property
    #:lowercase-mapping
    #:uppercase-mapping
    #:character-named
    #:numeric-type
    #:numeric-value
    #:disable-alternative-character-syntax
    #:enable-alternative-character-syntax
    #:unicode-name
    #:unicode1-name
    #:script
    #:normalization-form-c
    #:normalization-form-d
    #:normalization-form-k-c
    #:normalization-form-k-d
    #:titlecase-mapping)
  (:bundle
    #:specials
    #:util
    #:conditions
    #:lists
    #:hash-tables
    #:api
    #:methods
    #:test-functions
    #:derived
    #:alias))
