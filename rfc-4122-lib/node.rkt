#lang racket/base

(provide node-id? generate-node-id get-mac-address)

(require racket/port
         racket/string
         racket/system)

(define NODE-REGEX #px"^[a-fA-F0-9]{12}$")

(define (node-id? candidate)
  (if (string? candidate)
      (if (non-empty-string? candidate)
          ;; match it against regex? check it converts to a hex value?
          (if (regexp-match NODE-REGEX candidate)
              #t
              #f)
          #f)
      #f))

(define (get-mac-address #:ifconfig-invoker [system system])
  (define mac-address-regex #px"ether.+?\n")
  (define network-config (with-output-to-string (lambda () (system "/sbin/ifconfig"))))
  (displayln network-config)
  ;; TODO generate psuedorandom mac address
  (let ([mac-output (regexp-match mac-address-regex network-config)])
    (string-replace (string-replace (string-trim (car mac-output)) "ether " "") ":" "")))


(define (generate-node-id #:version [version 1])
  (cond
    [(equal? version 1) (get-mac-address)]))
