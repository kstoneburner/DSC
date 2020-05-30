try:
    import requests
    import urllib.request
except:
    print("=========================================================================================================================================")
    print("You need to install the Requests library!")
    print("=========================================================================================================================================")
    quit()
import json
g = {
    "url" : "https://www.zillow.com/webservice/GetSearchResults.htm?zws-id=X1-ZWz177ma9narkb_2doog&citystatezip=94546",
    "zwsid" : "X1-ZWz177ma9narkb_2doog",
    "weburl" : "https://www.zillow.com/homes/94546_rb/",
    "weburl2" : "https://www.zillow.com/search/GetSearchPageState.htm?searchQueryState=%7B%22pagination%22%3A%7B%7D%2C%22usersSearchTerm%22%3A%2294546%22%2C%22mapBounds%22%3A%7B%22west%22%3A-122.18865090551756%2C%22east%22%3A-121.9878070944824%2C%22south%22%3A37.699082636856744%2C%22north%22%3A37.74253363878007%7D%2C%22mapZoom%22%3A13%2C%22regionSelection%22%3A%5B%7B%22regionId%22%3A97753%2C%22regionType%22%3A7%7D%5D%2C%22isMapVisible%22%3Atrue%2C%22filterState%22%3A%7B%7D%2C%22isListVisible%22%3Atrue%7D",
    "weburl3" : "https://www.zillow.com/search/GetSearchPageState.htm?searchQueryState=\{%22pagination%22%3A\{\}%2C%22usersSearchTerm%22%3A%2294546%22%2C%22mapBounds%22%3A\{%22west%22%3A-122.18865090551756%2C%22east%22%3A-121.9878070944824%2C%22south%22%3A37.699082636856744%2C%22north%22%3A37.74253363878007\}%2C%22mapZoom%22%3A13%2C%22regionSelection%22%3A\[\{%22regionId%22%3A97753%2C%22regionType%22%3A7\}\]%2C%22isMapVisible%22%3Atrue%2C%22filterState%22%3A\{\}%2C%22isListVisible%22%3Atrue\}",
}

html = urllib.request.urlopen(g['weburl3']).read()
print(html)

quit()
r = requests.get(g['weburl2'])

print(r)
print(type(r))
for key in r:
    print(key)
### Convert Response to Dictionary
#r_dict = r.json()

#print(r_dict)
