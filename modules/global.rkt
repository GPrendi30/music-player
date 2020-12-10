
----------db------------
database -> variable
db_show -> accepts no arguments 
(db_get-song a-song-id) -> accepts a-song-id 
(db_add-song a-song [a-song-list (db_list-id "song")
(db_get-song a-song-key)
(check-album-empty a-song)
(check-artist-empty a-song)
(db_get-album a-album-key)
(db_get-author a-author-key)
(db_add-playlist playlist-name song-list)
(db_get-playlist a-playlist-key)
(db_add-single-to-playlist a-playlist-key a-song)
(db_add-to-favorites a-song)
(db_remove-from-favorites a-song)
db_get-favorites-list -> accepts no arguments

---------player------------
init-player -> variable
(add a-song)
stop!  ->  accepts no arguments 
stop!  ->  accepts no arguments
pause! ->  accepts no arguments
play!  ->  accepts no arguments
(update! a-path)
dec-vol -> accepts no arguments
inc-vol -> accepts no arguments
get-volume -> accepts no arguments
(set-volume val)
current-time -> accepts no arguments

-----------queue-------------
QUEUE -> empty
(enqueue_single element)
(dequeue element)
(removev2 element QUEUE)
queue_first-> accepts no arguments
queue_last -> accepts no arguments
queue_show -> accepts no arguments
queue_reset-> accepts no arguments

-----------song----------------
SONG [path tag audio-prop image-path]
(create-SONG a-song-path)
(resize a-png-path dimensions)
(create-absolute-path a-relative-path)
(get-info a-song info-type)
(get-image a-song type)
(get-duration-seconds a-song)

------------sort-----------------
(sortv2 list [mode "asc"])
(sortv3 list [mode "asc"])
(searchv2 a-string los)
(searchv3 a-string los)
(extract-nth a-list index)
