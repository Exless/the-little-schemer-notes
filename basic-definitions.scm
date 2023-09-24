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

(define-module (basic-definitions)
  :export (atom?
           member?))

