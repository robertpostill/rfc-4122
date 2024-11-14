#lang racket/base

(require json
         mock
         rackunit
         rackunit/text-ui
         rfc-4122)

(define (seed-test-file filename seed-data)
  (call-with-output-file filename
                          #:exists 'truncate
                          (lambda (out)
                            (display seed-data out)))
  seed-data)

(define tests
  (test-suite
   "Main flow tests for rfc-4122"
   
    (test-suite
     "generate-uuid"

     (check-equal? (generate-uuid) "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"))
    
    (test-suite
     "generate-lockfile"
     (test-case
         "the lockfile exists and is good"
       (define good-json "{ \"test\" : 1, \n \"test2\" : \"blah\" }")
       (define expectation (seed-test-file "test.json" good-json))
       (define result (generate-lockfile "test.json"))
       (check-equal? result (string->jsexpr expectation)))
     (test-case
         "the lockfile exists but can't be parsed"
       (define bad-json "bad-data")
       (seed-test-file "test.json" bad-json)
       (define result (generate-lockfile "test.json"))
       (check-true (jsexpr? result)))
     (test-case
         "the lockfile exists and the json is wrong"
       (define bad-json "{ \"test\" : 1, \n \"test2\" : \"blah\" }")
       (seed-test-file "test.json" bad-json)
       (define result (generate-lockfile "test.json"))
       (check-true (jsexpr? result))))))

(module+ test
  (void
   (run-tests tests)))
