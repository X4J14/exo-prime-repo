(exo
  (:export :intern #:exo-run #:main))

(defun exo-run (mod-path mod-props input-file)
  (declare (ignore mod-path mod-props))
  (main input-file))

;; The Computer Language Benchmarks Game
;; https://benchmarksgame-team.pages.debian.net/benchmarksgame/program/revcomp-sbcl-2.html
;;
;; contributed by Antonio Saade

(declaim (optimize (speed 3) (safety 0) (debug 0)))

(defconstant +lut+
  (let ((lut (make-array 256 :element-type 'base-char)))
    (loop
      for a across "ACGTMRWSYKVHDBNUacgtmrwsykvhdbnu"
      for b across "TGCAKYWSRMBDHVNATGCAKYWSRMBDHVNA"
      do (setf (aref lut (char-code a)) b))
    lut))

(declaim (inline compl))
(defun compl (a)
  (declare (type base-char a))
  (aref +lut+ (char-code a)))

(declaim (inline write-seq-by-n))
(defun write-seq-by-n (s n out)
  (declare (type simple-string s)
           (type fixnum n))
  (loop
    with length = (length s)
    for start from 0 by n below length
    do (write-line s out :start start :end (min length (+ start n)))))

(declaim (inline process-fasta))
(defun process-fasta (s out)
  (declare (type simple-string s))
  (do ((start 0 (1+ start))
       (end (- (length s) 1) (1- end))
       (b #\0))
      ((< end start))
    (setf b (schar s start))
    (setf (schar s start) (compl (schar s end)))
    (setf (schar s end) (compl b)))
  (write-seq-by-n s 60 out))

(defun main (&optional (pifile #p"/dev/stdin"))
  (with-open-file (in pifile)
    (loop
      :with fasta = (make-string-output-stream :element-type 'base-char)
      :for line = (read-line in nil)
      :while line :do
         (if (char= (char line 0) #\>)
             (progn
               (process-fasta (get-output-stream-string fasta) *standard-output*)
               (write-line line *standard-output*))
             (write-string line fasta))
      :finally (process-fasta (get-output-stream-string fasta) *standard-output*))));)