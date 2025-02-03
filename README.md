# exo-prime-repo
Exo modules repository


**;; benchmarks-game module ;;**  

*Requirements*:  
Depends on tests parameters, but by default requires free ~4Gb disk space and 6Gb RAM.

*Run parameters:*
```lisp
(exo:run (:benchmarks-game "0.1") :run-clean-output) ; Clean a test output directory
(exo:run (:benchmarks-game "0.1")) ; Show a list to choose test and then run
(exo:run (:benchmarks-game "0.1") :run-all) : Runs all tests
(exo:run (:benchmarks-game "0.1") (:@exo-run-benchmark <test-name>)) ; Runs necessary test
(exo:run (:benchmarks-game "0.1")
  (:@exo-run-suite ; run necessary tests
    ((<test-name> <value>) <test-name>)
  ))
```
