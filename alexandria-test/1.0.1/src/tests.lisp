(exo
  (:import :intern
    (#:tests-1 #:t1)
    (#:tests-2 #:t2))
  (:export :intern #:exo-run))

(defun exo-run (mod-path mod-cfg)
  (declare (ignore mod-path mod-cfg))
  (t1:run-tests :compiled nil)
  (t1:run-tests :compiled t))