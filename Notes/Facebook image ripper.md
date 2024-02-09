Get list of photos from a group in .json format.
Check download folder if files already exist. If yes, skip.
Download the source image from aforementioned .json format list.

Filename should be created-date+photo-id.extension
created-date should be in YYYY-MM-DD format.

Extension doesn't matter, will be converted in .py script regardless

TECHNICAL DETAILS
Group IDs:
o De Mijngang: 106522215647024
o Good Old Times: 646377955571672

GET API call:
{group-id}?fields=albums{photos{webp_images,created_time}}

PAGING API call:
{album-id}/photos?fields=created_time&limit=25&pretty=0&before={page-id}

RATE LIMIT
https://stackoverflow.com/questions/18037926/get-all-photos-of-a-page-using-facebook-api