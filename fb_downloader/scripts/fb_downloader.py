import os
import json
import urllib
import pickle
import time
import sys
import facebook

access_token = "970d1b751e7995c0ace05f18b1028131"
safe_characters = '-_() abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

def give_input():
    print("> Enter a Facebook public page ID")
    return input("> ")

def fetch_images(page_id, last=None):
    graphApi = facebook.GraphAPI(access_token)
    image_url = '%s/photos/uploaded' % page_id
    fetched_list = []

    if not last:
        args = {'fields': ['source','name'], 'limit': 1000}
        # result = graphApi.request(image_url, args)
        # result = graphApi.get_objects(ids=[page_id], fields='source,name', limit=1000)
        
        result = graphApi.get_object(id=page_id, fields="og_object")
        print(result["og_object"])

        process_image_data(fetched_list, result['data'])
    else:
        result = {'paging': {'next': last}}

    for image in xrange(10):
        if 'paging' not in result:
            break
        try:
            image_url = result['paging']['next']
            result = json.loads(urllib.urlopen(url).read())
            process_image_data(fetched_list, result['data'])
        except:
            break

    save_image_data(image_url, 'last_url')
    return fetched_list

def process_image_data(request, data):
    error_list = []

    for extract in data:
        if 'source' not in extract:
            error_list.append(extract)
            continue
        
        source = extract['source']
        
        if 'name' in extract:
            name = ''.join(safe_character for safe_character in extract['name'][:99] if safe_character in safe_characters) + source[-4:]
        else:
            name = source[source.rfind('/')+1:]
        request.append({'name': name, 'src': source})
    
    if error_list:
        print(error_list)

def read_image_data(name):
    with open('%s.lst' % name, 'r') as file:
        request = pickle.load(file)
    return request

def save_image_data(request, name):
    with open('%s.lst' % name, 'w') as file:
        pickle.dump(request, file)

def download_images(page_id, request):
    if not os.path.isdir(page_id):
        os.mkdir(page_id)
    os.chdir(page_id)

    for image in request:
        image['src'] = image['src'].replace('_s', "_n")
        urllib.urlretrieve(image['src'], image['name'])
        image_amount += 1

def main():
    # page_id = give_input()
    # page_id = "GoodOldTimesShop"
    page_id = "justin.muris"

    start_time = time.perf_counter()

    fetched_list = fetch_images(page_id)
    save_image_data(fetched_list, 'photos')
    download_images(page_id, fetched_list)

    stop_time = time.perf_counter()
    elapsed_time = stop_time - start_time
    print()
    print(f"> Parsed data and downloaded {image_amount} images finished in {stop_time - start_time:0.1f} seconds.")

# Execute
image_amount = 0
main()