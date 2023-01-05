#lang racket

(require threading)

(define depths (~> (file->lines "input1.txt")
	(map string->number _)))

(define (part-01 in)
  (for/sum ([x in] [y (drop in 1)] #:when (< x y))
  1))

(define (part-02 in)
  (for/sum ([x in] [y (drop in 3)] #:when (< x y))
  1))
