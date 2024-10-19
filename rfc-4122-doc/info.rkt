#lang info

(define collection "rfc-4122")
(define deps '("base"))
(define build-deps '("rfc-4122-lib"
                     "scribble-lib"
                     "racket-doc"
                     "sandbox-lib"))
(define version "0.0")
(define pkg-authors '(robertpostill))
(define scribblings '(("scribblings/rfc-4122.scrbl" ())))
(define clean '("compiled" "doc" "doc/rfc-4122"))
