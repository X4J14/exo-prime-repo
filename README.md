# exo-prime-repo
Exo modules repository


**;; benchmarks-game module ;;**  

*Requirements*:  
Depends on tests parameters, but by default is requires ~4Gb disk space and 6Gb RAM.

*Run parameters:*
```lisp
(exo:run (:benchmarks-game "0.1") :run-clean-output) ; Clean of the tests output directory
(exo:run (:benchmarks-game "0.1")) ; Show a list to choose test and then run
(exo:run (:benchmarks-game "0.1") :run-all) : Run all tests
(exo:run (:benchmarks-game "0.1") (:@exo-run-benchmark <test-name>)) ; Run necessary test
(exo:run (:benchmarks-game "0.1")
  (:@exo-run-suite ; Run necessary tests
    ((<test-name> <value>) <test-name>)
  ))
```
