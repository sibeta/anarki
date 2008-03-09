;;; basic.arc.t - test the various ways of declaring and executing functions.
;;;
;;; This file is licensed under the MIT X11 License:
;;; http://www.opensource.org/licenses/mit-license.php
;;;
;;; (C) Copyright by Shlomi Fish, 2008

(load "arctap.arc")

(plan 21)

(def func1 (a b) 
     (+ a (* 2 b)))

; TEST
(ok (is (func1 2 100) 202) "func1 #1")

; TEST
(ok (is (func1 100 2) 104) "func1 #2")

; TEST
(ok (is (func1 3 3) 9) "func1 #3 - same args")

; TEST
(ok (is (func1 10 1) 12) "func1 #4")

(def 1- (n) (- n 1))

; TEST
(ok (is (1- 5) 4) "Testing 1- - #1")

; TEST
(ok (is (1- 1) 0) "Testing 1- - #2")

; TEST
(ok (is (1- 0) -1) "Testing 1- - #3")

(def factorial1 (n)
     (if (is n 0)
       1 
       (* n (factorial1 (1- n)))))

; TEST
(ok (is (factorial1 4) 24) "Simple recursion - #1")

; TEST
(ok (is (factorial1 0) 1) "Simple recursion - #2")

; TEST
(ok (is (factorial1 1) 1) "Simple recursion - #3")

; TEST
(ok (is (factorial1 3) 6) "Simple recursion - #4")

(= myvar 1000)

(with (myvar 50)
      (def counter1 () 
           (= myvar (+ myvar 1))))

; TEST
(ok (is myvar 1000) "myvar is not affected by (with)")

; TEST
(ok (is (counter1) 51) "counter1 is counting")

; TEST
(ok (is (counter1) 52) "counter1 is counting")

; TEST
(ok (is myvar 1000) "myvar is still 1000 after running (counter1)")

(def poly1 (x . coeffs)
     (with (r 0)
           (= r (fn (myrest) 
                  (if (not myrest)
                    0 
                    (+ (car myrest) (* x (r (cdr myrest)))))))
           (r coeffs)))

; TEST
(test-is (poly1 5 3 2) 13 "x = 5; 3+2x = 13 - testing variable arguments")

; TEST
(test-is (poly1 2 3 2) 7 "x = 2; 3+2x = 7 - testing variable arguments")

; TEST
(test-is (poly1 0 3 2 5 100) 3 "x = 0; 3+... = 3 - testing variable arguments")

(def poly2 (x . coeffs)
     ((rfn r (myrest) 
                  (if (not myrest)
                    0 
                    (+ (car myrest) (* x (r (cdr myrest))))))
            coeffs))

; TEST
(test-is (poly2 5 3 2) 13 "x = 5; 3+2x = 13 - testing rfn")

; TEST
(test-is (poly2 2 3 2) 7 "x = 2; 3+2x = 7 - testing rfn")

; TEST
(test-is (poly2 0 3 2 5 100) 3 "x = 0; 3+... = 3 - testing rfn")

