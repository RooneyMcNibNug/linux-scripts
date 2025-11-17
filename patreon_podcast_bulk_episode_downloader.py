## If you have an XML file from a Patreon you subscribe to or want to share, you can use this to parse the XML and 
## download all the mp3s into a temp folder to sort/move somewhere nicer later. YMMV, I whipped this up in like 10min
## so that I could get a bunch of things loaded on an audioplayer before travelling.

import requests
from bs4 import BeautifulSoup
import os

# XML URL here as STDIN
xml_url = input("Enter the XML URL: ")

# Fetch then parse XML content
response = requests.get(xml_url)
if response.status_code != 200:
    print("Failed to fetch the XML file.")
    exit()

xml_content = response.content
soup = BeautifulSoup(xml_content, 'xml')

# Temp dir for mp3s
os.makedirs('tmp_patreon_podcast_downloads', exist_ok=True)

# Find mp3s and get titles
items = soup.find_all('item')
for item in items:
    title = item.find('title').text.strip()
    mp3_url = item.find('enclosure')['url']

    # Ensure the title is a valid filename
    safe_title = "".join(x for x in title if x.isalnum() or x in (" ", "_")).rstrip()

    # Download mp3
    try:
        mp3_response = requests.get(mp3_url, allow_redirects=True)
        if mp3_response.status_code == 200:
            file_path = os.path.join('tmp_patreon_podcast_downloads', f"{safe_title}.mp3")
            with open(file_path, 'wb') as f:
                f.write(mp3_response.content)
            print(f'Downloaded: {safe_title}.mp3')
        else:
            print(f"Error downloading {mp3_url}: {mp3_response.status_code}")
    except Exception as e:
        print(f"Exception occurred while downloading {mp3_url}: {e}")

# Donezo
print("~~ All downloads are complete ~~")
