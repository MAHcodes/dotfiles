import requests
from bs4 import BeautifulSoup
from datetime import datetime


def main():
    URL = "https://almanar.com.lb/legacy/salat.php"
    headers = {'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:79.0) Gecko/20100101 Firefox/79.0'}
    try:
        page = requests.get(URL, headers=headers)
    except:
        return "network error"
    soup = BeautifulSoup(page.content, "html.parser")
    times = soup.find("div", class_="prayer-times")

    def get_time(time):
        return times.find("div", class_ = time).find("div", class_="m-left").text.strip()

    time_names = ["emsak", "fajer", "shorook", "dohor", "aser", "moghreb", "ishaa", "midnight"]

    time_format = "%H:%M"

    now = datetime.now().strftime(time_format)


    less_time = 86400
    less_name = "none"

    for name in time_names:
        time = get_time(name)
        time_diff = (datetime.strptime(time, time_format) - datetime.strptime(now, time_format)).seconds
        if int(time_diff) < int(less_time):
            less_time = time_diff
            less_name = name

    return f"{less_name} {get_time(less_name)}"

if __name__ == "__main__":
    print(main())
