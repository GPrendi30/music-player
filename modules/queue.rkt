;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname queue) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require racket/base)
(require "player.rkt")
(require "song.rkt")

(provide ;queue functions
         QUEUE
         ;adding or removing
         enqueue
         dequeue
         removev2
         ;showing
         queue_first
         queue_last
         queue_show
         ;resetting
         queue_reset)
         

(define QUEUE '())

;=======================================================================================;

(define (enqueue_single element)
  (local
    [(define new-QUEUE
       (if (empty? QUEUE)
      (cons element QUEUE)
      (append QUEUE (list element))))
     (define updated-QUEUE (set! QUEUE new-QUEUE))]
  (if (equal? QUEUE new-QUEUE)
      #t
      #f)))

(define (enqueue_multiple list)
  (write (map enqueue_single list)))

(define (enqueue any)
  (if (list? any)
      (enqueue_multiple any)
      (enqueue_single any)))


;=======================================================================================;

(define (sublist list [first-index 0] [last-index (- (length list) 1)])
   (cond
    [(> first-index last-index)
     '()]
    [else
     (let
      [(current (list-ref list first-index))]
       (cons
        current (sublist list (+ first-index 1) last-index)))]))


(define (removev2 element list [index 0])
  (if (> index (- (length list) 1))
      #f
      (local
        [(define pre (sublist list 0 (- index 1)))
         (define post (sublist list (+ index 1)))
         (define current (list-ref list index))]
        (cond
          [(equal? (length list) 1)
           (if (equal? (first list) element)
               (rest list)
               list)]
          [else
           (if (equal? current element)
               (append pre post)
               (removev2 element list (+ index 1)))]
          ))))

(define (dequeue element)
  (local
      [(define new-QUEUE (removev2 element QUEUE))
       (define update-QUEUE
         (if new-QUEUE
             (set! QUEUE new-QUEUE)
             #f))]
    (if (equal? QUEUE new-QUEUE)
      #t
      #f)))


;==========================================================================;

(define (queue_reset)
  (set! QUEUE '()))

(define (queue_first)
  (first QUEUE))

(define (queue_last)
  (let
      [(last (- (length QUEUE) 1))]
    (list-ref QUEUE last)))

(define (queue_show)
  QUEUE)