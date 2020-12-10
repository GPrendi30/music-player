;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require racket/base)

(provide ;sorting
         sortv2
         sortv3 ;sorts uppercase and downcase the same
         ;searching
         searchv2
         searchv3;searches uppercase and downcase
         ;auxilary
         extract-nth)
         


;auxilary

(define (integer-val a-string num)
  (char->integer (string-val a-string num)))

(define (string-val a-string num)
  (list-ref (string->list a-string) num))

(define (real-list list)
  (map string-downcase list))

(define (extract-nth a-list index)
  (cond
    [(= index 0) (first a-list)]
    [else   
     (extract-nth (rest a-list) (- index 1))]))

(define (bind key value)
  (cond
    [(= (length key) 0)
     '()]
    [else
     (cons (list (first key) (first value))
           (bind (rest key) (rest value)))]))




;Comparing strings
(define (compare-strings string1 string2 [index 0])
  (local
    [(define char1 (integer-val string1 index))
     (define char2 (integer-val string2 index))
     (define len1 (string-length string1))
     (define len2 (string-length string2))]
    (cond 
      [(and (= char1 char2)
            (not (= index (- len1 1)))
            (not (= index (- len2 1))))
       (compare-strings string1 string2 (+ index 1))]
      [else
       (cond
         [(equal? char1 char2)
          (if (<= len1 len2) #t #f)]
         [(< char1 char2) #t]
         [(< char2 char1) #f])
       ])))


;sorting
(define (smallers pivot los)
  (cond
    [(empty? los) '()]
    [(string? (first los))
     (if (compare-strings pivot (first los) 0)
         (smallers pivot (rest los))
         (cons (first los) (smallers pivot (rest los)))
         )]
    [else
     (if (< pivot (first los))
         (smallers pivot (rest los))
         (cons (first los) (smallers pivot (rest los))))]
            ))


(define (largers pivot los)
  (cond
    [(empty? los) '()]
    [(string? (first los)) 
     (if (compare-strings pivot (first los) 0)
         (cons (first los) (largers pivot (rest los)))
         (largers pivot (rest los)))]
    [else
     (if (< pivot (first los))
         (cons (first los) (largers pivot (rest los)))
         (largers pivot (rest los)))]))


(define (quick-sort los)
  (cond
    [(empty? los) '()]
    [else
     (let
         [(pivot (first los))
          (lost (rest los))]
       (append
        (quick-sort (smallers pivot lost))
        (list pivot)
        (quick-sort (largers pivot lost))))]))


(define (quick-sort-reverse los)
  (cond
    [(empty? los) '()]
    [else
     (let
         [(pivot (first los))
          (lost (rest los))]
       (append
        (quick-sort-reverse (largers pivot lost))
        (list pivot)
        (quick-sort-reverse (smallers pivot lost))
        ))]))

(define (sortv2 list [mode "asc"])
  (let
      [(sorted (quick-sort list))
      (reversev2 (quick-sort-reverse list))]
    (cond
      [(equal? mode "asc") sorted]
      [(equal? mode "desc") reversev2])))



;searching

(define (contains? string1 string2 [index1 0] [index2 0])
  (let
      [(len1 (string-length string1))
       (len2 (string-length string2))]
    (if (>= len1 len2)
        (let
            [(char1 (string-val string1 index1))
             (char2 (string-val string2 index2))]
          (cond
            [(and (equal? char1 char2)
                  (<= index1 (- len1 1)))
             (if
              (= index2 (- len2 1))
              #t
              (contains? string1 string2 (+ index1 1) (+ index2 1)))]
            [(< index1 (- len1 1))
             (contains? string1 string2 (+ index1 1) index2)]
            [else #f]))
        #f)))

(define (searchv2 a-string los)
  (cond
    [(empty? los) '()]
    [else
     (if (contains? (first los) a-string)
         (cons (first los) (searchv2 a-string (rest los)))
         (searchv2 a-string (rest los)))]))


;final
(define (query los hash)
  (cond
    [(empty? los) '()]
    [else
     (cons (first (hash-ref hash (first los)))
           (query (rest los) hash))]))

(define (searchv3 a-string los)
  (local
    [(define bound (bind (real-list los) los))
     (define string (string-downcase a-string))
     (define hash (make-hash bound))
     (define searched (searchv2 string (real-list los)))]
    (query searched hash)))

(define (sortv3 list [mode "asc"])
  (local
    [(define to-sort (real-list list))
     (define sorted (sortv2 to-sort mode))
     (define bounded (bind to-sort list))
     (define hash (make-hash bounded))]
    (query sorted hash)))
