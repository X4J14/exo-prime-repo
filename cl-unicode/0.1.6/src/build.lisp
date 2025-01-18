(exo
  (:import :extern
    (#:cl-ppcre #:ppcre)
    (#:cl-ppcre (
      #:*standard-optimize-settings*
      #:with-rebinding))
    (#:flexi-streams #:flex))
  (:export :intern #:create-source-files)
  (:bundle
    #:specials
    #:util
    #:build/util
    #:build/char-info
    #:build/read
    #:build/dump))