#lang racket

(provide (all-defined-out)
		 (all-from-out threading))

(require syntax/parse/define
         threading)

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

(define-syntax-parser zip
  [(_)
  #'(zip-fun '(()))]
  [(_ lists)
  #'(zip-fun lists)]
  [(_ l1 l2 ...+)
  #'(zip-fun (list l1 l2 ...))])

(define (zip-fun lists)
  #;(printf "called with ~a\n" lists)
  (cond
    [(ormap empty? lists) '()]
	[else
	  (define new-args (map (λ (li) (drop li 1)) lists))
	  #;(println new-args)
	  (cons
	    (map first lists)
		(zip-fun new-args))]))

#;(curry)