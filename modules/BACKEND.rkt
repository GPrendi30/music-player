;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname BACKEND) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))


(require racket/base)
(require "player.rkt")
(require "queue.rkt")
(require "db.rkt")
(require "song.rkt")
(require "sort.rkt")

;provided functions by player.rkt
(provide init-player
         add
         stop!
         pause!
         play!
         update!
         dec-vol
         inc-vol
         get-volume
         set-volume
         current-time
         reset!)


;provided functions by queue.rkt
(provide ;queue functions
         QUEUE
         ;adding or removing
         enqueue
         dequeue
         ;showing
         queue_first
         queue_last
         queue_show
         ;resetting
         queue_reset)

;provided functions by song.rkt
(provide ;creating
         create-SONG
         resize
         create-absolute-path
         ;song-struct
         SONG
         ;song functions
         get-info
         get-image
         get-duration-seconds)

;provided functions by database.rkt
(provide ;global database functions
         database
         db_show
         db_list-id
         ;song functions
         db_add-song
         db_get-song
         ;album functions
         db_get-album
         db_get-author
         ;check functions
         check-album-empty
         check-artist-empty
         ;playlist functions
         db_add-playlist
         db_get-playlist
         db_add-single-to-playlist
         ;favorites function
         db_add-to-favorites
         db_remove-from-favorites
         db_get-favorites-list
         )

;provided functions by song.rkt
(provide ;sorting
         sortv2
         sortv3 ;sorts uppercase and downcase the same
         ;searching
         searchv2
         searchv3;searches uppercase and downcase
         ;auxilary
         extract-nth)

