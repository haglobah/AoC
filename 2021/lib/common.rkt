#lang racket

(provide (all-defined-out)
		 (all-from-out threading))

(require threading)

(define (get-folder-name path)
  (second (reverse (string-split (path->string path) "\\"))))
(define (find-infile path)
  (string-append (get-folder-name path) ".input"))

(define (read-input infile)
  (file->lines infile))

(define (map-input f infile)
  (with-input-from-file infile
    (λ () (for/list ([line (in-lines)])
	                (f line)))
  #:mode 'text))

(define (lines s)
  (~> (string-split s "\n")
      (map (λ (s) (string-replace s "\r" "")) _)))

;; split input into groups split by a empty lines
(define (groups s)
  (string-split s "\r\n\r\n"))

(define (words s)
  (string-split s " "))

(define (chars s)
  (string->list s))
