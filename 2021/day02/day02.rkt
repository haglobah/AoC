#lang racket

(require "../lib/common.rkt"
         racket/runtime-path)

(define-runtime-path path ".")
(define in (find-infile path))

(define (part-01 in)
  (read-input in))

(define (part-02 in)
  (read-input in))