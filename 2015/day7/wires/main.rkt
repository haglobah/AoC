#lang br/quicklang

(module+ reader
  (provide read-syntax))

(define (read-syntax path port)
  (define wire-datums
    (for/list ([wire-str (in-lines port)])
              (format-datum '(wire ~a) wire-str)))
  (strip-bindings
   #`(module wires-mod wires/main
       #,@wire-datums)))

(define-macro (wires-module-begin WIRE-DATUM ...)
  #'(#%module-begin
     WIRE-DATUM ...))
(provide (rename-out [wires-module-begin #%module-begin]))

(define-macro-cases wire
  [(wire ARG -> ID)
   #'(define/display (ID) (val ARG))]
  [(wire OP ARG -> ID)
   #'(wire (OP (val ARG)) -> ID)]
  [(wire ARG1 OP ARG2 -> ID)
   #'(wire (OP (val ARG1) (val ARG2)) -> ID)]
  [else #'(void)])
(provide wire)

(define-macro (define/display (ID) BODY)
  #'(begin
      (define (ID) BODY)
      (module+ main
        (displayln (format "~a: ~a" 'ID (ID))))))

(define val
  (let ([val-cache (make-hash)])
    (λ (num-or-wire)
      (if (number? num-or-wire)
          num-or-wire
          (hash-ref! val-cache num-or-wire num-or-wire)))))

(define (mod-16bit x) (modulo x 65536))
(define-macro (define-16bit ID PROC-ID)
  #'(define ID (compose1 mod-16bit PROC-ID)))

(define-16bit AND bitwise-and)
(define-16bit OR bitwise-ior)
(define-16bit NOT bitwise-not)
(define-16bit LSHIFT arithmetic-shift)
(define (RSHIFT val amount) (LSHIFT val (- amount)))
(provide AND OR NOT LSHIFT RSHIFT)


