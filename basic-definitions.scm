(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))


(define member?
  (lambda (a lat)
    (cond
     ((null? lat) #f)
     ((eq? (car lat) a) #t)
     (else (member? a (cdr lat))
           ))))

(define add1
  (lambda (n) (+ 1 n)))

(define sub1
  (lambda (n) (- n 1)))

(define-module (basic-definitions)
  :export (atom?
           member?))

