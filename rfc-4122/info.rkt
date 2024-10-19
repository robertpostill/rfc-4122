#lang info

(define version "0.0")
(define collection 'multi)
(define deps '("base"
               "rfc-4122-lib"
               "rfc-4122-doc"
               "rfc-4122-test"))
(define build-deps '())
(define implies '("rfc-4122-lib"
                  "rfc-4122-doc"
                  "rfc-4122-test"))
