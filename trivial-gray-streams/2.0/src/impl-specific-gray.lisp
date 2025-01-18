(exo
  (:import :runtime
    #+sbcl #:sb-gray
    #+allegro #:excl
    #+cmu #:ext
    #+(or clisp ecl mkcl mocl clasp) #:gray
    #+openmcl #:ccl
    #+lispworks #:stream
    #+(or abcl genera) #:gray-streams
    #+mezzano #:mezzano.gray)
  (:export :intern
    #:fundamental-stream
    #:fundamental-input-stream
    #:fundamental-output-stream
    #:fundamental-character-stream
    #:fundamental-binary-stream
    #:fundamental-character-input-stream
    #:fundamental-character-output-stream
    #:fundamental-binary-input-stream
    #:fundamental-binary-output-stream
    #:stream-read-char
    #:stream-unread-char
    #:stream-read-char-no-hang
    #:stream-peek-char
    #:stream-listen
    #:stream-read-line
    #:stream-clear-input
    #:stream-write-char
    #:stream-line-column
    #:stream-start-line-p
    #:stream-write-string
    #:stream-terpri
    #:stream-fresh-line
    #:stream-finish-output
    #:stream-force-output
    #:stream-clear-output
    #:stream-advance-to-column
    #:stream-read-byte
    #:stream-write-byte
    #:stream-read-sequence
    #:stream-write-sequence
    #:stream-file-position))