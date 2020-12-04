;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname player_final) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;#lang racket
(require overscan)
(require racket/class)
(require racket/provide)
 (require ffi/unsafe/introspection)
(require ffi/unsafe)


;mp3 parsing
(define mpeg-parse (element-factory%-make "mpegaudioparse"))
(define audio-dec (element-factory%-make "mpg123audiodec"))
(define audio-convert (element-factory%-make "audioconvert"))
(define pulse (element-factory%-make "autoaudiosink"))
(define pipeline (pipeline%-new "player"))
(define volume (element-factory%-make "volume"))

;playing
;(send pipeline set-state 'playing)

(define (init-player)
    (and
     ;adding
     (send pipeline add mpeg-parse)
     (send pipeline add audio-dec)
     (send pipeline add audio-convert)
     (send pipeline add pulse)
     (send pipeline add volume)
     ;linking
     (send mpeg-parse link audio-dec)
     (send audio-dec link audio-convert)
     (send audio-convert link volume)
     (send volume link pulse)))
     
     
(define (play a-song)
  (let
      [(audio-source (filesrc a-song))]
    (and
     (send pipeline add audio-source)
     (send audio-source link mpeg-parse)
     (send pipeline set-state 'playing))))

(define (stop)
  (send pipeline set-state 'null))

(define (stop!)
  (if (equal? (stop) 'success)
      #t #f))

(define (pause)
  (send pipeline set-state 'paused))

(define (pause!)
  (if (equal? (pause) 'success)
      #t #f))

(define (inc-vol)
  (local
      [(define current-vol (gobject-get volume "volume" _double))
       (define vol-unit #i0.1)
       (define new-vol (+ current-vol vol-unit))]
    (gobject-set! volume "volume" new-vol _double)))

(define (dec-vol)
  (local
   [(define current-vol (gobject-get volume "volume" _double))
       (define vol-unit #i0.1)
       (define new-vol (- current-vol vol-unit))]
    (gobject-set! volume "volume" new-vol _double)))

(define (get-vol)
  (gobject-get volume "volume" _double))

(define (set-volume val)
  (cond
    [(number? val)
     (gobject-set! volume "volume" val _double)]
    [(equal? val "mute")
     (gobject-set! volume "mute" #t)]
    [(equal? val "unmute")
     (gobject-set! volume "mute" #f)]))

(define (pipeline-state)
  (send pipeline get-state))

(define (continue)
  (send pipeline set-state 'playing))

(define (continue!)
  (if (equal? (continue) 'success)
      #t #f))
(define (get-volume)
  (number->string (get-vol)))
(define song1 "/home/geri/Music/Mzk/BEATS/Dzeko vs. Riggi & Piros - Heaven (feat. Veronica) [Official Lyric Video].mp3")

(provide stop!)
(provide pause!)
(provide continue!)
(provide play)
(provide init-player)
(provide song1)
(provide dec-vol)
(provide inc-vol)
(provide get-volume)
(provide set-volume)
