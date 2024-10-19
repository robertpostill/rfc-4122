#lang racket

(require rackunit
         rackunit/text-ui
         rfc-4122)

(define tests

  (test-suite
   "Tests for rfc-4122"

   (check-equal? (hello) "Hello, World!")
   (check-equal? (hello "robertpostill") "Hello, robertpostill!")))

(module+ test
  (void
   (run-tests tests)))
