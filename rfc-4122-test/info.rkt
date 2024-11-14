#lang info

(define collection "rfc-4122")
(define deps '("base"))
(define build-deps '("rfc-4122-lib"
                     "rackunit-lib"
                     "cover"
                     "cover-coveralls"
                     "mock"))
(define version "0.0")
(define pkg-authors '(robertpostill))
(define clean '("compiled" "tests/compiled"))
