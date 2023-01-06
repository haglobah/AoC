#lang racket

(require "../lib/common.rkt"
         racket/runtime-path)

(define-runtime-path path ".")
(define in (read-input (find-infile path)))

(define (part-01 in)
  (define report (map chars in))
  (define 01s-list (zip report))
  (define cons-ε/γ (λ (#:mode m l acc) 
    (if (> (count-occurences #\1 l)
           (count-occurences #\0 l))
		(cons (if (equal? m "ε") #\1 #\0) acc)
		(cons (if (equal? m "ε") #\0 #\1) acc)
		)))
  (define ε (reverse (foldl (curry cons-ε/γ #:mode "ε") '() 01s-list)))
  (define g (reverse (foldl (curry cons-ε/γ #:mode "g") '() 01s-list)))
  (* (decode ε) (decode g)))

(define (part-02 in)
  (define report (map chars in))
  (println report)
  (define co2 (diagnose #t report))
  co2)

(define (count-occurences char list) 
    (foldl (λ (c acc) (if (equal? c char) (+ 1 acc) acc)) 0 list))

(define (diagnose mode report)
  (find-diag mode 0 report))

(define (find-diag mode rec report)
  (cond [(= rec (length (first report))) (first report)]
        [(= (length report) 1) (first report)]
		[else (find-diag mode (- rec 1)
		                 (filter (curry less/more-bits? mode rec report) report))]))

(define (less/more-bits? mode position lists filter-list)
  (define 01s (zip lists))
  (equal? (list-ref filter-list position) (more? #\1 #\0 01s)))

(define (more? c1 c2 list)
  (> (count-occurences c1 list) (count-occurences c2 list)))

(define (decode diagnostic)
  (string->number (list->string diagnostic) 2))

(define (count-bits@ report position)
  (for*/fold ([0s 0]
              [1s 0])
             ([r report])
    (if (equal? #\0 (list-ref r position))
        (values (add1 0s) 1s)
        (values 0s (add1 1s)))))

(define test-string #<<HERE
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
HERE
)

(define test (lines test-string))
