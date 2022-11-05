from random import randint
from time import sleep
import requests
from bs4 import BeautifulSoup
import fake_useragent
import json
import tqdm

data = {
    'data':[]
}
for page in range (1,40): 
    url = "https://hh.ru/search/vacancy?text=Python+%D1%80%D0%B0%D0%B7%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D1%87%D0%B8%D0%BA&salary=&clusters=true&area=1&ored_clusters=true&enable_snippets=true&page={page}&hhtmFrom=vacancy_search_list"
    headers = {'User-Agent': fake_useragent.UserAgent().random}
    resp = requests.get(url, headers = headers)
    soup = BeautifulSoup(resp.text, "lxml")
    pages = soup.find_all(class_="vacancy-serp-item-body")
    if len(pages) == 0:
        break
    for page in tqdm.tqdm(pages):

        url_object = page.find(attrs={"data-qa":"serp-item__title"})        
        title = url_object.text

        region = page.find(attrs={"data-qa":"vacancy-serp__vacancy-address"}).text       
        
        url_object_resp = requests.get(url_object.attrs['href'], headers=headers)
        soup_item = BeautifulSoup(url_object_resp.text, "lxml")
        
        salary = soup_item.find(attrs={"data-qa":"vacancy-salary"}).text
        
        work_expierence = soup_item.find(attrs={"data-qa":"vacancy-experience"}).text
        

        data['data'].append({'title':title, 'work experience': work_expierence, 'salary':salary, 'region':region})
        sleep(randint(1,3))

        with open('data.json', 'w') as file:
            json.dump(data,file, ensure_ascii=False)




