#lang br/quicklang

(provide way
		 forward
		 up
		 down
		 print
         (rename-out [ways-module-begin #%module-begin]))

(module+ reader 
  (provide read-syntax))

(define (read-syntax path port)
  (define way-datums
	(for/list ([way-str (in-lines port)])
	          (if (equal? way-str "")
			      (void)
				  (format-datum '(~a) way-str))))
  (strip-bindings
    #`(module ways-mod day02/main
	  #,@way-datums)))

(define-macro (ways-module-begin DIRECTIONS ...)
  #'(#%module-begin
     DIRECTIONS ...))

(define depth 0)
(define distance 0)

(define (print)
  (printf "distance: ~a\n" distance)
  (printf "depth: ~a\n" depth)
  (printf "dist * depth: ~a\n" (* distance depth))
  )

(define (forward n)
  (set! distance (+ distance n)))
(define (up n)
  (set! depth (- depth n)))
(define (down n)
  (set! depth (+ depth n)))

(define (way var val)
  (print val)
  (match var
    ["forward" (set! distance (+ distance val))]
	["up" (set! depth (- depth val))]
	["down" (set! depth (+ depth val))])
	(void))

(define (adjust op var val)
  (printf "adjust ~a by ~a\n" 'var 'val)
  (set! var (op var val)))