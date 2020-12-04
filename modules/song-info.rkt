;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname song-info) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require racket/runtime-path)
(require taglib)
(require racket/base)
(require racket/system)

(define FFMPEG "../lib/ffmpeg/ffmpeg")
(define song2 "/home/geri/Music/Mzk/BEATS/Ed Sheeran & Justin Bieber - I Don't Care [Official Lyric Video].mp3")

(define-struct SONG [path tag audio-prop image-path])

(define (create-image a-song-path save-path save-name)
   (let
       [(save-file (string-append save-path save-name ".png"))]
        (process* FFMPEG "-i" a-song-path save-file)
    save-file))

(define (make-imagev2 a-song-path save-path)
  (local
      [(define metadata (get-metadata a-song-path))
       (define tag (first metadata))
       (define album (tag-album tag))
       (define title (tag-title tag))]
    (if (= (string-length album) 0)
          (create-image a-song-path save-path title)
          (create-image a-song-path save-path album))
      ))
          
           
(define (add-SONG a-song-path)
  (local
    [(define metadata (get-metadata a-song-path))
     (define audio-tag (first metadata))
     (define audio-props (rest metadata))
     (define album (tag-album audio-tag))
     (define title (tag-title audio-tag))
     (define default-dir "../db/images")
     (define image-path
       (if (= (string-length album) 0)
          (create-image a-song-path default-dir title)
          (create-image a-song-path default-dir album)))
     ]
    (make-SONG a-song-path tag audio-props image-path)))

(provide add-SONG)
(provide SONG)