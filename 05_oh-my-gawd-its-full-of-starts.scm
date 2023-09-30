

(define a 'cup)
(define l '((coffee)
            cup
            ((tea) cup)
            (and (hick))
            (cup)
            ))
;; what is
(rember* a l)
;; => (
;;  (coffee)
;;  ((tea))
;;  (and (hick))
;; )
;; note: rember* is pronounced
;; idiomatically rember-star
