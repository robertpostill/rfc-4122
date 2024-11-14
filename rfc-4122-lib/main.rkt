#lang racket/base

(provide generate-uuid generate-lockfile)

(require json
         racket/port)

(define LOCK-FILENAME "rfc4122.json")

(define MAC-OS-DIR "/Users/Shared")

(define DIRNAME "rfc-4122")

(define lockfile (string-append MAC-OS-DIR "/" DIRNAME "/" LOCK-FILENAME))

(define (generate-uuid)
  "test")

(define (generate-lockfile lockfile)
  (displayln (format "Looking for a lockfile at ~a" lockfile))
  (let ([exists (file-exists? lockfile)])
    (if exists
        (consume-lockfile lockfile)
        (initialise-lockfile lockfile))))

(define (initialise-lockfile lockfile)
  (displayln "Lockfile requires initialisation."))

;;read the UUID generator state: the values of the timestamp, clock sequence,
;; and node ID used to generate the last UUID.
(define (read-lockfile lockfile)
  (call-with-input-file lockfile
    (λ (in) (port->string in))))

(define (create-jsexpr)
  (displayln "creating jsexpr as whatever was in the state file didn't work")
  "maybe?")

(define (parse-json-from-lockfile json-string)
  (with-handlers ([exn:fail:read?
                   (lambda (exn) (create-jsexpr))])
    (string->jsexpr json-string)))

(define (consume-lockfile lockfile)
  (displayln "Lockfile exists: Attempting To Read State")
  (let ([lockfile-contents (read-lockfile lockfile)])
    (if (jsexpr? lockfile-contents)
        (parse-json-from-lockfile lockfile-contents)
        (initialise-lockfile lockfile))))
