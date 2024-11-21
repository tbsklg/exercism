#lang racket

(provide acronym)

(define/contract (acronym s)
  (-> string? string?)
  (define words (string-split s #px"[-_\\s]+"))
  (apply string-append (for/list ([word (in-list words)])
    (string-upcase (substring word 0 1)))))
