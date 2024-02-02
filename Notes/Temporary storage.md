RATE LIMIT
https://stackoverflow.com/questions/18037926/get-all-photos-of-a-page-using-facebook-api
get group
get list of photos as json, filename = date
check if files already exist -> skip
download via webp_images from json


GET
106522215647024?fields=albums{photos{webp_images,created_time}}

PAGING
119285344359716/photos?fields=created_time&limit=25&pretty=0&before=MzE0NjU3MjExNDg5MTk0

filename = created_time+id

tree: "albums" -> "data" -> "photos" -> "data" -> "created_time" / "webp_images" [0] -> "source"

demijngang/albums?fields=id
-> {album-id}/photos?fields=webp_images,updated_time
-> "data" "webp_images" [0] "source"
-> filename = updated_time + id ?
-> download