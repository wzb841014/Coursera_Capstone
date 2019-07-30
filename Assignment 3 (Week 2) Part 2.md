

```python
import numpy as np # library to handle data in a vectorized manner

import pandas as pd # library for data analsysis
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)

import json # library to handle JSON files

#!conda install -c conda-forge geopy --yes # uncomment this line if you haven't completed the Foursquare API lab
from geopy.geocoders import Nominatim # convert an address into latitude and longitude values

import requests # library to handle requests
from pandas.io.json import json_normalize # tranform JSON file into a pandas dataframe

# Matplotlib and associated plotting modules
import matplotlib.cm as cm
import matplotlib.colors as colors

# import k-means from clustering stage
from sklearn.cluster import KMeans

#!conda install -c conda-forge folium=0.5.0 --yes # uncomment this line if you haven't completed the Foursquare API lab
import folium # map rendering library

import requests

print('Libraries imported.')



```

    Libraries imported.
    


```python
newyork_data = json.loads(requests.get('https://cocl.us/new_york_dataset').text)
```


```python
# define the dataframe columns
column_names = ['Borough', 'Neighborhood', 'Latitude', 'Longitude'] 

# instantiate the dataframe
neighborhoods = pd.DataFrame(columns=column_names)
```


```python
neighborhoods_data = newyork_data['features']
```


```python
for data in neighborhoods_data:
    borough = neighborhood_name = data['properties']['borough'] 
    neighborhood_name = data['properties']['name']
        
    neighborhood_latlon = data['geometry']['coordinates']
    neighborhood_lat = neighborhood_latlon[1]
    neighborhood_lon = neighborhood_latlon[0]
    
    neighborhoods = neighborhoods.append({'Borough': borough,
                                          'Neighborhood': neighborhood_name,
                                          'Latitude': neighborhood_lat,
                                          'Longitude': neighborhood_lon}, ignore_index=True)
```


```python
Latitude = neighborhoods["Latitude"].mean()
Longitude = neighborhoods["Longitude"].mean()
neighborhoods.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Borough</th>
      <th>Neighborhood</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Bronx</td>
      <td>Wakefield</td>
      <td>40.894705</td>
      <td>-73.847201</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Bronx</td>
      <td>Co-op City</td>
      <td>40.874294</td>
      <td>-73.829939</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Bronx</td>
      <td>Eastchester</td>
      <td>40.887556</td>
      <td>-73.827806</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Bronx</td>
      <td>Fieldston</td>
      <td>40.895437</td>
      <td>-73.905643</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Bronx</td>
      <td>Riverdale</td>
      <td>40.890834</td>
      <td>-73.912585</td>
    </tr>
  </tbody>
</table>
</div>




```python
import pandas as pd
import requests
from bs4 import BeautifulSoup

res = requests.get("https://www.health.ny.gov/statistics/cancer/registry/appendix/neighborhoods.htm")
soup = BeautifulSoup(res.content,'lxml')
table = soup.find_all('table')[0] 
df = pd.read_html(str(table))
print(df[0].to_json(orient='records'))
df = df[0]
df.head()
```

    [{"Borough":"Bronx","Neighborhood":"Central Bronx","ZIP Codes":"10453, 10457, 10460"},{"Borough":"Bronx","Neighborhood":"Bronx Park and Fordham","ZIP Codes":"10458, 10467, 10468"},{"Borough":"Bronx","Neighborhood":"High Bridge and Morrisania","ZIP Codes":"10451, 10452, 10456"},{"Borough":"Bronx","Neighborhood":"Hunts Point and Mott Haven","ZIP Codes":"10454, 10455, 10459, 10474"},{"Borough":"Bronx","Neighborhood":"Kingsbridge and Riverdale","ZIP Codes":"10463, 10471"},{"Borough":"Bronx","Neighborhood":"Northeast Bronx","ZIP Codes":"10466, 10469, 10470, 10475"},{"Borough":"Bronx","Neighborhood":"Southeast Bronx","ZIP Codes":"10461, 10462,10464, 10465, 10472, 10473"},{"Borough":"Brooklyn","Neighborhood":"Central Brooklyn","ZIP Codes":"11212, 11213, 11216, 11233, 11238"},{"Borough":"Brooklyn","Neighborhood":"Southwest Brooklyn","ZIP Codes":"11209, 11214, 11228"},{"Borough":"Brooklyn","Neighborhood":"Borough Park","ZIP Codes":"11204, 11218, 11219, 11230"},{"Borough":"Brooklyn","Neighborhood":"Canarsie and Flatlands","ZIP Codes":"11234, 11236, 11239"},{"Borough":"Brooklyn","Neighborhood":"Southern Brooklyn","ZIP Codes":"11223, 11224, 11229, 11235"},{"Borough":"Brooklyn","Neighborhood":"Northwest Brooklyn","ZIP Codes":"11201, 11205, 11215, 11217, 11231"},{"Borough":"Brooklyn","Neighborhood":"Flatbush","ZIP Codes":"11203, 11210, 11225, 11226"},{"Borough":"Brooklyn","Neighborhood":"East New York and New Lots","ZIP Codes":"11207, 11208"},{"Borough":"Brooklyn","Neighborhood":"Greenpoint","ZIP Codes":"11211, 11222"},{"Borough":"Brooklyn","Neighborhood":"Sunset Park","ZIP Codes":"11220, 11232"},{"Borough":"Brooklyn","Neighborhood":"Bushwick and Williamsburg","ZIP Codes":"11206, 11221, 11237"},{"Borough":"Manhattan","Neighborhood":"Central Harlem","ZIP Codes":"10026, 10027, 10030, 10037, 10039"},{"Borough":"Manhattan","Neighborhood":"Chelsea and Clinton","ZIP Codes":"10001, 10011, 10018, 10019, 10020, 10036"},{"Borough":"Manhattan","Neighborhood":"East Harlem","ZIP Codes":"10029, 10035"},{"Borough":"Manhattan","Neighborhood":"Gramercy Park and Murray Hill","ZIP Codes":"10010, 10016, 10017, 10022"},{"Borough":"Manhattan","Neighborhood":"Greenwich Village and Soho","ZIP Codes":"10012, 10013, 10014"},{"Borough":"Manhattan","Neighborhood":"Lower Manhattan","ZIP Codes":"10004, 10005, 10006, 10007, 10038, 10280"},{"Borough":"Manhattan","Neighborhood":"Lower East Side","ZIP Codes":"10002, 10003, 10009"},{"Borough":"Manhattan","Neighborhood":"Upper East Side","ZIP Codes":"10021, 10028, 10044, 10065, 10075, 10128"},{"Borough":"Manhattan","Neighborhood":"Upper West Side","ZIP Codes":"10023, 10024, 10025"},{"Borough":"Manhattan","Neighborhood":"Inwood and Washington Heights","ZIP Codes":"10031, 10032, 10033, 10034, 10040"},{"Borough":"Queens","Neighborhood":"Northeast Queens","ZIP Codes":"11361, 11362, 11363, 11364"},{"Borough":"Queens","Neighborhood":"North Queens","ZIP Codes":"11354, 11355, 11356, 11357, 11358, 11359, 11360"},{"Borough":"Queens","Neighborhood":"Central Queens","ZIP Codes":"11365, 11366, 11367"},{"Borough":"Queens","Neighborhood":"Jamaica","ZIP Codes":"11412, 11423, 11432, 11433, 11434, 11435, 11436"},{"Borough":"Queens","Neighborhood":"Northwest Queens","ZIP Codes":"11101, 11102, 11103, 11104, 11105, 11106"},{"Borough":"Queens","Neighborhood":"West Central Queens","ZIP Codes":"11374, 11375, 11379, 11385"},{"Borough":"Queens","Neighborhood":"Rockaways","ZIP Codes":"11691, 11692, 11693, 11694, 11695, 11697"},{"Borough":"Queens","Neighborhood":"Southeast Queens","ZIP Codes":"11004, 11005, 11411, 11413, 11422, 11426, 11427, 11428, 11429"},{"Borough":"Queens","Neighborhood":"Southwest Queens","ZIP Codes":"11414, 11415, 11416, 11417, 11418, 11419, 11420, 11421"},{"Borough":"Queens","Neighborhood":"West Queens","ZIP Codes":"11368, 11369, 11370, 11372, 11373, 11377, 11378"},{"Borough":"Staten Island","Neighborhood":"Port Richmond","ZIP Codes":"10302, 10303, 10310"},{"Borough":"Staten Island","Neighborhood":"South Shore","ZIP Codes":"10306, 10307, 10308, 10309, 10312"},{"Borough":"Staten Island","Neighborhood":"Stapleton and St. George","ZIP Codes":"10301, 10304, 10305"},{"Borough":"Staten Island","Neighborhood":"Mid-Island","ZIP Codes":"10314"}]
    




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Borough</th>
      <th>Neighborhood</th>
      <th>ZIP Codes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Bronx</td>
      <td>Central Bronx</td>
      <td>10453, 10457, 10460</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Bronx</td>
      <td>Bronx Park and Fordham</td>
      <td>10458, 10467, 10468</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Bronx</td>
      <td>High Bridge and Morrisania</td>
      <td>10451, 10452, 10456</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Bronx</td>
      <td>Hunts Point and Mott Haven</td>
      <td>10454, 10455, 10459, 10474</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Bronx</td>
      <td>Kingsbridge and Riverdale</td>
      <td>10463, 10471</td>
    </tr>
  </tbody>
</table>
</div>




```python
df[["ZIP Codes","Borough"]]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>ZIP Codes</th>
      <th>Borough</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10453, 10457, 10460</td>
      <td>Bronx</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10458, 10467, 10468</td>
      <td>Bronx</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10451, 10452, 10456</td>
      <td>Bronx</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10454, 10455, 10459, 10474</td>
      <td>Bronx</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10463, 10471</td>
      <td>Bronx</td>
    </tr>
    <tr>
      <th>5</th>
      <td>10466, 10469, 10470, 10475</td>
      <td>Bronx</td>
    </tr>
    <tr>
      <th>6</th>
      <td>10461, 10462,10464, 10465, 10472, 10473</td>
      <td>Bronx</td>
    </tr>
    <tr>
      <th>7</th>
      <td>11212, 11213, 11216, 11233, 11238</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>8</th>
      <td>11209, 11214, 11228</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>9</th>
      <td>11204, 11218, 11219, 11230</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11234, 11236, 11239</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>11</th>
      <td>11223, 11224, 11229, 11235</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>12</th>
      <td>11201, 11205, 11215, 11217, 11231</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>13</th>
      <td>11203, 11210, 11225, 11226</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>14</th>
      <td>11207, 11208</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>15</th>
      <td>11211, 11222</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>16</th>
      <td>11220, 11232</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>17</th>
      <td>11206, 11221, 11237</td>
      <td>Brooklyn</td>
    </tr>
    <tr>
      <th>18</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
    </tr>
    <tr>
      <th>19</th>
      <td>10001, 10011, 10018, 10019, 10020, 10036</td>
      <td>Manhattan</td>
    </tr>
    <tr>
      <th>20</th>
      <td>10029, 10035</td>
      <td>Manhattan</td>
    </tr>
    <tr>
      <th>21</th>
      <td>10010, 10016, 10017, 10022</td>
      <td>Manhattan</td>
    </tr>
    <tr>
      <th>22</th>
      <td>10012, 10013, 10014</td>
      <td>Manhattan</td>
    </tr>
    <tr>
      <th>23</th>
      <td>10004, 10005, 10006, 10007, 10038, 10280</td>
      <td>Manhattan</td>
    </tr>
    <tr>
      <th>24</th>
      <td>10002, 10003, 10009</td>
      <td>Manhattan</td>
    </tr>
    <tr>
      <th>25</th>
      <td>10021, 10028, 10044, 10065, 10075, 10128</td>
      <td>Manhattan</td>
    </tr>
    <tr>
      <th>26</th>
      <td>10023, 10024, 10025</td>
      <td>Manhattan</td>
    </tr>
    <tr>
      <th>27</th>
      <td>10031, 10032, 10033, 10034, 10040</td>
      <td>Manhattan</td>
    </tr>
    <tr>
      <th>28</th>
      <td>11361, 11362, 11363, 11364</td>
      <td>Queens</td>
    </tr>
    <tr>
      <th>29</th>
      <td>11354, 11355, 11356, 11357, 11358, 11359, 11360</td>
      <td>Queens</td>
    </tr>
    <tr>
      <th>30</th>
      <td>11365, 11366, 11367</td>
      <td>Queens</td>
    </tr>
    <tr>
      <th>31</th>
      <td>11412, 11423, 11432, 11433, 11434, 11435, 11436</td>
      <td>Queens</td>
    </tr>
    <tr>
      <th>32</th>
      <td>11101, 11102, 11103, 11104, 11105, 11106</td>
      <td>Queens</td>
    </tr>
    <tr>
      <th>33</th>
      <td>11374, 11375, 11379, 11385</td>
      <td>Queens</td>
    </tr>
    <tr>
      <th>34</th>
      <td>11691, 11692, 11693, 11694, 11695, 11697</td>
      <td>Queens</td>
    </tr>
    <tr>
      <th>35</th>
      <td>11004, 11005, 11411, 11413, 11422, 11426, 1142...</td>
      <td>Queens</td>
    </tr>
    <tr>
      <th>36</th>
      <td>11414, 11415, 11416, 11417, 11418, 11419, 1142...</td>
      <td>Queens</td>
    </tr>
    <tr>
      <th>37</th>
      <td>11368, 11369, 11370, 11372, 11373, 11377, 11378</td>
      <td>Queens</td>
    </tr>
    <tr>
      <th>38</th>
      <td>10302, 10303, 10310</td>
      <td>Staten Island</td>
    </tr>
    <tr>
      <th>39</th>
      <td>10306, 10307, 10308, 10309, 10312</td>
      <td>Staten Island</td>
    </tr>
    <tr>
      <th>40</th>
      <td>10301, 10304, 10305</td>
      <td>Staten Island</td>
    </tr>
    <tr>
      <th>41</th>
      <td>10314</td>
      <td>Staten Island</td>
    </tr>
  </tbody>
</table>
</div>




```python
neighborhoods = pd.merge(df[["ZIP Codes","Borough"]], neighborhoods, left_on = "Borough", right_on = "Borough")
neighborhoods.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>ZIP Codes</th>
      <th>Borough</th>
      <th>Neighborhood</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10453, 10457, 10460</td>
      <td>Bronx</td>
      <td>Wakefield</td>
      <td>40.894705</td>
      <td>-73.847201</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10453, 10457, 10460</td>
      <td>Bronx</td>
      <td>Co-op City</td>
      <td>40.874294</td>
      <td>-73.829939</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10453, 10457, 10460</td>
      <td>Bronx</td>
      <td>Eastchester</td>
      <td>40.887556</td>
      <td>-73.827806</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10453, 10457, 10460</td>
      <td>Bronx</td>
      <td>Fieldston</td>
      <td>40.895437</td>
      <td>-73.905643</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10453, 10457, 10460</td>
      <td>Bronx</td>
      <td>Riverdale</td>
      <td>40.890834</td>
      <td>-73.912585</td>
    </tr>
  </tbody>
</table>
</div>




```python
manhattan_data = neighborhoods[neighborhoods['Borough'] == 'Manhattan'].reset_index(drop=True)
manhattan_data.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>ZIP Codes</th>
      <th>Borough</th>
      <th>Neighborhood</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
      <td>Marble Hill</td>
      <td>40.876551</td>
      <td>-73.910660</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
      <td>Chinatown</td>
      <td>40.715618</td>
      <td>-73.994279</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
      <td>Washington Heights</td>
      <td>40.851903</td>
      <td>-73.936900</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
      <td>Inwood</td>
      <td>40.867684</td>
      <td>-73.921210</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
      <td>Hamilton Heights</td>
      <td>40.823604</td>
      <td>-73.949688</td>
    </tr>
  </tbody>
</table>
</div>




```python
CLIENT_ID = 'AC5FBDNGSWPK0ZTOXQBBVLG54QYJ1JIAZ5REXIOT0HWTXWCI' # your Foursquare ID
CLIENT_SECRET = 'AU4BZM5JRBEQDNXQKJYBYRNITH3VRTVKCCIZEVDO1LAHHLHT' # your Foursquare Secret
VERSION = '20180605' # Foursquare API version

print('Your credentails:')
print('CLIENT_ID: ' + CLIENT_ID)
print('CLIENT_SECRET:' + CLIENT_SECRET)
```

    Your credentails:
    CLIENT_ID: AC5FBDNGSWPK0ZTOXQBBVLG54QYJ1JIAZ5REXIOT0HWTXWCI
    CLIENT_SECRET:AU4BZM5JRBEQDNXQKJYBYRNITH3VRTVKCCIZEVDO1LAHHLHT
    


```python
manhattan_data.loc[0, 'Neighborhood']
```




    'Marble Hill'




```python
neighborhood_latitude = manhattan_data.loc[0, 'Latitude'] # neighborhood latitude value
neighborhood_longitude = manhattan_data.loc[0, 'Longitude'] # neighborhood longitude value

neighborhood_name = manhattan_data.loc[0, 'Neighborhood'] # neighborhood name

print('Latitude and longitude values of {} are {}, {}.'.format(neighborhood_name, 
                                                               neighborhood_latitude, 
                                                               neighborhood_longitude))
```

    Latitude and longitude values of Marble Hill are 40.87655077879964, -73.91065965862981.
    


```python
LIMIT = 100 # limit of number of venues returned by Foursquare API
radius = 500 # define radius

url = 'https://api.foursquare.com/v2/venues/explore?&client_id={}&client_secret={}&v={}&ll={},{}&radius={}&limit={}'.format(
    CLIENT_ID, 
    CLIENT_SECRET, 
    VERSION, 
    neighborhood_latitude, 
    neighborhood_longitude, 
    radius, 
    LIMIT)
```


```python
results = requests.get(url).json()
results
```




    {'meta': {'code': 200, 'requestId': '5d3ff1eb22be1200324c8b3a'},
     'response': {'suggestedFilters': {'header': 'Tap to show:',
       'filters': [{'name': 'Open now', 'key': 'openNow'}]},
      'headerLocation': 'Marble Hill',
      'headerFullLocation': 'Marble Hill, New York',
      'headerLocationGranularity': 'neighborhood',
      'totalResults': 26,
      'suggestedBounds': {'ne': {'lat': 40.88105078329964,
        'lng': -73.90471933917806},
       'sw': {'lat': 40.87205077429964, 'lng': -73.91659997808156}},
      'groups': [{'type': 'Recommended Places',
        'name': 'recommended',
        'items': [{'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4b4429abf964a52037f225e3',
           'name': "Arturo's",
           'location': {'address': '5198 Broadway',
            'crossStreet': 'at 225th St.',
            'lat': 40.87441177110231,
            'lng': -73.91027100981574,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87441177110231,
              'lng': -73.91027100981574}],
            'distance': 240,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'New York',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5198 Broadway (at 225th St.)',
             'New York, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1ca941735',
             'name': 'Pizza Place',
             'pluralName': 'Pizza Places',
             'shortName': 'Pizza',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/pizza_',
              'suffix': '.png'},
             'primary': True}],
           'delivery': {'id': '72548',
            'url': 'https://www.seamless.com/menu/arturos-pizza-5189-broadway-ave-new-york/72548?affiliate=1131&utm_source=foursquare-affiliate-network&utm_medium=affiliate&utm_campaign=1131&utm_content=72548',
            'provider': {'name': 'seamless',
             'icon': {'prefix': 'https://fastly.4sqi.net/img/general/cap/',
              'sizes': [40, 50],
              'name': '/delivery_provider_seamless_20180129.png'}}},
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4b4429abf964a52037f225e3-0'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4baf59e8f964a520a6f93be3',
           'name': 'Bikram Yoga',
           'location': {'address': '5500 Broadway',
            'crossStreet': '230th Street',
            'lat': 40.876843690797934,
            'lng': -73.90620384419528,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.876843690797934,
              'lng': -73.90620384419528}],
            'distance': 376,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5500 Broadway (230th Street)',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d102941735',
             'name': 'Yoga Studio',
             'pluralName': 'Yoga Studios',
             'shortName': 'Yoga Studio',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/gym_yogastudio_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4baf59e8f964a520a6f93be3-1'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4b79cc46f964a520c5122fe3',
           'name': 'Tibbett Diner',
           'location': {'address': '3033 Tibbett Ave',
            'crossStreet': 'btwn 230th & 231st',
            'lat': 40.8804044222466,
            'lng': -73.90893738006402,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.8804044222466,
              'lng': -73.90893738006402}],
            'distance': 452,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['3033 Tibbett Ave (btwn 230th & 231st)',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d147941735',
             'name': 'Diner',
             'pluralName': 'Diners',
             'shortName': 'Diner',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/diner_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4b79cc46f964a520c5122fe3-2'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '55f81cd2498ee903149fcc64',
           'name': 'Starbucks',
           'location': {'address': '171 W 230th St',
            'crossStreet': 'Kimberly Pl',
            'lat': 40.87753134921497,
            'lng': -73.90558216359267,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87753134921497,
              'lng': -73.90558216359267}],
            'distance': 441,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['171 W 230th St (Kimberly Pl)',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1e0931735',
             'name': 'Coffee Shop',
             'pluralName': 'Coffee Shops',
             'shortName': 'Coffee Shop',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/coffeeshop_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-55f81cd2498ee903149fcc64-3'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4b5357adf964a520319827e3',
           'name': "Dunkin'",
           'location': {'address': '5501 Broadway',
            'crossStreet': 'W 230th St',
            'lat': 40.87713584201589,
            'lng': -73.90666550701411,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87713584201589,
              'lng': -73.90666550701411}],
            'distance': 342,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5501 Broadway (W 230th St)',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d148941735',
             'name': 'Donut Shop',
             'pluralName': 'Donut Shops',
             'shortName': 'Donuts',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/donuts_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4b5357adf964a520319827e3-4'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '55f751ca498eacc0307d1cfe',
           'name': 'Blink Fitness Riverdale',
           'location': {'address': '5520 Broadway',
            'crossStreet': 'at W 230th St',
            'lat': 40.87714687429521,
            'lng': -73.90583697267095,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87714687429521,
              'lng': -73.90583697267095}],
            'distance': 411,
            'postalCode': '10463',
            'cc': 'US',
            'neighborhood': 'Kingsbridge',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5520 Broadway (at W 230th St)',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d176941735',
             'name': 'Gym',
             'pluralName': 'Gyms',
             'shortName': 'Gym',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/building/gym_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-55f751ca498eacc0307d1cfe-5'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4a725fa1f964a520f6da1fe3',
           'name': 'TCR The Club of Riverdale',
           'location': {'address': '2600 Netherland Ave',
            'lat': 40.8786283,
            'lng': -73.9145678,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.8786283,
              'lng': -73.9145678}],
            'distance': 402,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['2600 Netherland Ave',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4e39a891bd410d7aed40cbc2',
             'name': 'Tennis Stadium',
             'pluralName': 'Tennis Stadiums',
             'shortName': 'Tennis',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/arts_entertainment/stadium_tennis_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []},
           'venuePage': {'id': '40358759'}},
          'referralId': 'e-0-4a725fa1f964a520f6da1fe3-6'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4b9c9c6af964a520b27236e3',
           'name': 'Land & Sea Restaurant',
           'location': {'address': '5535 Broadway',
            'crossStreet': '231st St',
            'lat': 40.87788463309788,
            'lng': -73.90587282193539,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87788463309788,
              'lng': -73.90587282193539}],
            'distance': 429,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5535 Broadway (231st St)',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1ce941735',
             'name': 'Seafood Restaurant',
             'pluralName': 'Seafood Restaurants',
             'shortName': 'Seafood',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/seafood_',
              'suffix': '.png'},
             'primary': True}],
           'delivery': {'id': '277380',
            'url': 'https://www.seamless.com/menu/land--sea-restaurant-5535-broadway-ave-bronx/277380?affiliate=1131&utm_source=foursquare-affiliate-network&utm_medium=affiliate&utm_campaign=1131&utm_content=277380',
            'provider': {'name': 'seamless',
             'icon': {'prefix': 'https://fastly.4sqi.net/img/general/cap/',
              'sizes': [40, 50],
              'name': '/delivery_provider_seamless_20180129.png'}}},
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4b9c9c6af964a520b27236e3-7'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '546d31ca498e561c698a0320',
           'name': 'T.J. Maxx',
           'location': {'lat': 40.87723198343352,
            'lng': -73.90504239962168,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87723198343352,
              'lng': -73.90504239962168}],
            'distance': 478,
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['Bronx, NY', 'United States']},
           'categories': [{'id': '4bf58dd8d48988d1f6941735',
             'name': 'Department Store',
             'pluralName': 'Department Stores',
             'shortName': 'Department Store',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/departmentstore_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-546d31ca498e561c698a0320-8'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '57655be738faa66160da7527',
           'name': 'Starbucks',
           'location': {'address': '50 W 225th St',
            'lat': 40.873754554218515,
            'lng': -73.90861305343668,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.873754554218515,
              'lng': -73.90861305343668}],
            'distance': 355,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'New York',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['50 W 225th St',
             'New York, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1e0931735',
             'name': 'Coffee Shop',
             'pluralName': 'Coffee Shops',
             'shortName': 'Coffee Shop',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/coffeeshop_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-57655be738faa66160da7527-9'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4b88e053f964a5208a1132e3',
           'name': 'Rite Aid',
           'location': {'address': '5237 Broadway',
            'crossStreet': '228th Street',
            'lat': 40.875466574434704,
            'lng': -73.90890629016033,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.875466574434704,
              'lng': -73.90890629016033}],
            'distance': 190,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5237 Broadway (228th Street)',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d10f951735',
             'name': 'Pharmacy',
             'pluralName': 'Pharmacies',
             'shortName': 'Pharmacy',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/pharmacy_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4b88e053f964a5208a1132e3-10'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '5631194e498e2de074de661c',
           'name': 'Vitamin Shoppe',
           'location': {'address': '5510 Broadway',
            'lat': 40.87716,
            'lng': -73.905632,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87716,
              'lng': -73.905632}],
            'distance': 428,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5510 Broadway',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '5744ccdfe4b0c0459246b4cd',
             'name': 'Supplement Shop',
             'pluralName': 'Supplement Shops',
             'shortName': 'Supplement Shop',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/education/lab_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-5631194e498e2de074de661c-11'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4b9f030af964a520eb0f37e3',
           'name': 'GameStop',
           'location': {'address': '90 W 225th St Ste A-B',
            'crossStreet': 'btw Broadway & Exterior St.',
            'lat': 40.874266802124836,
            'lng': -73.90934218062803,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.874266802124836,
              'lng': -73.90934218062803}],
            'distance': 277,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['90 W 225th St Ste A-B (btw Broadway & Exterior St.)',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d10b951735',
             'name': 'Video Game Store',
             'pluralName': 'Video Game Stores',
             'shortName': 'Video Games',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/videogames_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4b9f030af964a520eb0f37e3-12'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4b9c9c43f964a520ac7236e3',
           'name': 'Lot Less Closeouts',
           'location': {'address': '5545 Broadway',
            'crossStreet': '231st St',
            'lat': 40.878270422202085,
            'lng': -73.9052646742604,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.878270422202085,
              'lng': -73.9052646742604}],
            'distance': 492,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5545 Broadway (231st St)',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '52dea92d3cf9994f4e043dbb',
             'name': 'Discount Store',
             'pluralName': 'Discount Stores',
             'shortName': 'Discount Store',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/discountstore_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4b9c9c43f964a520ac7236e3-13'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4dfe40df8877333e195b68fc',
           'name': 'Parrilla Latina',
           'location': {'address': '230th St & Broadway',
            'lat': 40.87747294351472,
            'lng': -73.90607346968568,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87747294351472,
              'lng': -73.90607346968568}],
            'distance': 399,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['230th St & Broadway',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1cc941735',
             'name': 'Steakhouse',
             'pluralName': 'Steakhouses',
             'shortName': 'Steakhouse',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/steakhouse_',
              'suffix': '.png'},
             'primary': True}],
           'delivery': {'id': '330981',
            'url': 'https://www.seamless.com/menu/parrilla-latina-5523-broadway-bronx/330981?affiliate=1131&utm_source=foursquare-affiliate-network&utm_medium=affiliate&utm_campaign=1131&utm_content=330981',
            'provider': {'name': 'seamless',
             'icon': {'prefix': 'https://fastly.4sqi.net/img/general/cap/',
              'sizes': [40, 50],
              'name': '/delivery_provider_seamless_20180129.png'}}},
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4dfe40df8877333e195b68fc-14'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4e4e4517bd4101d0d7a67568',
           'name': 'Baskin-Robbins',
           'location': {'address': '5501 Broadway',
            'lat': 40.8769755336728,
            'lng': -73.90675193198494,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.8769755336728,
              'lng': -73.90675193198494}],
            'distance': 332,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5501 Broadway',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1c9941735',
             'name': 'Ice Cream Shop',
             'pluralName': 'Ice Cream Shops',
             'shortName': 'Ice Cream',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/icecream_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4e4e4517bd4101d0d7a67568-15'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4b4f7b65f964a5205a0827e3',
           'name': 'Subway Sandwiches',
           'location': {'address': '5209 Broadway',
            'lat': 40.8746665302951,
            'lng': -73.9095858429637,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.8746665302951,
              'lng': -73.9095858429637}],
            'distance': 228,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5209 Broadway',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1c5941735',
             'name': 'Sandwich Place',
             'pluralName': 'Sandwich Places',
             'shortName': 'Sandwiches',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/deli_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4b4f7b65f964a5205a0827e3-16'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4ec68016cc21b428e1d2060a',
           'name': 'TD Bank',
           'location': {'address': '281 W 230th St',
            'lat': 40.8794958,
            'lng': -73.9092856,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.8794958,
              'lng': -73.9092856}],
            'distance': 347,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['281 W 230th St',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d10a951735',
             'name': 'Bank',
             'pluralName': 'Banks',
             'shortName': 'Bank',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/financial_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4ec68016cc21b428e1d2060a-17'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '585c205665e7c70a2f1055ea',
           'name': 'Boston Market',
           'location': {'address': '5520 Broadway',
            'lat': 40.87743,
            'lng': -73.9054121,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87743,
              'lng': -73.9054121}],
            'distance': 452,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5520 Broadway',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d14e941735',
             'name': 'American Restaurant',
             'pluralName': 'American Restaurants',
             'shortName': 'American',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/default_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-585c205665e7c70a2f1055ea-18'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '56229ff8498e2abb44b6f12b',
           'name': 'Five Below',
           'location': {'address': '171 W 230th St Fl 2',
            'lat': 40.87763977050781,
            'lng': -73.90499114990234,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87763977050781,
              'lng': -73.90499114990234}],
            'distance': 492,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['171 W 230th St Fl 2',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '52dea92d3cf9994f4e043dbb',
             'name': 'Discount Store',
             'pluralName': 'Discount Stores',
             'shortName': 'Discount Store',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/discountstore_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-56229ff8498e2abb44b6f12b-19'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4e4ce4debd413c4cc66d05d0',
           'name': 'SUBWAY',
           'location': {'address': '5549 Broadway',
            'lat': 40.87849271667849,
            'lng': -73.90538547211088,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87849271667849,
              'lng': -73.90538547211088}],
            'distance': 493,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5549 Broadway',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1c5941735',
             'name': 'Sandwich Place',
             'pluralName': 'Sandwich Places',
             'shortName': 'Sandwiches',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/deli_',
              'suffix': '.png'},
             'primary': True}],
           'delivery': {'id': '774886',
            'url': 'https://www.seamless.com/menu/subway-5549-broadway-bronx/774886?affiliate=1131&utm_source=foursquare-affiliate-network&utm_medium=affiliate&utm_campaign=1131&utm_content=774886',
            'provider': {'name': 'seamless',
             'icon': {'prefix': 'https://fastly.4sqi.net/img/general/cap/',
              'sizes': [40, 50],
              'name': '/delivery_provider_seamless_20180129.png'}}},
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4e4ce4debd413c4cc66d05d0-20'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '58f4fc2b829b0c305839877b',
           'name': 'Forever 21',
           'location': {'lat': 40.87747,
            'lng': -73.90594,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87747,
              'lng': -73.90594}],
            'distance': 410,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'New York',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['New York, NY 10463', 'United States']},
           'categories': [{'id': '4bf58dd8d48988d103951735',
             'name': 'Clothing Store',
             'pluralName': 'Clothing Stores',
             'shortName': 'Apparel',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/apparel_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-58f4fc2b829b0c305839877b-21'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '53319bb511d2ef06787f02b4',
           'name': 'Broadway Plaza',
           'location': {'address': '171 W 231st St',
            'lat': 40.87753906779665,
            'lng': -73.90539578168178,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87753906779665,
              'lng': -73.90539578168178}],
            'distance': 456,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['171 W 231st St',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1fd941735',
             'name': 'Shopping Mall',
             'pluralName': 'Shopping Malls',
             'shortName': 'Mall',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/mall_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-53319bb511d2ef06787f02b4-22'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4d0a529133d6b60cf4cf9985',
           'name': 'Subway',
           'location': {'address': '5209 Broadway',
            'lat': 40.877720351115315,
            'lng': -73.90537973066263,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.877720351115315,
              'lng': -73.90537973066263}],
            'distance': 463,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['5209 Broadway',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1c5941735',
             'name': 'Sandwich Place',
             'pluralName': 'Sandwich Places',
             'shortName': 'Sandwiches',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/deli_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4d0a529133d6b60cf4cf9985-23'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4ed7956b8b81b2bf28adc714',
           'name': 'Terrace View Delicatessen',
           'location': {'address': '135 Terrace View Ave.',
            'lat': 40.87647647652852,
            'lng': -73.91274586964578,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87647647652852,
              'lng': -73.91274586964578}],
            'distance': 175,
            'postalCode': '10034',
            'cc': 'US',
            'city': 'New York',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['135 Terrace View Ave.',
             'New York, NY 10034',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d146941735',
             'name': 'Deli / Bodega',
             'pluralName': 'Delis / Bodegas',
             'shortName': 'Deli / Bodega',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/deli_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4ed7956b8b81b2bf28adc714-24'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4bc05fe4f8219c74ff79b110',
           'name': 'Studio Esthetique Day Spa',
           'location': {'address': '2600 Netherland Ave Ste 104',
            'crossStreet': 'W 227th Street',
            'lat': 40.87868612830189,
            'lng': -73.91520884226871,
            'labeledLatLngs': [{'label': 'display',
              'lat': 40.87868612830189,
              'lng': -73.91520884226871}],
            'distance': 450,
            'postalCode': '10463',
            'cc': 'US',
            'city': 'Bronx',
            'state': 'NY',
            'country': 'United States',
            'formattedAddress': ['2600 Netherland Ave Ste 104 (W 227th Street)',
             'Bronx, NY 10463',
             'United States']},
           'categories': [{'id': '4bf58dd8d48988d1ed941735',
             'name': 'Spa',
             'pluralName': 'Spas',
             'shortName': 'Spa',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/spa_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4bc05fe4f8219c74ff79b110-25'}]}]}}




```python
# function that extracts the category of the venue
def get_category_type(row):
    try:
        categories_list = row['categories']
    except:
        categories_list = row['venue.categories']
        
    if len(categories_list) == 0:
        return None
    else:
        return categories_list[0]['name']
```


```python
venues = results['response']['groups'][0]['items']
    
nearby_venues = json_normalize(venues) # flatten JSON

# filter columns
filtered_columns = ['venue.name', 'venue.categories', 'venue.location.lat', 'venue.location.lng']
nearby_venues =nearby_venues.loc[:, filtered_columns]

# filter the category for each row
nearby_venues['venue.categories'] = nearby_venues.apply(get_category_type, axis=1)

# clean columns
nearby_venues.columns = [col.split(".")[-1] for col in nearby_venues.columns]

nearby_venues.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
      <th>categories</th>
      <th>lat</th>
      <th>lng</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Arturo's</td>
      <td>Pizza Place</td>
      <td>40.874412</td>
      <td>-73.910271</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Bikram Yoga</td>
      <td>Yoga Studio</td>
      <td>40.876844</td>
      <td>-73.906204</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Tibbett Diner</td>
      <td>Diner</td>
      <td>40.880404</td>
      <td>-73.908937</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Starbucks</td>
      <td>Coffee Shop</td>
      <td>40.877531</td>
      <td>-73.905582</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Dunkin'</td>
      <td>Donut Shop</td>
      <td>40.877136</td>
      <td>-73.906666</td>
    </tr>
  </tbody>
</table>
</div>




```python
print('{} venues were returned by Foursquare.'.format(nearby_venues.shape[0]))
```

    26 venues were returned by Foursquare.
    


```python
def getNearbyVenues(names, latitudes, longitudes, radius=500):
    
    venues_list=[]
    for name, lat, lng in zip(names, latitudes, longitudes):
        print(name)
            
        # create the API request URL
        url = 'https://api.foursquare.com/v2/venues/explore?&client_id={}&client_secret={}&v={}&ll={},{}&radius={}&limit={}'.format(
            CLIENT_ID, 
            CLIENT_SECRET, 
            VERSION, 
            lat, 
            lng, 
            radius, 
            LIMIT)
            
        # make the GET request
        results = requests.get(url).json()["response"]['groups'][0]['items']
        
        # return only relevant information for each nearby venue
        venues_list.append([(
            name, 
            lat, 
            lng, 
            v['venue']['name'], 
            v['venue']['location']['lat'], 
            v['venue']['location']['lng'],  
            v['venue']['categories'][0]['name']) for v in results])

    nearby_venues = pd.DataFrame([item for venue_list in venues_list for item in venue_list])
    nearby_venues.columns = ['Neighborhood', 
                  'Neighborhood Latitude', 
                  'Neighborhood Longitude', 
                  'Venue', 
                  'Venue Latitude', 
                  'Venue Longitude', 
                  'Venue Category']
    
    return(nearby_venues)
```


```python
manhattan_data = manhattan_data.loc[:39,:]

```


```python
manhattan_venues = getNearbyVenues(names=manhattan_data['Neighborhood'],
                                   latitudes=manhattan_data['Latitude'],
                                   longitudes=manhattan_data['Longitude']
                                  )

```

    Marble Hill
    Chinatown
    Washington Heights
    Inwood
    Hamilton Heights
    Manhattanville
    Central Harlem
    East Harlem
    Upper East Side
    Yorkville
    Lenox Hill
    Roosevelt Island
    Upper West Side
    Lincoln Square
    Clinton
    Midtown
    Murray Hill
    Chelsea
    Greenwich Village
    East Village
    Lower East Side
    Tribeca
    Little Italy
    Soho
    West Village
    Manhattan Valley
    Morningside Heights
    Gramercy
    Battery Park City
    Financial District
    Carnegie Hill
    Noho
    Civic Center
    Midtown South
    Sutton Place
    Turtle Bay
    Tudor City
    Stuyvesant Town
    Flatiron
    Hudson Yards
    


```python
print('There are {} uniques categories.'.format(len(manhattan_venues['Venue Category'].unique())))
```

    There are 334 uniques categories.
    


```python
print(manhattan_venues.shape)
manhattan_venues.head()
```

    (3318, 7)
    




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Neighborhood</th>
      <th>Neighborhood Latitude</th>
      <th>Neighborhood Longitude</th>
      <th>Venue</th>
      <th>Venue Latitude</th>
      <th>Venue Longitude</th>
      <th>Venue Category</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Marble Hill</td>
      <td>40.876551</td>
      <td>-73.91066</td>
      <td>Arturo's</td>
      <td>40.874412</td>
      <td>-73.910271</td>
      <td>Pizza Place</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Marble Hill</td>
      <td>40.876551</td>
      <td>-73.91066</td>
      <td>Bikram Yoga</td>
      <td>40.876844</td>
      <td>-73.906204</td>
      <td>Yoga Studio</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Marble Hill</td>
      <td>40.876551</td>
      <td>-73.91066</td>
      <td>Tibbett Diner</td>
      <td>40.880404</td>
      <td>-73.908937</td>
      <td>Diner</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Marble Hill</td>
      <td>40.876551</td>
      <td>-73.91066</td>
      <td>Starbucks</td>
      <td>40.877531</td>
      <td>-73.905582</td>
      <td>Coffee Shop</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Marble Hill</td>
      <td>40.876551</td>
      <td>-73.91066</td>
      <td>Dunkin'</td>
      <td>40.877136</td>
      <td>-73.906666</td>
      <td>Donut Shop</td>
    </tr>
  </tbody>
</table>
</div>




```python
manhattan_venues.groupby('Neighborhood').count()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Neighborhood Latitude</th>
      <th>Neighborhood Longitude</th>
      <th>Venue</th>
      <th>Venue Latitude</th>
      <th>Venue Longitude</th>
      <th>Venue Category</th>
    </tr>
    <tr>
      <th>Neighborhood</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Battery Park City</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Carnegie Hill</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Central Harlem</th>
      <td>42</td>
      <td>42</td>
      <td>42</td>
      <td>42</td>
      <td>42</td>
      <td>42</td>
    </tr>
    <tr>
      <th>Chelsea</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Chinatown</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Civic Center</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Clinton</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>East Harlem</th>
      <td>42</td>
      <td>42</td>
      <td>42</td>
      <td>42</td>
      <td>42</td>
      <td>42</td>
    </tr>
    <tr>
      <th>East Village</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Financial District</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Flatiron</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Gramercy</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Greenwich Village</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Hamilton Heights</th>
      <td>61</td>
      <td>61</td>
      <td>61</td>
      <td>61</td>
      <td>61</td>
      <td>61</td>
    </tr>
    <tr>
      <th>Hudson Yards</th>
      <td>77</td>
      <td>77</td>
      <td>77</td>
      <td>77</td>
      <td>77</td>
      <td>77</td>
    </tr>
    <tr>
      <th>Inwood</th>
      <td>55</td>
      <td>55</td>
      <td>55</td>
      <td>55</td>
      <td>55</td>
      <td>55</td>
    </tr>
    <tr>
      <th>Lenox Hill</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Lincoln Square</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Little Italy</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Lower East Side</th>
      <td>62</td>
      <td>62</td>
      <td>62</td>
      <td>62</td>
      <td>62</td>
      <td>62</td>
    </tr>
    <tr>
      <th>Manhattan Valley</th>
      <td>56</td>
      <td>56</td>
      <td>56</td>
      <td>56</td>
      <td>56</td>
      <td>56</td>
    </tr>
    <tr>
      <th>Manhattanville</th>
      <td>40</td>
      <td>40</td>
      <td>40</td>
      <td>40</td>
      <td>40</td>
      <td>40</td>
    </tr>
    <tr>
      <th>Marble Hill</th>
      <td>26</td>
      <td>26</td>
      <td>26</td>
      <td>26</td>
      <td>26</td>
      <td>26</td>
    </tr>
    <tr>
      <th>Midtown</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Midtown South</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Morningside Heights</th>
      <td>40</td>
      <td>40</td>
      <td>40</td>
      <td>40</td>
      <td>40</td>
      <td>40</td>
    </tr>
    <tr>
      <th>Murray Hill</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Noho</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Roosevelt Island</th>
      <td>26</td>
      <td>26</td>
      <td>26</td>
      <td>26</td>
      <td>26</td>
      <td>26</td>
    </tr>
    <tr>
      <th>Soho</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Stuyvesant Town</th>
      <td>21</td>
      <td>21</td>
      <td>21</td>
      <td>21</td>
      <td>21</td>
      <td>21</td>
    </tr>
    <tr>
      <th>Sutton Place</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Tribeca</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Tudor City</th>
      <td>83</td>
      <td>83</td>
      <td>83</td>
      <td>83</td>
      <td>83</td>
      <td>83</td>
    </tr>
    <tr>
      <th>Turtle Bay</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Upper East Side</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Upper West Side</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Washington Heights</th>
      <td>87</td>
      <td>87</td>
      <td>87</td>
      <td>87</td>
      <td>87</td>
      <td>87</td>
    </tr>
    <tr>
      <th>West Village</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Yorkville</th>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
      <td>100</td>
    </tr>
  </tbody>
</table>
</div>




```python
print('There are {} uniques categories.'.format(len(manhattan_venues['Venue Category'].unique())))
```

    There are 334 uniques categories.
    


```python
# one hot encoding
manhattan_onehot = pd.get_dummies(manhattan_venues[['Venue Category']], prefix="", prefix_sep="")

# add neighborhood column back to dataframe
manhattan_onehot['Neighborhood'] = manhattan_venues['Neighborhood'] 

# move neighborhood column to the first column
fixed_columns = [manhattan_onehot.columns[-1]] + list(manhattan_onehot.columns[:-1])
manhattan_onehot = manhattan_onehot[fixed_columns]

manhattan_onehot.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Neighborhood</th>
      <th>Accessories Store</th>
      <th>Adult Boutique</th>
      <th>Afghan Restaurant</th>
      <th>African Restaurant</th>
      <th>American Restaurant</th>
      <th>Antique Shop</th>
      <th>Arcade</th>
      <th>Arepa Restaurant</th>
      <th>Argentinian Restaurant</th>
      <th>Art Gallery</th>
      <th>Art Museum</th>
      <th>Arts &amp; Crafts Store</th>
      <th>Asian Restaurant</th>
      <th>Athletics &amp; Sports</th>
      <th>Auditorium</th>
      <th>Australian Restaurant</th>
      <th>Austrian Restaurant</th>
      <th>Auto Workshop</th>
      <th>BBQ Joint</th>
      <th>Baby Store</th>
      <th>Bagel Shop</th>
      <th>Bakery</th>
      <th>Bank</th>
      <th>Bar</th>
      <th>Baseball Field</th>
      <th>Basketball Court</th>
      <th>Bed &amp; Breakfast</th>
      <th>Beer Bar</th>
      <th>Beer Garden</th>
      <th>Beer Store</th>
      <th>Big Box Store</th>
      <th>Bike Rental / Bike Share</th>
      <th>Bike Shop</th>
      <th>Bike Trail</th>
      <th>Bistro</th>
      <th>Board Shop</th>
      <th>Boat or Ferry</th>
      <th>Bookstore</th>
      <th>Boutique</th>
      <th>Boxing Gym</th>
      <th>Brazilian Restaurant</th>
      <th>Breakfast Spot</th>
      <th>Bridal Shop</th>
      <th>Bridge</th>
      <th>Bubble Tea Shop</th>
      <th>Building</th>
      <th>Burger Joint</th>
      <th>Burrito Place</th>
      <th>Bus Station</th>
      <th>Bus Stop</th>
      <th>Business Service</th>
      <th>Butcher</th>
      <th>Cafeteria</th>
      <th>Café</th>
      <th>Cambodian Restaurant</th>
      <th>Camera Store</th>
      <th>Candy Store</th>
      <th>Cantonese Restaurant</th>
      <th>Caribbean Restaurant</th>
      <th>Caucasian Restaurant</th>
      <th>Cheese Shop</th>
      <th>Chinese Restaurant</th>
      <th>Chocolate Shop</th>
      <th>Circus</th>
      <th>Climbing Gym</th>
      <th>Clothing Store</th>
      <th>Club House</th>
      <th>Cocktail Bar</th>
      <th>Coffee Shop</th>
      <th>College Academic Building</th>
      <th>College Bookstore</th>
      <th>College Cafeteria</th>
      <th>College Theater</th>
      <th>Comedy Club</th>
      <th>Community Center</th>
      <th>Concert Hall</th>
      <th>Convenience Store</th>
      <th>Cosmetics Shop</th>
      <th>Coworking Space</th>
      <th>Creperie</th>
      <th>Cuban Restaurant</th>
      <th>Cultural Center</th>
      <th>Cupcake Shop</th>
      <th>Cycle Studio</th>
      <th>Czech Restaurant</th>
      <th>Dance Studio</th>
      <th>Daycare</th>
      <th>Deli / Bodega</th>
      <th>Department Store</th>
      <th>Design Studio</th>
      <th>Dessert Shop</th>
      <th>Dim Sum Restaurant</th>
      <th>Diner</th>
      <th>Discount Store</th>
      <th>Dive Bar</th>
      <th>Doctor's Office</th>
      <th>Dog Run</th>
      <th>Donut Shop</th>
      <th>Drugstore</th>
      <th>Dumpling Restaurant</th>
      <th>Duty-free Shop</th>
      <th>Eastern European Restaurant</th>
      <th>Electronics Store</th>
      <th>Empanada Restaurant</th>
      <th>English Restaurant</th>
      <th>Ethiopian Restaurant</th>
      <th>Event Space</th>
      <th>Exhibit</th>
      <th>Falafel Restaurant</th>
      <th>Farmers Market</th>
      <th>Fast Food Restaurant</th>
      <th>Field</th>
      <th>Filipino Restaurant</th>
      <th>Financial or Legal Service</th>
      <th>Fish Market</th>
      <th>Flea Market</th>
      <th>Flower Shop</th>
      <th>Food &amp; Drink Shop</th>
      <th>Food Court</th>
      <th>Food Truck</th>
      <th>Fountain</th>
      <th>French Restaurant</th>
      <th>Fried Chicken Joint</th>
      <th>Frozen Yogurt Shop</th>
      <th>Furniture / Home Store</th>
      <th>Gaming Cafe</th>
      <th>Garden</th>
      <th>Garden Center</th>
      <th>Gas Station</th>
      <th>Gastropub</th>
      <th>Gay Bar</th>
      <th>General College &amp; University</th>
      <th>General Entertainment</th>
      <th>German Restaurant</th>
      <th>Gift Shop</th>
      <th>Golf Course</th>
      <th>Gourmet Shop</th>
      <th>Greek Restaurant</th>
      <th>Grocery Store</th>
      <th>Gym</th>
      <th>Gym / Fitness Center</th>
      <th>Gym Pool</th>
      <th>Gymnastics Gym</th>
      <th>Harbor / Marina</th>
      <th>Hardware Store</th>
      <th>Hawaiian Restaurant</th>
      <th>Health &amp; Beauty Service</th>
      <th>Health Food Store</th>
      <th>Heliport</th>
      <th>Herbs &amp; Spices Store</th>
      <th>High School</th>
      <th>Himalayan Restaurant</th>
      <th>Historic Site</th>
      <th>History Museum</th>
      <th>Hobby Shop</th>
      <th>Hookah Bar</th>
      <th>Hostel</th>
      <th>Hot Dog Joint</th>
      <th>Hotel</th>
      <th>Hotel Bar</th>
      <th>Hotpot Restaurant</th>
      <th>Ice Cream Shop</th>
      <th>Indian Restaurant</th>
      <th>Indie Movie Theater</th>
      <th>Indie Theater</th>
      <th>Indoor Play Area</th>
      <th>Irish Pub</th>
      <th>Israeli Restaurant</th>
      <th>Italian Restaurant</th>
      <th>Japanese Curry Restaurant</th>
      <th>Japanese Restaurant</th>
      <th>Jazz Club</th>
      <th>Jewelry Store</th>
      <th>Jewish Restaurant</th>
      <th>Juice Bar</th>
      <th>Karaoke Bar</th>
      <th>Kebab Restaurant</th>
      <th>Kids Store</th>
      <th>Korean Restaurant</th>
      <th>Kosher Restaurant</th>
      <th>Latin American Restaurant</th>
      <th>Laundry Service</th>
      <th>Leather Goods Store</th>
      <th>Lebanese Restaurant</th>
      <th>Library</th>
      <th>Lingerie Store</th>
      <th>Liquor Store</th>
      <th>Lounge</th>
      <th>Malay Restaurant</th>
      <th>Market</th>
      <th>Martial Arts Dojo</th>
      <th>Massage Studio</th>
      <th>Medical Center</th>
      <th>Mediterranean Restaurant</th>
      <th>Memorial Site</th>
      <th>Men's Store</th>
      <th>Metro Station</th>
      <th>Mexican Restaurant</th>
      <th>Middle Eastern Restaurant</th>
      <th>Mini Golf</th>
      <th>Miscellaneous Shop</th>
      <th>Mobile Phone Shop</th>
      <th>Modern European Restaurant</th>
      <th>Molecular Gastronomy Restaurant</th>
      <th>Monument / Landmark</th>
      <th>Moroccan Restaurant</th>
      <th>Movie Theater</th>
      <th>Museum</th>
      <th>Music School</th>
      <th>Music Venue</th>
      <th>Nail Salon</th>
      <th>New American Restaurant</th>
      <th>Newsstand</th>
      <th>Nightclub</th>
      <th>Non-Profit</th>
      <th>Noodle House</th>
      <th>North Indian Restaurant</th>
      <th>Office</th>
      <th>Opera House</th>
      <th>Optical Shop</th>
      <th>Organic Grocery</th>
      <th>Other Nightlife</th>
      <th>Outdoor Sculpture</th>
      <th>Outdoors &amp; Recreation</th>
      <th>Paella Restaurant</th>
      <th>Pakistani Restaurant</th>
      <th>Paper / Office Supplies Store</th>
      <th>Park</th>
      <th>Performing Arts Venue</th>
      <th>Persian Restaurant</th>
      <th>Peruvian Restaurant</th>
      <th>Pet Café</th>
      <th>Pet Service</th>
      <th>Pet Store</th>
      <th>Pharmacy</th>
      <th>Photography Studio</th>
      <th>Piano Bar</th>
      <th>Pie Shop</th>
      <th>Pilates Studio</th>
      <th>Pizza Place</th>
      <th>Playground</th>
      <th>Plaza</th>
      <th>Poke Place</th>
      <th>Pool</th>
      <th>Pub</th>
      <th>Public Art</th>
      <th>Ramen Restaurant</th>
      <th>Record Shop</th>
      <th>Recreation Center</th>
      <th>Rental Car Location</th>
      <th>Residential Building (Apartment / Condo)</th>
      <th>Resort</th>
      <th>Rest Area</th>
      <th>Restaurant</th>
      <th>Rock Club</th>
      <th>Roof Deck</th>
      <th>Russian Restaurant</th>
      <th>Sake Bar</th>
      <th>Salad Place</th>
      <th>Salon / Barbershop</th>
      <th>Sandwich Place</th>
      <th>Scandinavian Restaurant</th>
      <th>Scenic Lookout</th>
      <th>School</th>
      <th>Sculpture Garden</th>
      <th>Seafood Restaurant</th>
      <th>Shanghai Restaurant</th>
      <th>Shipping Store</th>
      <th>Shoe Repair</th>
      <th>Shoe Store</th>
      <th>Shopping Mall</th>
      <th>Skate Park</th>
      <th>Ski Shop</th>
      <th>Smoke Shop</th>
      <th>Smoothie Shop</th>
      <th>Snack Place</th>
      <th>Soba Restaurant</th>
      <th>Social Club</th>
      <th>Soup Place</th>
      <th>South American Restaurant</th>
      <th>South Indian Restaurant</th>
      <th>Southern / Soul Food Restaurant</th>
      <th>Spa</th>
      <th>Spanish Restaurant</th>
      <th>Speakeasy</th>
      <th>Spiritual Center</th>
      <th>Sporting Goods Shop</th>
      <th>Sports Bar</th>
      <th>Sports Club</th>
      <th>Steakhouse</th>
      <th>Street Art</th>
      <th>Strip Club</th>
      <th>Supermarket</th>
      <th>Supplement Shop</th>
      <th>Sushi Restaurant</th>
      <th>Swiss Restaurant</th>
      <th>Szechuan Restaurant</th>
      <th>Taco Place</th>
      <th>Tailor Shop</th>
      <th>Taiwanese Restaurant</th>
      <th>Tapas Restaurant</th>
      <th>Tattoo Parlor</th>
      <th>Tea Room</th>
      <th>Tech Startup</th>
      <th>Tennis Court</th>
      <th>Tennis Stadium</th>
      <th>Thai Restaurant</th>
      <th>Theater</th>
      <th>Theme Park Ride / Attraction</th>
      <th>Thrift / Vintage Store</th>
      <th>Tiki Bar</th>
      <th>Tourist Information Center</th>
      <th>Toy / Game Store</th>
      <th>Trail</th>
      <th>Tree</th>
      <th>Turkish Restaurant</th>
      <th>Udon Restaurant</th>
      <th>Used Bookstore</th>
      <th>Vegetarian / Vegan Restaurant</th>
      <th>Venezuelan Restaurant</th>
      <th>Veterinarian</th>
      <th>Video Game Store</th>
      <th>Video Store</th>
      <th>Vietnamese Restaurant</th>
      <th>Volleyball Court</th>
      <th>Watch Shop</th>
      <th>Waterfront</th>
      <th>Weight Loss Center</th>
      <th>Whisky Bar</th>
      <th>Wine Bar</th>
      <th>Wine Shop</th>
      <th>Wings Joint</th>
      <th>Women's Store</th>
      <th>Yoga Studio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Marble Hill</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Marble Hill</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Marble Hill</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Marble Hill</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Marble Hill</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>




```python
manhattan_onehot.shape
manhattan_grouped = manhattan_onehot.groupby('Neighborhood').mean().reset_index()
manhattan_grouped
manhattan_grouped.shape
num_top_venues = 5

for hood in manhattan_grouped['Neighborhood']:
    print("----"+hood+"----")
    temp = manhattan_grouped[manhattan_grouped['Neighborhood'] == hood].T.reset_index()
    temp.columns = ['venue','freq']
    temp = temp.iloc[1:]
    temp['freq'] = temp['freq'].astype(float)
    temp = temp.round({'freq': 2})
    print(temp.sort_values('freq', ascending=False).reset_index(drop=True).head(num_top_venues))
    print('\n')


```

    ----Battery Park City----
               venue  freq
    0           Park  0.07
    1    Coffee Shop  0.07
    2          Hotel  0.05
    3            Gym  0.04
    4  Memorial Site  0.04
    
    
    ----Carnegie Hill----
             venue  freq
    0  Coffee Shop  0.06
    1  Pizza Place  0.06
    2         Café  0.05
    3          Bar  0.04
    4  Yoga Studio  0.03
    
    
    ----Central Harlem----
                     venue  freq
    0   African Restaurant  0.07
    1   Chinese Restaurant  0.05
    2  American Restaurant  0.05
    3   Seafood Restaurant  0.05
    4    French Restaurant  0.05
    
    
    ----Chelsea----
                    venue  freq
    0         Coffee Shop  0.06
    1      Ice Cream Shop  0.05
    2  Italian Restaurant  0.05
    3           Nightclub  0.04
    4              Bakery  0.04
    
    
    ----Chinatown----
                       venue  freq
    0     Chinese Restaurant  0.09
    1           Cocktail Bar  0.05
    2     Salon / Barbershop  0.04
    3    American Restaurant  0.04
    4  Vietnamese Restaurant  0.04
    
    
    ----Civic Center----
                      venue  freq
    0  Gym / Fitness Center  0.05
    1                 Hotel  0.04
    2     French Restaurant  0.04
    3        Sandwich Place  0.04
    4    Italian Restaurant  0.04
    
    
    ----Clinton----
                      venue  freq
    0               Theater  0.12
    1  Gym / Fitness Center  0.05
    2   American Restaurant  0.04
    3                 Hotel  0.04
    4    Italian Restaurant  0.04
    
    
    ----East Harlem----
                           venue  freq
    0         Mexican Restaurant  0.12
    1                     Bakery  0.10
    2              Deli / Bodega  0.07
    3  Latin American Restaurant  0.05
    4            Thai Restaurant  0.05
    
    
    ----East Village----
                    venue  freq
    0                 Bar  0.06
    1            Wine Bar  0.05
    2      Ice Cream Shop  0.04
    3  Chinese Restaurant  0.04
    4  Mexican Restaurant  0.04
    
    
    ----Financial District----
             venue  freq
    0  Coffee Shop  0.08
    1   Steakhouse  0.04
    2          Gym  0.04
    3        Hotel  0.04
    4  Event Space  0.03
    
    
    ----Flatiron----
                      venue  freq
    0                   Gym  0.05
    1           Yoga Studio  0.04
    2   Japanese Restaurant  0.04
    3  Gym / Fitness Center  0.04
    4   American Restaurant  0.04
    
    
    ----Gramercy----
                     venue  freq
    0                  Bar  0.05
    1          Pizza Place  0.04
    2  American Restaurant  0.04
    3         Cocktail Bar  0.04
    4   Italian Restaurant  0.04
    
    
    ----Greenwich Village----
                    venue  freq
    0  Italian Restaurant  0.13
    1    Sushi Restaurant  0.04
    2      Clothing Store  0.04
    3                Café  0.03
    4  Seafood Restaurant  0.03
    
    
    ----Hamilton Heights----
                    venue  freq
    0  Mexican Restaurant  0.07
    1                Café  0.07
    2         Pizza Place  0.07
    3         Coffee Shop  0.05
    4  Chinese Restaurant  0.05
    
    
    ----Hudson Yards----
                      venue  freq
    0   American Restaurant  0.06
    1                  Café  0.05
    2  Gym / Fitness Center  0.05
    3    Italian Restaurant  0.05
    4                 Hotel  0.04
    
    
    ----Inwood----
                      venue  freq
    0    Mexican Restaurant  0.07
    1                  Café  0.07
    2           Pizza Place  0.05
    3                Lounge  0.05
    4  Caribbean Restaurant  0.04
    
    
    ----Lenox Hill----
                    venue  freq
    0         Coffee Shop  0.07
    1         Pizza Place  0.05
    2    Sushi Restaurant  0.05
    3  Italian Restaurant  0.05
    4        Burger Joint  0.03
    
    
    ----Lincoln Square----
                      venue  freq
    0               Theater  0.06
    1  Gym / Fitness Center  0.06
    2                  Café  0.05
    3          Concert Hall  0.05
    4                 Plaza  0.05
    
    
    ----Little Italy----
                          venue  freq
    0                    Bakery  0.05
    1                      Café  0.04
    2            Clothing Store  0.03
    3           Bubble Tea Shop  0.03
    4  Mediterranean Restaurant  0.03
    
    
    ----Lower East Side----
                    venue  freq
    0         Coffee Shop  0.06
    1                Café  0.05
    2  Chinese Restaurant  0.05
    3         Pizza Place  0.05
    4                Park  0.05
    
    
    ----Manhattan Valley----
                   venue  freq
    0        Coffee Shop  0.05
    1  Indian Restaurant  0.05
    2        Pizza Place  0.05
    3        Yoga Studio  0.04
    4         Playground  0.04
    
    
    ----Manhattanville----
                    venue  freq
    0       Deli / Bodega  0.05
    1  Italian Restaurant  0.05
    2  Mexican Restaurant  0.05
    3  Seafood Restaurant  0.05
    4         Coffee Shop  0.05
    
    
    ----Marble Hill----
                    venue  freq
    0      Sandwich Place  0.12
    1      Discount Store  0.08
    2         Coffee Shop  0.08
    3  Seafood Restaurant  0.04
    4                 Gym  0.04
    
    
    ----Midtown----
                venue  freq
    0           Hotel  0.07
    1    Cocktail Bar  0.04
    2  Clothing Store  0.04
    3         Theater  0.04
    4     Coffee Shop  0.04
    
    
    ----Midtown South----
                     venue  freq
    0    Korean Restaurant  0.14
    1                Hotel  0.07
    2  Japanese Restaurant  0.04
    3       Cosmetics Shop  0.04
    4         Dessert Shop  0.04
    
    
    ----Morningside Heights----
                     venue  freq
    0          Coffee Shop  0.08
    1  American Restaurant  0.08
    2                 Park  0.08
    3            Bookstore  0.08
    4        Deli / Bodega  0.05
    
    
    ----Murray Hill----
                     venue  freq
    0          Coffee Shop  0.05
    1  Japanese Restaurant  0.04
    2                Hotel  0.04
    3       Sandwich Place  0.04
    4   Italian Restaurant  0.03
    
    
    ----Noho----
                    venue  freq
    0  Italian Restaurant  0.06
    1   French Restaurant  0.05
    2    Sushi Restaurant  0.04
    3        Cocktail Bar  0.04
    4       Grocery Store  0.03
    
    
    ----Roosevelt Island----
                venue  freq
    0  Sandwich Place  0.08
    1     Coffee Shop  0.08
    2            Park  0.08
    3    Liquor Store  0.04
    4     Supermarket  0.04
    
    
    ----Soho----
                venue  freq
    0  Clothing Store  0.09
    1        Boutique  0.06
    2     Art Gallery  0.04
    3      Shoe Store  0.04
    4   Women's Store  0.04
    
    
    ----Stuyvesant Town----
                venue  freq
    0   Boat or Ferry  0.10
    1            Park  0.10
    2      Playground  0.10
    3             Bar  0.10
    4  Baseball Field  0.05
    
    
    ----Sutton Place----
                        venue  freq
    0    Gym / Fitness Center  0.06
    1  Furniture / Home Store  0.04
    2      Italian Restaurant  0.04
    3       Indian Restaurant  0.04
    4     American Restaurant  0.03
    
    
    ----Tribeca----
                     venue  freq
    0                 Park  0.05
    1   Italian Restaurant  0.05
    2             Boutique  0.05
    3                 Café  0.05
    4  American Restaurant  0.04
    
    
    ----Tudor City----
                    venue  freq
    0                Park  0.06
    1  Mexican Restaurant  0.06
    2                Café  0.05
    3    Greek Restaurant  0.05
    4         Pizza Place  0.04
    
    
    ----Turtle Bay----
                    venue  freq
    0    Sushi Restaurant  0.05
    1          Steakhouse  0.05
    2         Coffee Shop  0.05
    3  Italian Restaurant  0.05
    4    Ramen Restaurant  0.04
    
    
    ----Upper East Side----
                    venue  freq
    0  Italian Restaurant  0.08
    1             Exhibit  0.07
    2         Art Gallery  0.05
    3              Bakery  0.04
    4           Juice Bar  0.04
    
    
    ----Upper West Side----
                               venue  freq
    0             Italian Restaurant  0.06
    1                       Wine Bar  0.04
    2                            Bar  0.04
    3  Vegetarian / Vegan Restaurant  0.03
    4       Mediterranean Restaurant  0.03
    
    
    ----Washington Heights----
                           venue  freq
    0                       Café  0.06
    1          Mobile Phone Shop  0.05
    2                     Bakery  0.05
    3              Grocery Store  0.03
    4  Latin American Restaurant  0.02
    
    
    ----West Village----
                         venue  freq
    0       Italian Restaurant  0.08
    1  New American Restaurant  0.05
    2           Cosmetics Shop  0.05
    3                     Park  0.04
    4      American Restaurant  0.04
    
    
    ----Yorkville----
                    venue  freq
    0  Italian Restaurant  0.06
    1                 Gym  0.06
    2         Coffee Shop  0.06
    3                 Bar  0.05
    4    Sushi Restaurant  0.04
    
    
    


```python
def return_most_common_venues(row, num_top_venues):
    row_categories = row.iloc[1:]
    row_categories_sorted = row_categories.sort_values(ascending=False)
    
    return row_categories_sorted.index.values[0:num_top_venues]
```


```python
num_top_venues = 10

indicators = ['st', 'nd', 'rd']

# create columns according to number of top venues
columns = ['Neighborhood']
for ind in np.arange(num_top_venues):
    try:
        columns.append('{}{} Most Common Venue'.format(ind+1, indicators[ind]))
    except:
        columns.append('{}th Most Common Venue'.format(ind+1))

# create a new dataframe
neighborhoods_venues_sorted_dataset_1 = pd.DataFrame(columns=columns)
neighborhoods_venues_sorted_dataset_1['Neighborhood'] = manhattan_grouped['Neighborhood']

for ind in np.arange(manhattan_grouped.shape[0]):
    neighborhoods_venues_sorted_dataset_1.iloc[ind, 1:] = return_most_common_venues(manhattan_grouped.iloc[ind, :], num_top_venues)

neighborhoods_venues_sorted_dataset_1.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Neighborhood</th>
      <th>1st Most Common Venue</th>
      <th>2nd Most Common Venue</th>
      <th>3rd Most Common Venue</th>
      <th>4th Most Common Venue</th>
      <th>5th Most Common Venue</th>
      <th>6th Most Common Venue</th>
      <th>7th Most Common Venue</th>
      <th>8th Most Common Venue</th>
      <th>9th Most Common Venue</th>
      <th>10th Most Common Venue</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Battery Park City</td>
      <td>Park</td>
      <td>Coffee Shop</td>
      <td>Hotel</td>
      <td>Memorial Site</td>
      <td>Gym</td>
      <td>Wine Shop</td>
      <td>Italian Restaurant</td>
      <td>Clothing Store</td>
      <td>Food Court</td>
      <td>Sushi Restaurant</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Carnegie Hill</td>
      <td>Coffee Shop</td>
      <td>Pizza Place</td>
      <td>Café</td>
      <td>Bar</td>
      <td>Yoga Studio</td>
      <td>Japanese Restaurant</td>
      <td>Bookstore</td>
      <td>Cosmetics Shop</td>
      <td>Bakery</td>
      <td>French Restaurant</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Central Harlem</td>
      <td>African Restaurant</td>
      <td>Seafood Restaurant</td>
      <td>Chinese Restaurant</td>
      <td>Bar</td>
      <td>American Restaurant</td>
      <td>French Restaurant</td>
      <td>Public Art</td>
      <td>Gym</td>
      <td>Dessert Shop</td>
      <td>Beer Bar</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Chelsea</td>
      <td>Coffee Shop</td>
      <td>Italian Restaurant</td>
      <td>Ice Cream Shop</td>
      <td>Bakery</td>
      <td>Nightclub</td>
      <td>Theater</td>
      <td>American Restaurant</td>
      <td>Seafood Restaurant</td>
      <td>Art Gallery</td>
      <td>Hotel</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Chinatown</td>
      <td>Chinese Restaurant</td>
      <td>Cocktail Bar</td>
      <td>Vietnamese Restaurant</td>
      <td>American Restaurant</td>
      <td>Salon / Barbershop</td>
      <td>Dumpling Restaurant</td>
      <td>Spa</td>
      <td>Bakery</td>
      <td>Bubble Tea Shop</td>
      <td>Dim Sum Restaurant</td>
    </tr>
  </tbody>
</table>
</div>




```python

manhattan_grouped_clustering_dataset_1 = manhattan_grouped.drop('Neighborhood', 1)
```


```python
import pandas as pd
import requests
from bs4 import BeautifulSoup

res = requests.get("https://en.wikipedia.org/wiki/List_of_postal_codes_of_Canada:_M")
soup = BeautifulSoup(res.content,'lxml')
table = soup.find_all('table')[0] 
df = pd.read_html(str(table))
print(df[0].to_json(orient='records'))

df = df[0]

df = df[df.Borough != "Not assigned"]
df.head()

df.shape[0]
print(df.iloc[0].Postcode)

df_new = pd.DataFrame({"Postcode":[],"Borough":[],"Neighbourhood":[]})
for m in range(df.shape[0]):
    new_Neighbourhood = ""
    for j in df[df.Postcode == df.iloc[m].Postcode].Neighbourhood:
        if j == "Not assigned":
            new_Neighbourhood = "," + df.iloc[m].Borough
        else:
            new_Neighbourhood = new_Neighbourhood + "," + j
    df_new = df_new.append({"Postcode": df.iloc[m].Postcode, "Borough": df.iloc[m].Borough, "Neighbourhood": new_Neighbourhood[1:]}, ignore_index=True)
df_new.head()
 

df_new = df_new.drop_duplicates()
df_new.head()

df_new.shape


df_geo = pd.read_csv("https://cocl.us/Geospatial_data")

df_geo.head()

pd.merge(df_new, df_geo, left_on = "Postcode", right_on = "Postal Code").drop(["Postal Code"], axis = 1)
```

    [{"Postcode":"M1A","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M2A","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3A","Borough":"North York","Neighbourhood":"Parkwoods"},{"Postcode":"M4A","Borough":"North York","Neighbourhood":"Victoria Village"},{"Postcode":"M5A","Borough":"Downtown Toronto","Neighbourhood":"Harbourfront"},{"Postcode":"M5A","Borough":"Downtown Toronto","Neighbourhood":"Regent Park"},{"Postcode":"M6A","Borough":"North York","Neighbourhood":"Lawrence Heights"},{"Postcode":"M6A","Borough":"North York","Neighbourhood":"Lawrence Manor"},{"Postcode":"M7A","Borough":"Queen's Park","Neighbourhood":"Not assigned"},{"Postcode":"M8A","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9A","Borough":"Etobicoke","Neighbourhood":"Islington Avenue"},{"Postcode":"M1B","Borough":"Scarborough","Neighbourhood":"Rouge"},{"Postcode":"M1B","Borough":"Scarborough","Neighbourhood":"Malvern"},{"Postcode":"M2B","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3B","Borough":"North York","Neighbourhood":"Don Mills North"},{"Postcode":"M4B","Borough":"East York","Neighbourhood":"Woodbine Gardens"},{"Postcode":"M4B","Borough":"East York","Neighbourhood":"Parkview Hill"},{"Postcode":"M5B","Borough":"Downtown Toronto","Neighbourhood":"Ryerson"},{"Postcode":"M5B","Borough":"Downtown Toronto","Neighbourhood":"Garden District"},{"Postcode":"M6B","Borough":"North York","Neighbourhood":"Glencairn"},{"Postcode":"M7B","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8B","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9B","Borough":"Etobicoke","Neighbourhood":"Cloverdale"},{"Postcode":"M9B","Borough":"Etobicoke","Neighbourhood":"Islington"},{"Postcode":"M9B","Borough":"Etobicoke","Neighbourhood":"Martin Grove"},{"Postcode":"M9B","Borough":"Etobicoke","Neighbourhood":"Princess Gardens"},{"Postcode":"M9B","Borough":"Etobicoke","Neighbourhood":"West Deane Park"},{"Postcode":"M1C","Borough":"Scarborough","Neighbourhood":"Highland Creek"},{"Postcode":"M1C","Borough":"Scarborough","Neighbourhood":"Rouge Hill"},{"Postcode":"M1C","Borough":"Scarborough","Neighbourhood":"Port Union"},{"Postcode":"M2C","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3C","Borough":"North York","Neighbourhood":"Flemingdon Park"},{"Postcode":"M3C","Borough":"North York","Neighbourhood":"Don Mills South"},{"Postcode":"M4C","Borough":"East York","Neighbourhood":"Woodbine Heights"},{"Postcode":"M5C","Borough":"Downtown Toronto","Neighbourhood":"St. James Town"},{"Postcode":"M6C","Borough":"York","Neighbourhood":"Humewood-Cedarvale"},{"Postcode":"M7C","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8C","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9C","Borough":"Etobicoke","Neighbourhood":"Bloordale Gardens"},{"Postcode":"M9C","Borough":"Etobicoke","Neighbourhood":"Eringate"},{"Postcode":"M9C","Borough":"Etobicoke","Neighbourhood":"Markland Wood"},{"Postcode":"M9C","Borough":"Etobicoke","Neighbourhood":"Old Burnhamthorpe"},{"Postcode":"M1E","Borough":"Scarborough","Neighbourhood":"Guildwood"},{"Postcode":"M1E","Borough":"Scarborough","Neighbourhood":"Morningside"},{"Postcode":"M1E","Borough":"Scarborough","Neighbourhood":"West Hill"},{"Postcode":"M2E","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3E","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4E","Borough":"East Toronto","Neighbourhood":"The Beaches"},{"Postcode":"M5E","Borough":"Downtown Toronto","Neighbourhood":"Berczy Park"},{"Postcode":"M6E","Borough":"York","Neighbourhood":"Caledonia-Fairbanks"},{"Postcode":"M7E","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8E","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9E","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M1G","Borough":"Scarborough","Neighbourhood":"Woburn"},{"Postcode":"M2G","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3G","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4G","Borough":"East York","Neighbourhood":"Leaside"},{"Postcode":"M5G","Borough":"Downtown Toronto","Neighbourhood":"Central Bay Street"},{"Postcode":"M6G","Borough":"Downtown Toronto","Neighbourhood":"Christie"},{"Postcode":"M7G","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8G","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9G","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M1H","Borough":"Scarborough","Neighbourhood":"Cedarbrae"},{"Postcode":"M2H","Borough":"North York","Neighbourhood":"Hillcrest Village"},{"Postcode":"M3H","Borough":"North York","Neighbourhood":"Bathurst Manor"},{"Postcode":"M3H","Borough":"North York","Neighbourhood":"Downsview North"},{"Postcode":"M3H","Borough":"North York","Neighbourhood":"Wilson Heights"},{"Postcode":"M4H","Borough":"East York","Neighbourhood":"Thorncliffe Park"},{"Postcode":"M5H","Borough":"Downtown Toronto","Neighbourhood":"Adelaide"},{"Postcode":"M5H","Borough":"Downtown Toronto","Neighbourhood":"King"},{"Postcode":"M5H","Borough":"Downtown Toronto","Neighbourhood":"Richmond"},{"Postcode":"M6H","Borough":"West Toronto","Neighbourhood":"Dovercourt Village"},{"Postcode":"M6H","Borough":"West Toronto","Neighbourhood":"Dufferin"},{"Postcode":"M7H","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8H","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9H","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M1J","Borough":"Scarborough","Neighbourhood":"Scarborough Village"},{"Postcode":"M2J","Borough":"North York","Neighbourhood":"Fairview"},{"Postcode":"M2J","Borough":"North York","Neighbourhood":"Henry Farm"},{"Postcode":"M2J","Borough":"North York","Neighbourhood":"Oriole"},{"Postcode":"M3J","Borough":"North York","Neighbourhood":"Northwood Park"},{"Postcode":"M3J","Borough":"North York","Neighbourhood":"York University"},{"Postcode":"M4J","Borough":"East York","Neighbourhood":"East Toronto"},{"Postcode":"M5J","Borough":"Downtown Toronto","Neighbourhood":"Harbourfront East"},{"Postcode":"M5J","Borough":"Downtown Toronto","Neighbourhood":"Toronto Islands"},{"Postcode":"M5J","Borough":"Downtown Toronto","Neighbourhood":"Union Station"},{"Postcode":"M6J","Borough":"West Toronto","Neighbourhood":"Little Portugal"},{"Postcode":"M6J","Borough":"West Toronto","Neighbourhood":"Trinity"},{"Postcode":"M7J","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8J","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9J","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M1K","Borough":"Scarborough","Neighbourhood":"East Birchmount Park"},{"Postcode":"M1K","Borough":"Scarborough","Neighbourhood":"Ionview"},{"Postcode":"M1K","Borough":"Scarborough","Neighbourhood":"Kennedy Park"},{"Postcode":"M2K","Borough":"North York","Neighbourhood":"Bayview Village"},{"Postcode":"M3K","Borough":"North York","Neighbourhood":"CFB Toronto"},{"Postcode":"M3K","Borough":"North York","Neighbourhood":"Downsview East"},{"Postcode":"M4K","Borough":"East Toronto","Neighbourhood":"The Danforth West"},{"Postcode":"M4K","Borough":"East Toronto","Neighbourhood":"Riverdale"},{"Postcode":"M5K","Borough":"Downtown Toronto","Neighbourhood":"Design Exchange"},{"Postcode":"M5K","Borough":"Downtown Toronto","Neighbourhood":"Toronto Dominion Centre"},{"Postcode":"M6K","Borough":"West Toronto","Neighbourhood":"Brockton"},{"Postcode":"M6K","Borough":"West Toronto","Neighbourhood":"Exhibition Place"},{"Postcode":"M6K","Borough":"West Toronto","Neighbourhood":"Parkdale Village"},{"Postcode":"M7K","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8K","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9K","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M1L","Borough":"Scarborough","Neighbourhood":"Clairlea"},{"Postcode":"M1L","Borough":"Scarborough","Neighbourhood":"Golden Mile"},{"Postcode":"M1L","Borough":"Scarborough","Neighbourhood":"Oakridge"},{"Postcode":"M2L","Borough":"North York","Neighbourhood":"Silver Hills"},{"Postcode":"M2L","Borough":"North York","Neighbourhood":"York Mills"},{"Postcode":"M3L","Borough":"North York","Neighbourhood":"Downsview West"},{"Postcode":"M4L","Borough":"East Toronto","Neighbourhood":"The Beaches West"},{"Postcode":"M4L","Borough":"East Toronto","Neighbourhood":"India Bazaar"},{"Postcode":"M5L","Borough":"Downtown Toronto","Neighbourhood":"Commerce Court"},{"Postcode":"M5L","Borough":"Downtown Toronto","Neighbourhood":"Victoria Hotel"},{"Postcode":"M6L","Borough":"North York","Neighbourhood":"Downsview"},{"Postcode":"M6L","Borough":"North York","Neighbourhood":"North Park"},{"Postcode":"M6L","Borough":"North York","Neighbourhood":"Upwood Park"},{"Postcode":"M7L","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8L","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9L","Borough":"North York","Neighbourhood":"Humber Summit"},{"Postcode":"M1M","Borough":"Scarborough","Neighbourhood":"Cliffcrest"},{"Postcode":"M1M","Borough":"Scarborough","Neighbourhood":"Cliffside"},{"Postcode":"M1M","Borough":"Scarborough","Neighbourhood":"Scarborough Village West"},{"Postcode":"M2M","Borough":"North York","Neighbourhood":"Newtonbrook"},{"Postcode":"M2M","Borough":"North York","Neighbourhood":"Willowdale"},{"Postcode":"M3M","Borough":"North York","Neighbourhood":"Downsview Central"},{"Postcode":"M4M","Borough":"East Toronto","Neighbourhood":"Studio District"},{"Postcode":"M5M","Borough":"North York","Neighbourhood":"Bedford Park"},{"Postcode":"M5M","Borough":"North York","Neighbourhood":"Lawrence Manor East"},{"Postcode":"M6M","Borough":"York","Neighbourhood":"Del Ray"},{"Postcode":"M6M","Borough":"York","Neighbourhood":"Keelesdale"},{"Postcode":"M6M","Borough":"York","Neighbourhood":"Mount Dennis"},{"Postcode":"M6M","Borough":"York","Neighbourhood":"Silverthorn"},{"Postcode":"M7M","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8M","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9M","Borough":"North York","Neighbourhood":"Emery"},{"Postcode":"M9M","Borough":"North York","Neighbourhood":"Humberlea"},{"Postcode":"M1N","Borough":"Scarborough","Neighbourhood":"Birch Cliff"},{"Postcode":"M1N","Borough":"Scarborough","Neighbourhood":"Cliffside West"},{"Postcode":"M2N","Borough":"North York","Neighbourhood":"Willowdale South"},{"Postcode":"M3N","Borough":"North York","Neighbourhood":"Downsview Northwest"},{"Postcode":"M4N","Borough":"Central Toronto","Neighbourhood":"Lawrence Park"},{"Postcode":"M5N","Borough":"Central Toronto","Neighbourhood":"Roselawn"},{"Postcode":"M6N","Borough":"York","Neighbourhood":"The Junction North"},{"Postcode":"M6N","Borough":"York","Neighbourhood":"Runnymede"},{"Postcode":"M7N","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8N","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9N","Borough":"York","Neighbourhood":"Weston"},{"Postcode":"M1P","Borough":"Scarborough","Neighbourhood":"Dorset Park"},{"Postcode":"M1P","Borough":"Scarborough","Neighbourhood":"Scarborough Town Centre"},{"Postcode":"M1P","Borough":"Scarborough","Neighbourhood":"Wexford Heights"},{"Postcode":"M2P","Borough":"North York","Neighbourhood":"York Mills West"},{"Postcode":"M3P","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4P","Borough":"Central Toronto","Neighbourhood":"Davisville North"},{"Postcode":"M5P","Borough":"Central Toronto","Neighbourhood":"Forest Hill North"},{"Postcode":"M5P","Borough":"Central Toronto","Neighbourhood":"Forest Hill West"},{"Postcode":"M6P","Borough":"West Toronto","Neighbourhood":"High Park"},{"Postcode":"M6P","Borough":"West Toronto","Neighbourhood":"The Junction South"},{"Postcode":"M7P","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8P","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9P","Borough":"Etobicoke","Neighbourhood":"Westmount"},{"Postcode":"M1R","Borough":"Scarborough","Neighbourhood":"Maryvale"},{"Postcode":"M1R","Borough":"Scarborough","Neighbourhood":"Wexford"},{"Postcode":"M2R","Borough":"North York","Neighbourhood":"Willowdale West"},{"Postcode":"M3R","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4R","Borough":"Central Toronto","Neighbourhood":"North Toronto West"},{"Postcode":"M5R","Borough":"Central Toronto","Neighbourhood":"The Annex"},{"Postcode":"M5R","Borough":"Central Toronto","Neighbourhood":"North Midtown"},{"Postcode":"M5R","Borough":"Central Toronto","Neighbourhood":"Yorkville"},{"Postcode":"M6R","Borough":"West Toronto","Neighbourhood":"Parkdale"},{"Postcode":"M6R","Borough":"West Toronto","Neighbourhood":"Roncesvalles"},{"Postcode":"M7R","Borough":"Mississauga","Neighbourhood":"Canada Post Gateway Processing Centre"},{"Postcode":"M8R","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9R","Borough":"Etobicoke","Neighbourhood":"Kingsview Village"},{"Postcode":"M9R","Borough":"Etobicoke","Neighbourhood":"Martin Grove Gardens"},{"Postcode":"M9R","Borough":"Etobicoke","Neighbourhood":"Richview Gardens"},{"Postcode":"M9R","Borough":"Etobicoke","Neighbourhood":"St. Phillips"},{"Postcode":"M1S","Borough":"Scarborough","Neighbourhood":"Agincourt"},{"Postcode":"M2S","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3S","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4S","Borough":"Central Toronto","Neighbourhood":"Davisville"},{"Postcode":"M5S","Borough":"Downtown Toronto","Neighbourhood":"Harbord"},{"Postcode":"M5S","Borough":"Downtown Toronto","Neighbourhood":"University of Toronto"},{"Postcode":"M6S","Borough":"West Toronto","Neighbourhood":"Runnymede"},{"Postcode":"M6S","Borough":"West Toronto","Neighbourhood":"Swansea"},{"Postcode":"M7S","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8S","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9S","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M1T","Borough":"Scarborough","Neighbourhood":"Clarks Corners"},{"Postcode":"M1T","Borough":"Scarborough","Neighbourhood":"Sullivan"},{"Postcode":"M1T","Borough":"Scarborough","Neighbourhood":"Tam O'Shanter"},{"Postcode":"M2T","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3T","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4T","Borough":"Central Toronto","Neighbourhood":"Moore Park"},{"Postcode":"M4T","Borough":"Central Toronto","Neighbourhood":"Summerhill East"},{"Postcode":"M5T","Borough":"Downtown Toronto","Neighbourhood":"Chinatown"},{"Postcode":"M5T","Borough":"Downtown Toronto","Neighbourhood":"Grange Park"},{"Postcode":"M5T","Borough":"Downtown Toronto","Neighbourhood":"Kensington Market"},{"Postcode":"M6T","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M7T","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8T","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M9T","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M1V","Borough":"Scarborough","Neighbourhood":"Agincourt North"},{"Postcode":"M1V","Borough":"Scarborough","Neighbourhood":"L'Amoreaux East"},{"Postcode":"M1V","Borough":"Scarborough","Neighbourhood":"Milliken"},{"Postcode":"M1V","Borough":"Scarborough","Neighbourhood":"Steeles East"},{"Postcode":"M2V","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3V","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4V","Borough":"Central Toronto","Neighbourhood":"Deer Park"},{"Postcode":"M4V","Borough":"Central Toronto","Neighbourhood":"Forest Hill SE"},{"Postcode":"M4V","Borough":"Central Toronto","Neighbourhood":"Rathnelly"},{"Postcode":"M4V","Borough":"Central Toronto","Neighbourhood":"South Hill"},{"Postcode":"M4V","Borough":"Central Toronto","Neighbourhood":"Summerhill West"},{"Postcode":"M5V","Borough":"Downtown Toronto","Neighbourhood":"CN Tower"},{"Postcode":"M5V","Borough":"Downtown Toronto","Neighbourhood":"Bathurst Quay"},{"Postcode":"M5V","Borough":"Downtown Toronto","Neighbourhood":"Island airport"},{"Postcode":"M5V","Borough":"Downtown Toronto","Neighbourhood":"Harbourfront West"},{"Postcode":"M5V","Borough":"Downtown Toronto","Neighbourhood":"King and Spadina"},{"Postcode":"M5V","Borough":"Downtown Toronto","Neighbourhood":"Railway Lands"},{"Postcode":"M5V","Borough":"Downtown Toronto","Neighbourhood":"South Niagara"},{"Postcode":"M6V","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M7V","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8V","Borough":"Etobicoke","Neighbourhood":"Humber Bay Shores"},{"Postcode":"M8V","Borough":"Etobicoke","Neighbourhood":"Mimico South"},{"Postcode":"M8V","Borough":"Etobicoke","Neighbourhood":"New Toronto"},{"Postcode":"M9V","Borough":"Etobicoke","Neighbourhood":"Albion Gardens"},{"Postcode":"M9V","Borough":"Etobicoke","Neighbourhood":"Beaumond Heights"},{"Postcode":"M9V","Borough":"Etobicoke","Neighbourhood":"Humbergate"},{"Postcode":"M9V","Borough":"Etobicoke","Neighbourhood":"Jamestown"},{"Postcode":"M9V","Borough":"Etobicoke","Neighbourhood":"Mount Olive"},{"Postcode":"M9V","Borough":"Etobicoke","Neighbourhood":"Silverstone"},{"Postcode":"M9V","Borough":"Etobicoke","Neighbourhood":"South Steeles"},{"Postcode":"M9V","Borough":"Etobicoke","Neighbourhood":"Thistletown"},{"Postcode":"M1W","Borough":"Scarborough","Neighbourhood":"L'Amoreaux West"},{"Postcode":"M2W","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3W","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4W","Borough":"Downtown Toronto","Neighbourhood":"Rosedale"},{"Postcode":"M5W","Borough":"Downtown Toronto","Neighbourhood":"Stn A PO Boxes 25 The Esplanade"},{"Postcode":"M6W","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M7W","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8W","Borough":"Etobicoke","Neighbourhood":"Alderwood"},{"Postcode":"M8W","Borough":"Etobicoke","Neighbourhood":"Long Branch"},{"Postcode":"M9W","Borough":"Etobicoke","Neighbourhood":"Northwest"},{"Postcode":"M1X","Borough":"Scarborough","Neighbourhood":"Upper Rouge"},{"Postcode":"M2X","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3X","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4X","Borough":"Downtown Toronto","Neighbourhood":"Cabbagetown"},{"Postcode":"M4X","Borough":"Downtown Toronto","Neighbourhood":"St. James Town"},{"Postcode":"M5X","Borough":"Downtown Toronto","Neighbourhood":"First Canadian Place"},{"Postcode":"M5X","Borough":"Downtown Toronto","Neighbourhood":"Underground city"},{"Postcode":"M6X","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M7X","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8X","Borough":"Etobicoke","Neighbourhood":"The Kingsway"},{"Postcode":"M8X","Borough":"Etobicoke","Neighbourhood":"Montgomery Road"},{"Postcode":"M8X","Borough":"Etobicoke","Neighbourhood":"Old Mill North"},{"Postcode":"M9X","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M1Y","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M2Y","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3Y","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4Y","Borough":"Downtown Toronto","Neighbourhood":"Church and Wellesley"},{"Postcode":"M5Y","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M6Y","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M7Y","Borough":"East Toronto","Neighbourhood":"Business Reply Mail Processing Centre 969 Eastern"},{"Postcode":"M8Y","Borough":"Etobicoke","Neighbourhood":"Humber Bay"},{"Postcode":"M8Y","Borough":"Etobicoke","Neighbourhood":"King's Mill Park"},{"Postcode":"M8Y","Borough":"Etobicoke","Neighbourhood":"Kingsway Park South East"},{"Postcode":"M8Y","Borough":"Etobicoke","Neighbourhood":"Mimico NE"},{"Postcode":"M8Y","Borough":"Etobicoke","Neighbourhood":"Old Mill South"},{"Postcode":"M8Y","Borough":"Etobicoke","Neighbourhood":"The Queensway East"},{"Postcode":"M8Y","Borough":"Etobicoke","Neighbourhood":"Royal York South East"},{"Postcode":"M8Y","Borough":"Etobicoke","Neighbourhood":"Sunnylea"},{"Postcode":"M9Y","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M1Z","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M2Z","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M3Z","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M4Z","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M5Z","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M6Z","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M7Z","Borough":"Not assigned","Neighbourhood":"Not assigned"},{"Postcode":"M8Z","Borough":"Etobicoke","Neighbourhood":"Kingsway Park South West"},{"Postcode":"M8Z","Borough":"Etobicoke","Neighbourhood":"Mimico NW"},{"Postcode":"M8Z","Borough":"Etobicoke","Neighbourhood":"The Queensway West"},{"Postcode":"M8Z","Borough":"Etobicoke","Neighbourhood":"Royal York South West"},{"Postcode":"M8Z","Borough":"Etobicoke","Neighbourhood":"South of Bloor"},{"Postcode":"M9Z","Borough":"Not assigned","Neighbourhood":"Not assigned"}]
    M3A
    




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Postcode</th>
      <th>Borough</th>
      <th>Neighbourhood</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>M3A</td>
      <td>North York</td>
      <td>Parkwoods</td>
      <td>43.753259</td>
      <td>-79.329656</td>
    </tr>
    <tr>
      <th>1</th>
      <td>M4A</td>
      <td>North York</td>
      <td>Victoria Village</td>
      <td>43.725882</td>
      <td>-79.315572</td>
    </tr>
    <tr>
      <th>2</th>
      <td>M5A</td>
      <td>Downtown Toronto</td>
      <td>Harbourfront,Regent Park</td>
      <td>43.654260</td>
      <td>-79.360636</td>
    </tr>
    <tr>
      <th>3</th>
      <td>M6A</td>
      <td>North York</td>
      <td>Lawrence Heights,Lawrence Manor</td>
      <td>43.718518</td>
      <td>-79.464763</td>
    </tr>
    <tr>
      <th>4</th>
      <td>M7A</td>
      <td>Queen's Park</td>
      <td>Queen's Park</td>
      <td>43.662301</td>
      <td>-79.389494</td>
    </tr>
    <tr>
      <th>5</th>
      <td>M9A</td>
      <td>Etobicoke</td>
      <td>Islington Avenue</td>
      <td>43.667856</td>
      <td>-79.532242</td>
    </tr>
    <tr>
      <th>6</th>
      <td>M1B</td>
      <td>Scarborough</td>
      <td>Rouge,Malvern</td>
      <td>43.806686</td>
      <td>-79.194353</td>
    </tr>
    <tr>
      <th>7</th>
      <td>M3B</td>
      <td>North York</td>
      <td>Don Mills North</td>
      <td>43.745906</td>
      <td>-79.352188</td>
    </tr>
    <tr>
      <th>8</th>
      <td>M4B</td>
      <td>East York</td>
      <td>Woodbine Gardens,Parkview Hill</td>
      <td>43.706397</td>
      <td>-79.309937</td>
    </tr>
    <tr>
      <th>9</th>
      <td>M5B</td>
      <td>Downtown Toronto</td>
      <td>Ryerson,Garden District</td>
      <td>43.657162</td>
      <td>-79.378937</td>
    </tr>
    <tr>
      <th>10</th>
      <td>M6B</td>
      <td>North York</td>
      <td>Glencairn</td>
      <td>43.709577</td>
      <td>-79.445073</td>
    </tr>
    <tr>
      <th>11</th>
      <td>M9B</td>
      <td>Etobicoke</td>
      <td>Cloverdale,Islington,Martin Grove,Princess Gar...</td>
      <td>43.650943</td>
      <td>-79.554724</td>
    </tr>
    <tr>
      <th>12</th>
      <td>M1C</td>
      <td>Scarborough</td>
      <td>Highland Creek,Rouge Hill,Port Union</td>
      <td>43.784535</td>
      <td>-79.160497</td>
    </tr>
    <tr>
      <th>13</th>
      <td>M3C</td>
      <td>North York</td>
      <td>Flemingdon Park,Don Mills South</td>
      <td>43.725900</td>
      <td>-79.340923</td>
    </tr>
    <tr>
      <th>14</th>
      <td>M4C</td>
      <td>East York</td>
      <td>Woodbine Heights</td>
      <td>43.695344</td>
      <td>-79.318389</td>
    </tr>
    <tr>
      <th>15</th>
      <td>M5C</td>
      <td>Downtown Toronto</td>
      <td>St. James Town</td>
      <td>43.651494</td>
      <td>-79.375418</td>
    </tr>
    <tr>
      <th>16</th>
      <td>M6C</td>
      <td>York</td>
      <td>Humewood-Cedarvale</td>
      <td>43.693781</td>
      <td>-79.428191</td>
    </tr>
    <tr>
      <th>17</th>
      <td>M9C</td>
      <td>Etobicoke</td>
      <td>Bloordale Gardens,Eringate,Markland Wood,Old B...</td>
      <td>43.643515</td>
      <td>-79.577201</td>
    </tr>
    <tr>
      <th>18</th>
      <td>M1E</td>
      <td>Scarborough</td>
      <td>Guildwood,Morningside,West Hill</td>
      <td>43.763573</td>
      <td>-79.188711</td>
    </tr>
    <tr>
      <th>19</th>
      <td>M4E</td>
      <td>East Toronto</td>
      <td>The Beaches</td>
      <td>43.676357</td>
      <td>-79.293031</td>
    </tr>
    <tr>
      <th>20</th>
      <td>M5E</td>
      <td>Downtown Toronto</td>
      <td>Berczy Park</td>
      <td>43.644771</td>
      <td>-79.373306</td>
    </tr>
    <tr>
      <th>21</th>
      <td>M6E</td>
      <td>York</td>
      <td>Caledonia-Fairbanks</td>
      <td>43.689026</td>
      <td>-79.453512</td>
    </tr>
    <tr>
      <th>22</th>
      <td>M1G</td>
      <td>Scarborough</td>
      <td>Woburn</td>
      <td>43.770992</td>
      <td>-79.216917</td>
    </tr>
    <tr>
      <th>23</th>
      <td>M4G</td>
      <td>East York</td>
      <td>Leaside</td>
      <td>43.709060</td>
      <td>-79.363452</td>
    </tr>
    <tr>
      <th>24</th>
      <td>M5G</td>
      <td>Downtown Toronto</td>
      <td>Central Bay Street</td>
      <td>43.657952</td>
      <td>-79.387383</td>
    </tr>
    <tr>
      <th>25</th>
      <td>M6G</td>
      <td>Downtown Toronto</td>
      <td>Christie</td>
      <td>43.669542</td>
      <td>-79.422564</td>
    </tr>
    <tr>
      <th>26</th>
      <td>M1H</td>
      <td>Scarborough</td>
      <td>Cedarbrae</td>
      <td>43.773136</td>
      <td>-79.239476</td>
    </tr>
    <tr>
      <th>27</th>
      <td>M2H</td>
      <td>North York</td>
      <td>Hillcrest Village</td>
      <td>43.803762</td>
      <td>-79.363452</td>
    </tr>
    <tr>
      <th>28</th>
      <td>M3H</td>
      <td>North York</td>
      <td>Bathurst Manor,Downsview North,Wilson Heights</td>
      <td>43.754328</td>
      <td>-79.442259</td>
    </tr>
    <tr>
      <th>29</th>
      <td>M4H</td>
      <td>East York</td>
      <td>Thorncliffe Park</td>
      <td>43.705369</td>
      <td>-79.349372</td>
    </tr>
    <tr>
      <th>30</th>
      <td>M5H</td>
      <td>Downtown Toronto</td>
      <td>Adelaide,King,Richmond</td>
      <td>43.650571</td>
      <td>-79.384568</td>
    </tr>
    <tr>
      <th>31</th>
      <td>M6H</td>
      <td>West Toronto</td>
      <td>Dovercourt Village,Dufferin</td>
      <td>43.669005</td>
      <td>-79.442259</td>
    </tr>
    <tr>
      <th>32</th>
      <td>M1J</td>
      <td>Scarborough</td>
      <td>Scarborough Village</td>
      <td>43.744734</td>
      <td>-79.239476</td>
    </tr>
    <tr>
      <th>33</th>
      <td>M2J</td>
      <td>North York</td>
      <td>Fairview,Henry Farm,Oriole</td>
      <td>43.778517</td>
      <td>-79.346556</td>
    </tr>
    <tr>
      <th>34</th>
      <td>M3J</td>
      <td>North York</td>
      <td>Northwood Park,York University</td>
      <td>43.767980</td>
      <td>-79.487262</td>
    </tr>
    <tr>
      <th>35</th>
      <td>M4J</td>
      <td>East York</td>
      <td>East Toronto</td>
      <td>43.685347</td>
      <td>-79.338106</td>
    </tr>
    <tr>
      <th>36</th>
      <td>M5J</td>
      <td>Downtown Toronto</td>
      <td>Harbourfront East,Toronto Islands,Union Station</td>
      <td>43.640816</td>
      <td>-79.381752</td>
    </tr>
    <tr>
      <th>37</th>
      <td>M6J</td>
      <td>West Toronto</td>
      <td>Little Portugal,Trinity</td>
      <td>43.647927</td>
      <td>-79.419750</td>
    </tr>
    <tr>
      <th>38</th>
      <td>M1K</td>
      <td>Scarborough</td>
      <td>East Birchmount Park,Ionview,Kennedy Park</td>
      <td>43.727929</td>
      <td>-79.262029</td>
    </tr>
    <tr>
      <th>39</th>
      <td>M2K</td>
      <td>North York</td>
      <td>Bayview Village</td>
      <td>43.786947</td>
      <td>-79.385975</td>
    </tr>
    <tr>
      <th>40</th>
      <td>M3K</td>
      <td>North York</td>
      <td>CFB Toronto,Downsview East</td>
      <td>43.737473</td>
      <td>-79.464763</td>
    </tr>
    <tr>
      <th>41</th>
      <td>M4K</td>
      <td>East Toronto</td>
      <td>The Danforth West,Riverdale</td>
      <td>43.679557</td>
      <td>-79.352188</td>
    </tr>
    <tr>
      <th>42</th>
      <td>M5K</td>
      <td>Downtown Toronto</td>
      <td>Design Exchange,Toronto Dominion Centre</td>
      <td>43.647177</td>
      <td>-79.381576</td>
    </tr>
    <tr>
      <th>43</th>
      <td>M6K</td>
      <td>West Toronto</td>
      <td>Brockton,Exhibition Place,Parkdale Village</td>
      <td>43.636847</td>
      <td>-79.428191</td>
    </tr>
    <tr>
      <th>44</th>
      <td>M1L</td>
      <td>Scarborough</td>
      <td>Clairlea,Golden Mile,Oakridge</td>
      <td>43.711112</td>
      <td>-79.284577</td>
    </tr>
    <tr>
      <th>45</th>
      <td>M2L</td>
      <td>North York</td>
      <td>Silver Hills,York Mills</td>
      <td>43.757490</td>
      <td>-79.374714</td>
    </tr>
    <tr>
      <th>46</th>
      <td>M3L</td>
      <td>North York</td>
      <td>Downsview West</td>
      <td>43.739015</td>
      <td>-79.506944</td>
    </tr>
    <tr>
      <th>47</th>
      <td>M4L</td>
      <td>East Toronto</td>
      <td>The Beaches West,India Bazaar</td>
      <td>43.668999</td>
      <td>-79.315572</td>
    </tr>
    <tr>
      <th>48</th>
      <td>M5L</td>
      <td>Downtown Toronto</td>
      <td>Commerce Court,Victoria Hotel</td>
      <td>43.648198</td>
      <td>-79.379817</td>
    </tr>
    <tr>
      <th>49</th>
      <td>M6L</td>
      <td>North York</td>
      <td>Downsview,North Park,Upwood Park</td>
      <td>43.713756</td>
      <td>-79.490074</td>
    </tr>
    <tr>
      <th>50</th>
      <td>M9L</td>
      <td>North York</td>
      <td>Humber Summit</td>
      <td>43.756303</td>
      <td>-79.565963</td>
    </tr>
    <tr>
      <th>51</th>
      <td>M1M</td>
      <td>Scarborough</td>
      <td>Cliffcrest,Cliffside,Scarborough Village West</td>
      <td>43.716316</td>
      <td>-79.239476</td>
    </tr>
    <tr>
      <th>52</th>
      <td>M2M</td>
      <td>North York</td>
      <td>Newtonbrook,Willowdale</td>
      <td>43.789053</td>
      <td>-79.408493</td>
    </tr>
    <tr>
      <th>53</th>
      <td>M3M</td>
      <td>North York</td>
      <td>Downsview Central</td>
      <td>43.728496</td>
      <td>-79.495697</td>
    </tr>
    <tr>
      <th>54</th>
      <td>M4M</td>
      <td>East Toronto</td>
      <td>Studio District</td>
      <td>43.659526</td>
      <td>-79.340923</td>
    </tr>
    <tr>
      <th>55</th>
      <td>M5M</td>
      <td>North York</td>
      <td>Bedford Park,Lawrence Manor East</td>
      <td>43.733283</td>
      <td>-79.419750</td>
    </tr>
    <tr>
      <th>56</th>
      <td>M6M</td>
      <td>York</td>
      <td>Del Ray,Keelesdale,Mount Dennis,Silverthorn</td>
      <td>43.691116</td>
      <td>-79.476013</td>
    </tr>
    <tr>
      <th>57</th>
      <td>M9M</td>
      <td>North York</td>
      <td>Emery,Humberlea</td>
      <td>43.724766</td>
      <td>-79.532242</td>
    </tr>
    <tr>
      <th>58</th>
      <td>M1N</td>
      <td>Scarborough</td>
      <td>Birch Cliff,Cliffside West</td>
      <td>43.692657</td>
      <td>-79.264848</td>
    </tr>
    <tr>
      <th>59</th>
      <td>M2N</td>
      <td>North York</td>
      <td>Willowdale South</td>
      <td>43.770120</td>
      <td>-79.408493</td>
    </tr>
    <tr>
      <th>60</th>
      <td>M3N</td>
      <td>North York</td>
      <td>Downsview Northwest</td>
      <td>43.761631</td>
      <td>-79.520999</td>
    </tr>
    <tr>
      <th>61</th>
      <td>M4N</td>
      <td>Central Toronto</td>
      <td>Lawrence Park</td>
      <td>43.728020</td>
      <td>-79.388790</td>
    </tr>
    <tr>
      <th>62</th>
      <td>M5N</td>
      <td>Central Toronto</td>
      <td>Roselawn</td>
      <td>43.711695</td>
      <td>-79.416936</td>
    </tr>
    <tr>
      <th>63</th>
      <td>M6N</td>
      <td>York</td>
      <td>The Junction North,Runnymede</td>
      <td>43.673185</td>
      <td>-79.487262</td>
    </tr>
    <tr>
      <th>64</th>
      <td>M9N</td>
      <td>York</td>
      <td>Weston</td>
      <td>43.706876</td>
      <td>-79.518188</td>
    </tr>
    <tr>
      <th>65</th>
      <td>M1P</td>
      <td>Scarborough</td>
      <td>Dorset Park,Scarborough Town Centre,Wexford He...</td>
      <td>43.757410</td>
      <td>-79.273304</td>
    </tr>
    <tr>
      <th>66</th>
      <td>M2P</td>
      <td>North York</td>
      <td>York Mills West</td>
      <td>43.752758</td>
      <td>-79.400049</td>
    </tr>
    <tr>
      <th>67</th>
      <td>M4P</td>
      <td>Central Toronto</td>
      <td>Davisville North</td>
      <td>43.712751</td>
      <td>-79.390197</td>
    </tr>
    <tr>
      <th>68</th>
      <td>M5P</td>
      <td>Central Toronto</td>
      <td>Forest Hill North,Forest Hill West</td>
      <td>43.696948</td>
      <td>-79.411307</td>
    </tr>
    <tr>
      <th>69</th>
      <td>M6P</td>
      <td>West Toronto</td>
      <td>High Park,The Junction South</td>
      <td>43.661608</td>
      <td>-79.464763</td>
    </tr>
    <tr>
      <th>70</th>
      <td>M9P</td>
      <td>Etobicoke</td>
      <td>Westmount</td>
      <td>43.696319</td>
      <td>-79.532242</td>
    </tr>
    <tr>
      <th>71</th>
      <td>M1R</td>
      <td>Scarborough</td>
      <td>Maryvale,Wexford</td>
      <td>43.750072</td>
      <td>-79.295849</td>
    </tr>
    <tr>
      <th>72</th>
      <td>M2R</td>
      <td>North York</td>
      <td>Willowdale West</td>
      <td>43.782736</td>
      <td>-79.442259</td>
    </tr>
    <tr>
      <th>73</th>
      <td>M4R</td>
      <td>Central Toronto</td>
      <td>North Toronto West</td>
      <td>43.715383</td>
      <td>-79.405678</td>
    </tr>
    <tr>
      <th>74</th>
      <td>M5R</td>
      <td>Central Toronto</td>
      <td>The Annex,North Midtown,Yorkville</td>
      <td>43.672710</td>
      <td>-79.405678</td>
    </tr>
    <tr>
      <th>75</th>
      <td>M6R</td>
      <td>West Toronto</td>
      <td>Parkdale,Roncesvalles</td>
      <td>43.648960</td>
      <td>-79.456325</td>
    </tr>
    <tr>
      <th>76</th>
      <td>M7R</td>
      <td>Mississauga</td>
      <td>Canada Post Gateway Processing Centre</td>
      <td>43.636966</td>
      <td>-79.615819</td>
    </tr>
    <tr>
      <th>77</th>
      <td>M9R</td>
      <td>Etobicoke</td>
      <td>Kingsview Village,Martin Grove Gardens,Richvie...</td>
      <td>43.688905</td>
      <td>-79.554724</td>
    </tr>
    <tr>
      <th>78</th>
      <td>M1S</td>
      <td>Scarborough</td>
      <td>Agincourt</td>
      <td>43.794200</td>
      <td>-79.262029</td>
    </tr>
    <tr>
      <th>79</th>
      <td>M4S</td>
      <td>Central Toronto</td>
      <td>Davisville</td>
      <td>43.704324</td>
      <td>-79.388790</td>
    </tr>
    <tr>
      <th>80</th>
      <td>M5S</td>
      <td>Downtown Toronto</td>
      <td>Harbord,University of Toronto</td>
      <td>43.662696</td>
      <td>-79.400049</td>
    </tr>
    <tr>
      <th>81</th>
      <td>M6S</td>
      <td>West Toronto</td>
      <td>Runnymede,Swansea</td>
      <td>43.651571</td>
      <td>-79.484450</td>
    </tr>
    <tr>
      <th>82</th>
      <td>M1T</td>
      <td>Scarborough</td>
      <td>Clarks Corners,Sullivan,Tam O'Shanter</td>
      <td>43.781638</td>
      <td>-79.304302</td>
    </tr>
    <tr>
      <th>83</th>
      <td>M4T</td>
      <td>Central Toronto</td>
      <td>Moore Park,Summerhill East</td>
      <td>43.689574</td>
      <td>-79.383160</td>
    </tr>
    <tr>
      <th>84</th>
      <td>M5T</td>
      <td>Downtown Toronto</td>
      <td>Chinatown,Grange Park,Kensington Market</td>
      <td>43.653206</td>
      <td>-79.400049</td>
    </tr>
    <tr>
      <th>85</th>
      <td>M1V</td>
      <td>Scarborough</td>
      <td>Agincourt North,L'Amoreaux East,Milliken,Steel...</td>
      <td>43.815252</td>
      <td>-79.284577</td>
    </tr>
    <tr>
      <th>86</th>
      <td>M4V</td>
      <td>Central Toronto</td>
      <td>Deer Park,Forest Hill SE,Rathnelly,South Hill,...</td>
      <td>43.686412</td>
      <td>-79.400049</td>
    </tr>
    <tr>
      <th>87</th>
      <td>M5V</td>
      <td>Downtown Toronto</td>
      <td>CN Tower,Bathurst Quay,Island airport,Harbourf...</td>
      <td>43.628947</td>
      <td>-79.394420</td>
    </tr>
    <tr>
      <th>88</th>
      <td>M8V</td>
      <td>Etobicoke</td>
      <td>Humber Bay Shores,Mimico South,New Toronto</td>
      <td>43.605647</td>
      <td>-79.501321</td>
    </tr>
    <tr>
      <th>89</th>
      <td>M9V</td>
      <td>Etobicoke</td>
      <td>Albion Gardens,Beaumond Heights,Humbergate,Jam...</td>
      <td>43.739416</td>
      <td>-79.588437</td>
    </tr>
    <tr>
      <th>90</th>
      <td>M1W</td>
      <td>Scarborough</td>
      <td>L'Amoreaux West</td>
      <td>43.799525</td>
      <td>-79.318389</td>
    </tr>
    <tr>
      <th>91</th>
      <td>M4W</td>
      <td>Downtown Toronto</td>
      <td>Rosedale</td>
      <td>43.679563</td>
      <td>-79.377529</td>
    </tr>
    <tr>
      <th>92</th>
      <td>M5W</td>
      <td>Downtown Toronto</td>
      <td>Stn A PO Boxes 25 The Esplanade</td>
      <td>43.646435</td>
      <td>-79.374846</td>
    </tr>
    <tr>
      <th>93</th>
      <td>M8W</td>
      <td>Etobicoke</td>
      <td>Alderwood,Long Branch</td>
      <td>43.602414</td>
      <td>-79.543484</td>
    </tr>
    <tr>
      <th>94</th>
      <td>M9W</td>
      <td>Etobicoke</td>
      <td>Northwest</td>
      <td>43.706748</td>
      <td>-79.594054</td>
    </tr>
    <tr>
      <th>95</th>
      <td>M1X</td>
      <td>Scarborough</td>
      <td>Upper Rouge</td>
      <td>43.836125</td>
      <td>-79.205636</td>
    </tr>
    <tr>
      <th>96</th>
      <td>M4X</td>
      <td>Downtown Toronto</td>
      <td>Cabbagetown,St. James Town</td>
      <td>43.667967</td>
      <td>-79.367675</td>
    </tr>
    <tr>
      <th>97</th>
      <td>M5X</td>
      <td>Downtown Toronto</td>
      <td>First Canadian Place,Underground city</td>
      <td>43.648429</td>
      <td>-79.382280</td>
    </tr>
    <tr>
      <th>98</th>
      <td>M8X</td>
      <td>Etobicoke</td>
      <td>The Kingsway,Montgomery Road,Old Mill North</td>
      <td>43.653654</td>
      <td>-79.506944</td>
    </tr>
    <tr>
      <th>99</th>
      <td>M4Y</td>
      <td>Downtown Toronto</td>
      <td>Church and Wellesley</td>
      <td>43.665860</td>
      <td>-79.383160</td>
    </tr>
    <tr>
      <th>100</th>
      <td>M7Y</td>
      <td>East Toronto</td>
      <td>Business Reply Mail Processing Centre 969 Eastern</td>
      <td>43.662744</td>
      <td>-79.321558</td>
    </tr>
    <tr>
      <th>101</th>
      <td>M8Y</td>
      <td>Etobicoke</td>
      <td>Humber Bay,King's Mill Park,Kingsway Park Sout...</td>
      <td>43.636258</td>
      <td>-79.498509</td>
    </tr>
    <tr>
      <th>102</th>
      <td>M8Z</td>
      <td>Etobicoke</td>
      <td>Kingsway Park South West,Mimico NW,The Queensw...</td>
      <td>43.628841</td>
      <td>-79.520999</td>
    </tr>
  </tbody>
</table>
</div>




```python
import numpy as np # library to handle data in a vectorized manner

import pandas as pd # library for data analsysis
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)

import json # library to handle JSON files

#!conda install -c conda-forge geopy --yes # uncomment this line if you haven't completed the Foursquare API lab
from geopy.geocoders import Nominatim # convert an address into latitude and longitude values

import requests # library to handle requests
from pandas.io.json import json_normalize # tranform JSON file into a pandas dataframe

# Matplotlib and associated plotting modules
import matplotlib.cm as cm
import matplotlib.colors as colors

# import k-means from clustering stage
from sklearn.cluster import KMeans

#!conda install -c conda-forge folium=0.5.0 --yes # uncomment this line if you haven't completed the Foursquare API lab
import folium # map rendering library

print('Libraries imported.')

neighborhoods = pd.merge(df_new, df_geo, left_on = "Postcode", right_on = "Postal Code").drop(["Postal Code"], axis = 1)

print('The dataframe has {} boroughs and {} neighborhoods.'.format(
        len(neighborhoods['Borough'].unique()),
        neighborhoods.shape[0]
    )
)
```

    Libraries imported.
    The dataframe has 11 boroughs and 103 neighborhoods.
    


```python
# create map of New York using latitude and longitude values

map_Toronto = folium.Map(location=[neighborhoods.Latitude.mean(), neighborhoods.Longitude.mean()], zoom_start=10)

# add markers to map
for lat, lng, borough, neighborhood in zip(neighborhoods['Latitude'], neighborhoods['Longitude'], neighborhoods['Borough'], neighborhoods['Neighbourhood']):
    label = '{}, {}'.format(neighborhood, borough)
    label = folium.Popup(label, parse_html=True)
    folium.CircleMarker(
        [lat, lng],
        radius=5,
        popup=label,
        color='blue',
        fill=True,
        fill_color='#3186cc',
        fill_opacity=0.7,
        parse_html=False).add_to(map_Toronto)  
    
map_Toronto
```




<div style="width:100%;"><div style="position:relative;width:100%;height:0;padding-bottom:60%;"><iframe src="data:text/html;charset=utf-8;base64,PCFET0NUWVBFIGh0bWw+CjxoZWFkPiAgICAKICAgIDxtZXRhIGh0dHAtZXF1aXY9ImNvbnRlbnQtdHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04IiAvPgogICAgPHNjcmlwdD5MX1BSRUZFUl9DQU5WQVMgPSBmYWxzZTsgTF9OT19UT1VDSCA9IGZhbHNlOyBMX0RJU0FCTEVfM0QgPSBmYWxzZTs8L3NjcmlwdD4KICAgIDxzY3JpcHQgc3JjPSJodHRwczovL2Nkbi5qc2RlbGl2ci5uZXQvbnBtL2xlYWZsZXRAMS4yLjAvZGlzdC9sZWFmbGV0LmpzIj48L3NjcmlwdD4KICAgIDxzY3JpcHQgc3JjPSJodHRwczovL2FqYXguZ29vZ2xlYXBpcy5jb20vYWpheC9saWJzL2pxdWVyeS8xLjExLjEvanF1ZXJ5Lm1pbi5qcyI+PC9zY3JpcHQ+CiAgICA8c2NyaXB0IHNyYz0iaHR0cHM6Ly9tYXhjZG4uYm9vdHN0cmFwY2RuLmNvbS9ib290c3RyYXAvMy4yLjAvanMvYm9vdHN0cmFwLm1pbi5qcyI+PC9zY3JpcHQ+CiAgICA8c2NyaXB0IHNyYz0iaHR0cHM6Ly9jZG5qcy5jbG91ZGZsYXJlLmNvbS9hamF4L2xpYnMvTGVhZmxldC5hd2Vzb21lLW1hcmtlcnMvMi4wLjIvbGVhZmxldC5hd2Vzb21lLW1hcmtlcnMuanMiPjwvc2NyaXB0PgogICAgPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL2Nkbi5qc2RlbGl2ci5uZXQvbnBtL2xlYWZsZXRAMS4yLjAvZGlzdC9sZWFmbGV0LmNzcyIvPgogICAgPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL21heGNkbi5ib290c3RyYXBjZG4uY29tL2Jvb3RzdHJhcC8zLjIuMC9jc3MvYm9vdHN0cmFwLm1pbi5jc3MiLz4KICAgIDxsaW5rIHJlbD0ic3R5bGVzaGVldCIgaHJlZj0iaHR0cHM6Ly9tYXhjZG4uYm9vdHN0cmFwY2RuLmNvbS9ib290c3RyYXAvMy4yLjAvY3NzL2Jvb3RzdHJhcC10aGVtZS5taW4uY3NzIi8+CiAgICA8bGluayByZWw9InN0eWxlc2hlZXQiIGhyZWY9Imh0dHBzOi8vbWF4Y2RuLmJvb3RzdHJhcGNkbi5jb20vZm9udC1hd2Vzb21lLzQuNi4zL2Nzcy9mb250LWF3ZXNvbWUubWluLmNzcyIvPgogICAgPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL2NkbmpzLmNsb3VkZmxhcmUuY29tL2FqYXgvbGlicy9MZWFmbGV0LmF3ZXNvbWUtbWFya2Vycy8yLjAuMi9sZWFmbGV0LmF3ZXNvbWUtbWFya2Vycy5jc3MiLz4KICAgIDxsaW5rIHJlbD0ic3R5bGVzaGVldCIgaHJlZj0iaHR0cHM6Ly9yYXdnaXQuY29tL3B5dGhvbi12aXN1YWxpemF0aW9uL2ZvbGl1bS9tYXN0ZXIvZm9saXVtL3RlbXBsYXRlcy9sZWFmbGV0LmF3ZXNvbWUucm90YXRlLmNzcyIvPgogICAgPHN0eWxlPmh0bWwsIGJvZHkge3dpZHRoOiAxMDAlO2hlaWdodDogMTAwJTttYXJnaW46IDA7cGFkZGluZzogMDt9PC9zdHlsZT4KICAgIDxzdHlsZT4jbWFwIHtwb3NpdGlvbjphYnNvbHV0ZTt0b3A6MDtib3R0b206MDtyaWdodDowO2xlZnQ6MDt9PC9zdHlsZT4KICAgIAogICAgICAgICAgICA8c3R5bGU+ICNtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUgewogICAgICAgICAgICAgICAgcG9zaXRpb24gOiByZWxhdGl2ZTsKICAgICAgICAgICAgICAgIHdpZHRoIDogMTAwLjAlOwogICAgICAgICAgICAgICAgaGVpZ2h0OiAxMDAuMCU7CiAgICAgICAgICAgICAgICBsZWZ0OiAwLjAlOwogICAgICAgICAgICAgICAgdG9wOiAwLjAlOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICA8L3N0eWxlPgogICAgICAgIAo8L2hlYWQ+Cjxib2R5PiAgICAKICAgIAogICAgICAgICAgICA8ZGl2IGNsYXNzPSJmb2xpdW0tbWFwIiBpZD0ibWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1IiA+PC9kaXY+CiAgICAgICAgCjwvYm9keT4KPHNjcmlwdD4gICAgCiAgICAKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGJvdW5kcyA9IG51bGw7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgdmFyIG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSA9IEwubWFwKAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ21hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNScsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7Y2VudGVyOiBbNDMuNzA0NjA3NzMzOTgwNTksLTc5LjM5NzE1MjkxMTY1MDQ4XSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHpvb206IDEwLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWF4Qm91bmRzOiBib3VuZHMsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsYXllcnM6IFtdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd29ybGRDb3B5SnVtcDogZmFsc2UsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcnM6IEwuQ1JTLkVQU0czODU3CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0pOwogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgdGlsZV9sYXllcl9iZmVlNzc0M2ExMWY0OTdmYmEwMTc3ZTM4ZGExNTRiZCA9IEwudGlsZUxheWVyKAogICAgICAgICAgICAgICAgJ2h0dHBzOi8ve3N9LnRpbGUub3BlbnN0cmVldG1hcC5vcmcve3p9L3t4fS97eX0ucG5nJywKICAgICAgICAgICAgICAgIHsKICAiYXR0cmlidXRpb24iOiBudWxsLAogICJkZXRlY3RSZXRpbmEiOiBmYWxzZSwKICAibWF4Wm9vbSI6IDE4LAogICJtaW5ab29tIjogMSwKICAibm9XcmFwIjogZmFsc2UsCiAgInN1YmRvbWFpbnMiOiAiYWJjIgp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMGEzMzY4ZGJhOThkNDZkY2JkYjgzODBiMWNjZjhlMTcgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NTMyNTg2LC03OS4zMjk2NTY1XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2JiOTJiYTYxMjg4NTQ4ZjM4ODMxYTk1NTg2NWQyOTI2ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2M4MGU2YmY4OGQwNzRhNTFhOWZlNDhlZWNmYjJhYjVlID0gJCgnPGRpdiBpZD0iaHRtbF9jODBlNmJmODhkMDc0YTUxYTlmZTQ4ZWVjZmIyYWI1ZSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+UGFya3dvb2RzLCBOb3J0aCBZb3JrPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9iYjkyYmE2MTI4ODU0OGYzODgzMWE5NTU4NjVkMjkyNi5zZXRDb250ZW50KGh0bWxfYzgwZTZiZjg4ZDA3NGE1MWE5ZmU0OGVlY2ZiMmFiNWUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMGEzMzY4ZGJhOThkNDZkY2JkYjgzODBiMWNjZjhlMTcuYmluZFBvcHVwKHBvcHVwX2JiOTJiYTYxMjg4NTQ4ZjM4ODMxYTk1NTg2NWQyOTI2KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2MwZTVmYjY2MzFjYzRlNGQ5NzNhNDhjZTE0MzgzNTg5ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzI1ODgyMjk5OTk5OTk1LC03OS4zMTU1NzE1OTk5OTk5OF0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF82OTYzOWQ3Y2U3YTI0ZDNjYWVmOTJhNzE3OTA2YTA0NyA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF85ZWM3NWM0YWE4YTY0MzcwYjQ2MjFiYzg2ZDY2NTQ3OSA9ICQoJzxkaXYgaWQ9Imh0bWxfOWVjNzVjNGFhOGE2NDM3MGI0NjIxYmM4NmQ2NjU0NzkiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlZpY3RvcmlhIFZpbGxhZ2UsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzY5NjM5ZDdjZTdhMjRkM2NhZWY5MmE3MTc5MDZhMDQ3LnNldENvbnRlbnQoaHRtbF85ZWM3NWM0YWE4YTY0MzcwYjQ2MjFiYzg2ZDY2NTQ3OSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9jMGU1ZmI2NjMxY2M0ZTRkOTczYTQ4Y2UxNDM4MzU4OS5iaW5kUG9wdXAocG9wdXBfNjk2MzlkN2NlN2EyNGQzY2FlZjkyYTcxNzkwNmEwNDcpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNDIwNTg4YWY1ZDk2NDhjM2JkYWU5MGI2ODQ0ZGYwM2MgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NTQyNTk5LC03OS4zNjA2MzU5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2RlNTk1ZmZiNTA3ZTRmYzU5YjRmNTQ4N2Y2ZTQ1MzM5ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzljMGM3ODE3Mzk1ZTQzZGJiYzAwZGNhMjYzMWUxMzZmID0gJCgnPGRpdiBpZD0iaHRtbF85YzBjNzgxNzM5NWU0M2RiYmMwMGRjYTI2MzFlMTM2ZiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+SGFyYm91cmZyb250LFJlZ2VudCBQYXJrLCBEb3dudG93biBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9kZTU5NWZmYjUwN2U0ZmM1OWI0ZjU0ODdmNmU0NTMzOS5zZXRDb250ZW50KGh0bWxfOWMwYzc4MTczOTVlNDNkYmJjMDBkY2EyNjMxZTEzNmYpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNDIwNTg4YWY1ZDk2NDhjM2JkYWU5MGI2ODQ0ZGYwM2MuYmluZFBvcHVwKHBvcHVwX2RlNTk1ZmZiNTA3ZTRmYzU5YjRmNTQ4N2Y2ZTQ1MzM5KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2Y1MDViNTA5ODRkODRmMGJhMTJkOGU3YjBhMzQ2YzZiID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzE4NTE3OTk5OTk5OTk2LC03OS40NjQ3NjMyOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9jOTY4YWY2Yjk0M2U0MmU3YTc0ZThhODdhMjgwMmE3MiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8wM2Y0MjE4YWMxYzA0MmIwYmNlNDkyODFmZDVmMzdkMCA9ICQoJzxkaXYgaWQ9Imh0bWxfMDNmNDIxOGFjMWMwNDJiMGJjZTQ5MjgxZmQ1ZjM3ZDAiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkxhd3JlbmNlIEhlaWdodHMsTGF3cmVuY2UgTWFub3IsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2M5NjhhZjZiOTQzZTQyZTdhNzRlOGE4N2EyODAyYTcyLnNldENvbnRlbnQoaHRtbF8wM2Y0MjE4YWMxYzA0MmIwYmNlNDkyODFmZDVmMzdkMCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9mNTA1YjUwOTg0ZDg0ZjBiYTEyZDhlN2IwYTM0NmM2Yi5iaW5kUG9wdXAocG9wdXBfYzk2OGFmNmI5NDNlNDJlN2E3NGU4YTg3YTI4MDJhNzIpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYzZmYTk4MDYzZDczNDE2ZmIxOTgxYjAxZTExMGZjOWMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NjIzMDE1LC03OS4zODk0OTM4XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzI4ZmZmZTEzMGY3NDRmYTk4NWEyZDYzZGZlY2VkNzU5ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzdjOWRiZmU0OTc4ZjQwZTNhMGUyNTAxYTJjOWM4NGVjID0gJCgnPGRpdiBpZD0iaHRtbF83YzlkYmZlNDk3OGY0MGUzYTBlMjUwMWEyYzljODRlYyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+UXVlZW4mIzM5O3MgUGFyaywgUXVlZW4mIzM5O3MgUGFyazwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMjhmZmZlMTMwZjc0NGZhOTg1YTJkNjNkZmVjZWQ3NTkuc2V0Q29udGVudChodG1sXzdjOWRiZmU0OTc4ZjQwZTNhMGUyNTAxYTJjOWM4NGVjKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2M2ZmE5ODA2M2Q3MzQxNmZiMTk4MWIwMWUxMTBmYzljLmJpbmRQb3B1cChwb3B1cF8yOGZmZmUxMzBmNzQ0ZmE5ODVhMmQ2M2RmZWNlZDc1OSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl85NjU0ZDRjYmYzZjk0MWZhOTYxOGEzYTcyNDg5YzBlOSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2Nzg1NTYsLTc5LjUzMjI0MjQwMDAwMDAyXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzVmZmI0NTk2Yjc3YjQ3NWU5M2YyNTIwNTljNTJlYWM2ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzhlNmU3M2RhY2M1ZDQ3OTJhZmIxOWE3ZDUzNDRmYjJmID0gJCgnPGRpdiBpZD0iaHRtbF84ZTZlNzNkYWNjNWQ0NzkyYWZiMTlhN2Q1MzQ0ZmIyZiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+SXNsaW5ndG9uIEF2ZW51ZSwgRXRvYmljb2tlPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF81ZmZiNDU5NmI3N2I0NzVlOTNmMjUyMDU5YzUyZWFjNi5zZXRDb250ZW50KGh0bWxfOGU2ZTczZGFjYzVkNDc5MmFmYjE5YTdkNTM0NGZiMmYpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfOTY1NGQ0Y2JmM2Y5NDFmYTk2MThhM2E3MjQ4OWMwZTkuYmluZFBvcHVwKHBvcHVwXzVmZmI0NTk2Yjc3YjQ3NWU5M2YyNTIwNTljNTJlYWM2KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2NjZmMxZjM4NDlhMTQzYjliMjQyNTg4YzBkMTY0N2FkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuODA2Njg2Mjk5OTk5OTk2LC03OS4xOTQzNTM0MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF80NGY3ZTNhM2ZhZWE0ZjI5Yjc4NjE0YmEwYTliYzE5OSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8xYWRhYjg0MWM0NzU0M2M3ODdjMTFjMjM0MWZjYmMwZSA9ICQoJzxkaXYgaWQ9Imh0bWxfMWFkYWI4NDFjNDc1NDNjNzg3YzExYzIzNDFmY2JjMGUiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlJvdWdlLE1hbHZlcm4sIFNjYXJib3JvdWdoPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF80NGY3ZTNhM2ZhZWE0ZjI5Yjc4NjE0YmEwYTliYzE5OS5zZXRDb250ZW50KGh0bWxfMWFkYWI4NDFjNDc1NDNjNzg3YzExYzIzNDFmY2JjMGUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfY2NmYzFmMzg0OWExNDNiOWIyNDI1ODhjMGQxNjQ3YWQuYmluZFBvcHVwKHBvcHVwXzQ0ZjdlM2EzZmFlYTRmMjliNzg2MTRiYTBhOWJjMTk5KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2EzMzA1MmQzMGM5MTQ1Njg4OWM0NmU1OGY2ZjY2NDYwID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzQ1OTA1Nzk5OTk5OTk2LC03OS4zNTIxODhdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMTZkODAwMmI0OGQ0NDA5Mzg2OGM5NWYzMzRmYjU4OWMgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZDAzYzBlMWJmYjc2NDA5ZDg1ZjdjMGI5NmUzNjM5NzkgPSAkKCc8ZGl2IGlkPSJodG1sX2QwM2MwZTFiZmI3NjQwOWQ4NWY3YzBiOTZlMzYzOTc5IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Eb24gTWlsbHMgTm9ydGgsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzE2ZDgwMDJiNDhkNDQwOTM4NjhjOTVmMzM0ZmI1ODljLnNldENvbnRlbnQoaHRtbF9kMDNjMGUxYmZiNzY0MDlkODVmN2MwYjk2ZTM2Mzk3OSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9hMzMwNTJkMzBjOTE0NTY4ODljNDZlNThmNmY2NjQ2MC5iaW5kUG9wdXAocG9wdXBfMTZkODAwMmI0OGQ0NDA5Mzg2OGM5NWYzMzRmYjU4OWMpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYzZhZWYwMjlhODc5NDM1NzkwM2MxNzQyZjVlZGM5NmIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MDYzOTcyLC03OS4zMDk5MzddLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNTljY2U2Mjk3OTgyNGVkNTg5M2IxMTUwNDg3M2VjZjggPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfN2E2NDUxYjdhNzQxNDBiMmJhYzU3MWIyNmU5NDhhZTcgPSAkKCc8ZGl2IGlkPSJodG1sXzdhNjQ1MWI3YTc0MTQwYjJiYWM1NzFiMjZlOTQ4YWU3IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Xb29kYmluZSBHYXJkZW5zLFBhcmt2aWV3IEhpbGwsIEVhc3QgWW9yazwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNTljY2U2Mjk3OTgyNGVkNTg5M2IxMTUwNDg3M2VjZjguc2V0Q29udGVudChodG1sXzdhNjQ1MWI3YTc0MTQwYjJiYWM1NzFiMjZlOTQ4YWU3KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2M2YWVmMDI5YTg3OTQzNTc5MDNjMTc0MmY1ZWRjOTZiLmJpbmRQb3B1cChwb3B1cF81OWNjZTYyOTc5ODI0ZWQ1ODkzYjExNTA0ODczZWNmOCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl83OTVjOTQ5NDUyZTA0N2NkYTYxMTQ4MTRhNmQ3YzUzZiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY1NzE2MTgsLTc5LjM3ODkzNzA5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzkxMDE5YTcyNTI4ZTQ4OTY4NmE2NTEyZDMwZDIxOTQ3ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2U0NzQyN2Q1MDI3MDRlN2FiYTZiNmE1YWI0NDBmZGYyID0gJCgnPGRpdiBpZD0iaHRtbF9lNDc0MjdkNTAyNzA0ZTdhYmE2YjZhNWFiNDQwZmRmMiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+UnllcnNvbixHYXJkZW4gRGlzdHJpY3QsIERvd250b3duIFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzkxMDE5YTcyNTI4ZTQ4OTY4NmE2NTEyZDMwZDIxOTQ3LnNldENvbnRlbnQoaHRtbF9lNDc0MjdkNTAyNzA0ZTdhYmE2YjZhNWFiNDQwZmRmMik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl83OTVjOTQ5NDUyZTA0N2NkYTYxMTQ4MTRhNmQ3YzUzZi5iaW5kUG9wdXAocG9wdXBfOTEwMTlhNzI1MjhlNDg5Njg2YTY1MTJkMzBkMjE5NDcpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZWIzYjkzYTM3ZjBkNGY4ZGExNWQxYWJlNjY1NjkyZDcgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MDk1NzcsLTc5LjQ0NTA3MjU5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzAwYmViNzlhZTA3YjRmMmQ5OGE1Nzk1YzJmNzg2ZDk1ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2Y0MmY0MzdkMGYyMTQ5MzQ4YmE1NzNlMjIyOGI4ZmZmID0gJCgnPGRpdiBpZD0iaHRtbF9mNDJmNDM3ZDBmMjE0OTM0OGJhNTczZTIyMjhiOGZmZiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+R2xlbmNhaXJuLCBOb3J0aCBZb3JrPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8wMGJlYjc5YWUwN2I0ZjJkOThhNTc5NWMyZjc4NmQ5NS5zZXRDb250ZW50KGh0bWxfZjQyZjQzN2QwZjIxNDkzNDhiYTU3M2UyMjI4YjhmZmYpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZWIzYjkzYTM3ZjBkNGY4ZGExNWQxYWJlNjY1NjkyZDcuYmluZFBvcHVwKHBvcHVwXzAwYmViNzlhZTA3YjRmMmQ5OGE1Nzk1YzJmNzg2ZDk1KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2M0ODNmZDRmNmM2MzQ3MDVhMDFmZWRmZTI3Y2U5N2U4ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjUwOTQzMiwtNzkuNTU0NzI0NDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZTI3NDZjNDIyZTEyNDI3YmFiZWFmMTM4ZjQzMmMxMGIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNmQ5ZTU0NDgxMjMwNGU0YTljZjU5YTg4Nzk1ZjNhM2QgPSAkKCc8ZGl2IGlkPSJodG1sXzZkOWU1NDQ4MTIzMDRlNGE5Y2Y1OWE4ODc5NWYzYTNkIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5DbG92ZXJkYWxlLElzbGluZ3RvbixNYXJ0aW4gR3JvdmUsUHJpbmNlc3MgR2FyZGVucyxXZXN0IERlYW5lIFBhcmssIEV0b2JpY29rZTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZTI3NDZjNDIyZTEyNDI3YmFiZWFmMTM4ZjQzMmMxMGIuc2V0Q29udGVudChodG1sXzZkOWU1NDQ4MTIzMDRlNGE5Y2Y1OWE4ODc5NWYzYTNkKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2M0ODNmZDRmNmM2MzQ3MDVhMDFmZWRmZTI3Y2U5N2U4LmJpbmRQb3B1cChwb3B1cF9lMjc0NmM0MjJlMTI0MjdiYWJlYWYxMzhmNDMyYzEwYik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl80YzAzMDEyZmUwOTg0ZTc4YmJiMmU3OWUxNTc5ZTczNCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc4NDUzNTEsLTc5LjE2MDQ5NzA5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzNlZTQ4NDc3ZmU3NDRhZjM5YzM2ZTZmM2U5YmJiODUxID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2VhZjVmNTM1YWNiODQ1ODNhYzY5OTYzMjhhMTRiMTM1ID0gJCgnPGRpdiBpZD0iaHRtbF9lYWY1ZjUzNWFjYjg0NTgzYWM2OTk2MzI4YTE0YjEzNSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+SGlnaGxhbmQgQ3JlZWssUm91Z2UgSGlsbCxQb3J0IFVuaW9uLCBTY2FyYm9yb3VnaDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfM2VlNDg0NzdmZTc0NGFmMzljMzZlNmYzZTliYmI4NTEuc2V0Q29udGVudChodG1sX2VhZjVmNTM1YWNiODQ1ODNhYzY5OTYzMjhhMTRiMTM1KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzRjMDMwMTJmZTA5ODRlNzhiYmIyZTc5ZTE1NzllNzM0LmJpbmRQb3B1cChwb3B1cF8zZWU0ODQ3N2ZlNzQ0YWYzOWMzNmU2ZjNlOWJiYjg1MSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9lOWRjMTMxZjkzY2U0ZWZiYTIwZTZkY2Y2YWVmZDhjNyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcyNTg5OTcwMDAwMDAxLC03OS4zNDA5MjNdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZTNjNDkyNGNjZDczNGFhZjk0NGMxOTNkMjY1Y2E3ZGIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNzc5NDk5MjUzY2ZmNDFlZThjNTVmMmRiNGE4NmQ5ZGEgPSAkKCc8ZGl2IGlkPSJodG1sXzc3OTQ5OTI1M2NmZjQxZWU4YzU1ZjJkYjRhODZkOWRhIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5GbGVtaW5nZG9uIFBhcmssRG9uIE1pbGxzIFNvdXRoLCBOb3J0aCBZb3JrPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9lM2M0OTI0Y2NkNzM0YWFmOTQ0YzE5M2QyNjVjYTdkYi5zZXRDb250ZW50KGh0bWxfNzc5NDk5MjUzY2ZmNDFlZThjNTVmMmRiNGE4NmQ5ZGEpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZTlkYzEzMWY5M2NlNGVmYmEyMGU2ZGNmNmFlZmQ4YzcuYmluZFBvcHVwKHBvcHVwX2UzYzQ5MjRjY2Q3MzRhYWY5NDRjMTkzZDI2NWNhN2RiKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2Q2OTIzMzVhNzU4YjRhYmM4YzFjODE1MDg1NzhkZGE3ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjk1MzQzOTAwMDAwMDA1LC03OS4zMTgzODg3XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzUyNWY5Y2JkNzlkODRkOTliNjc5ZDE1YzJmNzU5Y2VlID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2U5NzlmZmU1N2QwZTQwYmE4YTMyMjYyODMxZWE0ZTFkID0gJCgnPGRpdiBpZD0iaHRtbF9lOTc5ZmZlNTdkMGU0MGJhOGEzMjI2MjgzMWVhNGUxZCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+V29vZGJpbmUgSGVpZ2h0cywgRWFzdCBZb3JrPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF81MjVmOWNiZDc5ZDg0ZDk5YjY3OWQxNWMyZjc1OWNlZS5zZXRDb250ZW50KGh0bWxfZTk3OWZmZTU3ZDBlNDBiYThhMzIyNjI4MzFlYTRlMWQpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZDY5MjMzNWE3NThiNGFiYzhjMWM4MTUwODU3OGRkYTcuYmluZFBvcHVwKHBvcHVwXzUyNWY5Y2JkNzlkODRkOTliNjc5ZDE1YzJmNzU5Y2VlKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzMwYzJjNjVhODZjNTQyYWM4YTI4NjA3NThiODIyZDc4ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjUxNDkzOSwtNzkuMzc1NDE3OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9mMzBiMWE2ZjViM2E0NDEyYTljZmExYWYxMDRhMzA3ZiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF82Zjk2YjBiMWIyYWI0ODNlYmVmZTk0MTJmZWYwMjZhYiA9ICQoJzxkaXYgaWQ9Imh0bWxfNmY5NmIwYjFiMmFiNDgzZWJlZmU5NDEyZmVmMDI2YWIiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlN0LiBKYW1lcyBUb3duLCBEb3dudG93biBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9mMzBiMWE2ZjViM2E0NDEyYTljZmExYWYxMDRhMzA3Zi5zZXRDb250ZW50KGh0bWxfNmY5NmIwYjFiMmFiNDgzZWJlZmU5NDEyZmVmMDI2YWIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMzBjMmM2NWE4NmM1NDJhYzhhMjg2MDc1OGI4MjJkNzguYmluZFBvcHVwKHBvcHVwX2YzMGIxYTZmNWIzYTQ0MTJhOWNmYTFhZjEwNGEzMDdmKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2I3NmFhMDJhMWY1ODQyMzRhOTY3YzRiYjA3NDI5ZTg3ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjkzNzgxMywtNzkuNDI4MTkxNDAwMDAwMDJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNzk1NmU4Nzk5MGJhNGY5OWJhZWY4MGViYjQ4MzEyZDUgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfN2U2NTAzYzgxNjJmNGQ5YjgyNDA3NTM1Y2RmYzIyMzUgPSAkKCc8ZGl2IGlkPSJodG1sXzdlNjUwM2M4MTYyZjRkOWI4MjQwNzUzNWNkZmMyMjM1IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5IdW1ld29vZC1DZWRhcnZhbGUsIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzc5NTZlODc5OTBiYTRmOTliYWVmODBlYmI0ODMxMmQ1LnNldENvbnRlbnQoaHRtbF83ZTY1MDNjODE2MmY0ZDliODI0MDc1MzVjZGZjMjIzNSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9iNzZhYTAyYTFmNTg0MjM0YTk2N2M0YmIwNzQyOWU4Ny5iaW5kUG9wdXAocG9wdXBfNzk1NmU4Nzk5MGJhNGY5OWJhZWY4MGViYjQ4MzEyZDUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfODVmZDIwODA1YjIwNGE1ZmJmMWIzNDQ3NTYwYzUxZWYgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NDM1MTUyLC03OS41NzcyMDA3OTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9iNDlkNzBlZWU3YzQ0ZmIzYjc4MTE2ODJkZGI3YzE3ZCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9hNzU4MmM5M2ViYTM0ZmY4Yjk2YmM3OTNlYWQ0MjczOCA9ICQoJzxkaXYgaWQ9Imh0bWxfYTc1ODJjOTNlYmEzNGZmOGI5NmJjNzkzZWFkNDI3MzgiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkJsb29yZGFsZSBHYXJkZW5zLEVyaW5nYXRlLE1hcmtsYW5kIFdvb2QsT2xkIEJ1cm5oYW10aG9ycGUsIEV0b2JpY29rZTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYjQ5ZDcwZWVlN2M0NGZiM2I3ODExNjgyZGRiN2MxN2Quc2V0Q29udGVudChodG1sX2E3NTgyYzkzZWJhMzRmZjhiOTZiYzc5M2VhZDQyNzM4KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzg1ZmQyMDgwNWIyMDRhNWZiZjFiMzQ0NzU2MGM1MWVmLmJpbmRQb3B1cChwb3B1cF9iNDlkNzBlZWU3YzQ0ZmIzYjc4MTE2ODJkZGI3YzE3ZCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl82ZmJlYTgzNDJkYjU0ZDIwYWQzZWYzZjhhZTgwM2EzZSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc2MzU3MjYsLTc5LjE4ODcxMTVdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMzFmZTQwNzI1NjM5NGI4N2E5NTY4MjJkODNiOWFjYjUgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMzI3NGMyOTY0Y2NmNGM5Yjk0NzcxZDYwZDZkOGE2NzYgPSAkKCc8ZGl2IGlkPSJodG1sXzMyNzRjMjk2NGNjZjRjOWI5NDc3MWQ2MGQ2ZDhhNjc2IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5HdWlsZHdvb2QsTW9ybmluZ3NpZGUsV2VzdCBIaWxsLCBTY2FyYm9yb3VnaDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMzFmZTQwNzI1NjM5NGI4N2E5NTY4MjJkODNiOWFjYjUuc2V0Q29udGVudChodG1sXzMyNzRjMjk2NGNjZjRjOWI5NDc3MWQ2MGQ2ZDhhNjc2KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzZmYmVhODM0MmRiNTRkMjBhZDNlZjNmOGFlODAzYTNlLmJpbmRQb3B1cChwb3B1cF8zMWZlNDA3MjU2Mzk0Yjg3YTk1NjgyMmQ4M2I5YWNiNSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl82MDkyMTQ0NDQyZGU0MTJkYmE1MGQ0MWZhZDk2ZDI3OSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY3NjM1NzM5OTk5OTk5LC03OS4yOTMwMzEyXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzAwYTcxZDdhNDljMDRmNTNiMDEwZTJjZTE1Y2FkMWU4ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2YwZTgwYWFmZDQ4YTRhYmU5YTJmMDczZDZiNGQzOGViID0gJCgnPGRpdiBpZD0iaHRtbF9mMGU4MGFhZmQ0OGE0YWJlOWEyZjA3M2Q2YjRkMzhlYiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+VGhlIEJlYWNoZXMsIEVhc3QgVG9yb250bzwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMDBhNzFkN2E0OWMwNGY1M2IwMTBlMmNlMTVjYWQxZTguc2V0Q29udGVudChodG1sX2YwZTgwYWFmZDQ4YTRhYmU5YTJmMDczZDZiNGQzOGViKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzYwOTIxNDQ0NDJkZTQxMmRiYTUwZDQxZmFkOTZkMjc5LmJpbmRQb3B1cChwb3B1cF8wMGE3MWQ3YTQ5YzA0ZjUzYjAxMGUyY2UxNWNhZDFlOCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9hZGRhYzZmOTg2YTI0ZGU1OWE0MzkwMzFiODgzZWFlZiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY0NDc3MDc5OTk5OTk5NiwtNzkuMzczMzA2NF0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8zMmMyM2ZiNWI2Y2I0M2FiYWFjYjM4OWMxOTBlY2Q4NyA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF84ZWVhZDEwOTVjZDY0ODM2YmI2ZTIwZDBmNTAwZTZiMyA9ICQoJzxkaXYgaWQ9Imh0bWxfOGVlYWQxMDk1Y2Q2NDgzNmJiNmUyMGQwZjUwMGU2YjMiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkJlcmN6eSBQYXJrLCBEb3dudG93biBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8zMmMyM2ZiNWI2Y2I0M2FiYWFjYjM4OWMxOTBlY2Q4Ny5zZXRDb250ZW50KGh0bWxfOGVlYWQxMDk1Y2Q2NDgzNmJiNmUyMGQwZjUwMGU2YjMpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYWRkYWM2Zjk4NmEyNGRlNTlhNDM5MDMxYjg4M2VhZWYuYmluZFBvcHVwKHBvcHVwXzMyYzIzZmI1YjZjYjQzYWJhYWNiMzg5YzE5MGVjZDg3KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2QwYmVlZGZiYmM0ZjQxMjY5ZjVjY2M5NTNmYzRlNWY0ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjg5MDI1NiwtNzkuNDUzNTEyXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzcyOTAyZDljZGM5OTQ2ZDY5ZmM5OWVmMDZlYzEwYTFiID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2FmMDQ1YTQ1YjhhYjRhMmRhODVhNDE4YjVlM2U2Zjk5ID0gJCgnPGRpdiBpZD0iaHRtbF9hZjA0NWE0NWI4YWI0YTJkYTg1YTQxOGI1ZTNlNmY5OSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2FsZWRvbmlhLUZhaXJiYW5rcywgWW9yazwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNzI5MDJkOWNkYzk5NDZkNjlmYzk5ZWYwNmVjMTBhMWIuc2V0Q29udGVudChodG1sX2FmMDQ1YTQ1YjhhYjRhMmRhODVhNDE4YjVlM2U2Zjk5KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2QwYmVlZGZiYmM0ZjQxMjY5ZjVjY2M5NTNmYzRlNWY0LmJpbmRQb3B1cChwb3B1cF83MjkwMmQ5Y2RjOTk0NmQ2OWZjOTllZjA2ZWMxMGExYik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8yOGUwMTUzM2EzNzU0OTNhOWMxYjVmOWE4MmU0NzcwNyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc3MDk5MjEsLTc5LjIxNjkxNzQwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2NhNjU5MjlhYzRiODQ2NmVhMzgwZGU4N2UzZDE0NDBhID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzUxNDgyMjYzNTg3ZjQwOWI5MmZkODdiMDIwNDUyYmZmID0gJCgnPGRpdiBpZD0iaHRtbF81MTQ4MjI2MzU4N2Y0MDliOTJmZDg3YjAyMDQ1MmJmZiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+V29idXJuLCBTY2FyYm9yb3VnaDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfY2E2NTkyOWFjNGI4NDY2ZWEzODBkZTg3ZTNkMTQ0MGEuc2V0Q29udGVudChodG1sXzUxNDgyMjYzNTg3ZjQwOWI5MmZkODdiMDIwNDUyYmZmKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzI4ZTAxNTMzYTM3NTQ5M2E5YzFiNWY5YTgyZTQ3NzA3LmJpbmRQb3B1cChwb3B1cF9jYTY1OTI5YWM0Yjg0NjZlYTM4MGRlODdlM2QxNDQwYSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl81YTA2ODc2YjQ0MGQ0ZmI0YTI2MWQ3Zjg2NThjNWVlNCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcwOTA2MDQsLTc5LjM2MzQ1MTddLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfOTFmNjE4MzM0MDMwNGNkYjhhYTNkM2Y4NTE5MWViZjggPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMmRkMGFiZTM3ZjM2NGM3MGFjM2Y3Y2E1YzE0NGIzZjYgPSAkKCc8ZGl2IGlkPSJodG1sXzJkZDBhYmUzN2YzNjRjNzBhYzNmN2NhNWMxNDRiM2Y2IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5MZWFzaWRlLCBFYXN0IFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzkxZjYxODMzNDAzMDRjZGI4YWEzZDNmODUxOTFlYmY4LnNldENvbnRlbnQoaHRtbF8yZGQwYWJlMzdmMzY0YzcwYWMzZjdjYTVjMTQ0YjNmNik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl81YTA2ODc2YjQ0MGQ0ZmI0YTI2MWQ3Zjg2NThjNWVlNC5iaW5kUG9wdXAocG9wdXBfOTFmNjE4MzM0MDMwNGNkYjhhYTNkM2Y4NTE5MWViZjgpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYTQ1OTlmYThiOTc4NDE0MzlmNDkwMzM0OGYwMTBkNTAgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NTc5NTI0LC03OS4zODczODI2XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzIwNWU4ZWQyNmRmZTQxNGRhNzFmYmIwNDBlMzhmNDFlID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2RlYzdhMjA4YWE4OTQwNjNhMTYwNDk2NDA1MWQ4YjFhID0gJCgnPGRpdiBpZD0iaHRtbF9kZWM3YTIwOGFhODk0MDYzYTE2MDQ5NjQwNTFkOGIxYSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2VudHJhbCBCYXkgU3RyZWV0LCBEb3dudG93biBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8yMDVlOGVkMjZkZmU0MTRkYTcxZmJiMDQwZTM4ZjQxZS5zZXRDb250ZW50KGh0bWxfZGVjN2EyMDhhYTg5NDA2M2ExNjA0OTY0MDUxZDhiMWEpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYTQ1OTlmYThiOTc4NDE0MzlmNDkwMzM0OGYwMTBkNTAuYmluZFBvcHVwKHBvcHVwXzIwNWU4ZWQyNmRmZTQxNGRhNzFmYmIwNDBlMzhmNDFlKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzA3ZTU5ODI3ZDI3MDQxYmJiYWRjMWE3NTM5NzY4NTM1ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjY5NTQyLC03OS40MjI1NjM3XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzg3MWMxODk0NmNjYTQ4ZDliMDljZjNhODYzZmRiYTE0ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2VmZjMzNTAwM2M3NjRkYTFhYTRiNGRhNTdhYmZkM2VmID0gJCgnPGRpdiBpZD0iaHRtbF9lZmYzMzUwMDNjNzY0ZGExYWE0YjRkYTU3YWJmZDNlZiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2hyaXN0aWUsIERvd250b3duIFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzg3MWMxODk0NmNjYTQ4ZDliMDljZjNhODYzZmRiYTE0LnNldENvbnRlbnQoaHRtbF9lZmYzMzUwMDNjNzY0ZGExYWE0YjRkYTU3YWJmZDNlZik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8wN2U1OTgyN2QyNzA0MWJiYmFkYzFhNzUzOTc2ODUzNS5iaW5kUG9wdXAocG9wdXBfODcxYzE4OTQ2Y2NhNDhkOWIwOWNmM2E4NjNmZGJhMTQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMWJhNjlkYjE0ZmRmNDQ5OWI3YTA1OTRkNWQwNzFhNTIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NzMxMzYsLTc5LjIzOTQ3NjA5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzk2MmIxZTA5Y2E5NjRhNTBiNWU1ZjAyNmI2N2M4NWE1ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzY1OTMyZWYwOWE0NjRkOWE5NjM5ZGFmNjAyYTY4NDY1ID0gJCgnPGRpdiBpZD0iaHRtbF82NTkzMmVmMDlhNDY0ZDlhOTYzOWRhZjYwMmE2ODQ2NSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2VkYXJicmFlLCBTY2FyYm9yb3VnaDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfOTYyYjFlMDljYTk2NGE1MGI1ZTVmMDI2YjY3Yzg1YTUuc2V0Q29udGVudChodG1sXzY1OTMyZWYwOWE0NjRkOWE5NjM5ZGFmNjAyYTY4NDY1KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzFiYTY5ZGIxNGZkZjQ0OTliN2EwNTk0ZDVkMDcxYTUyLmJpbmRQb3B1cChwb3B1cF85NjJiMWUwOWNhOTY0YTUwYjVlNWYwMjZiNjdjODVhNSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9kN2Q4OTdhNGNjNmM0MzcxYjUyNDA4OWVhZGEwOGU5ZSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjgwMzc2MjIsLTc5LjM2MzQ1MTddLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfODY0OTY5ZmU0NGM5NGRlOTgwYjYwNjU2YjNiMGYxZGQgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYTkyYTg3ZTk1OTQ2NGZiMTk5NTAwZDdiOTg2MTQ5YTEgPSAkKCc8ZGl2IGlkPSJodG1sX2E5MmE4N2U5NTk0NjRmYjE5OTUwMGQ3Yjk4NjE0OWExIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5IaWxsY3Jlc3QgVmlsbGFnZSwgTm9ydGggWW9yazwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfODY0OTY5ZmU0NGM5NGRlOTgwYjYwNjU2YjNiMGYxZGQuc2V0Q29udGVudChodG1sX2E5MmE4N2U5NTk0NjRmYjE5OTUwMGQ3Yjk4NjE0OWExKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2Q3ZDg5N2E0Y2M2YzQzNzFiNTI0MDg5ZWFkYTA4ZTllLmJpbmRQb3B1cChwb3B1cF84NjQ5NjlmZTQ0Yzk0ZGU5ODBiNjA2NTZiM2IwZjFkZCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8xODMyMThhZWY3OWE0MGUzOGNkY2RmNzBmNGFmZjM1NSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc1NDMyODMsLTc5LjQ0MjI1OTNdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfOTYwYzk2YTNiZWQ1NGU5YjgwNWFlZWJlNGZhZThiNTIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZGExYTA2MjlkNDQwNGYxYWFhMmI1ZDRiZjhkNzZmN2UgPSAkKCc8ZGl2IGlkPSJodG1sX2RhMWEwNjI5ZDQ0MDRmMWFhYTJiNWQ0YmY4ZDc2ZjdlIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5CYXRodXJzdCBNYW5vcixEb3duc3ZpZXcgTm9ydGgsV2lsc29uIEhlaWdodHMsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzk2MGM5NmEzYmVkNTRlOWI4MDVhZWViZTRmYWU4YjUyLnNldENvbnRlbnQoaHRtbF9kYTFhMDYyOWQ0NDA0ZjFhYWEyYjVkNGJmOGQ3NmY3ZSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8xODMyMThhZWY3OWE0MGUzOGNkY2RmNzBmNGFmZjM1NS5iaW5kUG9wdXAocG9wdXBfOTYwYzk2YTNiZWQ1NGU5YjgwNWFlZWJlNGZhZThiNTIpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZWI3ODI0MWM5MDA3NDIwZjg2YzcxMDkzZmE1NzhjZWIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MDUzNjg5LC03OS4zNDkzNzE5MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8xOTQ5YWQ2NmEwZmM0MTkxOTJmYzE3MWE5YzQwYTg3NCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF81MDYzNDg0ZWRkN2U0NjUyOWE1NmM5MmExYThmNzM0NCA9ICQoJzxkaXYgaWQ9Imh0bWxfNTA2MzQ4NGVkZDdlNDY1MjlhNTZjOTJhMWE4ZjczNDQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlRob3JuY2xpZmZlIFBhcmssIEVhc3QgWW9yazwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMTk0OWFkNjZhMGZjNDE5MTkyZmMxNzFhOWM0MGE4NzQuc2V0Q29udGVudChodG1sXzUwNjM0ODRlZGQ3ZTQ2NTI5YTU2YzkyYTFhOGY3MzQ0KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2ViNzgyNDFjOTAwNzQyMGY4NmM3MTA5M2ZhNTc4Y2ViLmJpbmRQb3B1cChwb3B1cF8xOTQ5YWQ2NmEwZmM0MTkxOTJmYzE3MWE5YzQwYTg3NCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8xMjI1OTJiZjY1MzE0YjU5YTVmYTdiMTI0M2EyMGY2YiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY1MDU3MTIwMDAwMDAxLC03OS4zODQ1Njc1XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzBjNDRlNjMxNmE2MzQwN2Q5ZDRkMDhjMWNmMzk5NTBjID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzlmOTJjZWE5NDZlYjQ0ZGY5ZWNjZDJhYWYwMjY2MmY4ID0gJCgnPGRpdiBpZD0iaHRtbF85ZjkyY2VhOTQ2ZWI0NGRmOWVjY2QyYWFmMDI2NjJmOCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+QWRlbGFpZGUsS2luZyxSaWNobW9uZCwgRG93bnRvd24gVG9yb250bzwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMGM0NGU2MzE2YTYzNDA3ZDlkNGQwOGMxY2YzOTk1MGMuc2V0Q29udGVudChodG1sXzlmOTJjZWE5NDZlYjQ0ZGY5ZWNjZDJhYWYwMjY2MmY4KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzEyMjU5MmJmNjUzMTRiNTlhNWZhN2IxMjQzYTIwZjZiLmJpbmRQb3B1cChwb3B1cF8wYzQ0ZTYzMTZhNjM0MDdkOWQ0ZDA4YzFjZjM5OTUwYyk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl82YjMxNmQzMTVlMzk0MzJhYjRlOWQ2NmUyMjUzYjBlZiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2OTAwNTEwMDAwMDAxLC03OS40NDIyNTkzXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2FhMmVjNTI2M2EzMDQ5ZjM5N2VjYTk2NTg2ZGE2ZmU3ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzY1NWNmOGYyNTc2YTRmODA5ZWZkMDdiZDNiZDFjMmU5ID0gJCgnPGRpdiBpZD0iaHRtbF82NTVjZjhmMjU3NmE0ZjgwOWVmZDA3YmQzYmQxYzJlOSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RG92ZXJjb3VydCBWaWxsYWdlLER1ZmZlcmluLCBXZXN0IFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2FhMmVjNTI2M2EzMDQ5ZjM5N2VjYTk2NTg2ZGE2ZmU3LnNldENvbnRlbnQoaHRtbF82NTVjZjhmMjU3NmE0ZjgwOWVmZDA3YmQzYmQxYzJlOSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl82YjMxNmQzMTVlMzk0MzJhYjRlOWQ2NmUyMjUzYjBlZi5iaW5kUG9wdXAocG9wdXBfYWEyZWM1MjYzYTMwNDlmMzk3ZWNhOTY1ODZkYTZmZTcpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNGI5YmU1YTVlMjIwNDUxMzk2NGI0M2JiNWZiNmJjYTMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NDQ3MzQyLC03OS4yMzk0NzYwOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9hZTRiY2Y5MDczZWI0MmI0YmUzMjg1YTYyOGU5ZTQ1ZSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9kZDQ0MjllMDMyMzI0MzhiYTE3MjVlZDhiYmVkYmJhOCA9ICQoJzxkaXYgaWQ9Imh0bWxfZGQ0NDI5ZTAzMjMyNDM4YmExNzI1ZWQ4YmJlZGJiYTgiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlNjYXJib3JvdWdoIFZpbGxhZ2UsIFNjYXJib3JvdWdoPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9hZTRiY2Y5MDczZWI0MmI0YmUzMjg1YTYyOGU5ZTQ1ZS5zZXRDb250ZW50KGh0bWxfZGQ0NDI5ZTAzMjMyNDM4YmExNzI1ZWQ4YmJlZGJiYTgpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNGI5YmU1YTVlMjIwNDUxMzk2NGI0M2JiNWZiNmJjYTMuYmluZFBvcHVwKHBvcHVwX2FlNGJjZjkwNzNlYjQyYjRiZTMyODVhNjI4ZTllNDVlKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzIxMDJjMGJhMThmNjQ3YWY5NjA1NmQ2ZTkwOGYwZjViID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzc4NTE3NSwtNzkuMzQ2NTU1N10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF80NDA4ZGMwZWFkN2E0NDdhOThiMWU3MDY5ZjUzMzg1YiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9lYTAwMGJiZjgxZDA0NDU2OWVmMWFkYzMyMjczYTdiMSA9ICQoJzxkaXYgaWQ9Imh0bWxfZWEwMDBiYmY4MWQwNDQ1NjllZjFhZGMzMjI3M2E3YjEiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkZhaXJ2aWV3LEhlbnJ5IEZhcm0sT3Jpb2xlLCBOb3J0aCBZb3JrPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF80NDA4ZGMwZWFkN2E0NDdhOThiMWU3MDY5ZjUzMzg1Yi5zZXRDb250ZW50KGh0bWxfZWEwMDBiYmY4MWQwNDQ1NjllZjFhZGMzMjI3M2E3YjEpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMjEwMmMwYmExOGY2NDdhZjk2MDU2ZDZlOTA4ZjBmNWIuYmluZFBvcHVwKHBvcHVwXzQ0MDhkYzBlYWQ3YTQ0N2E5OGIxZTcwNjlmNTMzODViKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2I4YTllNWFlYTM0ZjRiYjQ4ZmZhOWY1NzA1NTJlMTc2ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzY3OTgwMywtNzkuNDg3MjYxOTAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMzI4ZTNmNWJiYWFiNDkzZDk2MTMwZTA2ODQ2YjQyMzIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZTQ0NTNiNDdjZjdlNDNiOGI0YTE1NWEyM2Y0YjJiOTEgPSAkKCc8ZGl2IGlkPSJodG1sX2U0NDUzYjQ3Y2Y3ZTQzYjhiNGExNTVhMjNmNGIyYjkxIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Ob3J0aHdvb2QgUGFyayxZb3JrIFVuaXZlcnNpdHksIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzMyOGUzZjViYmFhYjQ5M2Q5NjEzMGUwNjg0NmI0MjMyLnNldENvbnRlbnQoaHRtbF9lNDQ1M2I0N2NmN2U0M2I4YjRhMTU1YTIzZjRiMmI5MSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9iOGE5ZTVhZWEzNGY0YmI0OGZmYTlmNTcwNTUyZTE3Ni5iaW5kUG9wdXAocG9wdXBfMzI4ZTNmNWJiYWFiNDkzZDk2MTMwZTA2ODQ2YjQyMzIpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNDM2NzM1MmJlZmVlNDMxNDlkMDViZTc0Mjk4OTMyZTAgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42ODUzNDcsLTc5LjMzODEwNjVdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMDE0MDE1MjRkMjI1NDgyODk1Nzg5ZjgzNjQ3YzdmZTYgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNDlhMmJmYjNiNzQ1NGM1NGEzNTVjN2E1NzljNTUwMWUgPSAkKCc8ZGl2IGlkPSJodG1sXzQ5YTJiZmIzYjc0NTRjNTRhMzU1YzdhNTc5YzU1MDFlIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5FYXN0IFRvcm9udG8sIEVhc3QgWW9yazwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMDE0MDE1MjRkMjI1NDgyODk1Nzg5ZjgzNjQ3YzdmZTYuc2V0Q29udGVudChodG1sXzQ5YTJiZmIzYjc0NTRjNTRhMzU1YzdhNTc5YzU1MDFlKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzQzNjczNTJiZWZlZTQzMTQ5ZDA1YmU3NDI5ODkzMmUwLmJpbmRQb3B1cChwb3B1cF8wMTQwMTUyNGQyMjU0ODI4OTU3ODlmODM2NDdjN2ZlNik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9mZjczMmQ1ZTM4M2I0Nzg5OTQxMTJiMWVkNjRkZGQ2NiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY0MDgxNTcsLTc5LjM4MTc1MjI5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2NkZjFiMTc0OWM4YTQ0NjE4NTdiOWFjODVhMzBlMTExID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzZhODQ0ZTQ2YTJlNjRjODg5YjFjMjUyOGMyMWQzZGY0ID0gJCgnPGRpdiBpZD0iaHRtbF82YTg0NGU0NmEyZTY0Yzg4OWIxYzI1MjhjMjFkM2RmNCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+SGFyYm91cmZyb250IEVhc3QsVG9yb250byBJc2xhbmRzLFVuaW9uIFN0YXRpb24sIERvd250b3duIFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2NkZjFiMTc0OWM4YTQ0NjE4NTdiOWFjODVhMzBlMTExLnNldENvbnRlbnQoaHRtbF82YTg0NGU0NmEyZTY0Yzg4OWIxYzI1MjhjMjFkM2RmNCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9mZjczMmQ1ZTM4M2I0Nzg5OTQxMTJiMWVkNjRkZGQ2Ni5iaW5kUG9wdXAocG9wdXBfY2RmMWIxNzQ5YzhhNDQ2MTg1N2I5YWM4NWEzMGUxMTEpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfODBjNTU2ZjZkNjhhNGRjZWIwM2JjNjMxZDVkMDZkZDUgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NDc5MjY3MDAwMDAwMDYsLTc5LjQxOTc0OTddLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNmZmODFmZjk5YjYxNGY5ODgxMWI0NDNlM2Q2OThiNmIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZGY3Yjg3YTE3YjZhNDkyNDhlODY2MjRkYWFiMjA0YTUgPSAkKCc8ZGl2IGlkPSJodG1sX2RmN2I4N2ExN2I2YTQ5MjQ4ZTg2NjI0ZGFhYjIwNGE1IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5MaXR0bGUgUG9ydHVnYWwsVHJpbml0eSwgV2VzdCBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF82ZmY4MWZmOTliNjE0Zjk4ODExYjQ0M2UzZDY5OGI2Yi5zZXRDb250ZW50KGh0bWxfZGY3Yjg3YTE3YjZhNDkyNDhlODY2MjRkYWFiMjA0YTUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfODBjNTU2ZjZkNjhhNGRjZWIwM2JjNjMxZDVkMDZkZDUuYmluZFBvcHVwKHBvcHVwXzZmZjgxZmY5OWI2MTRmOTg4MTFiNDQzZTNkNjk4YjZiKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzVjYTE3YjQ5YTZlZTQ5YmViNDEyZDFkZDJiNjc5MWQ2ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzI3OTI5MiwtNzkuMjYyMDI5NDAwMDAwMDJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfODYyMWY5ZjJlNzFjNGE2MzhkY2UyNDAzNTJhNWNmZDAgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMGExN2VhNWI5NDcwNDc5N2FlYWRlODdhOTNjM2QwMDMgPSAkKCc8ZGl2IGlkPSJodG1sXzBhMTdlYTViOTQ3MDQ3OTdhZWFkZTg3YTkzYzNkMDAzIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5FYXN0IEJpcmNobW91bnQgUGFyayxJb252aWV3LEtlbm5lZHkgUGFyaywgU2NhcmJvcm91Z2g8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzg2MjFmOWYyZTcxYzRhNjM4ZGNlMjQwMzUyYTVjZmQwLnNldENvbnRlbnQoaHRtbF8wYTE3ZWE1Yjk0NzA0Nzk3YWVhZGU4N2E5M2MzZDAwMyk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl81Y2ExN2I0OWE2ZWU0OWJlYjQxMmQxZGQyYjY3OTFkNi5iaW5kUG9wdXAocG9wdXBfODYyMWY5ZjJlNzFjNGE2MzhkY2UyNDAzNTJhNWNmZDApOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNmMyMmU1NGEwZDRmNDEyYmJiZmQ0NTljOGY3ZTczMDMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43ODY5NDczLC03OS4zODU5NzVdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYjZkMmYyMmYxZjkwNDFkYzg1NjYxMDc5NjNlNzk3NTggPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfOWZiMDJhY2M3YTU4NDc4OGI5YzU1ZmFiNjlmZWQ4ZTcgPSAkKCc8ZGl2IGlkPSJodG1sXzlmYjAyYWNjN2E1ODQ3ODhiOWM1NWZhYjY5ZmVkOGU3IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5CYXl2aWV3IFZpbGxhZ2UsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2I2ZDJmMjJmMWY5MDQxZGM4NTY2MTA3OTYzZTc5NzU4LnNldENvbnRlbnQoaHRtbF85ZmIwMmFjYzdhNTg0Nzg4YjljNTVmYWI2OWZlZDhlNyk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl82YzIyZTU0YTBkNGY0MTJiYmJmZDQ1OWM4ZjdlNzMwMy5iaW5kUG9wdXAocG9wdXBfYjZkMmYyMmYxZjkwNDFkYzg1NjYxMDc5NjNlNzk3NTgpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNWQ0MWNhY2UzNWFjNGUzZDk5NzM2OGEwYzVhZDMxNmIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43Mzc0NzMyMDAwMDAwMDQsLTc5LjQ2NDc2MzI5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzk1NWRlMTBhY2QxOTRiN2E5MTIxOTk4YWI5NjQ0MDQ1ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2M3MDk4MGRkZGNiOTQ4NjBiOTEwMTgxZThhN2FlYTcyID0gJCgnPGRpdiBpZD0iaHRtbF9jNzA5ODBkZGRjYjk0ODYwYjkxMDE4MWU4YTdhZWE3MiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q0ZCIFRvcm9udG8sRG93bnN2aWV3IEVhc3QsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzk1NWRlMTBhY2QxOTRiN2E5MTIxOTk4YWI5NjQ0MDQ1LnNldENvbnRlbnQoaHRtbF9jNzA5ODBkZGRjYjk0ODYwYjkxMDE4MWU4YTdhZWE3Mik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl81ZDQxY2FjZTM1YWM0ZTNkOTk3MzY4YTBjNWFkMzE2Yi5iaW5kUG9wdXAocG9wdXBfOTU1ZGUxMGFjZDE5NGI3YTkxMjE5OThhYjk2NDQwNDUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfY2QxYTg5Njk4ZWE5NDA1OWFjYjY2ODVkYjRhOWJkYjkgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42Nzk1NTcxLC03OS4zNTIxODhdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZDY0YjBhZGNmZDczNDJmMThjOGQwMTNiNTEwOGQxMWYgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNDgxZmZmZTkxZWRkNGFhZmJlNjgxN2FmYjBmOTNmZjcgPSAkKCc8ZGl2IGlkPSJodG1sXzQ4MWZmZmU5MWVkZDRhYWZiZTY4MTdhZmIwZjkzZmY3IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5UaGUgRGFuZm9ydGggV2VzdCxSaXZlcmRhbGUsIEVhc3QgVG9yb250bzwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZDY0YjBhZGNmZDczNDJmMThjOGQwMTNiNTEwOGQxMWYuc2V0Q29udGVudChodG1sXzQ4MWZmZmU5MWVkZDRhYWZiZTY4MTdhZmIwZjkzZmY3KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2NkMWE4OTY5OGVhOTQwNTlhY2I2Njg1ZGI0YTliZGI5LmJpbmRQb3B1cChwb3B1cF9kNjRiMGFkY2ZkNzM0MmYxOGM4ZDAxM2I1MTA4ZDExZik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9lOTViMjk2YzFhNTc0MzQ4OTQ4OTBhYjg4NDUxMTYxMSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY0NzE3NjgsLTc5LjM4MTU3NjQwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2EzZWQzMTY1OTZhYzQwNDA5MGQ5NTI0MzAzMjJjZWFjID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzdkM2Q0ODVmNWI2YzRlNzY4ZWY3NjFjN2ZiZTZlMGYzID0gJCgnPGRpdiBpZD0iaHRtbF83ZDNkNDg1ZjViNmM0ZTc2OGVmNzYxYzdmYmU2ZTBmMyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RGVzaWduIEV4Y2hhbmdlLFRvcm9udG8gRG9taW5pb24gQ2VudHJlLCBEb3dudG93biBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9hM2VkMzE2NTk2YWM0MDQwOTBkOTUyNDMwMzIyY2VhYy5zZXRDb250ZW50KGh0bWxfN2QzZDQ4NWY1YjZjNGU3NjhlZjc2MWM3ZmJlNmUwZjMpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZTk1YjI5NmMxYTU3NDM0ODk0ODkwYWI4ODQ1MTE2MTEuYmluZFBvcHVwKHBvcHVwX2EzZWQzMTY1OTZhYzQwNDA5MGQ5NTI0MzAzMjJjZWFjKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzkzYWI5NmY5M2ZmNzQzYmE5YzdiNTI3NjE4YzY2ZGNkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjM2ODQ3MiwtNzkuNDI4MTkxNDAwMDAwMDJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMTJlMjRkNGY3MTgwNGI1MWJhNzllOTA4NTdmOTE1ZWUgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMDliODhlZmY0MDU5NDcyYWE5NjBhZTJiYmY5NDg5YjIgPSAkKCc8ZGl2IGlkPSJodG1sXzA5Yjg4ZWZmNDA1OTQ3MmFhOTYwYWUyYmJmOTQ4OWIyIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Ccm9ja3RvbixFeGhpYml0aW9uIFBsYWNlLFBhcmtkYWxlIFZpbGxhZ2UsIFdlc3QgVG9yb250bzwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMTJlMjRkNGY3MTgwNGI1MWJhNzllOTA4NTdmOTE1ZWUuc2V0Q29udGVudChodG1sXzA5Yjg4ZWZmNDA1OTQ3MmFhOTYwYWUyYmJmOTQ4OWIyKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzkzYWI5NmY5M2ZmNzQzYmE5YzdiNTI3NjE4YzY2ZGNkLmJpbmRQb3B1cChwb3B1cF8xMmUyNGQ0ZjcxODA0YjUxYmE3OWU5MDg1N2Y5MTVlZSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8wOGE2MTNmNjc4YzI0M2Y4YjdhN2RiYmZmNDc3YzIwOSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcxMTExMTcwMDAwMDAwNCwtNzkuMjg0NTc3Ml0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9iMWQ2N2U5N2M5NDA0ZDdhODgxYmM0N2E2MmI5OWYzNyA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8wZmM3YWRmMTc3NzY0MjUwOGM2MDU3MWE3NDNmMGY4OCA9ICQoJzxkaXYgaWQ9Imh0bWxfMGZjN2FkZjE3Nzc2NDI1MDhjNjA1NzFhNzQzZjBmODgiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNsYWlybGVhLEdvbGRlbiBNaWxlLE9ha3JpZGdlLCBTY2FyYm9yb3VnaDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYjFkNjdlOTdjOTQwNGQ3YTg4MWJjNDdhNjJiOTlmMzcuc2V0Q29udGVudChodG1sXzBmYzdhZGYxNzc3NjQyNTA4YzYwNTcxYTc0M2YwZjg4KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzA4YTYxM2Y2NzhjMjQzZjhiN2E3ZGJiZmY0NzdjMjA5LmJpbmRQb3B1cChwb3B1cF9iMWQ2N2U5N2M5NDA0ZDdhODgxYmM0N2E2MmI5OWYzNyk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl83MDU2MGNjNmUwODc0ZWE1OTUyNmQ2NDFkNDYwY2VjMCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc1NzQ5MDIsLTc5LjM3NDcxNDA5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzA3OTQxMzY1OWM1YjQ1MzE4ZDAzMzU0MmYxYWVlYzJlID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2UwNDYwMWYwMjNlYTQwZGY4ZTE1OTRkNWVlM2QxOTExID0gJCgnPGRpdiBpZD0iaHRtbF9lMDQ2MDFmMDIzZWE0MGRmOGUxNTk0ZDVlZTNkMTkxMSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+U2lsdmVyIEhpbGxzLFlvcmsgTWlsbHMsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzA3OTQxMzY1OWM1YjQ1MzE4ZDAzMzU0MmYxYWVlYzJlLnNldENvbnRlbnQoaHRtbF9lMDQ2MDFmMDIzZWE0MGRmOGUxNTk0ZDVlZTNkMTkxMSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl83MDU2MGNjNmUwODc0ZWE1OTUyNmQ2NDFkNDYwY2VjMC5iaW5kUG9wdXAocG9wdXBfMDc5NDEzNjU5YzViNDUzMThkMDMzNTQyZjFhZWVjMmUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNmQ3NWZlYjdmMjJmNDQ0NWFmZjcwNzI3NmQ1NmZkOTggPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MzkwMTQ2LC03OS41MDY5NDM2XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzU0ZTZjMTA4N2FiYTQ0ZThhMTY0NTBkNTVhZGE5MWZjID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzE4ZmEyM2MyN2NmNzQwZThhODM1MDA5ZGVlZTQ0ZTkwID0gJCgnPGRpdiBpZD0iaHRtbF8xOGZhMjNjMjdjZjc0MGU4YTgzNTAwOWRlZWU0NGU5MCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RG93bnN2aWV3IFdlc3QsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzU0ZTZjMTA4N2FiYTQ0ZThhMTY0NTBkNTVhZGE5MWZjLnNldENvbnRlbnQoaHRtbF8xOGZhMjNjMjdjZjc0MGU4YTgzNTAwOWRlZWU0NGU5MCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl82ZDc1ZmViN2YyMmY0NDQ1YWZmNzA3Mjc2ZDU2ZmQ5OC5iaW5kUG9wdXAocG9wdXBfNTRlNmMxMDg3YWJhNDRlOGExNjQ1MGQ1NWFkYTkxZmMpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfODE3MWY2NWQwY2M2NGIzZWFhMDJjMzI4OTc3NzhlM2YgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42Njg5OTg1LC03OS4zMTU1NzE1OTk5OTk5OF0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF83Y2UyODVmYmQ2ZGQ0ZDY4YjhlYjUyNTAwYTQ0NWI5ZSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF83ZTExNmY1YWQzZmM0MTdkODAzMTZlNmQ0N2ZmNjgzNSA9ICQoJzxkaXYgaWQ9Imh0bWxfN2UxMTZmNWFkM2ZjNDE3ZDgwMzE2ZTZkNDdmZjY4MzUiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlRoZSBCZWFjaGVzIFdlc3QsSW5kaWEgQmF6YWFyLCBFYXN0IFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzdjZTI4NWZiZDZkZDRkNjhiOGViNTI1MDBhNDQ1YjllLnNldENvbnRlbnQoaHRtbF83ZTExNmY1YWQzZmM0MTdkODAzMTZlNmQ0N2ZmNjgzNSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl84MTcxZjY1ZDBjYzY0YjNlYWEwMmMzMjg5Nzc3OGUzZi5iaW5kUG9wdXAocG9wdXBfN2NlMjg1ZmJkNmRkNGQ2OGI4ZWI1MjUwMGE0NDViOWUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfY2UzOTViODQ4MjI2NDM0ZDkwYWQxYzM5YjBhNDhhOTggPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NDgxOTg1LC03OS4zNzk4MTY5MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF84ODkxZjkzNDAwMWY0NjI3OWU2YWQzZWJkMzFiODhjNyA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF82NDMwMmI5MzdhZTk0YTYzYmIyZjVlMDBlMmE3MzhkNyA9ICQoJzxkaXYgaWQ9Imh0bWxfNjQzMDJiOTM3YWU5NGE2M2JiMmY1ZTAwZTJhNzM4ZDciIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNvbW1lcmNlIENvdXJ0LFZpY3RvcmlhIEhvdGVsLCBEb3dudG93biBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF84ODkxZjkzNDAwMWY0NjI3OWU2YWQzZWJkMzFiODhjNy5zZXRDb250ZW50KGh0bWxfNjQzMDJiOTM3YWU5NGE2M2JiMmY1ZTAwZTJhNzM4ZDcpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfY2UzOTViODQ4MjI2NDM0ZDkwYWQxYzM5YjBhNDhhOTguYmluZFBvcHVwKHBvcHVwXzg4OTFmOTM0MDAxZjQ2Mjc5ZTZhZDNlYmQzMWI4OGM3KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzMxYjgwZTcyZDUyODRmNmM5MzA1NDc2NTI0MzNiOGZhID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzEzNzU2MjAwMDAwMDA2LC03OS40OTAwNzM4XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzIwMWIwZjZjYzYyOTRiNmNiZTA5ZjEzNmFiOWE0MzVkID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzE4NDQ2NTE3MWYzMjQxYTQ4MDA3Y2NiNGUwZmI3ZmZhID0gJCgnPGRpdiBpZD0iaHRtbF8xODQ0NjUxNzFmMzI0MWE0ODAwN2NjYjRlMGZiN2ZmYSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RG93bnN2aWV3LE5vcnRoIFBhcmssVXB3b29kIFBhcmssIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzIwMWIwZjZjYzYyOTRiNmNiZTA5ZjEzNmFiOWE0MzVkLnNldENvbnRlbnQoaHRtbF8xODQ0NjUxNzFmMzI0MWE0ODAwN2NjYjRlMGZiN2ZmYSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8zMWI4MGU3MmQ1Mjg0ZjZjOTMwNTQ3NjUyNDMzYjhmYS5iaW5kUG9wdXAocG9wdXBfMjAxYjBmNmNjNjI5NGI2Y2JlMDlmMTM2YWI5YTQzNWQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMzEwODcyZGQ4OTIzNDk2Njk4OGFkNDIzOGM0ZGEzYTggPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NTYzMDMzLC03OS41NjU5NjMyOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF84OTE4NjQ0YmY2NjU0MTFlODc2OTAwZThiMDBkNzA2NyA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF83ZTk1NDUwOGJhNTc0MTBmYThiZmM1YjMyYjhmNDg5MiA9ICQoJzxkaXYgaWQ9Imh0bWxfN2U5NTQ1MDhiYTU3NDEwZmE4YmZjNWIzMmI4ZjQ4OTIiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkh1bWJlciBTdW1taXQsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzg5MTg2NDRiZjY2NTQxMWU4NzY5MDBlOGIwMGQ3MDY3LnNldENvbnRlbnQoaHRtbF83ZTk1NDUwOGJhNTc0MTBmYThiZmM1YjMyYjhmNDg5Mik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8zMTA4NzJkZDg5MjM0OTY2OTg4YWQ0MjM4YzRkYTNhOC5iaW5kUG9wdXAocG9wdXBfODkxODY0NGJmNjY1NDExZTg3NjkwMGU4YjAwZDcwNjcpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZTZiNDBiZTE3OTVkNDY2Y2EyZjQ5OWE3YTRhMzRmY2YgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MTYzMTYsLTc5LjIzOTQ3NjA5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2IxNDI1OWZhNGRkZTQ4NDhhYzI3NGI5ZWQxMGNjNjkwID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2YwNjk1N2VlMzliNTQ4NTJiNTMwMDk5N2RkYTk5MjA2ID0gJCgnPGRpdiBpZD0iaHRtbF9mMDY5NTdlZTM5YjU0ODUyYjUzMDA5OTdkZGE5OTIwNiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2xpZmZjcmVzdCxDbGlmZnNpZGUsU2NhcmJvcm91Z2ggVmlsbGFnZSBXZXN0LCBTY2FyYm9yb3VnaDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYjE0MjU5ZmE0ZGRlNDg0OGFjMjc0YjllZDEwY2M2OTAuc2V0Q29udGVudChodG1sX2YwNjk1N2VlMzliNTQ4NTJiNTMwMDk5N2RkYTk5MjA2KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2U2YjQwYmUxNzk1ZDQ2NmNhMmY0OTlhN2E0YTM0ZmNmLmJpbmRQb3B1cChwb3B1cF9iMTQyNTlmYTRkZGU0ODQ4YWMyNzRiOWVkMTBjYzY5MCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl81MjBhMTdmODEzNjk0OTlhYWY1YzE1YThiZDMyMzMzNCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc4OTA1MywtNzkuNDA4NDkyNzk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMDcwYWI5NDNhNmExNDA2N2JhYTc4YjdlNDNmZGUwOGUgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZjExYTlmMmJmNjlkNDM5MWE1ZDUxZTYzZjVhZTU0ZTggPSAkKCc8ZGl2IGlkPSJodG1sX2YxMWE5ZjJiZjY5ZDQzOTFhNWQ1MWU2M2Y1YWU1NGU4IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5OZXd0b25icm9vayxXaWxsb3dkYWxlLCBOb3J0aCBZb3JrPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8wNzBhYjk0M2E2YTE0MDY3YmFhNzhiN2U0M2ZkZTA4ZS5zZXRDb250ZW50KGh0bWxfZjExYTlmMmJmNjlkNDM5MWE1ZDUxZTYzZjVhZTU0ZTgpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNTIwYTE3ZjgxMzY5NDk5YWFmNWMxNWE4YmQzMjMzMzQuYmluZFBvcHVwKHBvcHVwXzA3MGFiOTQzYTZhMTQwNjdiYWE3OGI3ZTQzZmRlMDhlKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzZlYzQyY2M2NzEyOTQ3NzhiZjllNmRlYzFkMmZlY2Y3ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzI4NDk2NCwtNzkuNDk1Njk3NDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZDBlNTA1YzM4YjExNDMzNjgwYmI5OWUwMTdjYTY0N2QgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZjVmMDU4ZTNmOWVjNGZjMWE4MDAyMjQyNDExZTQ3YjIgPSAkKCc8ZGl2IGlkPSJodG1sX2Y1ZjA1OGUzZjllYzRmYzFhODAwMjI0MjQxMWU0N2IyIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Eb3duc3ZpZXcgQ2VudHJhbCwgTm9ydGggWW9yazwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZDBlNTA1YzM4YjExNDMzNjgwYmI5OWUwMTdjYTY0N2Quc2V0Q29udGVudChodG1sX2Y1ZjA1OGUzZjllYzRmYzFhODAwMjI0MjQxMWU0N2IyKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzZlYzQyY2M2NzEyOTQ3NzhiZjllNmRlYzFkMmZlY2Y3LmJpbmRQb3B1cChwb3B1cF9kMGU1MDVjMzhiMTE0MzM2ODBiYjk5ZTAxN2NhNjQ3ZCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9mMTE2NTk2N2MwMDI0ZDBiOTcwYTI1MTI1ZmJmZjNiMyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY1OTUyNTUsLTc5LjM0MDkyM10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF85MjlkNWQ3YmE5ZTM0ZjU4YmRhYTBhZDQyMjFkMzIxYiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9hOWYzMWMxN2RlMzY0MjkzODcyN2UwYTljM2FjMjI3NyA9ICQoJzxkaXYgaWQ9Imh0bWxfYTlmMzFjMTdkZTM2NDI5Mzg3MjdlMGE5YzNhYzIyNzciIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlN0dWRpbyBEaXN0cmljdCwgRWFzdCBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF85MjlkNWQ3YmE5ZTM0ZjU4YmRhYTBhZDQyMjFkMzIxYi5zZXRDb250ZW50KGh0bWxfYTlmMzFjMTdkZTM2NDI5Mzg3MjdlMGE5YzNhYzIyNzcpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZjExNjU5NjdjMDAyNGQwYjk3MGEyNTEyNWZiZmYzYjMuYmluZFBvcHVwKHBvcHVwXzkyOWQ1ZDdiYTllMzRmNThiZGFhMGFkNDIyMWQzMjFiKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzgzYThkNTM4NTQ0NzQzOTlhMzM2Y2E3ZmI5MDM1OTE1ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzMzMjgyNSwtNzkuNDE5NzQ5N10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8xYzY4M2I0ZmMzOTk0YjAyODM3ZDIyMDcwOTA0MWQ0NSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF81OTAyYzNkMzI3MjA0NGYwOWE1Mzc0YzA5NzI2MTZmOSA9ICQoJzxkaXYgaWQ9Imh0bWxfNTkwMmMzZDMyNzIwNDRmMDlhNTM3NGMwOTcyNjE2ZjkiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkJlZGZvcmQgUGFyayxMYXdyZW5jZSBNYW5vciBFYXN0LCBOb3J0aCBZb3JrPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8xYzY4M2I0ZmMzOTk0YjAyODM3ZDIyMDcwOTA0MWQ0NS5zZXRDb250ZW50KGh0bWxfNTkwMmMzZDMyNzIwNDRmMDlhNTM3NGMwOTcyNjE2ZjkpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfODNhOGQ1Mzg1NDQ3NDM5OWEzMzZjYTdmYjkwMzU5MTUuYmluZFBvcHVwKHBvcHVwXzFjNjgzYjRmYzM5OTRiMDI4MzdkMjIwNzA5MDQxZDQ1KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2Y1ZTc4YThlNjA4NTQzNjY5YTk0OTg1ZTkyYjI0NDBkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjkxMTE1OCwtNzkuNDc2MDEzMjk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMWUxOWU2ODk3ZGM2NDE0OThkZGYyYjI3ZjVjYzA2OWUgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfOTRiNTNiZmM0NThjNDhjN2IzMzdmMTA2NDIyZjJjMzggPSAkKCc8ZGl2IGlkPSJodG1sXzk0YjUzYmZjNDU4YzQ4YzdiMzM3ZjEwNjQyMmYyYzM4IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5EZWwgUmF5LEtlZWxlc2RhbGUsTW91bnQgRGVubmlzLFNpbHZlcnRob3JuLCBZb3JrPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8xZTE5ZTY4OTdkYzY0MTQ5OGRkZjJiMjdmNWNjMDY5ZS5zZXRDb250ZW50KGh0bWxfOTRiNTNiZmM0NThjNDhjN2IzMzdmMTA2NDIyZjJjMzgpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZjVlNzhhOGU2MDg1NDM2NjlhOTQ5ODVlOTJiMjQ0MGQuYmluZFBvcHVwKHBvcHVwXzFlMTllNjg5N2RjNjQxNDk4ZGRmMmIyN2Y1Y2MwNjllKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzYzOGExMGNlNzI5YTRkYjdiYWFlYzFiMjE2MmVmODIyID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzI0NzY1OSwtNzkuNTMyMjQyNDAwMDAwMDJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfOWY3NmI4OTYwNDgzNDFjOTgyMjRlMjM0ZGFmZjhkODQgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfOWRhMGM0NWVlZmEyNDc2MWI3ZDk2ZTdkMThlNDY2YTIgPSAkKCc8ZGl2IGlkPSJodG1sXzlkYTBjNDVlZWZhMjQ3NjFiN2Q5NmU3ZDE4ZTQ2NmEyIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5FbWVyeSxIdW1iZXJsZWEsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzlmNzZiODk2MDQ4MzQxYzk4MjI0ZTIzNGRhZmY4ZDg0LnNldENvbnRlbnQoaHRtbF85ZGEwYzQ1ZWVmYTI0NzYxYjdkOTZlN2QxOGU0NjZhMik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl82MzhhMTBjZTcyOWE0ZGI3YmFhZWMxYjIxNjJlZjgyMi5iaW5kUG9wdXAocG9wdXBfOWY3NmI4OTYwNDgzNDFjOTgyMjRlMjM0ZGFmZjhkODQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZTY4YTJhNDEwOTQ0NGFiMjkwZmExY2Y0MGM2ZmQ5OWYgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42OTI2NTcwMDAwMDAwMDQsLTc5LjI2NDg0ODFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZjRjM2E5ZGE5Yzg3NGZlMmE4MGIxNGM0YTgwNmIxOWEgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZjA0NjQ5MGJiNjczNDMyNDg5MDJlYmY0ZDk1OTViZDggPSAkKCc8ZGl2IGlkPSJodG1sX2YwNDY0OTBiYjY3MzQzMjQ4OTAyZWJmNGQ5NTk1YmQ4IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5CaXJjaCBDbGlmZixDbGlmZnNpZGUgV2VzdCwgU2NhcmJvcm91Z2g8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2Y0YzNhOWRhOWM4NzRmZTJhODBiMTRjNGE4MDZiMTlhLnNldENvbnRlbnQoaHRtbF9mMDQ2NDkwYmI2NzM0MzI0ODkwMmViZjRkOTU5NWJkOCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9lNjhhMmE0MTA5NDQ0YWIyOTBmYTFjZjQwYzZmZDk5Zi5iaW5kUG9wdXAocG9wdXBfZjRjM2E5ZGE5Yzg3NGZlMmE4MGIxNGM0YTgwNmIxOWEpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYjk0YWI1MzZlMWUxNGM5OWIyNWFiZDg2YTY5ZTZlZjQgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NzAxMTk5LC03OS40MDg0OTI3OTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF82NGU2ZTJiMmQ2MzE0ZWM3OWVhN2RmOWY2YjdlMTBhOSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9lMDE0YmFhYmU2NjY0YjZmYmYwZWM4ODA3MGVkOWZmMyA9ICQoJzxkaXYgaWQ9Imh0bWxfZTAxNGJhYWJlNjY2NGI2ZmJmMGVjODgwNzBlZDlmZjMiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPldpbGxvd2RhbGUgU291dGgsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzY0ZTZlMmIyZDYzMTRlYzc5ZWE3ZGY5ZjZiN2UxMGE5LnNldENvbnRlbnQoaHRtbF9lMDE0YmFhYmU2NjY0YjZmYmYwZWM4ODA3MGVkOWZmMyk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9iOTRhYjUzNmUxZTE0Yzk5YjI1YWJkODZhNjllNmVmNC5iaW5kUG9wdXAocG9wdXBfNjRlNmUyYjJkNjMxNGVjNzllYTdkZjlmNmI3ZTEwYTkpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNDViYmY4ZDAwNTM3NDkzNjhlYjZmMTNmNjYxMDVhOWEgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NjE2MzEzLC03OS41MjA5OTk0MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF82OWJmNTVlMjU3MTk0MWU4YjljMDU4MjZlNmFiYTExZCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9iNDRmZjlkNjg0YmM0Njc5YjBlMjE2NzkyNjM0Y2Q0NiA9ICQoJzxkaXYgaWQ9Imh0bWxfYjQ0ZmY5ZDY4NGJjNDY3OWIwZTIxNjc5MjYzNGNkNDYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkRvd25zdmlldyBOb3J0aHdlc3QsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzY5YmY1NWUyNTcxOTQxZThiOWMwNTgyNmU2YWJhMTFkLnNldENvbnRlbnQoaHRtbF9iNDRmZjlkNjg0YmM0Njc5YjBlMjE2NzkyNjM0Y2Q0Nik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl80NWJiZjhkMDA1Mzc0OTM2OGViNmYxM2Y2NjEwNWE5YS5iaW5kUG9wdXAocG9wdXBfNjliZjU1ZTI1NzE5NDFlOGI5YzA1ODI2ZTZhYmExMWQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYjE3MWU2MDUwNTg2NGU1N2E4ODcxYTllNGNhNDNlYTEgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MjgwMjA1LC03OS4zODg3OTAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzJjYzgxYTI1ZjgyNDQ0MTJiZTgwOTAxY2RlMTkzMDZkID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzg1ZmMwMmRlYWNkOTRjNjNiNDllOTFhOTQ3YWEzY2ZlID0gJCgnPGRpdiBpZD0iaHRtbF84NWZjMDJkZWFjZDk0YzYzYjQ5ZTkxYTk0N2FhM2NmZSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+TGF3cmVuY2UgUGFyaywgQ2VudHJhbCBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8yY2M4MWEyNWY4MjQ0NDEyYmU4MDkwMWNkZTE5MzA2ZC5zZXRDb250ZW50KGh0bWxfODVmYzAyZGVhY2Q5NGM2M2I0OWU5MWE5NDdhYTNjZmUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYjE3MWU2MDUwNTg2NGU1N2E4ODcxYTllNGNhNDNlYTEuYmluZFBvcHVwKHBvcHVwXzJjYzgxYTI1ZjgyNDQ0MTJiZTgwOTAxY2RlMTkzMDZkKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzJkMjg5YjllZjA0MDQwNDRiZmRjYWM1YzRkYzg1ZTM0ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzExNjk0OCwtNzkuNDE2OTM1NTk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMjg5MDdiYWRiM2NiNGIwMjk4YzViZWM4MGRkYTM5MzggPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNGExMzk3ZDI3MTIzNDYwNmE5MjQ3ZjMxNjJjZmU0YzcgPSAkKCc8ZGl2IGlkPSJodG1sXzRhMTM5N2QyNzEyMzQ2MDZhOTI0N2YzMTYyY2ZlNGM3IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Sb3NlbGF3biwgQ2VudHJhbCBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8yODkwN2JhZGIzY2I0YjAyOThjNWJlYzgwZGRhMzkzOC5zZXRDb250ZW50KGh0bWxfNGExMzk3ZDI3MTIzNDYwNmE5MjQ3ZjMxNjJjZmU0YzcpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMmQyODliOWVmMDQwNDA0NGJmZGNhYzVjNGRjODVlMzQuYmluZFBvcHVwKHBvcHVwXzI4OTA3YmFkYjNjYjRiMDI5OGM1YmVjODBkZGEzOTM4KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2U5ZjY5NDE3OTE2NTRmNjVhMzI4YjFmNjk4MTkyODkxID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjczMTg1Mjk5OTk5OTksLTc5LjQ4NzI2MTkwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzIzMTNjNWEwMWZlZDQ4OWE4ODBlMzBiZTY4ZTNlMTIxID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzcwOTQyYTQ5MzA2MjQ4OWNhMTI2M2VkZjI0ZDRiYTljID0gJCgnPGRpdiBpZD0iaHRtbF83MDk0MmE0OTMwNjI0ODljYTEyNjNlZGYyNGQ0YmE5YyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+VGhlIEp1bmN0aW9uIE5vcnRoLFJ1bm55bWVkZSwgWW9yazwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMjMxM2M1YTAxZmVkNDg5YTg4MGUzMGJlNjhlM2UxMjEuc2V0Q29udGVudChodG1sXzcwOTQyYTQ5MzA2MjQ4OWNhMTI2M2VkZjI0ZDRiYTljKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2U5ZjY5NDE3OTE2NTRmNjVhMzI4YjFmNjk4MTkyODkxLmJpbmRQb3B1cChwb3B1cF8yMzEzYzVhMDFmZWQ0ODlhODgwZTMwYmU2OGUzZTEyMSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8zY2EzMTNiZjQ4NTg0YjAzYTRhMTU3ODI2OGQ2YjQwNiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcwNjg3NiwtNzkuNTE4MTg4NDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNTE2ODE1MDMwM2FjNDU4YmJhY2RjNTQ4OGRhYThmYzggPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfY2FkM2Y5Yjg4NDM1NDcwZDlkMzU1YmNiOWZkOWJjOTggPSAkKCc8ZGl2IGlkPSJodG1sX2NhZDNmOWI4ODQzNTQ3MGQ5ZDM1NWJjYjlmZDliYzk4IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5XZXN0b24sIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzUxNjgxNTAzMDNhYzQ1OGJiYWNkYzU0ODhkYWE4ZmM4LnNldENvbnRlbnQoaHRtbF9jYWQzZjliODg0MzU0NzBkOWQzNTViY2I5ZmQ5YmM5OCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8zY2EzMTNiZjQ4NTg0YjAzYTRhMTU3ODI2OGQ2YjQwNi5iaW5kUG9wdXAocG9wdXBfNTE2ODE1MDMwM2FjNDU4YmJhY2RjNTQ4OGRhYThmYzgpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfOWQ5NDU2MmYzZmE2NDdmZjk5Y2I2MjQ0ZGU0M2M0NzAgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NTc0MDk2LC03OS4yNzMzMDQwMDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9mMDhhYjdmYmQzZTI0MTQ0OGE1ZWU3MTE3MGUwNWZjZiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8wNWY0ODY0NTRjZGU0Njc1ODQ2ZjNlODk4ZWNlZTgzNiA9ICQoJzxkaXYgaWQ9Imh0bWxfMDVmNDg2NDU0Y2RlNDY3NTg0NmYzZTg5OGVjZWU4MzYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkRvcnNldCBQYXJrLFNjYXJib3JvdWdoIFRvd24gQ2VudHJlLFdleGZvcmQgSGVpZ2h0cywgU2NhcmJvcm91Z2g8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2YwOGFiN2ZiZDNlMjQxNDQ4YTVlZTcxMTcwZTA1ZmNmLnNldENvbnRlbnQoaHRtbF8wNWY0ODY0NTRjZGU0Njc1ODQ2ZjNlODk4ZWNlZTgzNik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl85ZDk0NTYyZjNmYTY0N2ZmOTljYjYyNDRkZTQzYzQ3MC5iaW5kUG9wdXAocG9wdXBfZjA4YWI3ZmJkM2UyNDE0NDhhNWVlNzExNzBlMDVmY2YpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMGE2ZjQ1OTg5NjZjNGYwNWFjMzNlZTUzZWRhZjliMDQgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NTI3NTgyOTk5OTk5OTYsLTc5LjQwMDA0OTNdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMzFjZTJkMmJlOGMzNGU4YWFkYjY0YzVhNTJhOGQyMGIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYTU2OGJlMGEzYjk2NDg2MGIzMjNiYTBjNTRlYjBjZTkgPSAkKCc8ZGl2IGlkPSJodG1sX2E1NjhiZTBhM2I5NjQ4NjBiMzIzYmEwYzU0ZWIwY2U5IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Zb3JrIE1pbGxzIFdlc3QsIE5vcnRoIFlvcms8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzMxY2UyZDJiZThjMzRlOGFhZGI2NGM1YTUyYThkMjBiLnNldENvbnRlbnQoaHRtbF9hNTY4YmUwYTNiOTY0ODYwYjMyM2JhMGM1NGViMGNlOSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8wYTZmNDU5ODk2NmM0ZjA1YWMzM2VlNTNlZGFmOWIwNC5iaW5kUG9wdXAocG9wdXBfMzFjZTJkMmJlOGMzNGU4YWFkYjY0YzVhNTJhOGQyMGIpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNzIxOGU4NGZjZWIzNDQ3YjgwOTA2MDY4N2QyMzUyYmYgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MTI3NTExLC03OS4zOTAxOTc1XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzA1MzdmNTc1YjEyODQ3ZWI4YTM5NGFiN2NmODVmMGEyID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2ExMGJlYzU2YzJiMzRhZDhiNWRhZDE2MjE5NzBmMDE5ID0gJCgnPGRpdiBpZD0iaHRtbF9hMTBiZWM1NmMyYjM0YWQ4YjVkYWQxNjIxOTcwZjAxOSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RGF2aXN2aWxsZSBOb3J0aCwgQ2VudHJhbCBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8wNTM3ZjU3NWIxMjg0N2ViOGEzOTRhYjdjZjg1ZjBhMi5zZXRDb250ZW50KGh0bWxfYTEwYmVjNTZjMmIzNGFkOGI1ZGFkMTYyMTk3MGYwMTkpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNzIxOGU4NGZjZWIzNDQ3YjgwOTA2MDY4N2QyMzUyYmYuYmluZFBvcHVwKHBvcHVwXzA1MzdmNTc1YjEyODQ3ZWI4YTM5NGFiN2NmODVmMGEyKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2NjODk2OTJhYzUyMTQ5MWU5N2M1NWI1NjY0Zjg4YTljID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjk2OTQ3NiwtNzkuNDExMzA3MjAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfM2YzYTFkNDBhNGE2NDJjODgwNGY4ZGU0NTIyZWQyNTQgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNGFmZDYzNzMyNTY4NGZmZDhlZTU4YzU1YjQ5MTMzMmQgPSAkKCc8ZGl2IGlkPSJodG1sXzRhZmQ2MzczMjU2ODRmZmQ4ZWU1OGM1NWI0OTEzMzJkIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Gb3Jlc3QgSGlsbCBOb3J0aCxGb3Jlc3QgSGlsbCBXZXN0LCBDZW50cmFsIFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzNmM2ExZDQwYTRhNjQyYzg4MDRmOGRlNDUyMmVkMjU0LnNldENvbnRlbnQoaHRtbF80YWZkNjM3MzI1Njg0ZmZkOGVlNThjNTViNDkxMzMyZCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9jYzg5NjkyYWM1MjE0OTFlOTdjNTViNTY2NGY4OGE5Yy5iaW5kUG9wdXAocG9wdXBfM2YzYTFkNDBhNGE2NDJjODgwNGY4ZGU0NTIyZWQyNTQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNTViYzRmMmVlODIyNGYxODljMjBiZDJlN2EwYzI2M2IgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NjE2MDgzLC03OS40NjQ3NjMyOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8xZjNmYmE2Yjk3MmQ0N2EwYmJmOGQxZWQwMzdmYjE0OSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8zMTRjZjQ1ZGM2ZDQ0NTI1YmQ0Yzg0Nzk0OThiMWY1NyA9ICQoJzxkaXYgaWQ9Imh0bWxfMzE0Y2Y0NWRjNmQ0NDUyNWJkNGM4NDc5NDk4YjFmNTciIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkhpZ2ggUGFyayxUaGUgSnVuY3Rpb24gU291dGgsIFdlc3QgVG9yb250bzwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMWYzZmJhNmI5NzJkNDdhMGJiZjhkMWVkMDM3ZmIxNDkuc2V0Q29udGVudChodG1sXzMxNGNmNDVkYzZkNDQ1MjViZDRjODQ3OTQ5OGIxZjU3KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzU1YmM0ZjJlZTgyMjRmMTg5YzIwYmQyZTdhMGMyNjNiLmJpbmRQb3B1cChwb3B1cF8xZjNmYmE2Yjk3MmQ0N2EwYmJmOGQxZWQwMzdmYjE0OSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9jYTc4OWM1YWZiMzE0MTdmYWE2ZDMxNzYyOTExZmJmNiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY5NjMxOSwtNzkuNTMyMjQyNDAwMDAwMDJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNTM0YzcxNGEyYTllNDhiMzgwMDY4MDYyOTlmNzk2N2MgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfOTdjMzRjNTQ0ZjI5NGFhNjkzYzFkZWNmZTFiZTQ5MmQgPSAkKCc8ZGl2IGlkPSJodG1sXzk3YzM0YzU0NGYyOTRhYTY5M2MxZGVjZmUxYmU0OTJkIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5XZXN0bW91bnQsIEV0b2JpY29rZTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNTM0YzcxNGEyYTllNDhiMzgwMDY4MDYyOTlmNzk2N2Muc2V0Q29udGVudChodG1sXzk3YzM0YzU0NGYyOTRhYTY5M2MxZGVjZmUxYmU0OTJkKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2NhNzg5YzVhZmIzMTQxN2ZhYTZkMzE3NjI5MTFmYmY2LmJpbmRQb3B1cChwb3B1cF81MzRjNzE0YTJhOWU0OGIzODAwNjgwNjI5OWY3OTY3Yyk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl82NmQ2ZGE5M2QwOGI0MmRiYWQ1ODJlNWE2NjA2ODczNCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc1MDA3MTUwMDAwMDAwNCwtNzkuMjk1ODQ5MV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9mMTJiNWJhN2NhNDM0ZTc5YTRiM2YxMWJlMGRlZWJlOSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8zYzZlNTExOTVkNGQ0NDdjYjMwZTkwMzE4NTcyMjJkZCA9ICQoJzxkaXYgaWQ9Imh0bWxfM2M2ZTUxMTk1ZDRkNDQ3Y2IzMGU5MDMxODU3MjIyZGQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPk1hcnl2YWxlLFdleGZvcmQsIFNjYXJib3JvdWdoPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9mMTJiNWJhN2NhNDM0ZTc5YTRiM2YxMWJlMGRlZWJlOS5zZXRDb250ZW50KGh0bWxfM2M2ZTUxMTk1ZDRkNDQ3Y2IzMGU5MDMxODU3MjIyZGQpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNjZkNmRhOTNkMDhiNDJkYmFkNTgyZTVhNjYwNjg3MzQuYmluZFBvcHVwKHBvcHVwX2YxMmI1YmE3Y2E0MzRlNzlhNGIzZjExYmUwZGVlYmU5KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzc5NjkwNWYxMDU1YzQ1NWFhZDczMWIyMTQ1OTgzODQ4ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzgyNzM2NCwtNzkuNDQyMjU5M10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8yOGM5ODhhZTY3Mjg0NDIyYjhiNjQ5OGQyYjRjZjU0ZCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF81YmJjYWI2MGQ0NWE0N2E4ODI1NzI5MTUwZGY1MDIzYiA9ICQoJzxkaXYgaWQ9Imh0bWxfNWJiY2FiNjBkNDVhNDdhODgyNTcyOTE1MGRmNTAyM2IiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPldpbGxvd2RhbGUgV2VzdCwgTm9ydGggWW9yazwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMjhjOTg4YWU2NzI4NDQyMmI4YjY0OThkMmI0Y2Y1NGQuc2V0Q29udGVudChodG1sXzViYmNhYjYwZDQ1YTQ3YTg4MjU3MjkxNTBkZjUwMjNiKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzc5NjkwNWYxMDU1YzQ1NWFhZDczMWIyMTQ1OTgzODQ4LmJpbmRQb3B1cChwb3B1cF8yOGM5ODhhZTY3Mjg0NDIyYjhiNjQ5OGQyYjRjZjU0ZCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9iODYyMWRkOWQ0OGE0NzQzYTUzMTU5NzlhMjFhN2MyNyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcxNTM4MzQsLTc5LjQwNTY3ODQwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzE4MGVhZjFhZTRjMTRkNzhiNDVlMjdiZDhjYjkzZWZkID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2RhZWZiOGU0YjAzODQ0YzZiMjg4YTA2YWI0ZWM2NDU0ID0gJCgnPGRpdiBpZD0iaHRtbF9kYWVmYjhlNGIwMzg0NGM2YjI4OGEwNmFiNGVjNjQ1NCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Tm9ydGggVG9yb250byBXZXN0LCBDZW50cmFsIFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzE4MGVhZjFhZTRjMTRkNzhiNDVlMjdiZDhjYjkzZWZkLnNldENvbnRlbnQoaHRtbF9kYWVmYjhlNGIwMzg0NGM2YjI4OGEwNmFiNGVjNjQ1NCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9iODYyMWRkOWQ0OGE0NzQzYTUzMTU5NzlhMjFhN2MyNy5iaW5kUG9wdXAocG9wdXBfMTgwZWFmMWFlNGMxNGQ3OGI0NWUyN2JkOGNiOTNlZmQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMjc3YzNkNjFiYWVjNDg1YTlkODdkNzBiNzA1NDQyMGUgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NzI3MDk3LC03OS40MDU2Nzg0MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8zMmQwZTVjZjUxMmY0ZTU5YTI5MGNmYTY4OWUzMGY5OSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8zYmVhM2Q4MTM4ZjQ0Y2RjYjZjY2YxOWQzZDkxMjE4MiA9ICQoJzxkaXYgaWQ9Imh0bWxfM2JlYTNkODEzOGY0NGNkY2I2Y2NmMTlkM2Q5MTIxODIiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlRoZSBBbm5leCxOb3J0aCBNaWR0b3duLFlvcmt2aWxsZSwgQ2VudHJhbCBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8zMmQwZTVjZjUxMmY0ZTU5YTI5MGNmYTY4OWUzMGY5OS5zZXRDb250ZW50KGh0bWxfM2JlYTNkODEzOGY0NGNkY2I2Y2NmMTlkM2Q5MTIxODIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMjc3YzNkNjFiYWVjNDg1YTlkODdkNzBiNzA1NDQyMGUuYmluZFBvcHVwKHBvcHVwXzMyZDBlNWNmNTEyZjRlNTlhMjkwY2ZhNjg5ZTMwZjk5KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzFlMjlkNGRhYTZjMDRkNWFiYTcwMDBkM2QzM2YxMDljID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjQ4OTU5NywtNzkuNDU2MzI1XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzhlOTUzZGY2OGE5ZDQ0NmRiOGU1MTQ4N2M0YzExMWVjID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzJiYTY1OGNiZDE0OTRhNGI4MDcwYjU4NTM3ZDQ0OWEwID0gJCgnPGRpdiBpZD0iaHRtbF8yYmE2NThjYmQxNDk0YTRiODA3MGI1ODUzN2Q0NDlhMCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+UGFya2RhbGUsUm9uY2VzdmFsbGVzLCBXZXN0IFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzhlOTUzZGY2OGE5ZDQ0NmRiOGU1MTQ4N2M0YzExMWVjLnNldENvbnRlbnQoaHRtbF8yYmE2NThjYmQxNDk0YTRiODA3MGI1ODUzN2Q0NDlhMCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8xZTI5ZDRkYWE2YzA0ZDVhYmE3MDAwZDNkMzNmMTA5Yy5iaW5kUG9wdXAocG9wdXBfOGU5NTNkZjY4YTlkNDQ2ZGI4ZTUxNDg3YzRjMTExZWMpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZmJjYzYwZGI0MzE4NGIwYWJiMzkwY2M0ZmQ2OWU1ZGMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42MzY5NjU2LC03OS42MTU4MTg5OTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF85NDcwODk1NWViYTg0NGJmOTMyNzIyNDg5ZjYwZjhlZCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9lMjNlYmJkM2NmYjY0N2ViODM3NTFkMjNjZjY0NDk0OCA9ICQoJzxkaXYgaWQ9Imh0bWxfZTIzZWJiZDNjZmI2NDdlYjgzNzUxZDIzY2Y2NDQ5NDgiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNhbmFkYSBQb3N0IEdhdGV3YXkgUHJvY2Vzc2luZyBDZW50cmUsIE1pc3Npc3NhdWdhPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF85NDcwODk1NWViYTg0NGJmOTMyNzIyNDg5ZjYwZjhlZC5zZXRDb250ZW50KGh0bWxfZTIzZWJiZDNjZmI2NDdlYjgzNzUxZDIzY2Y2NDQ5NDgpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZmJjYzYwZGI0MzE4NGIwYWJiMzkwY2M0ZmQ2OWU1ZGMuYmluZFBvcHVwKHBvcHVwXzk0NzA4OTU1ZWJhODQ0YmY5MzI3MjI0ODlmNjBmOGVkKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzRhYTc4NDg5OTA3MTQwMjBhM2VhMmYwZDk5MzMxY2ZlID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjg4OTA1NCwtNzkuNTU0NzI0NDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNmZjMzIxM2NjMzQ3NGE4ZDg1ZjZlNGM5NDA3YTcxNzggPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMTg2Nzc0ZjdhM2I4NGI3MzhjN2Y3ZDg5MzMxMjMyMmIgPSAkKCc8ZGl2IGlkPSJodG1sXzE4Njc3NGY3YTNiODRiNzM4YzdmN2Q4OTMzMTIzMjJiIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5LaW5nc3ZpZXcgVmlsbGFnZSxNYXJ0aW4gR3JvdmUgR2FyZGVucyxSaWNodmlldyBHYXJkZW5zLFN0LiBQaGlsbGlwcywgRXRvYmljb2tlPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF82ZmMzMjEzY2MzNDc0YThkODVmNmU0Yzk0MDdhNzE3OC5zZXRDb250ZW50KGh0bWxfMTg2Nzc0ZjdhM2I4NGI3MzhjN2Y3ZDg5MzMxMjMyMmIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNGFhNzg0ODk5MDcxNDAyMGEzZWEyZjBkOTkzMzFjZmUuYmluZFBvcHVwKHBvcHVwXzZmYzMyMTNjYzM0NzRhOGQ4NWY2ZTRjOTQwN2E3MTc4KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzVkZjE1MzVjNGFjOTQ1YmNhMWE4YTcyOTg2OTUzMTc5ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzk0MjAwMywtNzkuMjYyMDI5NDAwMDAwMDJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMTgxZWFkODc3MjM1NDI4MmE0ZDQ1NmQ0MmVmZDc0M2EgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYzUxMjYyZmZkNTA0NGYwYmExOTZlZjIxNjAxYjE4MTkgPSAkKCc8ZGl2IGlkPSJodG1sX2M1MTI2MmZmZDUwNDRmMGJhMTk2ZWYyMTYwMWIxODE5IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5BZ2luY291cnQsIFNjYXJib3JvdWdoPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8xODFlYWQ4NzcyMzU0MjgyYTRkNDU2ZDQyZWZkNzQzYS5zZXRDb250ZW50KGh0bWxfYzUxMjYyZmZkNTA0NGYwYmExOTZlZjIxNjAxYjE4MTkpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNWRmMTUzNWM0YWM5NDViY2ExYThhNzI5ODY5NTMxNzkuYmluZFBvcHVwKHBvcHVwXzE4MWVhZDg3NzIzNTQyODJhNGQ0NTZkNDJlZmQ3NDNhKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzhiMzFlMDdhOWNkODQ0MzliMGQ2YjBmN2RlZjIxODNjID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzA0MzI0NCwtNzkuMzg4NzkwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9lNmYwZTRiMWNkOGE0ZjE0ODhiY2E1ZDIwOWViNmVlMCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8yMzI5YmZlZjY3NjU0MzUzYmQyNDExYTVmZjQxNDk5MiA9ICQoJzxkaXYgaWQ9Imh0bWxfMjMyOWJmZWY2NzY1NDM1M2JkMjQxMWE1ZmY0MTQ5OTIiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkRhdmlzdmlsbGUsIENlbnRyYWwgVG9yb250bzwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZTZmMGU0YjFjZDhhNGYxNDg4YmNhNWQyMDllYjZlZTAuc2V0Q29udGVudChodG1sXzIzMjliZmVmNjc2NTQzNTNiZDI0MTFhNWZmNDE0OTkyKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzhiMzFlMDdhOWNkODQ0MzliMGQ2YjBmN2RlZjIxODNjLmJpbmRQb3B1cChwb3B1cF9lNmYwZTRiMWNkOGE0ZjE0ODhiY2E1ZDIwOWViNmVlMCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8yZGRiNTExZTRmNmY0ODVmOGZhY2YwNjhiNDY1MjdmZCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2MjY5NTYsLTc5LjQwMDA0OTNdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfOWNmZGZhNGU0MTQ0NGQ0NmE0NWZhODA2ODhmNWNmZDQgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYmFjYzViYzlhZDg1NDY5YjhhYmY3Y2M5ZWMwNmYwZDggPSAkKCc8ZGl2IGlkPSJodG1sX2JhY2M1YmM5YWQ4NTQ2OWI4YWJmN2NjOWVjMDZmMGQ4IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5IYXJib3JkLFVuaXZlcnNpdHkgb2YgVG9yb250bywgRG93bnRvd24gVG9yb250bzwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfOWNmZGZhNGU0MTQ0NGQ0NmE0NWZhODA2ODhmNWNmZDQuc2V0Q29udGVudChodG1sX2JhY2M1YmM5YWQ4NTQ2OWI4YWJmN2NjOWVjMDZmMGQ4KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzJkZGI1MTFlNGY2ZjQ4NWY4ZmFjZjA2OGI0NjUyN2ZkLmJpbmRQb3B1cChwb3B1cF85Y2ZkZmE0ZTQxNDQ0ZDQ2YTQ1ZmE4MDY4OGY1Y2ZkNCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8xZDc0ZWEyZmI0ZDg0NTgwODBjNzVkMWZmMWUzYmY4OCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY1MTU3MDYsLTc5LjQ4NDQ0OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZmY3NGQ2MzExMzY3NDUyMGE3NDgyMWVlZjZhZTI3NTAgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYzc3YjRhZmQ0NmQyNDFjMTkxYWIwNWRlYmY2NDcxZGUgPSAkKCc8ZGl2IGlkPSJodG1sX2M3N2I0YWZkNDZkMjQxYzE5MWFiMDVkZWJmNjQ3MWRlIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5SdW5ueW1lZGUsU3dhbnNlYSwgV2VzdCBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9mZjc0ZDYzMTEzNjc0NTIwYTc0ODIxZWVmNmFlMjc1MC5zZXRDb250ZW50KGh0bWxfYzc3YjRhZmQ0NmQyNDFjMTkxYWIwNWRlYmY2NDcxZGUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMWQ3NGVhMmZiNGQ4NDU4MDgwYzc1ZDFmZjFlM2JmODguYmluZFBvcHVwKHBvcHVwX2ZmNzRkNjMxMTM2NzQ1MjBhNzQ4MjFlZWY2YWUyNzUwKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzZkNjZhOGI3ZTkxODQ0M2Q5YmUyYjU0YzVjZDVjZTg0ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzgxNjM3NSwtNzkuMzA0MzAyMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9iNWQyNmY1YjJhNjk0NDAyOTc4OTJlNWM3YjAyZTVhZiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9iZDVhZjNhZjcwZDY0NGMyYmFmZTc3ZjJhYjcwMGMyOSA9ICQoJzxkaXYgaWQ9Imh0bWxfYmQ1YWYzYWY3MGQ2NDRjMmJhZmU3N2YyYWI3MDBjMjkiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNsYXJrcyBDb3JuZXJzLFN1bGxpdmFuLFRhbSBPJiMzOTtTaGFudGVyLCBTY2FyYm9yb3VnaDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYjVkMjZmNWIyYTY5NDQwMjk3ODkyZTVjN2IwMmU1YWYuc2V0Q29udGVudChodG1sX2JkNWFmM2FmNzBkNjQ0YzJiYWZlNzdmMmFiNzAwYzI5KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzZkNjZhOGI3ZTkxODQ0M2Q5YmUyYjU0YzVjZDVjZTg0LmJpbmRQb3B1cChwb3B1cF9iNWQyNmY1YjJhNjk0NDAyOTc4OTJlNWM3YjAyZTVhZik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9jYjVjOTVjODk1Zjg0YTQwOThmMjZhNzE2ZTJhNGI3ZCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY4OTU3NDMsLTc5LjM4MzE1OTkwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzUyZGQzZDA3Y2NmNDRiMTc5M2EyMjk3MTRmZWFjYTQxID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzlkMjZkNTU4YjFmMTQ2NGNiMTY3YzFiYWE1NWRkOTc4ID0gJCgnPGRpdiBpZD0iaHRtbF85ZDI2ZDU1OGIxZjE0NjRjYjE2N2MxYmFhNTVkZDk3OCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+TW9vcmUgUGFyayxTdW1tZXJoaWxsIEVhc3QsIENlbnRyYWwgVG9yb250bzwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNTJkZDNkMDdjY2Y0NGIxNzkzYTIyOTcxNGZlYWNhNDEuc2V0Q29udGVudChodG1sXzlkMjZkNTU4YjFmMTQ2NGNiMTY3YzFiYWE1NWRkOTc4KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2NiNWM5NWM4OTVmODRhNDA5OGYyNmE3MTZlMmE0YjdkLmJpbmRQb3B1cChwb3B1cF81MmRkM2QwN2NjZjQ0YjE3OTNhMjI5NzE0ZmVhY2E0MSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9lNzJhYTIwOTg3MWE0MzAyODNjNWM4ZjQ5OWMzOGNlNyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY1MzIwNTcsLTc5LjQwMDA0OTNdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYzg4MWNjZmNhMWY1NDc2YThjMjZkMDhjNGFhMGJhY2YgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNzMxNzljNWUyODUxNGY5NWE2N2QzMzQzNjU5ZTIyODUgPSAkKCc8ZGl2IGlkPSJodG1sXzczMTc5YzVlMjg1MTRmOTVhNjdkMzM0MzY1OWUyMjg1IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5DaGluYXRvd24sR3JhbmdlIFBhcmssS2Vuc2luZ3RvbiBNYXJrZXQsIERvd250b3duIFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2M4ODFjY2ZjYTFmNTQ3NmE4YzI2ZDA4YzRhYTBiYWNmLnNldENvbnRlbnQoaHRtbF83MzE3OWM1ZTI4NTE0Zjk1YTY3ZDMzNDM2NTllMjI4NSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9lNzJhYTIwOTg3MWE0MzAyODNjNWM4ZjQ5OWMzOGNlNy5iaW5kUG9wdXAocG9wdXBfYzg4MWNjZmNhMWY1NDc2YThjMjZkMDhjNGFhMGJhY2YpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZDMxODJmNTFjZDJiNDJlNWFjOTRkNzVkNWZkZDgxZTcgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My44MTUyNTIyLC03OS4yODQ1NzcyXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2Y0NGY1NWJjODIwZDQ4ZjI5MTc1MzEwOGViMjA3NWZhID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzRhZjFkYTQ0ODRiNTQ5ZTI4MGUxZWVlMGJhMzljYjk2ID0gJCgnPGRpdiBpZD0iaHRtbF80YWYxZGE0NDg0YjU0OWUyODBlMWVlZTBiYTM5Y2I5NiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+QWdpbmNvdXJ0IE5vcnRoLEwmIzM5O0Ftb3JlYXV4IEVhc3QsTWlsbGlrZW4sU3RlZWxlcyBFYXN0LCBTY2FyYm9yb3VnaDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZjQ0ZjU1YmM4MjBkNDhmMjkxNzUzMTA4ZWIyMDc1ZmEuc2V0Q29udGVudChodG1sXzRhZjFkYTQ0ODRiNTQ5ZTI4MGUxZWVlMGJhMzljYjk2KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2QzMTgyZjUxY2QyYjQyZTVhYzk0ZDc1ZDVmZGQ4MWU3LmJpbmRQb3B1cChwb3B1cF9mNDRmNTViYzgyMGQ0OGYyOTE3NTMxMDhlYjIwNzVmYSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9jMWEzNWY4ZGEwZTY0MzdjOTY1NTc5MzZmNTUwMzkxYyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY4NjQxMjI5OTk5OTk5LC03OS40MDAwNDkzXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2JmYjdiMzM1ZmM2NjRlYWM5MWQ2MGEzN2VjNjVlNzM1ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzRiODk3MzE1NTRlMjQxZDQ5NGE3ZjU1N2JjMTUxZjg4ID0gJCgnPGRpdiBpZD0iaHRtbF80Yjg5NzMxNTU0ZTI0MWQ0OTRhN2Y1NTdiYzE1MWY4OCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RGVlciBQYXJrLEZvcmVzdCBIaWxsIFNFLFJhdGhuZWxseSxTb3V0aCBIaWxsLFN1bW1lcmhpbGwgV2VzdCwgQ2VudHJhbCBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9iZmI3YjMzNWZjNjY0ZWFjOTFkNjBhMzdlYzY1ZTczNS5zZXRDb250ZW50KGh0bWxfNGI4OTczMTU1NGUyNDFkNDk0YTdmNTU3YmMxNTFmODgpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYzFhMzVmOGRhMGU2NDM3Yzk2NTU3OTM2ZjU1MDM5MWMuYmluZFBvcHVwKHBvcHVwX2JmYjdiMzM1ZmM2NjRlYWM5MWQ2MGEzN2VjNjVlNzM1KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzJjMzIzMmE5ZjhkNjRlNDU4YTg5NDc5MTBlMTgzNjNkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjI4OTQ2NywtNzkuMzk0NDE5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF82YTZhNWVkMjQzN2Y0ZDYyYTZmMmY3NjU2MzA5YjI2OCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9jYmRmMGQwMDZkOGM0MzY1OTA3OGEyZDNjMWMzMWY2NiA9ICQoJzxkaXYgaWQ9Imh0bWxfY2JkZjBkMDA2ZDhjNDM2NTkwNzhhMmQzYzFjMzFmNjYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNOIFRvd2VyLEJhdGh1cnN0IFF1YXksSXNsYW5kIGFpcnBvcnQsSGFyYm91cmZyb250IFdlc3QsS2luZyBhbmQgU3BhZGluYSxSYWlsd2F5IExhbmRzLFNvdXRoIE5pYWdhcmEsIERvd250b3duIFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzZhNmE1ZWQyNDM3ZjRkNjJhNmYyZjc2NTYzMDliMjY4LnNldENvbnRlbnQoaHRtbF9jYmRmMGQwMDZkOGM0MzY1OTA3OGEyZDNjMWMzMWY2Nik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8yYzMyMzJhOWY4ZDY0ZTQ1OGE4OTQ3OTEwZTE4MzYzZC5iaW5kUG9wdXAocG9wdXBfNmE2YTVlZDI0MzdmNGQ2MmE2ZjJmNzY1NjMwOWIyNjgpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZTM0NmM5NDVhYjAyNDg2MmI4YTNhMTAwYTIyZjBlZTkgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42MDU2NDY2LC03OS41MDEzMjA3MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8zMThiOTAyNzBmNjI0MjYyYTdhZTRhMzE3NmE0YTI5MCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8xMzViNjAzZjA4ZWM0MDkwOGE2ZmQ5MGI1NzNlZTI1NyA9ICQoJzxkaXYgaWQ9Imh0bWxfMTM1YjYwM2YwOGVjNDA5MDhhNmZkOTBiNTczZWUyNTciIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkh1bWJlciBCYXkgU2hvcmVzLE1pbWljbyBTb3V0aCxOZXcgVG9yb250bywgRXRvYmljb2tlPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8zMThiOTAyNzBmNjI0MjYyYTdhZTRhMzE3NmE0YTI5MC5zZXRDb250ZW50KGh0bWxfMTM1YjYwM2YwOGVjNDA5MDhhNmZkOTBiNTczZWUyNTcpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZTM0NmM5NDVhYjAyNDg2MmI4YTNhMTAwYTIyZjBlZTkuYmluZFBvcHVwKHBvcHVwXzMxOGI5MDI3MGY2MjQyNjJhN2FlNGEzMTc2YTRhMjkwKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2NlMjUwZDJhZGRlNDQwZGFhNDViZDgxM2I0YjkzOWEyID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzM5NDE2Mzk5OTk5OTk2LC03OS41ODg0MzY5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzE1NjFhZjg3YTljMDRmMjliNzY1OTYwYmY5ZjIzNWU1ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzhhMzk5MDFmNDc1NzQ2YjI4M2JmMDBlNTc5NjVmODRmID0gJCgnPGRpdiBpZD0iaHRtbF84YTM5OTAxZjQ3NTc0NmIyODNiZjAwZTU3OTY1Zjg0ZiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+QWxiaW9uIEdhcmRlbnMsQmVhdW1vbmQgSGVpZ2h0cyxIdW1iZXJnYXRlLEphbWVzdG93bixNb3VudCBPbGl2ZSxTaWx2ZXJzdG9uZSxTb3V0aCBTdGVlbGVzLFRoaXN0bGV0b3duLCBFdG9iaWNva2U8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzE1NjFhZjg3YTljMDRmMjliNzY1OTYwYmY5ZjIzNWU1LnNldENvbnRlbnQoaHRtbF84YTM5OTAxZjQ3NTc0NmIyODNiZjAwZTU3OTY1Zjg0Zik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9jZTI1MGQyYWRkZTQ0MGRhYTQ1YmQ4MTNiNGI5MzlhMi5iaW5kUG9wdXAocG9wdXBfMTU2MWFmODdhOWMwNGYyOWI3NjU5NjBiZjlmMjM1ZTUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfOGRlOTFkMWVlYWQ3NDVkZmFjNWE3YWFiZGI5NTI1ZTggPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43OTk1MjUyMDAwMDAwMDUsLTc5LjMxODM4ODddLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZGJmMzg3NjhiMGY3NDBjMThkZTJhNjM4MDU0NzlkMmEgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfY2ZlZTlmOGVmNzFhNDFjMjlhNDc3YjE1MGFhMjdmMTQgPSAkKCc8ZGl2IGlkPSJodG1sX2NmZWU5ZjhlZjcxYTQxYzI5YTQ3N2IxNTBhYTI3ZjE0IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5MJiMzOTtBbW9yZWF1eCBXZXN0LCBTY2FyYm9yb3VnaDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZGJmMzg3NjhiMGY3NDBjMThkZTJhNjM4MDU0NzlkMmEuc2V0Q29udGVudChodG1sX2NmZWU5ZjhlZjcxYTQxYzI5YTQ3N2IxNTBhYTI3ZjE0KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzhkZTkxZDFlZWFkNzQ1ZGZhYzVhN2FhYmRiOTUyNWU4LmJpbmRQb3B1cChwb3B1cF9kYmYzODc2OGIwZjc0MGMxOGRlMmE2MzgwNTQ3OWQyYSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9mMzE2OWVlNTZlNjE0YTRlYWZhMTJlNjkyMmM4NjBiNyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY3OTU2MjYsLTc5LjM3NzUyOTQwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzg1YWEzOWFkYjY1OTQxYzk4YjA1MjllNzFkNjE4ZmQwID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzQ1ZmRkYzZkMDA5MjRmODhiZjM5MzFlNzkwNjcyMjllID0gJCgnPGRpdiBpZD0iaHRtbF80NWZkZGM2ZDAwOTI0Zjg4YmYzOTMxZTc5MDY3MjI5ZSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Um9zZWRhbGUsIERvd250b3duIFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzg1YWEzOWFkYjY1OTQxYzk4YjA1MjllNzFkNjE4ZmQwLnNldENvbnRlbnQoaHRtbF80NWZkZGM2ZDAwOTI0Zjg4YmYzOTMxZTc5MDY3MjI5ZSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9mMzE2OWVlNTZlNjE0YTRlYWZhMTJlNjkyMmM4NjBiNy5iaW5kUG9wdXAocG9wdXBfODVhYTM5YWRiNjU5NDFjOThiMDUyOWU3MWQ2MThmZDApOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMWI4ZWQ4MWIxNjY5NGJhMTkwNjM2MTBkZDJiYmI0MGQgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NDY0MzUyLC03OS4zNzQ4NDU5OTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF84MGRhYWYxZjRkMzU0Y2ZhOTQxY2UyMDVjMWU3NGRjNSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8wNjIzZTBiYWUzM2E0NTdlOTllZDcwZmRkMWJjZmM0NCA9ICQoJzxkaXYgaWQ9Imh0bWxfMDYyM2UwYmFlMzNhNDU3ZTk5ZWQ3MGZkZDFiY2ZjNDQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlN0biBBIFBPIEJveGVzIDI1IFRoZSBFc3BsYW5hZGUsIERvd250b3duIFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzgwZGFhZjFmNGQzNTRjZmE5NDFjZTIwNWMxZTc0ZGM1LnNldENvbnRlbnQoaHRtbF8wNjIzZTBiYWUzM2E0NTdlOTllZDcwZmRkMWJjZmM0NCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8xYjhlZDgxYjE2Njk0YmExOTA2MzYxMGRkMmJiYjQwZC5iaW5kUG9wdXAocG9wdXBfODBkYWFmMWY0ZDM1NGNmYTk0MWNlMjA1YzFlNzRkYzUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfODdlNWFlYTc5NTczNDI5ZWI2ZDBhMmJiYWYyNzNiNmYgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42MDI0MTM3MDAwMDAwMSwtNzkuNTQzNDg0MDk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMWFlM2M2YWMyMmE4NGNiZWE2ZGIxODYwNmYzZDQ3NWYgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZWUzZjgwN2MyOGMzNDFiYTg3NTk0M2E3NTA0ZTc3ZWIgPSAkKCc8ZGl2IGlkPSJodG1sX2VlM2Y4MDdjMjhjMzQxYmE4NzU5NDNhNzUwNGU3N2ViIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5BbGRlcndvb2QsTG9uZyBCcmFuY2gsIEV0b2JpY29rZTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMWFlM2M2YWMyMmE4NGNiZWE2ZGIxODYwNmYzZDQ3NWYuc2V0Q29udGVudChodG1sX2VlM2Y4MDdjMjhjMzQxYmE4NzU5NDNhNzUwNGU3N2ViKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzg3ZTVhZWE3OTU3MzQyOWViNmQwYTJiYmFmMjczYjZmLmJpbmRQb3B1cChwb3B1cF8xYWUzYzZhYzIyYTg0Y2JlYTZkYjE4NjA2ZjNkNDc1Zik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8xNzY5NmMwZDg1MGI0ZWJiOTllNDhkZTQ3MDE2NDEyNCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcwNjc0ODI5OTk5OTk5NCwtNzkuNTk0MDU0NF0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9jNmJmMDBiMWNlYTM0ZjM0YTRiMzg3NDlkMTVkZDk5MiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF82ZTRlYWFmOTRkYzM0Y2IxYWU3OTNjN2ZhYjYwNmRlZiA9ICQoJzxkaXYgaWQ9Imh0bWxfNmU0ZWFhZjk0ZGMzNGNiMWFlNzkzYzdmYWI2MDZkZWYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPk5vcnRod2VzdCwgRXRvYmljb2tlPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9jNmJmMDBiMWNlYTM0ZjM0YTRiMzg3NDlkMTVkZDk5Mi5zZXRDb250ZW50KGh0bWxfNmU0ZWFhZjk0ZGMzNGNiMWFlNzkzYzdmYWI2MDZkZWYpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMTc2OTZjMGQ4NTBiNGViYjk5ZTQ4ZGU0NzAxNjQxMjQuYmluZFBvcHVwKHBvcHVwX2M2YmYwMGIxY2VhMzRmMzRhNGIzODc0OWQxNWRkOTkyKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2IyMTdlNmU4ZWZiZDQ1ZWQ4ZWI5NGIwOGI3M2U3ZTk1ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuODM2MTI0NzAwMDAwMDA2LC03OS4yMDU2MzYwOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8zZGM0M2VhNzQyZGM0MjcwOGRhZWQ5ODkxZjM4ZjUwZSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF80NTcxMGQ3MzhmOTA0Yzc2YWM3NDVhOTkwNDEwNjI5NyA9ICQoJzxkaXYgaWQ9Imh0bWxfNDU3MTBkNzM4ZjkwNGM3NmFjNzQ1YTk5MDQxMDYyOTciIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlVwcGVyIFJvdWdlLCBTY2FyYm9yb3VnaDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfM2RjNDNlYTc0MmRjNDI3MDhkYWVkOTg5MWYzOGY1MGUuc2V0Q29udGVudChodG1sXzQ1NzEwZDczOGY5MDRjNzZhYzc0NWE5OTA0MTA2Mjk3KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2IyMTdlNmU4ZWZiZDQ1ZWQ4ZWI5NGIwOGI3M2U3ZTk1LmJpbmRQb3B1cChwb3B1cF8zZGM0M2VhNzQyZGM0MjcwOGRhZWQ5ODkxZjM4ZjUwZSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl81NzNhOWZlOTZhNGQ0YWJlYjQwMDlhZmE4YTU0MGU3MyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2Nzk2NywtNzkuMzY3Njc1M10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF82ODBhZjM3ZGJmNzc0Yjc4OWNhNTMwNjk2M2JhYWFkYiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9mNzU1MWVjNjJmNDA0ZmJmOWY0OGEzZjQwMzk5MzZjZiA9ICQoJzxkaXYgaWQ9Imh0bWxfZjc1NTFlYzYyZjQwNGZiZjlmNDhhM2Y0MDM5OTM2Y2YiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNhYmJhZ2V0b3duLFN0LiBKYW1lcyBUb3duLCBEb3dudG93biBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF82ODBhZjM3ZGJmNzc0Yjc4OWNhNTMwNjk2M2JhYWFkYi5zZXRDb250ZW50KGh0bWxfZjc1NTFlYzYyZjQwNGZiZjlmNDhhM2Y0MDM5OTM2Y2YpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNTczYTlmZTk2YTRkNGFiZWI0MDA5YWZhOGE1NDBlNzMuYmluZFBvcHVwKHBvcHVwXzY4MGFmMzdkYmY3NzRiNzg5Y2E1MzA2OTYzYmFhYWRiKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzc3YTFiNmI3OTZjZDQxZDVhNjU0ZGMzZmFiNmRhZTY5ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjQ4NDI5MiwtNzkuMzgyMjgwMl0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF82N2U3NmM3NDBlMzU0NmQyYWIzMTM2YWI3OTIxYjRjZSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9mNWZlMDM4YTkyY2I0MDE4YmM4NDMwNTdiZTE0MTgxZCA9ICQoJzxkaXYgaWQ9Imh0bWxfZjVmZTAzOGE5MmNiNDAxOGJjODQzMDU3YmUxNDE4MWQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkZpcnN0IENhbmFkaWFuIFBsYWNlLFVuZGVyZ3JvdW5kIGNpdHksIERvd250b3duIFRvcm9udG88L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzY3ZTc2Yzc0MGUzNTQ2ZDJhYjMxMzZhYjc5MjFiNGNlLnNldENvbnRlbnQoaHRtbF9mNWZlMDM4YTkyY2I0MDE4YmM4NDMwNTdiZTE0MTgxZCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl83N2ExYjZiNzk2Y2Q0MWQ1YTY1NGRjM2ZhYjZkYWU2OS5iaW5kUG9wdXAocG9wdXBfNjdlNzZjNzQwZTM1NDZkMmFiMzEzNmFiNzkyMWI0Y2UpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNDAxOTNmNmRlNGUwNDAzM2EwMzhjZTNkMGRjY2EyZTMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NTM2NTM2MDAwMDAwMDUsLTc5LjUwNjk0MzZdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNjMwMTljMjk1YTM2NGQ0Mjk3YWViYmMzYTg5ZjUzOTUgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNDFlOTY4MjhmN2M0NDQ2OTk4N2FhN2EyYWJmOWUzODggPSAkKCc8ZGl2IGlkPSJodG1sXzQxZTk2ODI4ZjdjNDQ0Njk5ODdhYTdhMmFiZjllMzg4IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5UaGUgS2luZ3N3YXksTW9udGdvbWVyeSBSb2FkLE9sZCBNaWxsIE5vcnRoLCBFdG9iaWNva2U8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzYzMDE5YzI5NWEzNjRkNDI5N2FlYmJjM2E4OWY1Mzk1LnNldENvbnRlbnQoaHRtbF80MWU5NjgyOGY3YzQ0NDY5OTg3YWE3YTJhYmY5ZTM4OCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl80MDE5M2Y2ZGU0ZTA0MDMzYTAzOGNlM2QwZGNjYTJlMy5iaW5kUG9wdXAocG9wdXBfNjMwMTljMjk1YTM2NGQ0Mjk3YWViYmMzYTg5ZjUzOTUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZjViMzI4YmQ1MDExNGJiNGJjOGMzZTEzYTk2OWQ2NWUgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NjU4NTk5LC03OS4zODMxNTk5MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICJibHVlIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzMxODZjYyIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF9jNzRmYzlmNjU5NzM0YWRlOWQ2NmM1NTA0ZjA5NTUzNSk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9iZDc0Yjc0MTllODg0ZmMzYWI0N2ZlN2JjOGU5YzhjNiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9hN2I3YjBmNzFhMjA0ZWNjODQ2N2ZkYTA2N2M5Y2Q2MiA9ICQoJzxkaXYgaWQ9Imh0bWxfYTdiN2IwZjcxYTIwNGVjYzg0NjdmZGEwNjdjOWNkNjIiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNodXJjaCBhbmQgV2VsbGVzbGV5LCBEb3dudG93biBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9iZDc0Yjc0MTllODg0ZmMzYWI0N2ZlN2JjOGU5YzhjNi5zZXRDb250ZW50KGh0bWxfYTdiN2IwZjcxYTIwNGVjYzg0NjdmZGEwNjdjOWNkNjIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZjViMzI4YmQ1MDExNGJiNGJjOGMzZTEzYTk2OWQ2NWUuYmluZFBvcHVwKHBvcHVwX2JkNzRiNzQxOWU4ODRmYzNhYjQ3ZmU3YmM4ZTljOGM2KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzE1YzkxYzM3MzYzOTRhNzk4YjMwYzg1OWI3YTYyNjdmID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjYyNzQzOSwtNzkuMzIxNTU4XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogImJsdWUiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMzE4NmNjIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwX2M3NGZjOWY2NTk3MzRhZGU5ZDY2YzU1MDRmMDk1NTM1KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzM5ZjQzYTcxOTYxODRhNDViNWI1M2Y1ZWE5ZDZmYzFjID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzIyYWEzZmZiN2VjYjQ4NGE4ZDNiZjI5NGI0ODM1MjdhID0gJCgnPGRpdiBpZD0iaHRtbF8yMmFhM2ZmYjdlY2I0ODRhOGQzYmYyOTRiNDgzNTI3YSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+QnVzaW5lc3MgUmVwbHkgTWFpbCBQcm9jZXNzaW5nIENlbnRyZSA5NjkgRWFzdGVybiwgRWFzdCBUb3JvbnRvPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8zOWY0M2E3MTk2MTg0YTQ1YjViNTNmNWVhOWQ2ZmMxYy5zZXRDb250ZW50KGh0bWxfMjJhYTNmZmI3ZWNiNDg0YThkM2JmMjk0YjQ4MzUyN2EpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMTVjOTFjMzczNjM5NGE3OThiMzBjODU5YjdhNjI2N2YuYmluZFBvcHVwKHBvcHVwXzM5ZjQzYTcxOTYxODRhNDViNWI1M2Y1ZWE5ZDZmYzFjKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzIxNmNlYWEzY2RiZDQ2NDE5NGZlMDNiMjE5MDdhMDgyID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjM2MjU3OSwtNzkuNDk4NTA5MDk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNjNmMWFiMmQ3YTAxNGVmNmE3ZWJhNDQ1ZDkxNWNiZTIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYjBmYTc0ODdiMjY3NDJiYWI4ZGY4NGYzZmRlZmM5MDkgPSAkKCc8ZGl2IGlkPSJodG1sX2IwZmE3NDg3YjI2NzQyYmFiOGRmODRmM2ZkZWZjOTA5IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5IdW1iZXIgQmF5LEtpbmcmIzM5O3MgTWlsbCBQYXJrLEtpbmdzd2F5IFBhcmsgU291dGggRWFzdCxNaW1pY28gTkUsT2xkIE1pbGwgU291dGgsVGhlIFF1ZWVuc3dheSBFYXN0LFJveWFsIFlvcmsgU291dGggRWFzdCxTdW5ueWxlYSwgRXRvYmljb2tlPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF82M2YxYWIyZDdhMDE0ZWY2YTdlYmE0NDVkOTE1Y2JlMi5zZXRDb250ZW50KGh0bWxfYjBmYTc0ODdiMjY3NDJiYWI4ZGY4NGYzZmRlZmM5MDkpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMjE2Y2VhYTNjZGJkNDY0MTk0ZmUwM2IyMTkwN2EwODIuYmluZFBvcHVwKHBvcHVwXzYzZjFhYjJkN2EwMTRlZjZhN2ViYTQ0NWQ5MTVjYmUyKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzgzYzUwMmQzYzk4MDQwZDJhYmYxZjE2ZjU0Y2IwMjBjID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjI4ODQwOCwtNzkuNTIwOTk5NDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiYmx1ZSIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMzMTg2Y2MiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfYzc0ZmM5ZjY1OTczNGFkZTlkNjZjNTUwNGYwOTU1MzUpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNmU4YTBkZTk1YzEzNDIzYWE4ODJhMzIzMTk5NGUzN2QgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNDRkODgwMjE5NGI0NDY2ZWIxMjkwYmEwZjE1NjI4YzAgPSAkKCc8ZGl2IGlkPSJodG1sXzQ0ZDg4MDIxOTRiNDQ2NmViMTI5MGJhMGYxNTYyOGMwIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5LaW5nc3dheSBQYXJrIFNvdXRoIFdlc3QsTWltaWNvIE5XLFRoZSBRdWVlbnN3YXkgV2VzdCxSb3lhbCBZb3JrIFNvdXRoIFdlc3QsU291dGggb2YgQmxvb3IsIEV0b2JpY29rZTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNmU4YTBkZTk1YzEzNDIzYWE4ODJhMzIzMTk5NGUzN2Quc2V0Q29udGVudChodG1sXzQ0ZDg4MDIxOTRiNDQ2NmViMTI5MGJhMGYxNTYyOGMwKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzgzYzUwMmQzYzk4MDQwZDJhYmYxZjE2ZjU0Y2IwMjBjLmJpbmRQb3B1cChwb3B1cF82ZThhMGRlOTVjMTM0MjNhYTg4MmEzMjMxOTk0ZTM3ZCk7CgogICAgICAgICAgICAKICAgICAgICAKPC9zY3JpcHQ+" style="position:absolute;width:100%;height:100%;left:0;top:0;border:none !important;" allowfullscreen webkitallowfullscreen mozallowfullscreen></iframe></div></div>




```python
CLIENT_ID = 'AC5FBDNGSWPK0ZTOXQBBVLG54QYJ1JIAZ5REXIOT0HWTXWCI' # your Foursquare ID
CLIENT_SECRET = 'AU4BZM5JRBEQDNXQKJYBYRNITH3VRTVKCCIZEVDO1LAHHLHT' # your Foursquare Secret
VERSION = '20180605' # Foursquare API version

print('Your credentails:')
print('CLIENT_ID: ' + CLIENT_ID)
print('CLIENT_SECRET:' + CLIENT_SECRET)


neighborhood_latitude = neighborhoods.loc[0, 'Latitude'] # neighborhood latitude value
neighborhood_longitude = neighborhoods.loc[0, 'Longitude'] # neighborhood longitude value

neighborhood_name = neighborhoods.loc[0, 'Neighbourhood'] # neighborhood name

print('Latitude and longitude values of {} are {}, {}.'.format(neighborhood_name, 
                                                               neighborhood_latitude, 
                                                               neighborhood_longitude))
```

    Your credentails:
    CLIENT_ID: AC5FBDNGSWPK0ZTOXQBBVLG54QYJ1JIAZ5REXIOT0HWTXWCI
    CLIENT_SECRET:AU4BZM5JRBEQDNXQKJYBYRNITH3VRTVKCCIZEVDO1LAHHLHT
    Latitude and longitude values of Parkwoods are 43.7532586, -79.3296565.
    


```python
LIMIT = 100 # limit of number of venues returned by Foursquare API
radius = 500 # define radius
url = 'https://api.foursquare.com/v2/venues/explore?&client_id={}&client_secret={}&v={}&ll={},{}&radius={}&limit={}'.format(
    CLIENT_ID, 
    CLIENT_SECRET, 
    VERSION, 
    neighborhood_latitude, 
    neighborhood_longitude, 
    radius, 
    LIMIT)
results = requests.get(url).json()
results 
```




    {'meta': {'code': 200, 'requestId': '5d3ff34f92e7a9002c0153a4'},
     'response': {'warning': {'text': "There aren't a lot of results near you. Try something more general, reset your filters, or expand the search area."},
      'headerLocation': 'Parkwoods - Donalda',
      'headerFullLocation': 'Parkwoods - Donalda, Toronto',
      'headerLocationGranularity': 'neighborhood',
      'totalResults': 3,
      'suggestedBounds': {'ne': {'lat': 43.757758604500005,
        'lng': -79.32343823984928},
       'sw': {'lat': 43.7487585955, 'lng': -79.33587476015072}},
      'groups': [{'type': 'Recommended Places',
        'name': 'recommended',
        'items': [{'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4e8d9dcdd5fbbbb6b3003c7b',
           'name': 'Brookbanks Park',
           'location': {'address': 'Toronto',
            'lat': 43.751976046055574,
            'lng': -79.33214044722958,
            'labeledLatLngs': [{'label': 'display',
              'lat': 43.751976046055574,
              'lng': -79.33214044722958}],
            'distance': 245,
            'cc': 'CA',
            'city': 'Toronto',
            'state': 'ON',
            'country': 'Canada',
            'formattedAddress': ['Toronto', 'Toronto ON', 'Canada']},
           'categories': [{'id': '4bf58dd8d48988d163941735',
             'name': 'Park',
             'pluralName': 'Parks',
             'shortName': 'Park',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/parks_outdoors/park_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4e8d9dcdd5fbbbb6b3003c7b-0'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4e6696b6d16433b9ffff47c3',
           'name': 'KFC',
           'location': {'lat': 43.75438666345904,
            'lng': -79.3330206627504,
            'labeledLatLngs': [{'label': 'display',
              'lat': 43.75438666345904,
              'lng': -79.3330206627504}],
            'distance': 298,
            'cc': 'CA',
            'country': 'Canada',
            'formattedAddress': ['Canada']},
           'categories': [{'id': '4bf58dd8d48988d16e941735',
             'name': 'Fast Food Restaurant',
             'pluralName': 'Fast Food Restaurants',
             'shortName': 'Fast Food',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/food/fastfood_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4e6696b6d16433b9ffff47c3-1'},
         {'reasons': {'count': 0,
           'items': [{'summary': 'This spot is popular',
             'type': 'general',
             'reasonName': 'globalInteractionReason'}]},
          'venue': {'id': '4cb11e2075ebb60cd1c4caad',
           'name': 'Variety Store',
           'location': {'address': '29 Valley Woods Road',
            'lat': 43.75197441585782,
            'lng': -79.33311418516017,
            'labeledLatLngs': [{'label': 'display',
              'lat': 43.75197441585782,
              'lng': -79.33311418516017}],
            'distance': 312,
            'cc': 'CA',
            'city': 'Toronto',
            'state': 'ON',
            'country': 'Canada',
            'formattedAddress': ['29 Valley Woods Road', 'Toronto ON', 'Canada']},
           'categories': [{'id': '4bf58dd8d48988d1f9941735',
             'name': 'Food & Drink Shop',
             'pluralName': 'Food & Drink Shops',
             'shortName': 'Food & Drink',
             'icon': {'prefix': 'https://ss3.4sqi.net/img/categories_v2/shops/foodanddrink_',
              'suffix': '.png'},
             'primary': True}],
           'photos': {'count': 0, 'groups': []}},
          'referralId': 'e-0-4cb11e2075ebb60cd1c4caad-2'}]}]}}




```python
# function that extracts the category of the venue
def get_category_type(row):
    try:
        categories_list = row['categories']
    except:
        categories_list = row['venue.categories']
        
    if len(categories_list) == 0:
        return None
    else:
        return categories_list[0]['name']

venues = results['response']['groups'][0]['items']
    
nearby_venues = json_normalize(venues) # flatten JSON

# filter columns
filtered_columns = ['venue.name', 'venue.categories', 'venue.location.lat', 'venue.location.lng']
nearby_venues =nearby_venues.loc[:, filtered_columns]

# filter the category for each row
nearby_venues['venue.categories'] = nearby_venues.apply(get_category_type, axis=1)

# clean columns
nearby_venues.columns = [col.split(".")[-1] for col in nearby_venues.columns]

nearby_venues.head()

print('{} venues were returned by Foursquare.'.format(nearby_venues.shape[0]))
```

    3 venues were returned by Foursquare.
    


```python
def getNearbyVenues(names, latitudes, longitudes, radius=500):
    
    venues_list=[]
    for name, lat, lng in zip(names, latitudes, longitudes):
        print(name)
            
        # create the API request URL
        url = 'https://api.foursquare.com/v2/venues/explore?&client_id={}&client_secret={}&v={}&ll={},{}&radius={}&limit={}'.format(
            CLIENT_ID, 
            CLIENT_SECRET, 
            VERSION, 
            lat, 
            lng, 
            radius, 
            LIMIT)
            
        # make the GET request
        results = requests.get(url).json()["response"]['groups'][0]['items']
        
        # return only relevant information for each nearby venue
        venues_list.append([(
            name, 
            lat, 
            lng, 
            v['venue']['name'], 
            v['venue']['location']['lat'], 
            v['venue']['location']['lng'],  
            v['venue']['categories'][0]['name']) for v in results])

    nearby_venues = pd.DataFrame([item for venue_list in venues_list for item in venue_list])
    nearby_venues.columns = ['Neighborhood', 
                  'Neighborhood Latitude', 
                  'Neighborhood Longitude', 
                  'Venue', 
                  'Venue Latitude', 
                  'Venue Longitude', 
                  'Venue Category']
    
    return(nearby_venues)
```


```python
Toronto_venues = getNearbyVenues(names=neighborhoods['Neighbourhood'],
                                   latitudes=neighborhoods['Latitude'],
                                   longitudes=neighborhoods['Longitude']
                                  )
print('There are {} uniques categories.'.format(len(Toronto_venues['Venue Category'].unique())))

# one hot encoding
Toronto_onehot = pd.get_dummies(Toronto_venues[['Venue Category']], prefix="", prefix_sep="")

# add neighborhood column back to dataframe
Toronto_onehot['Neighborhood'] = Toronto_venues['Neighborhood'] 

# move neighborhood column to the first column
fixed_columns = [Toronto_onehot.columns[-1]] + list(Toronto_onehot.columns[:-1])
Toronto_onehot = Toronto_onehot[fixed_columns]

Toronto_onehot.head()

Toronto_grouped = Toronto_onehot.groupby('Neighborhood').mean().reset_index()

num_top_venues = 5
```

    Parkwoods
    Victoria Village
    Harbourfront,Regent Park
    Lawrence Heights,Lawrence Manor
    Queen's Park
    Islington Avenue
    Rouge,Malvern
    Don Mills North
    Woodbine Gardens,Parkview Hill
    Ryerson,Garden District
    Glencairn
    Cloverdale,Islington,Martin Grove,Princess Gardens,West Deane Park
    Highland Creek,Rouge Hill,Port Union
    Flemingdon Park,Don Mills South
    Woodbine Heights
    St. James Town
    Humewood-Cedarvale
    Bloordale Gardens,Eringate,Markland Wood,Old Burnhamthorpe
    Guildwood,Morningside,West Hill
    The Beaches
    Berczy Park
    Caledonia-Fairbanks
    Woburn
    Leaside
    Central Bay Street
    Christie
    Cedarbrae
    Hillcrest Village
    Bathurst Manor,Downsview North,Wilson Heights
    Thorncliffe Park
    Adelaide,King,Richmond
    Dovercourt Village,Dufferin
    Scarborough Village
    Fairview,Henry Farm,Oriole
    Northwood Park,York University
    East Toronto
    Harbourfront East,Toronto Islands,Union Station
    Little Portugal,Trinity
    East Birchmount Park,Ionview,Kennedy Park
    Bayview Village
    CFB Toronto,Downsview East
    The Danforth West,Riverdale
    Design Exchange,Toronto Dominion Centre
    Brockton,Exhibition Place,Parkdale Village
    Clairlea,Golden Mile,Oakridge
    Silver Hills,York Mills
    Downsview West
    The Beaches West,India Bazaar
    Commerce Court,Victoria Hotel
    Downsview,North Park,Upwood Park
    Humber Summit
    Cliffcrest,Cliffside,Scarborough Village West
    Newtonbrook,Willowdale
    Downsview Central
    Studio District
    Bedford Park,Lawrence Manor East
    Del Ray,Keelesdale,Mount Dennis,Silverthorn
    Emery,Humberlea
    Birch Cliff,Cliffside West
    Willowdale South
    Downsview Northwest
    Lawrence Park
    Roselawn
    The Junction North,Runnymede
    Weston
    Dorset Park,Scarborough Town Centre,Wexford Heights
    York Mills West
    Davisville North
    Forest Hill North,Forest Hill West
    High Park,The Junction South
    Westmount
    Maryvale,Wexford
    Willowdale West
    North Toronto West
    The Annex,North Midtown,Yorkville
    Parkdale,Roncesvalles
    Canada Post Gateway Processing Centre
    Kingsview Village,Martin Grove Gardens,Richview Gardens,St. Phillips
    Agincourt
    Davisville
    Harbord,University of Toronto
    Runnymede,Swansea
    Clarks Corners,Sullivan,Tam O'Shanter
    Moore Park,Summerhill East
    Chinatown,Grange Park,Kensington Market
    Agincourt North,L'Amoreaux East,Milliken,Steeles East
    Deer Park,Forest Hill SE,Rathnelly,South Hill,Summerhill West
    CN Tower,Bathurst Quay,Island airport,Harbourfront West,King and Spadina,Railway Lands,South Niagara
    Humber Bay Shores,Mimico South,New Toronto
    Albion Gardens,Beaumond Heights,Humbergate,Jamestown,Mount Olive,Silverstone,South Steeles,Thistletown
    L'Amoreaux West
    Rosedale
    Stn A PO Boxes 25 The Esplanade
    Alderwood,Long Branch
    Northwest
    Upper Rouge
    Cabbagetown,St. James Town
    First Canadian Place,Underground city
    The Kingsway,Montgomery Road,Old Mill North
    Church and Wellesley
    Business Reply Mail Processing Centre 969 Eastern
    Humber Bay,King's Mill Park,Kingsway Park South East,Mimico NE,Old Mill South,The Queensway East,Royal York South East,Sunnylea
    Kingsway Park South West,Mimico NW,The Queensway West,Royal York South West,South of Bloor
    There are 279 uniques categories.
    


```python
Toronto_grouped.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Neighborhood</th>
      <th>Yoga Studio</th>
      <th>Accessories Store</th>
      <th>Afghan Restaurant</th>
      <th>Airport</th>
      <th>Airport Food Court</th>
      <th>Airport Gate</th>
      <th>Airport Lounge</th>
      <th>Airport Service</th>
      <th>Airport Terminal</th>
      <th>American Restaurant</th>
      <th>Antique Shop</th>
      <th>Aquarium</th>
      <th>Art Gallery</th>
      <th>Art Museum</th>
      <th>Arts &amp; Crafts Store</th>
      <th>Asian Restaurant</th>
      <th>Athletics &amp; Sports</th>
      <th>Auto Garage</th>
      <th>Auto Workshop</th>
      <th>BBQ Joint</th>
      <th>Baby Store</th>
      <th>Bagel Shop</th>
      <th>Bakery</th>
      <th>Bank</th>
      <th>Bar</th>
      <th>Baseball Field</th>
      <th>Baseball Stadium</th>
      <th>Basketball Court</th>
      <th>Basketball Stadium</th>
      <th>Beach</th>
      <th>Bed &amp; Breakfast</th>
      <th>Beer Bar</th>
      <th>Beer Store</th>
      <th>Belgian Restaurant</th>
      <th>Bike Rental / Bike Share</th>
      <th>Bike Shop</th>
      <th>Bistro</th>
      <th>Boat or Ferry</th>
      <th>Bookstore</th>
      <th>Boutique</th>
      <th>Brazilian Restaurant</th>
      <th>Breakfast Spot</th>
      <th>Brewery</th>
      <th>Bridal Shop</th>
      <th>Bubble Tea Shop</th>
      <th>Building</th>
      <th>Burger Joint</th>
      <th>Burrito Place</th>
      <th>Bus Line</th>
      <th>Bus Station</th>
      <th>Bus Stop</th>
      <th>Business Service</th>
      <th>Butcher</th>
      <th>Café</th>
      <th>Cajun / Creole Restaurant</th>
      <th>Camera Store</th>
      <th>Candy Store</th>
      <th>Caribbean Restaurant</th>
      <th>Cheese Shop</th>
      <th>Chinese Restaurant</th>
      <th>Chocolate Shop</th>
      <th>Church</th>
      <th>Climbing Gym</th>
      <th>Clothing Store</th>
      <th>Cocktail Bar</th>
      <th>Coffee Shop</th>
      <th>College Arts Building</th>
      <th>College Auditorium</th>
      <th>College Gym</th>
      <th>College Rec Center</th>
      <th>College Stadium</th>
      <th>Colombian Restaurant</th>
      <th>Comfort Food Restaurant</th>
      <th>Comic Shop</th>
      <th>Concert Hall</th>
      <th>Construction &amp; Landscaping</th>
      <th>Convenience Store</th>
      <th>Cosmetics Shop</th>
      <th>Coworking Space</th>
      <th>Creperie</th>
      <th>Cuban Restaurant</th>
      <th>Cupcake Shop</th>
      <th>Curling Ice</th>
      <th>Dance Studio</th>
      <th>Deli / Bodega</th>
      <th>Department Store</th>
      <th>Dessert Shop</th>
      <th>Dim Sum Restaurant</th>
      <th>Diner</th>
      <th>Discount Store</th>
      <th>Dive Bar</th>
      <th>Dog Run</th>
      <th>Doner Restaurant</th>
      <th>Donut Shop</th>
      <th>Drugstore</th>
      <th>Dumpling Restaurant</th>
      <th>Eastern European Restaurant</th>
      <th>Electronics Store</th>
      <th>Empanada Restaurant</th>
      <th>Ethiopian Restaurant</th>
      <th>Event Space</th>
      <th>Falafel Restaurant</th>
      <th>Farmers Market</th>
      <th>Fast Food Restaurant</th>
      <th>Field</th>
      <th>Filipino Restaurant</th>
      <th>Financial or Legal Service</th>
      <th>Fish &amp; Chips Shop</th>
      <th>Fish Market</th>
      <th>Flea Market</th>
      <th>Flower Shop</th>
      <th>Food</th>
      <th>Food &amp; Drink Shop</th>
      <th>Food Court</th>
      <th>Food Truck</th>
      <th>Fountain</th>
      <th>Fraternity House</th>
      <th>French Restaurant</th>
      <th>Fried Chicken Joint</th>
      <th>Frozen Yogurt Shop</th>
      <th>Fruit &amp; Vegetable Store</th>
      <th>Furniture / Home Store</th>
      <th>Gaming Cafe</th>
      <th>Garden</th>
      <th>Garden Center</th>
      <th>Gastropub</th>
      <th>Gay Bar</th>
      <th>General Entertainment</th>
      <th>General Travel</th>
      <th>German Restaurant</th>
      <th>Gift Shop</th>
      <th>Gluten-free Restaurant</th>
      <th>Golf Course</th>
      <th>Gourmet Shop</th>
      <th>Greek Restaurant</th>
      <th>Grocery Store</th>
      <th>Gym</th>
      <th>Gym / Fitness Center</th>
      <th>Hakka Restaurant</th>
      <th>Harbor / Marina</th>
      <th>Hardware Store</th>
      <th>Health &amp; Beauty Service</th>
      <th>Health Food Store</th>
      <th>Historic Site</th>
      <th>History Museum</th>
      <th>Hobby Shop</th>
      <th>Hockey Arena</th>
      <th>Home Service</th>
      <th>Hookah Bar</th>
      <th>Hospital</th>
      <th>Hostel</th>
      <th>Hotel</th>
      <th>Hotel Bar</th>
      <th>Hotpot Restaurant</th>
      <th>Ice Cream Shop</th>
      <th>Indian Restaurant</th>
      <th>Indie Movie Theater</th>
      <th>Indonesian Restaurant</th>
      <th>Intersection</th>
      <th>Irish Pub</th>
      <th>Italian Restaurant</th>
      <th>Japanese Restaurant</th>
      <th>Jazz Club</th>
      <th>Jewelry Store</th>
      <th>Jewish Restaurant</th>
      <th>Juice Bar</th>
      <th>Korean Restaurant</th>
      <th>Lake</th>
      <th>Latin American Restaurant</th>
      <th>Light Rail Station</th>
      <th>Lingerie Store</th>
      <th>Liquor Store</th>
      <th>Lounge</th>
      <th>Luggage Store</th>
      <th>Mac &amp; Cheese Joint</th>
      <th>Malay Restaurant</th>
      <th>Market</th>
      <th>Martial Arts Dojo</th>
      <th>Massage Studio</th>
      <th>Medical Center</th>
      <th>Mediterranean Restaurant</th>
      <th>Men's Store</th>
      <th>Metro Station</th>
      <th>Mexican Restaurant</th>
      <th>Middle Eastern Restaurant</th>
      <th>Miscellaneous Shop</th>
      <th>Mobile Phone Shop</th>
      <th>Modern European Restaurant</th>
      <th>Molecular Gastronomy Restaurant</th>
      <th>Monument / Landmark</th>
      <th>Motel</th>
      <th>Movie Theater</th>
      <th>Museum</th>
      <th>Music Store</th>
      <th>Music Venue</th>
      <th>Nail Salon</th>
      <th>New American Restaurant</th>
      <th>Nightclub</th>
      <th>Noodle House</th>
      <th>Office</th>
      <th>Opera House</th>
      <th>Optical Shop</th>
      <th>Organic Grocery</th>
      <th>Other Great Outdoors</th>
      <th>Outdoor Sculpture</th>
      <th>Park</th>
      <th>Performing Arts Venue</th>
      <th>Persian Restaurant</th>
      <th>Pet Store</th>
      <th>Pharmacy</th>
      <th>Pizza Place</th>
      <th>Playground</th>
      <th>Plaza</th>
      <th>Poke Place</th>
      <th>Pool</th>
      <th>Portuguese Restaurant</th>
      <th>Poutine Place</th>
      <th>Pub</th>
      <th>Ramen Restaurant</th>
      <th>Record Shop</th>
      <th>Rental Car Location</th>
      <th>Restaurant</th>
      <th>River</th>
      <th>Roof Deck</th>
      <th>Sake Bar</th>
      <th>Salad Place</th>
      <th>Salon / Barbershop</th>
      <th>Sandwich Place</th>
      <th>Scenic Lookout</th>
      <th>Sculpture Garden</th>
      <th>Seafood Restaurant</th>
      <th>Shoe Store</th>
      <th>Shopping Mall</th>
      <th>Skate Park</th>
      <th>Skating Rink</th>
      <th>Smoke Shop</th>
      <th>Smoothie Shop</th>
      <th>Snack Place</th>
      <th>Soccer Field</th>
      <th>Social Club</th>
      <th>Soup Place</th>
      <th>Southern / Soul Food Restaurant</th>
      <th>Spa</th>
      <th>Speakeasy</th>
      <th>Sporting Goods Shop</th>
      <th>Sports Bar</th>
      <th>Stadium</th>
      <th>Stationery Store</th>
      <th>Steakhouse</th>
      <th>Strip Club</th>
      <th>Supermarket</th>
      <th>Supplement Shop</th>
      <th>Sushi Restaurant</th>
      <th>Swim School</th>
      <th>Taco Place</th>
      <th>Tailor Shop</th>
      <th>Taiwanese Restaurant</th>
      <th>Tanning Salon</th>
      <th>Tapas Restaurant</th>
      <th>Tea Room</th>
      <th>Tennis Court</th>
      <th>Thai Restaurant</th>
      <th>Theater</th>
      <th>Theme Restaurant</th>
      <th>Thrift / Vintage Store</th>
      <th>Toy / Game Store</th>
      <th>Trail</th>
      <th>Train Station</th>
      <th>Turkish Restaurant</th>
      <th>Vegetarian / Vegan Restaurant</th>
      <th>Video Game Store</th>
      <th>Video Store</th>
      <th>Vietnamese Restaurant</th>
      <th>Warehouse Store</th>
      <th>Wine Bar</th>
      <th>Wine Shop</th>
      <th>Wings Joint</th>
      <th>Women's Store</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Adelaide,King,Richmond</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.02</td>
      <td>0.0</td>
      <td>0.04</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.03</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.05</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.070000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.02</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.02</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.030000</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.020000</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.04</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.02</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.04</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Agincourt</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.25</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.25</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.25</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.250000</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Agincourt North,L'Amoreaux East,Milliken,Steel...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.5</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.5</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Albion Gardens,Beaumond Heights,Humbergate,Jam...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.1</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.100000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.1</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.1</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.2</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.100000</td>
      <td>0.200000</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.100000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Alderwood,Long Branch</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>0.222222</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.111111</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
for hood in Toronto_grouped['Neighborhood']:
    print("----"+hood+"----")
    temp = Toronto_grouped[Toronto_grouped['Neighborhood'] == hood].T.reset_index()
    temp.columns = ['venue','freq']
    temp = temp.iloc[1:]
    temp['freq'] = temp['freq'].astype(float)
    temp = temp.round({'freq': 2})
    print(temp.sort_values('freq', ascending=False).reset_index(drop=True).head(num_top_venues))
    print('\n')

def return_most_common_venues(row, num_top_venues):
    row_categories = row.iloc[1:]
    row_categories_sorted = row_categories.sort_values(ascending=False)
    
    return row_categories_sorted.index.values[0:num_top_venues]

num_top_venues = 10

indicators = ['st', 'nd', 'rd']
```

    ----Adelaide,King,Richmond----
                 venue  freq
    0      Coffee Shop  0.07
    1             Café  0.05
    2              Bar  0.04
    3       Steakhouse  0.04
    4  Thai Restaurant  0.04
    
    
    ----Agincourt----
                venue  freq
    0    Skating Rink  0.25
    1          Lounge  0.25
    2  Breakfast Spot  0.25
    3  Clothing Store  0.25
    4     Yoga Studio  0.00
    
    
    ----Agincourt North,L'Amoreaux East,Milliken,Steeles East----
                                 venue  freq
    0                       Playground   0.5
    1                             Park   0.5
    2                      Yoga Studio   0.0
    3                    Metro Station   0.0
    4  Molecular Gastronomy Restaurant   0.0
    
    
    ----Albion Gardens,Beaumond Heights,Humbergate,Jamestown,Mount Olive,Silverstone,South Steeles,Thistletown----
                     venue  freq
    0          Pizza Place   0.2
    1        Grocery Store   0.2
    2  Fried Chicken Joint   0.1
    3          Coffee Shop   0.1
    4       Sandwich Place   0.1
    
    
    ----Alderwood,Long Branch----
              venue  freq
    0   Pizza Place  0.22
    1      Pharmacy  0.11
    2   Coffee Shop  0.11
    3  Dance Studio  0.11
    4           Pub  0.11
    
    
    ----Bathurst Manor,Downsview North,Wilson Heights----
                    venue  freq
    0         Coffee Shop  0.11
    1       Shopping Mall  0.06
    2      Sandwich Place  0.06
    3  Frozen Yogurt Shop  0.06
    4    Sushi Restaurant  0.06
    
    
    ----Bayview Village----
                     venue  freq
    0                 Café  0.25
    1   Chinese Restaurant  0.25
    2                 Bank  0.25
    3  Japanese Restaurant  0.25
    4          Men's Store  0.00
    
    
    ----Bedford Park,Lawrence Manor East----
                      venue  freq
    0           Pizza Place  0.09
    1    Italian Restaurant  0.09
    2           Coffee Shop  0.09
    3  Fast Food Restaurant  0.04
    4     Indian Restaurant  0.04
    
    
    ----Berczy Park----
                    venue  freq
    0         Coffee Shop  0.11
    1              Bakery  0.05
    2        Cocktail Bar  0.05
    3         Cheese Shop  0.04
    4  Seafood Restaurant  0.04
    
    
    ----Birch Cliff,Cliffside West----
                       venue  freq
    0        College Stadium  0.25
    1  General Entertainment  0.25
    2           Skating Rink  0.25
    3                   Café  0.25
    4     Miscellaneous Shop  0.00
    
    
    ----Bloordale Gardens,Eringate,Markland Wood,Old Burnhamthorpe----
                   venue  freq
    0           Pharmacy  0.14
    1  Convenience Store  0.14
    2               Café  0.14
    3        Coffee Shop  0.14
    4         Beer Store  0.14
    
    
    ----Brockton,Exhibition Place,Parkdale Village----
                        venue  freq
    0             Coffee Shop  0.09
    1          Breakfast Spot  0.09
    2                    Café  0.09
    3       Convenience Store  0.05
    4  Furniture / Home Store  0.05
    
    
    ----Business Reply Mail Processing Centre 969 Eastern----
                venue  freq
    0     Pizza Place  0.07
    1      Restaurant  0.07
    2         Brewery  0.07
    3  Farmers Market  0.07
    4      Smoke Shop  0.07
    
    
    ----CFB Toronto,Downsview East----
                     venue  freq
    0              Airport   0.5
    1                 Park   0.5
    2          Yoga Studio   0.0
    3   Mexican Restaurant   0.0
    4  Monument / Landmark   0.0
    
    
    ----CN Tower,Bathurst Quay,Island airport,Harbourfront West,King and Spadina,Railway Lands,South Niagara----
                  venue  freq
    0   Airport Service  0.19
    1  Airport Terminal  0.12
    2    Airport Lounge  0.12
    3   Harbor / Marina  0.06
    4       Coffee Shop  0.06
    
    
    ----Cabbagetown,St. James Town----
                    venue  freq
    0         Coffee Shop  0.07
    1                 Pub  0.05
    2         Pizza Place  0.05
    3          Restaurant  0.05
    4  Italian Restaurant  0.05
    
    
    ----Caledonia-Fairbanks----
                      venue  freq
    0                  Park  0.33
    1         Women's Store  0.17
    2  Fast Food Restaurant  0.17
    3                Market  0.17
    4              Pharmacy  0.17
    
    
    ----Canada Post Gateway Processing Centre----
                           venue  freq
    0                Coffee Shop  0.18
    1                      Hotel  0.18
    2  Middle Eastern Restaurant  0.09
    3        Fried Chicken Joint  0.09
    4              Burrito Place  0.09
    
    
    ----Cedarbrae----
                     venue  freq
    0               Lounge  0.12
    1   Athletics & Sports  0.12
    2  Fried Chicken Joint  0.12
    3                 Bank  0.12
    4               Bakery  0.12
    
    
    ----Central Bay Street----
                           venue  freq
    0                Coffee Shop  0.14
    1                       Café  0.06
    2         Italian Restaurant  0.05
    3             Ice Cream Shop  0.05
    4  Middle Eastern Restaurant  0.03
    
    
    ----Chinatown,Grange Park,Kensington Market----
                               venue  freq
    0                           Café  0.08
    1  Vegetarian / Vegan Restaurant  0.06
    2             Chinese Restaurant  0.05
    3                         Bakery  0.04
    4            Dumpling Restaurant  0.04
    
    
    ----Christie----
                    venue  freq
    0       Grocery Store  0.20
    1                Café  0.20
    2                Park  0.13
    3  Italian Restaurant  0.07
    4           Nightclub  0.07
    
    
    ----Church and Wellesley----
                     venue  freq
    0          Coffee Shop  0.07
    1  Japanese Restaurant  0.06
    2              Gay Bar  0.05
    3     Sushi Restaurant  0.05
    4           Restaurant  0.04
    
    
    ----Clairlea,Golden Mile,Oakridge----
                      venue  freq
    0              Bus Line   0.2
    1                Bakery   0.2
    2  Fast Food Restaurant   0.1
    3                  Park   0.1
    4          Intersection   0.1
    
    
    ----Clarks Corners,Sullivan,Tam O'Shanter----
                     venue  freq
    0          Pizza Place  0.18
    1         Noodle House  0.09
    2        Shopping Mall  0.09
    3  Fried Chicken Joint  0.09
    4                 Bank  0.09
    
    
    ----Cliffcrest,Cliffside,Scarborough Village West----
                                 venue  freq
    0              American Restaurant   0.5
    1                            Motel   0.5
    2                           Museum   0.0
    3              Monument / Landmark   0.0
    4  Molecular Gastronomy Restaurant   0.0
    
    
    ----Cloverdale,Islington,Martin Grove,Princess Gardens,West Deane Park----
                                 venue  freq
    0                             Bank   1.0
    1                      Yoga Studio   0.0
    2        Middle Eastern Restaurant   0.0
    3              Monument / Landmark   0.0
    4  Molecular Gastronomy Restaurant   0.0
    
    
    ----Commerce Court,Victoria Hotel----
                     venue  freq
    0          Coffee Shop  0.09
    1                 Café  0.06
    2                Hotel  0.06
    3  American Restaurant  0.04
    4           Restaurant  0.04
    
    
    ----Davisville----
                venue  freq
    0  Sandwich Place  0.08
    1     Pizza Place  0.08
    2    Dessert Shop  0.08
    3      Restaurant  0.06
    4     Coffee Shop  0.06
    
    
    ----Davisville North----
                   venue  freq
    0     Sandwich Place  0.12
    1  Food & Drink Shop  0.12
    2               Park  0.12
    3     Breakfast Spot  0.12
    4                Gym  0.12
    
    
    ----Deer Park,Forest Hill SE,Rathnelly,South Hill,Summerhill West----
                     venue  freq
    0          Coffee Shop  0.13
    1                  Pub  0.13
    2  American Restaurant  0.07
    3  Fried Chicken Joint  0.07
    4           Bagel Shop  0.07
    
    
    ----Del Ray,Keelesdale,Mount Dennis,Silverthorn----
                     venue  freq
    0       Sandwich Place  0.25
    1   Turkish Restaurant  0.25
    2                  Bar  0.25
    3          Coffee Shop  0.25
    4  Monument / Landmark  0.00
    
    
    ----Design Exchange,Toronto Dominion Centre----
                    venue  freq
    0         Coffee Shop  0.14
    1                Café  0.08
    2               Hotel  0.06
    3  Italian Restaurant  0.04
    4          Restaurant  0.04
    
    
    ----Don Mills North----
                      venue  freq
    0   Japanese Restaurant   0.2
    1  Caribbean Restaurant   0.2
    2  Gym / Fitness Center   0.2
    3        Baseball Field   0.2
    4                  Café   0.2
    
    
    ----Dorset Park,Scarborough Town Centre,Wexford Heights----
                           venue  freq
    0          Indian Restaurant  0.33
    1         Chinese Restaurant  0.17
    2                  Pet Store  0.17
    3      Vietnamese Restaurant  0.17
    4  Latin American Restaurant  0.17
    
    
    ----Dovercourt Village,Dufferin----
                           venue  freq
    0                   Pharmacy  0.10
    1                     Bakery  0.10
    2                Supermarket  0.10
    3  Middle Eastern Restaurant  0.05
    4                        Bar  0.05
    
    
    ----Downsview Central----
                  venue  freq
    0  Business Service  0.25
    1      Home Service  0.25
    2    Baseball Field  0.25
    3        Food Truck  0.25
    4       Yoga Studio  0.00
    
    
    ----Downsview Northwest----
                      venue  freq
    0        Discount Store   0.2
    1  Gym / Fitness Center   0.2
    2          Liquor Store   0.2
    3         Grocery Store   0.2
    4    Athletics & Sports   0.2
    
    
    ----Downsview West----
               venue  freq
    0  Grocery Store   0.4
    1           Park   0.2
    2           Bank   0.2
    3  Shopping Mall   0.2
    4    Yoga Studio   0.0
    
    
    ----Downsview,North Park,Upwood Park----
                            venue  freq
    0            Basketball Court  0.25
    1                      Bakery  0.25
    2  Construction & Landscaping  0.25
    3                        Park  0.25
    4                 Yoga Studio  0.00
    
    
    ----East Birchmount Park,Ionview,Kennedy Park----
                   venue  freq
    0     Discount Store   0.2
    1        Bus Station   0.2
    2  Convenience Store   0.2
    3        Coffee Shop   0.2
    4   Department Store   0.2
    
    
    ----East Toronto----
                   venue  freq
    0        Pizza Place  0.25
    1               Park  0.25
    2        Coffee Shop  0.25
    3  Convenience Store  0.25
    4        Yoga Studio  0.00
    
    
    ----Emery,Humberlea----
                                 venue  freq
    0                   Baseball Field   1.0
    1                      Yoga Studio   0.0
    2        Middle Eastern Restaurant   0.0
    3              Monument / Landmark   0.0
    4  Molecular Gastronomy Restaurant   0.0
    
    
    ----Fairview,Henry Farm,Oriole----
                      venue  freq
    0        Clothing Store  0.12
    1  Fast Food Restaurant  0.08
    2           Coffee Shop  0.08
    3         Women's Store  0.05
    4      Toy / Game Store  0.03
    
    
    ----First Canadian Place,Underground city----
             venue  freq
    0  Coffee Shop  0.09
    1         Café  0.07
    2        Hotel  0.04
    3   Steakhouse  0.04
    4   Restaurant  0.04
    
    
    ----Flemingdon Park,Don Mills South----
                venue  freq
    0             Gym  0.10
    1   Grocery Store  0.10
    2     Coffee Shop  0.10
    3      Beer Store  0.10
    4  Clothing Store  0.05
    
    
    ----Forest Hill North,Forest Hill West----
                  venue  freq
    0     Jewelry Store  0.25
    1          Bus Line  0.25
    2             Trail  0.25
    3  Sushi Restaurant  0.25
    4       Yoga Studio  0.00
    
    
    ----Glencairn----
                     venue  freq
    0                  Pub  0.25
    1          Pizza Place  0.25
    2                 Park  0.25
    3  Japanese Restaurant  0.25
    4   Mexican Restaurant  0.00
    
    
    ----Guildwood,Morningside,West Hill----
                     venue  freq
    0         Intersection  0.14
    1       Breakfast Spot  0.14
    2  Rental Car Location  0.14
    3   Mexican Restaurant  0.14
    4    Electronics Store  0.14
    
    
    ----Harbord,University of Toronto----
            venue  freq
    0        Café  0.09
    1  Restaurant  0.06
    2   Bookstore  0.06
    3         Bar  0.06
    4      Bakery  0.06
    
    
    ----Harbourfront East,Toronto Islands,Union Station----
                    venue  freq
    0         Coffee Shop  0.11
    1               Hotel  0.05
    2            Aquarium  0.05
    3                Café  0.04
    4  Italian Restaurant  0.04
    
    
    ----Harbourfront,Regent Park----
             venue  freq
    0  Coffee Shop  0.18
    1         Park  0.06
    2          Pub  0.06
    3       Bakery  0.06
    4         Café  0.06
    
    
    ----High Park,The Junction South----
                    venue  freq
    0  Mexican Restaurant  0.09
    1                Café  0.09
    2                 Bar  0.09
    3           Bookstore  0.05
    4  Italian Restaurant  0.05
    
    
    ----Highland Creek,Rouge Hill,Port Union----
                                 venue  freq
    0                              Bar   0.5
    1                      Golf Course   0.5
    2                      Yoga Studio   0.0
    3               Mexican Restaurant   0.0
    4  Molecular Gastronomy Restaurant   0.0
    
    
    ----Hillcrest Village----
                          venue  freq
    0      Fast Food Restaurant   0.2
    1                   Dog Run   0.2
    2  Mediterranean Restaurant   0.2
    3                      Pool   0.2
    4               Golf Course   0.2
    
    
    ----Humber Bay Shores,Mimico South,New Toronto----
                    venue  freq
    0                Café  0.13
    1         Pizza Place  0.07
    2          Restaurant  0.07
    3  Mexican Restaurant  0.07
    4        Liquor Store  0.07
    
    
    ----Humber Bay,King's Mill Park,Kingsway Park South East,Mimico NE,Old Mill South,The Queensway East,Royal York South East,Sunnylea----
                            venue  freq
    0  Construction & Landscaping  0.33
    1                        Pool  0.33
    2              Baseball Field  0.33
    3                 Yoga Studio  0.00
    4   Middle Eastern Restaurant  0.00
    
    
    ----Humber Summit----
                     venue  freq
    0          Pizza Place   0.5
    1  Empanada Restaurant   0.5
    2          Yoga Studio   0.0
    3   Mexican Restaurant   0.0
    4  Monument / Landmark   0.0
    
    
    ----Humewood-Cedarvale----
                     venue  freq
    0                Field  0.33
    1         Hockey Arena  0.33
    2                Trail  0.33
    3   Mexican Restaurant  0.00
    4  Monument / Landmark  0.00
    
    
    ----Kingsview Village,Martin Grove Gardens,Richview Gardens,St. Phillips----
                           venue  freq
    0                Pizza Place  0.25
    1                       Park  0.25
    2                   Bus Line  0.25
    3          Mobile Phone Shop  0.25
    4  Middle Eastern Restaurant  0.00
    
    
    ----Kingsway Park South West,Mimico NW,The Queensway West,Royal York South West,South of Bloor----
                   venue  freq
    0  Convenience Store  0.08
    1                Gym  0.08
    2        Social Club  0.08
    3     Sandwich Place  0.08
    4     Discount Store  0.08
    
    
    ----L'Amoreaux West----
                      venue  freq
    0  Fast Food Restaurant  0.15
    1    Chinese Restaurant  0.15
    2              Pharmacy  0.08
    3           Pizza Place  0.08
    4   Japanese Restaurant  0.08
    
    
    ----Lawrence Heights,Lawrence Manor----
                        venue  freq
    0          Clothing Store  0.17
    1  Furniture / Home Store  0.17
    2           Women's Store  0.08
    3             Event Space  0.08
    4                Boutique  0.08
    
    
    ----Lawrence Park----
                    venue  freq
    0                Lake  0.25
    1                Park  0.25
    2            Bus Line  0.25
    3         Swim School  0.25
    4  Mexican Restaurant  0.00
    
    
    ----Leaside----
                        venue  freq
    0             Coffee Shop  0.11
    1     Sporting Goods Shop  0.09
    2            Burger Joint  0.06
    3  Furniture / Home Store  0.06
    4        Sushi Restaurant  0.06
    
    
    ----Little Portugal,Trinity----
                  venue  freq
    0               Bar  0.11
    1       Coffee Shop  0.06
    2  Asian Restaurant  0.05
    3       Men's Store  0.03
    4              Café  0.03
    
    
    ----Maryvale,Wexford----
                           venue  freq
    0  Middle Eastern Restaurant  0.14
    1                 Smoke Shop  0.14
    2                Auto Garage  0.14
    3                     Bakery  0.14
    4              Shopping Mall  0.14
    
    
    ----Moore Park,Summerhill East----
             venue  freq
    0         Park  0.25
    1   Playground  0.25
    2   Restaurant  0.25
    3        Trail  0.25
    4  Yoga Studio  0.00
    
    
    ----North Toronto West----
                     venue  freq
    0       Clothing Store  0.16
    1  Sporting Goods Shop  0.11
    2          Coffee Shop  0.11
    3          Yoga Studio  0.05
    4            Pet Store  0.05
    
    
    ----Northwest----
                     venue  freq
    0  Rental Car Location   0.5
    1            Drugstore   0.5
    2          Yoga Studio   0.0
    3        Movie Theater   0.0
    4  Monument / Landmark   0.0
    
    
    ----Northwood Park,York University----
                    venue  freq
    0  Miscellaneous Shop   0.2
    1      Massage Studio   0.2
    2  Falafel Restaurant   0.2
    3         Coffee Shop   0.2
    4                 Bar   0.2
    
    
    ----Parkdale,Roncesvalles----
                             venue  freq
    0               Breakfast Spot  0.13
    1                    Gift Shop  0.13
    2                 Dessert Shop  0.07
    3                    Bookstore  0.07
    4  Eastern European Restaurant  0.07
    
    
    ----Parkwoods----
                                 venue  freq
    0             Fast Food Restaurant  0.33
    1                             Park  0.33
    2                Food & Drink Shop  0.33
    3                    Metro Station  0.00
    4  Molecular Gastronomy Restaurant  0.00
    
    
    ----Queen's Park----
               venue  freq
    0    Coffee Shop  0.25
    1            Gym  0.06
    2           Park  0.06
    3           Café  0.03
    4  Smoothie Shop  0.03
    
    
    ----Rosedale----
             venue  freq
    0         Park   0.4
    1     Building   0.2
    2   Playground   0.2
    3        Trail   0.2
    4  Yoga Studio   0.0
    
    
    ----Roselawn----
                     venue  freq
    0               Garden   0.5
    1       Ice Cream Shop   0.5
    2          Yoga Studio   0.0
    3        Movie Theater   0.0
    4  Monument / Landmark   0.0
    
    
    ----Rouge,Malvern----
                                 venue  freq
    0             Fast Food Restaurant   1.0
    1               Mexican Restaurant   0.0
    2              Monument / Landmark   0.0
    3  Molecular Gastronomy Restaurant   0.0
    4       Modern European Restaurant   0.0
    
    
    ----Runnymede,Swansea----
                    venue  freq
    0         Pizza Place  0.08
    1         Coffee Shop  0.08
    2                Café  0.08
    3    Sushi Restaurant  0.05
    4  Italian Restaurant  0.05
    
    
    ----Ryerson,Garden District----
                           venue  freq
    0                Coffee Shop  0.09
    1             Clothing Store  0.06
    2             Cosmetics Shop  0.04
    3                       Café  0.03
    4  Middle Eastern Restaurant  0.03
    
    
    ----Scarborough Village----
                           venue  freq
    0                 Playground   0.5
    1              Jewelry Store   0.5
    2                Yoga Studio   0.0
    3  Middle Eastern Restaurant   0.0
    4        Monument / Landmark   0.0
    
    
    ----Silver Hills,York Mills----
                                 venue  freq
    0                             Park   1.0
    1                      Yoga Studio   0.0
    2                    Metro Station   0.0
    3  Molecular Gastronomy Restaurant   0.0
    4       Modern European Restaurant   0.0
    
    
    ----St. James Town----
                    venue  freq
    0         Coffee Shop  0.07
    1                Café  0.05
    2               Hotel  0.05
    3          Restaurant  0.05
    4  Italian Restaurant  0.04
    
    
    ----Stn A PO Boxes 25 The Esplanade----
                    venue  freq
    0         Coffee Shop  0.09
    1          Restaurant  0.04
    2                Café  0.04
    3            Beer Bar  0.03
    4  Seafood Restaurant  0.03
    
    
    ----Studio District----
                     venue  freq
    0                 Café  0.10
    1          Coffee Shop  0.07
    2            Gastropub  0.05
    3  American Restaurant  0.05
    4               Bakery  0.05
    
    
    ----The Annex,North Midtown,Yorkville----
                venue  freq
    0  Sandwich Place  0.13
    1            Café  0.13
    2     Coffee Shop  0.13
    3     Pizza Place  0.09
    4  Cosmetics Shop  0.04
    
    
    ----The Beaches----
                   venue  freq
    0              Trail  0.17
    1  Health Food Store  0.17
    2               Park  0.17
    3        Coffee Shop  0.17
    4                Pub  0.17
    
    
    ----The Beaches West,India Bazaar----
                venue  freq
    0  Sandwich Place  0.10
    1     Pizza Place  0.05
    2    Intersection  0.05
    3       Pet Store  0.05
    4             Pub  0.05
    
    
    ----The Danforth West,Riverdale----
                        venue  freq
    0        Greek Restaurant  0.21
    1             Coffee Shop  0.10
    2          Ice Cream Shop  0.07
    3      Italian Restaurant  0.07
    4  Furniture / Home Store  0.05
    
    
    ----The Junction North,Runnymede----
                           venue  freq
    0                Pizza Place  0.33
    1              Grocery Store  0.33
    2       Caribbean Restaurant  0.33
    3                Yoga Studio  0.00
    4  Middle Eastern Restaurant  0.00
    
    
    ----The Kingsway,Montgomery Road,Old Mill North----
                    venue  freq
    0                Park  0.33
    1                Pool  0.33
    2               River  0.33
    3         Yoga Studio  0.00
    4  Mexican Restaurant  0.00
    
    
    ----Thorncliffe Park----
                   venue  freq
    0  Indian Restaurant  0.12
    1       Burger Joint  0.12
    2        Yoga Studio  0.06
    3           Pharmacy  0.06
    4        Pizza Place  0.06
    
    
    ----Victoria Village----
                            venue  freq
    0                 Pizza Place  0.14
    1           French Restaurant  0.14
    2  Financial or Legal Service  0.14
    3                Hockey Arena  0.14
    4                 Coffee Shop  0.14
    
    
    ----Westmount----
                           venue  freq
    0                Pizza Place  0.29
    1                Coffee Shop  0.14
    2  Middle Eastern Restaurant  0.14
    3             Sandwich Place  0.14
    4         Chinese Restaurant  0.14
    
    
    ----Willowdale South----
                  venue  freq
    0  Ramen Restaurant  0.08
    1       Coffee Shop  0.08
    2              Café  0.05
    3  Sushi Restaurant  0.05
    4        Restaurant  0.05
    
    
    ----Willowdale West----
                venue  freq
    0        Pharmacy   0.2
    1   Grocery Store   0.2
    2     Coffee Shop   0.2
    3  Discount Store   0.2
    4     Pizza Place   0.2
    
    
    ----Woburn----
                     venue  freq
    0          Coffee Shop  0.67
    1    Korean Restaurant  0.33
    2          Yoga Studio  0.00
    3                Motel  0.00
    4  Monument / Landmark  0.00
    
    
    ----Woodbine Gardens,Parkview Hill----
                      venue  freq
    0           Pizza Place  0.18
    1  Fast Food Restaurant  0.18
    2    Athletics & Sports  0.09
    3                  Café  0.09
    4                  Bank  0.09
    
    
    ----Woodbine Heights----
                venue  freq
    0             Spa   0.1
    1    Skating Rink   0.1
    2        Pharmacy   0.1
    3            Park   0.1
    4  Cosmetics Shop   0.1
    
    
    ----York Mills West----
                    venue  freq
    0                Park  0.33
    1   Convenience Store  0.33
    2                Bank  0.33
    3         Yoga Studio  0.00
    4  Mexican Restaurant  0.00
    
    
    


```python
# create columns according to number of top venues
columns = ['Neighborhood']
for ind in np.arange(num_top_venues):
    try:
        columns.append('{}{} Most Common Venue'.format(ind+1, indicators[ind]))
    except:
        columns.append('{}th Most Common Venue'.format(ind+1))

# create a new dataframe
neighborhoods_venues_sorted = pd.DataFrame(columns=columns)
neighborhoods_venues_sorted['Neighborhood'] = Toronto_grouped['Neighborhood']

for ind in np.arange(Toronto_grouped.shape[0]):
    neighborhoods_venues_sorted.iloc[ind, 1:] = return_most_common_venues(Toronto_grouped.iloc[ind, :], num_top_venues)

neighborhoods_venues_sorted.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Neighborhood</th>
      <th>1st Most Common Venue</th>
      <th>2nd Most Common Venue</th>
      <th>3rd Most Common Venue</th>
      <th>4th Most Common Venue</th>
      <th>5th Most Common Venue</th>
      <th>6th Most Common Venue</th>
      <th>7th Most Common Venue</th>
      <th>8th Most Common Venue</th>
      <th>9th Most Common Venue</th>
      <th>10th Most Common Venue</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Adelaide,King,Richmond</td>
      <td>Coffee Shop</td>
      <td>Café</td>
      <td>Thai Restaurant</td>
      <td>Steakhouse</td>
      <td>Bar</td>
      <td>Gym</td>
      <td>Breakfast Spot</td>
      <td>Asian Restaurant</td>
      <td>American Restaurant</td>
      <td>Restaurant</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Agincourt</td>
      <td>Lounge</td>
      <td>Clothing Store</td>
      <td>Breakfast Spot</td>
      <td>Skating Rink</td>
      <td>Drugstore</td>
      <td>Discount Store</td>
      <td>Dive Bar</td>
      <td>Dog Run</td>
      <td>Doner Restaurant</td>
      <td>Donut Shop</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Agincourt North,L'Amoreaux East,Milliken,Steel...</td>
      <td>Park</td>
      <td>Playground</td>
      <td>Donut Shop</td>
      <td>Dim Sum Restaurant</td>
      <td>Diner</td>
      <td>Discount Store</td>
      <td>Dive Bar</td>
      <td>Dog Run</td>
      <td>Doner Restaurant</td>
      <td>Drugstore</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Albion Gardens,Beaumond Heights,Humbergate,Jam...</td>
      <td>Grocery Store</td>
      <td>Pizza Place</td>
      <td>Fast Food Restaurant</td>
      <td>Beer Store</td>
      <td>Sandwich Place</td>
      <td>Fried Chicken Joint</td>
      <td>Coffee Shop</td>
      <td>Pharmacy</td>
      <td>Comfort Food Restaurant</td>
      <td>Dim Sum Restaurant</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Alderwood,Long Branch</td>
      <td>Pizza Place</td>
      <td>Coffee Shop</td>
      <td>Skating Rink</td>
      <td>Dance Studio</td>
      <td>Pharmacy</td>
      <td>Pub</td>
      <td>Sandwich Place</td>
      <td>Gym</td>
      <td>Airport Service</td>
      <td>Dessert Shop</td>
    </tr>
  </tbody>
</table>
</div>




```python
# set number of clusters
kclusters = 5

Toronto_grouped_clustering = Toronto_grouped.drop('Neighborhood', 1)
```


```python
Toronto_manhattan = Toronto_grouped_clustering.append(manhattan_grouped_clustering_dataset_1)

Toronto_manhattan.head()
```

    C:\ProgramData\Anaconda3\lib\site-packages\pandas\core\frame.py:6692: FutureWarning: Sorting because non-concatenation axis is not aligned. A future version
    of pandas will change to not sort by default.
    
    To accept the future behavior, pass 'sort=False'.
    
    To retain the current behavior and silence the warning, pass 'sort=True'.
    
      sort=sort)
    




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Accessories Store</th>
      <th>Adult Boutique</th>
      <th>Afghan Restaurant</th>
      <th>African Restaurant</th>
      <th>Airport</th>
      <th>Airport Food Court</th>
      <th>Airport Gate</th>
      <th>Airport Lounge</th>
      <th>Airport Service</th>
      <th>Airport Terminal</th>
      <th>American Restaurant</th>
      <th>Antique Shop</th>
      <th>Aquarium</th>
      <th>Arcade</th>
      <th>Arepa Restaurant</th>
      <th>Argentinian Restaurant</th>
      <th>Art Gallery</th>
      <th>Art Museum</th>
      <th>Arts &amp; Crafts Store</th>
      <th>Asian Restaurant</th>
      <th>Athletics &amp; Sports</th>
      <th>Auditorium</th>
      <th>Australian Restaurant</th>
      <th>Austrian Restaurant</th>
      <th>Auto Garage</th>
      <th>Auto Workshop</th>
      <th>BBQ Joint</th>
      <th>Baby Store</th>
      <th>Bagel Shop</th>
      <th>Bakery</th>
      <th>Bank</th>
      <th>Bar</th>
      <th>Baseball Field</th>
      <th>Baseball Stadium</th>
      <th>Basketball Court</th>
      <th>Basketball Stadium</th>
      <th>Beach</th>
      <th>Bed &amp; Breakfast</th>
      <th>Beer Bar</th>
      <th>Beer Garden</th>
      <th>Beer Store</th>
      <th>Belgian Restaurant</th>
      <th>Big Box Store</th>
      <th>Bike Rental / Bike Share</th>
      <th>Bike Shop</th>
      <th>Bike Trail</th>
      <th>Bistro</th>
      <th>Board Shop</th>
      <th>Boat or Ferry</th>
      <th>Bookstore</th>
      <th>Boutique</th>
      <th>Boxing Gym</th>
      <th>Brazilian Restaurant</th>
      <th>Breakfast Spot</th>
      <th>Brewery</th>
      <th>Bridal Shop</th>
      <th>Bridge</th>
      <th>Bubble Tea Shop</th>
      <th>Building</th>
      <th>Burger Joint</th>
      <th>Burrito Place</th>
      <th>Bus Line</th>
      <th>Bus Station</th>
      <th>Bus Stop</th>
      <th>Business Service</th>
      <th>Butcher</th>
      <th>Cafeteria</th>
      <th>Café</th>
      <th>Cajun / Creole Restaurant</th>
      <th>Cambodian Restaurant</th>
      <th>Camera Store</th>
      <th>Candy Store</th>
      <th>Cantonese Restaurant</th>
      <th>Caribbean Restaurant</th>
      <th>Caucasian Restaurant</th>
      <th>Cheese Shop</th>
      <th>Chinese Restaurant</th>
      <th>Chocolate Shop</th>
      <th>Church</th>
      <th>Circus</th>
      <th>Climbing Gym</th>
      <th>Clothing Store</th>
      <th>Club House</th>
      <th>Cocktail Bar</th>
      <th>Coffee Shop</th>
      <th>College Academic Building</th>
      <th>College Arts Building</th>
      <th>College Auditorium</th>
      <th>College Bookstore</th>
      <th>College Cafeteria</th>
      <th>College Gym</th>
      <th>College Rec Center</th>
      <th>College Stadium</th>
      <th>College Theater</th>
      <th>Colombian Restaurant</th>
      <th>Comedy Club</th>
      <th>Comfort Food Restaurant</th>
      <th>Comic Shop</th>
      <th>Community Center</th>
      <th>Concert Hall</th>
      <th>Construction &amp; Landscaping</th>
      <th>Convenience Store</th>
      <th>Cosmetics Shop</th>
      <th>Coworking Space</th>
      <th>Creperie</th>
      <th>Cuban Restaurant</th>
      <th>Cultural Center</th>
      <th>Cupcake Shop</th>
      <th>Curling Ice</th>
      <th>Cycle Studio</th>
      <th>Czech Restaurant</th>
      <th>Dance Studio</th>
      <th>Daycare</th>
      <th>Deli / Bodega</th>
      <th>Department Store</th>
      <th>Design Studio</th>
      <th>Dessert Shop</th>
      <th>Dim Sum Restaurant</th>
      <th>Diner</th>
      <th>Discount Store</th>
      <th>Dive Bar</th>
      <th>Doctor's Office</th>
      <th>Dog Run</th>
      <th>Doner Restaurant</th>
      <th>Donut Shop</th>
      <th>Drugstore</th>
      <th>Dumpling Restaurant</th>
      <th>Duty-free Shop</th>
      <th>Eastern European Restaurant</th>
      <th>Electronics Store</th>
      <th>Empanada Restaurant</th>
      <th>English Restaurant</th>
      <th>Ethiopian Restaurant</th>
      <th>Event Space</th>
      <th>Exhibit</th>
      <th>Falafel Restaurant</th>
      <th>Farmers Market</th>
      <th>Fast Food Restaurant</th>
      <th>Field</th>
      <th>Filipino Restaurant</th>
      <th>Financial or Legal Service</th>
      <th>Fish &amp; Chips Shop</th>
      <th>Fish Market</th>
      <th>Flea Market</th>
      <th>Flower Shop</th>
      <th>Food</th>
      <th>Food &amp; Drink Shop</th>
      <th>Food Court</th>
      <th>Food Truck</th>
      <th>Fountain</th>
      <th>Fraternity House</th>
      <th>French Restaurant</th>
      <th>Fried Chicken Joint</th>
      <th>Frozen Yogurt Shop</th>
      <th>Fruit &amp; Vegetable Store</th>
      <th>Furniture / Home Store</th>
      <th>Gaming Cafe</th>
      <th>Garden</th>
      <th>Garden Center</th>
      <th>Gas Station</th>
      <th>Gastropub</th>
      <th>Gay Bar</th>
      <th>General College &amp; University</th>
      <th>General Entertainment</th>
      <th>General Travel</th>
      <th>German Restaurant</th>
      <th>Gift Shop</th>
      <th>Gluten-free Restaurant</th>
      <th>Golf Course</th>
      <th>Gourmet Shop</th>
      <th>Greek Restaurant</th>
      <th>Grocery Store</th>
      <th>Gym</th>
      <th>Gym / Fitness Center</th>
      <th>Gym Pool</th>
      <th>Gymnastics Gym</th>
      <th>Hakka Restaurant</th>
      <th>Harbor / Marina</th>
      <th>Hardware Store</th>
      <th>Hawaiian Restaurant</th>
      <th>Health &amp; Beauty Service</th>
      <th>Health Food Store</th>
      <th>Heliport</th>
      <th>Herbs &amp; Spices Store</th>
      <th>High School</th>
      <th>Himalayan Restaurant</th>
      <th>Historic Site</th>
      <th>History Museum</th>
      <th>Hobby Shop</th>
      <th>Hockey Arena</th>
      <th>Home Service</th>
      <th>Hookah Bar</th>
      <th>Hospital</th>
      <th>Hostel</th>
      <th>Hot Dog Joint</th>
      <th>Hotel</th>
      <th>Hotel Bar</th>
      <th>Hotpot Restaurant</th>
      <th>Ice Cream Shop</th>
      <th>Indian Restaurant</th>
      <th>Indie Movie Theater</th>
      <th>Indie Theater</th>
      <th>Indonesian Restaurant</th>
      <th>Indoor Play Area</th>
      <th>Intersection</th>
      <th>Irish Pub</th>
      <th>Israeli Restaurant</th>
      <th>Italian Restaurant</th>
      <th>Japanese Curry Restaurant</th>
      <th>Japanese Restaurant</th>
      <th>Jazz Club</th>
      <th>Jewelry Store</th>
      <th>Jewish Restaurant</th>
      <th>Juice Bar</th>
      <th>Karaoke Bar</th>
      <th>Kebab Restaurant</th>
      <th>Kids Store</th>
      <th>Korean Restaurant</th>
      <th>Kosher Restaurant</th>
      <th>Lake</th>
      <th>Latin American Restaurant</th>
      <th>Laundry Service</th>
      <th>Leather Goods Store</th>
      <th>Lebanese Restaurant</th>
      <th>Library</th>
      <th>Light Rail Station</th>
      <th>Lingerie Store</th>
      <th>Liquor Store</th>
      <th>Lounge</th>
      <th>Luggage Store</th>
      <th>Mac &amp; Cheese Joint</th>
      <th>Malay Restaurant</th>
      <th>Market</th>
      <th>Martial Arts Dojo</th>
      <th>Massage Studio</th>
      <th>Medical Center</th>
      <th>Mediterranean Restaurant</th>
      <th>Memorial Site</th>
      <th>Men's Store</th>
      <th>Metro Station</th>
      <th>Mexican Restaurant</th>
      <th>Middle Eastern Restaurant</th>
      <th>Mini Golf</th>
      <th>Miscellaneous Shop</th>
      <th>Mobile Phone Shop</th>
      <th>Modern European Restaurant</th>
      <th>Molecular Gastronomy Restaurant</th>
      <th>Monument / Landmark</th>
      <th>Moroccan Restaurant</th>
      <th>Motel</th>
      <th>Movie Theater</th>
      <th>Museum</th>
      <th>Music School</th>
      <th>Music Store</th>
      <th>Music Venue</th>
      <th>Nail Salon</th>
      <th>New American Restaurant</th>
      <th>Newsstand</th>
      <th>Nightclub</th>
      <th>Non-Profit</th>
      <th>Noodle House</th>
      <th>North Indian Restaurant</th>
      <th>Office</th>
      <th>Opera House</th>
      <th>Optical Shop</th>
      <th>Organic Grocery</th>
      <th>Other Great Outdoors</th>
      <th>Other Nightlife</th>
      <th>Outdoor Sculpture</th>
      <th>Outdoors &amp; Recreation</th>
      <th>Paella Restaurant</th>
      <th>Pakistani Restaurant</th>
      <th>Paper / Office Supplies Store</th>
      <th>Park</th>
      <th>Performing Arts Venue</th>
      <th>Persian Restaurant</th>
      <th>Peruvian Restaurant</th>
      <th>Pet Café</th>
      <th>Pet Service</th>
      <th>Pet Store</th>
      <th>Pharmacy</th>
      <th>Photography Studio</th>
      <th>Piano Bar</th>
      <th>Pie Shop</th>
      <th>Pilates Studio</th>
      <th>Pizza Place</th>
      <th>Playground</th>
      <th>Plaza</th>
      <th>Poke Place</th>
      <th>Pool</th>
      <th>Portuguese Restaurant</th>
      <th>Poutine Place</th>
      <th>Pub</th>
      <th>Public Art</th>
      <th>Ramen Restaurant</th>
      <th>Record Shop</th>
      <th>Recreation Center</th>
      <th>Rental Car Location</th>
      <th>Residential Building (Apartment / Condo)</th>
      <th>Resort</th>
      <th>Rest Area</th>
      <th>Restaurant</th>
      <th>River</th>
      <th>Rock Club</th>
      <th>Roof Deck</th>
      <th>Russian Restaurant</th>
      <th>Sake Bar</th>
      <th>Salad Place</th>
      <th>Salon / Barbershop</th>
      <th>Sandwich Place</th>
      <th>Scandinavian Restaurant</th>
      <th>Scenic Lookout</th>
      <th>School</th>
      <th>Sculpture Garden</th>
      <th>Seafood Restaurant</th>
      <th>Shanghai Restaurant</th>
      <th>Shipping Store</th>
      <th>Shoe Repair</th>
      <th>Shoe Store</th>
      <th>Shopping Mall</th>
      <th>Skate Park</th>
      <th>Skating Rink</th>
      <th>Ski Shop</th>
      <th>Smoke Shop</th>
      <th>Smoothie Shop</th>
      <th>Snack Place</th>
      <th>Soba Restaurant</th>
      <th>Soccer Field</th>
      <th>Social Club</th>
      <th>Soup Place</th>
      <th>South American Restaurant</th>
      <th>South Indian Restaurant</th>
      <th>Southern / Soul Food Restaurant</th>
      <th>Spa</th>
      <th>Spanish Restaurant</th>
      <th>Speakeasy</th>
      <th>Spiritual Center</th>
      <th>Sporting Goods Shop</th>
      <th>Sports Bar</th>
      <th>Sports Club</th>
      <th>Stadium</th>
      <th>Stationery Store</th>
      <th>Steakhouse</th>
      <th>Street Art</th>
      <th>Strip Club</th>
      <th>Supermarket</th>
      <th>Supplement Shop</th>
      <th>Sushi Restaurant</th>
      <th>Swim School</th>
      <th>Swiss Restaurant</th>
      <th>Szechuan Restaurant</th>
      <th>Taco Place</th>
      <th>Tailor Shop</th>
      <th>Taiwanese Restaurant</th>
      <th>Tanning Salon</th>
      <th>Tapas Restaurant</th>
      <th>Tattoo Parlor</th>
      <th>Tea Room</th>
      <th>Tech Startup</th>
      <th>Tennis Court</th>
      <th>Tennis Stadium</th>
      <th>Thai Restaurant</th>
      <th>Theater</th>
      <th>Theme Park Ride / Attraction</th>
      <th>Theme Restaurant</th>
      <th>Thrift / Vintage Store</th>
      <th>Tiki Bar</th>
      <th>Tourist Information Center</th>
      <th>Toy / Game Store</th>
      <th>Trail</th>
      <th>Train Station</th>
      <th>Tree</th>
      <th>Turkish Restaurant</th>
      <th>Udon Restaurant</th>
      <th>Used Bookstore</th>
      <th>Vegetarian / Vegan Restaurant</th>
      <th>Venezuelan Restaurant</th>
      <th>Veterinarian</th>
      <th>Video Game Store</th>
      <th>Video Store</th>
      <th>Vietnamese Restaurant</th>
      <th>Volleyball Court</th>
      <th>Warehouse Store</th>
      <th>Watch Shop</th>
      <th>Waterfront</th>
      <th>Weight Loss Center</th>
      <th>Whisky Bar</th>
      <th>Wine Bar</th>
      <th>Wine Shop</th>
      <th>Wings Joint</th>
      <th>Women's Store</th>
      <th>Yoga Studio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.02</td>
      <td>0.0</td>
      <td>0.04</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.03</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.05</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.070000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.02</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.02</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.030000</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.020000</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.01</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.04</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.02</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.04</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.01</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.25</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.25</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.25</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.000000</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.250000</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.5</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.000000</td>
      <td>0.5</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.1</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.100000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.1</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.1</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.2</td>
      <td>0.000000</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.100000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.200000</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.100000</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.000000</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.111111</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.222222</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.111111</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.111111</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
Toronto_manhattan.fillna(0, inplace = True)
```


```python
# run k-means clustering
kmeans = KMeans(n_clusters=kclusters, random_state=0).fit(Toronto_manhattan)

# check cluster labels generated for each row in the dataframe
kmeans.labels_[0:10] 
```




    array([1, 1, 2, 1, 1, 1, 1, 1, 1, 1])




```python
neighborhoods_venues_sorted_dataset_1.shape
kmeans.labels_[99:].shape
```




    (40,)



The following is for New York City.


```python
# add clustering labels
neighborhoods_venues_sorted_dataset_1.insert(0, 'Cluster Labels', kmeans.labels_[99:])

manhattan_merged = manhattan_data

# merge toronto_grouped with toronto_data to add latitude/longitude for each neighborhood
manhattan_merged = manhattan_merged.join(neighborhoods_venues_sorted_dataset_1.set_index('Neighborhood'), on='Neighborhood')

manhattan_merged.head() # check the last columns!
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>ZIP Codes</th>
      <th>Borough</th>
      <th>Neighborhood</th>
      <th>Latitude</th>
      <th>Longitude</th>
      <th>Cluster Labels</th>
      <th>1st Most Common Venue</th>
      <th>2nd Most Common Venue</th>
      <th>3rd Most Common Venue</th>
      <th>4th Most Common Venue</th>
      <th>5th Most Common Venue</th>
      <th>6th Most Common Venue</th>
      <th>7th Most Common Venue</th>
      <th>8th Most Common Venue</th>
      <th>9th Most Common Venue</th>
      <th>10th Most Common Venue</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
      <td>Marble Hill</td>
      <td>40.876551</td>
      <td>-73.910660</td>
      <td>1</td>
      <td>Sandwich Place</td>
      <td>Discount Store</td>
      <td>Coffee Shop</td>
      <td>Yoga Studio</td>
      <td>Tennis Stadium</td>
      <td>Supplement Shop</td>
      <td>Steakhouse</td>
      <td>Spa</td>
      <td>Shopping Mall</td>
      <td>Seafood Restaurant</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
      <td>Chinatown</td>
      <td>40.715618</td>
      <td>-73.994279</td>
      <td>1</td>
      <td>Chinese Restaurant</td>
      <td>Cocktail Bar</td>
      <td>Vietnamese Restaurant</td>
      <td>American Restaurant</td>
      <td>Salon / Barbershop</td>
      <td>Dumpling Restaurant</td>
      <td>Spa</td>
      <td>Bakery</td>
      <td>Bubble Tea Shop</td>
      <td>Dim Sum Restaurant</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
      <td>Washington Heights</td>
      <td>40.851903</td>
      <td>-73.936900</td>
      <td>1</td>
      <td>Café</td>
      <td>Bakery</td>
      <td>Mobile Phone Shop</td>
      <td>Grocery Store</td>
      <td>Deli / Bodega</td>
      <td>Spanish Restaurant</td>
      <td>Liquor Store</td>
      <td>Tapas Restaurant</td>
      <td>Mexican Restaurant</td>
      <td>Sandwich Place</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
      <td>Inwood</td>
      <td>40.867684</td>
      <td>-73.921210</td>
      <td>1</td>
      <td>Mexican Restaurant</td>
      <td>Café</td>
      <td>Pizza Place</td>
      <td>Lounge</td>
      <td>Bakery</td>
      <td>Park</td>
      <td>Restaurant</td>
      <td>Chinese Restaurant</td>
      <td>Caribbean Restaurant</td>
      <td>Spanish Restaurant</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10026, 10027, 10030, 10037, 10039</td>
      <td>Manhattan</td>
      <td>Hamilton Heights</td>
      <td>40.823604</td>
      <td>-73.949688</td>
      <td>1</td>
      <td>Pizza Place</td>
      <td>Mexican Restaurant</td>
      <td>Café</td>
      <td>Chinese Restaurant</td>
      <td>Coffee Shop</td>
      <td>School</td>
      <td>Sushi Restaurant</td>
      <td>Bank</td>
      <td>Bakery</td>
      <td>Deli / Bodega</td>
    </tr>
  </tbody>
</table>
</div>



The following is for Toronto.


```python
# add clustering labels
neighborhoods_venues_sorted.insert(0, 'Cluster Labels', kmeans.labels_[:99])



Toronto_merged = neighborhoods

# merge toronto_grouped with toronto_data to add latitude/longitude for each neighborhood
Toronto_merged = Toronto_merged.join(neighborhoods_venues_sorted.set_index('Neighborhood'), on='Neighbourhood')

Toronto_merged.head() # check the last columns!

Toronto_merged["Cluster Labels"] = Toronto_merged["Cluster Labels"].fillna(method = "ffill")
```


```python
# create map
map_clusters = folium.Map(location=[neighborhoods.Latitude.mean(), neighborhoods.Longitude.mean()], zoom_start=11)

# set color scheme for the clusters
x = np.arange(kclusters)
ys = [i + x + (i*x)**2 for i in range(kclusters)]
colors_array = cm.rainbow(np.linspace(0, 1, len(ys)))
rainbow = [colors.rgb2hex(i) for i in colors_array]

# add markers to the map
markers_colors = []
for lat, lon, poi, cluster in zip(Toronto_merged['Latitude'], Toronto_merged['Longitude'], Toronto_merged['Neighbourhood'], Toronto_merged['Cluster Labels']):
    label = folium.Popup(str(poi) + ' Cluster ' + str(cluster), parse_html=True)
    folium.CircleMarker(
        [lat, lon],
        radius=5,
        popup=label,
        color=rainbow[int(cluster)-1],
        fill=True,
        fill_color=rainbow[int(cluster)-1],
        fill_opacity=0.7).add_to(map_clusters)
       
map_clusters
```




<div style="width:100%;"><div style="position:relative;width:100%;height:0;padding-bottom:60%;"><iframe src="data:text/html;charset=utf-8;base64,PCFET0NUWVBFIGh0bWw+CjxoZWFkPiAgICAKICAgIDxtZXRhIGh0dHAtZXF1aXY9ImNvbnRlbnQtdHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04IiAvPgogICAgPHNjcmlwdD5MX1BSRUZFUl9DQU5WQVMgPSBmYWxzZTsgTF9OT19UT1VDSCA9IGZhbHNlOyBMX0RJU0FCTEVfM0QgPSBmYWxzZTs8L3NjcmlwdD4KICAgIDxzY3JpcHQgc3JjPSJodHRwczovL2Nkbi5qc2RlbGl2ci5uZXQvbnBtL2xlYWZsZXRAMS4yLjAvZGlzdC9sZWFmbGV0LmpzIj48L3NjcmlwdD4KICAgIDxzY3JpcHQgc3JjPSJodHRwczovL2FqYXguZ29vZ2xlYXBpcy5jb20vYWpheC9saWJzL2pxdWVyeS8xLjExLjEvanF1ZXJ5Lm1pbi5qcyI+PC9zY3JpcHQ+CiAgICA8c2NyaXB0IHNyYz0iaHR0cHM6Ly9tYXhjZG4uYm9vdHN0cmFwY2RuLmNvbS9ib290c3RyYXAvMy4yLjAvanMvYm9vdHN0cmFwLm1pbi5qcyI+PC9zY3JpcHQ+CiAgICA8c2NyaXB0IHNyYz0iaHR0cHM6Ly9jZG5qcy5jbG91ZGZsYXJlLmNvbS9hamF4L2xpYnMvTGVhZmxldC5hd2Vzb21lLW1hcmtlcnMvMi4wLjIvbGVhZmxldC5hd2Vzb21lLW1hcmtlcnMuanMiPjwvc2NyaXB0PgogICAgPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL2Nkbi5qc2RlbGl2ci5uZXQvbnBtL2xlYWZsZXRAMS4yLjAvZGlzdC9sZWFmbGV0LmNzcyIvPgogICAgPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL21heGNkbi5ib290c3RyYXBjZG4uY29tL2Jvb3RzdHJhcC8zLjIuMC9jc3MvYm9vdHN0cmFwLm1pbi5jc3MiLz4KICAgIDxsaW5rIHJlbD0ic3R5bGVzaGVldCIgaHJlZj0iaHR0cHM6Ly9tYXhjZG4uYm9vdHN0cmFwY2RuLmNvbS9ib290c3RyYXAvMy4yLjAvY3NzL2Jvb3RzdHJhcC10aGVtZS5taW4uY3NzIi8+CiAgICA8bGluayByZWw9InN0eWxlc2hlZXQiIGhyZWY9Imh0dHBzOi8vbWF4Y2RuLmJvb3RzdHJhcGNkbi5jb20vZm9udC1hd2Vzb21lLzQuNi4zL2Nzcy9mb250LWF3ZXNvbWUubWluLmNzcyIvPgogICAgPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL2NkbmpzLmNsb3VkZmxhcmUuY29tL2FqYXgvbGlicy9MZWFmbGV0LmF3ZXNvbWUtbWFya2Vycy8yLjAuMi9sZWFmbGV0LmF3ZXNvbWUtbWFya2Vycy5jc3MiLz4KICAgIDxsaW5rIHJlbD0ic3R5bGVzaGVldCIgaHJlZj0iaHR0cHM6Ly9yYXdnaXQuY29tL3B5dGhvbi12aXN1YWxpemF0aW9uL2ZvbGl1bS9tYXN0ZXIvZm9saXVtL3RlbXBsYXRlcy9sZWFmbGV0LmF3ZXNvbWUucm90YXRlLmNzcyIvPgogICAgPHN0eWxlPmh0bWwsIGJvZHkge3dpZHRoOiAxMDAlO2hlaWdodDogMTAwJTttYXJnaW46IDA7cGFkZGluZzogMDt9PC9zdHlsZT4KICAgIDxzdHlsZT4jbWFwIHtwb3NpdGlvbjphYnNvbHV0ZTt0b3A6MDtib3R0b206MDtyaWdodDowO2xlZnQ6MDt9PC9zdHlsZT4KICAgIAogICAgICAgICAgICA8c3R5bGU+ICNtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIgewogICAgICAgICAgICAgICAgcG9zaXRpb24gOiByZWxhdGl2ZTsKICAgICAgICAgICAgICAgIHdpZHRoIDogMTAwLjAlOwogICAgICAgICAgICAgICAgaGVpZ2h0OiAxMDAuMCU7CiAgICAgICAgICAgICAgICBsZWZ0OiAwLjAlOwogICAgICAgICAgICAgICAgdG9wOiAwLjAlOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICA8L3N0eWxlPgogICAgICAgIAo8L2hlYWQ+Cjxib2R5PiAgICAKICAgIAogICAgICAgICAgICA8ZGl2IGNsYXNzPSJmb2xpdW0tbWFwIiBpZD0ibWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViIiA+PC9kaXY+CiAgICAgICAgCjwvYm9keT4KPHNjcmlwdD4gICAgCiAgICAKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGJvdW5kcyA9IG51bGw7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgdmFyIG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1YiA9IEwubWFwKAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ21hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1YicsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7Y2VudGVyOiBbNDMuNzA0NjA3NzMzOTgwNTksLTc5LjM5NzE1MjkxMTY1MDQ4XSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHpvb206IDExLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWF4Qm91bmRzOiBib3VuZHMsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsYXllcnM6IFtdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd29ybGRDb3B5SnVtcDogZmFsc2UsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcnM6IEwuQ1JTLkVQU0czODU3CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0pOwogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgdGlsZV9sYXllcl8xZDQ4OTdhNjU2Mjg0ODliYmFhMDA5MDg0MDg1NDIwMiA9IEwudGlsZUxheWVyKAogICAgICAgICAgICAgICAgJ2h0dHBzOi8ve3N9LnRpbGUub3BlbnN0cmVldG1hcC5vcmcve3p9L3t4fS97eX0ucG5nJywKICAgICAgICAgICAgICAgIHsKICAiYXR0cmlidXRpb24iOiBudWxsLAogICJkZXRlY3RSZXRpbmEiOiBmYWxzZSwKICAibWF4Wm9vbSI6IDE4LAogICJtaW5ab29tIjogMSwKICAibm9XcmFwIjogZmFsc2UsCiAgInN1YmRvbWFpbnMiOiAiYWJjIgp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNDY3OTA5ZGZmOGM2NDFhNDlhMzMwZGE3YjZhNTczZjMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NTMyNTg2LC03OS4zMjk2NTY1XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiMwMGI1ZWIiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMDBiNWViIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2NlNzRkNjdlMjNlMTQ4MWNiYjBkNzMzN2U2YmUzZTk0ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2Y0NGYxYmJlZDY2YzRmMTdhMzFkY2Y2ODBkMzA5MTk3ID0gJCgnPGRpdiBpZD0iaHRtbF9mNDRmMWJiZWQ2NmM0ZjE3YTMxZGNmNjgwZDMwOTE5NyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+UGFya3dvb2RzIENsdXN0ZXIgMi4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9jZTc0ZDY3ZTIzZTE0ODFjYmIwZDczMzdlNmJlM2U5NC5zZXRDb250ZW50KGh0bWxfZjQ0ZjFiYmVkNjZjNGYxN2EzMWRjZjY4MGQzMDkxOTcpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNDY3OTA5ZGZmOGM2NDFhNDlhMzMwZGE3YjZhNTczZjMuYmluZFBvcHVwKHBvcHVwX2NlNzRkNjdlMjNlMTQ4MWNiYjBkNzMzN2U2YmUzZTk0KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzNhNTgyNjlhZWMxMTQxZmI4OGY1MzBmMTBkZGUzNTVhID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzI1ODgyMjk5OTk5OTk1LC03OS4zMTU1NzE1OTk5OTk5OF0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF85MWZmNzkyN2FkYTk0ODYzYWUzY2NlMzZhYjEwMDA1NCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9lN2U2NzgxMjc0NmE0MjUyOTY5NGE5NGQ4MTk2MThmNyA9ICQoJzxkaXYgaWQ9Imh0bWxfZTdlNjc4MTI3NDZhNDI1Mjk2OTRhOTRkODE5NjE4ZjciIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlZpY3RvcmlhIFZpbGxhZ2UgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzkxZmY3OTI3YWRhOTQ4NjNhZTNjY2UzNmFiMTAwMDU0LnNldENvbnRlbnQoaHRtbF9lN2U2NzgxMjc0NmE0MjUyOTY5NGE5NGQ4MTk2MThmNyk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8zYTU4MjY5YWVjMTE0MWZiODhmNTMwZjEwZGRlMzU1YS5iaW5kUG9wdXAocG9wdXBfOTFmZjc5MjdhZGE5NDg2M2FlM2NjZTM2YWIxMDAwNTQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZWQ4NDM5NzJlMjRiNGEwZWIyMmUyMjk1Mjc3NzQyNDQgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NTQyNTk5LC03OS4zNjA2MzU5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2YwYzY4MmQ3OGM2YTQ0NzdiYTUyNzYyYWU3Mzg5ZWMwID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2Q0YTJiNzNlNDU0MzRlYTNhYzdiYjA5YWZkNjY3M2RmID0gJCgnPGRpdiBpZD0iaHRtbF9kNGEyYjczZTQ1NDM0ZWEzYWM3YmIwOWFmZDY2NzNkZiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+SGFyYm91cmZyb250LFJlZ2VudCBQYXJrIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9mMGM2ODJkNzhjNmE0NDc3YmE1Mjc2MmFlNzM4OWVjMC5zZXRDb250ZW50KGh0bWxfZDRhMmI3M2U0NTQzNGVhM2FjN2JiMDlhZmQ2NjczZGYpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZWQ4NDM5NzJlMjRiNGEwZWIyMmUyMjk1Mjc3NzQyNDQuYmluZFBvcHVwKHBvcHVwX2YwYzY4MmQ3OGM2YTQ0NzdiYTUyNzYyYWU3Mzg5ZWMwKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzRiMjgwNDAyOWIxNDQzNGNiNTMwZTA5MmIzMWIxYjQyID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzE4NTE3OTk5OTk5OTk2LC03OS40NjQ3NjMyOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8wNzJjODU5OTQzMzA0MWRmYWFlOGQ4M2JkOGVhMmNiOCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF84OGQ1MzNiN2RlZWU0ODA4YWQxMWJkYmUyYTdhZWRjOCA9ICQoJzxkaXYgaWQ9Imh0bWxfODhkNTMzYjdkZWVlNDgwOGFkMTFiZGJlMmE3YWVkYzgiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkxhd3JlbmNlIEhlaWdodHMsTGF3cmVuY2UgTWFub3IgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzA3MmM4NTk5NDMzMDQxZGZhYWU4ZDgzYmQ4ZWEyY2I4LnNldENvbnRlbnQoaHRtbF84OGQ1MzNiN2RlZWU0ODA4YWQxMWJkYmUyYTdhZWRjOCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl80YjI4MDQwMjliMTQ0MzRjYjUzMGUwOTJiMzFiMWI0Mi5iaW5kUG9wdXAocG9wdXBfMDcyYzg1OTk0MzMwNDFkZmFhZThkODNiZDhlYTJjYjgpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMzBjOTg4MDc1ZjU1NDg1Zjg5NTlkYmU4NmE2ZjYwMmUgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NjIzMDE1LC03OS4zODk0OTM4XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2JhYTI2NDNlMTZmNjQyOGE5YTk5ZWZjYzA0NjAxNmU5ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2I1MTlhMDgwNmExNjQyNjZiM2EzZjczN2FiNjNmY2Q4ID0gJCgnPGRpdiBpZD0iaHRtbF9iNTE5YTA4MDZhMTY0MjY2YjNhM2Y3MzdhYjYzZmNkOCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+UXVlZW4mIzM5O3MgUGFyayBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYmFhMjY0M2UxNmY2NDI4YTlhOTllZmNjMDQ2MDE2ZTkuc2V0Q29udGVudChodG1sX2I1MTlhMDgwNmExNjQyNjZiM2EzZjczN2FiNjNmY2Q4KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzMwYzk4ODA3NWY1NTQ4NWY4OTU5ZGJlODZhNmY2MDJlLmJpbmRQb3B1cChwb3B1cF9iYWEyNjQzZTE2ZjY0MjhhOWE5OWVmY2MwNDYwMTZlOSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9kMzQyMzgyMWJjODc0MThmYTlkMjVhMmU2NDU4MzU3MCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2Nzg1NTYsLTc5LjUzMjI0MjQwMDAwMDAyXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2I5ZDU0Y2ZlYmZkMzQxMGY5ZDJmMTc0ZWFlNmYyMTRiID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzAwN2UxM2FiMGQwNzQxN2JiMzZlYzBmNGQyMjc1OTJjID0gJCgnPGRpdiBpZD0iaHRtbF8wMDdlMTNhYjBkMDc0MTdiYjM2ZWMwZjRkMjI3NTkyYyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+SXNsaW5ndG9uIEF2ZW51ZSBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYjlkNTRjZmViZmQzNDEwZjlkMmYxNzRlYWU2ZjIxNGIuc2V0Q29udGVudChodG1sXzAwN2UxM2FiMGQwNzQxN2JiMzZlYzBmNGQyMjc1OTJjKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2QzNDIzODIxYmM4NzQxOGZhOWQyNWEyZTY0NTgzNTcwLmJpbmRQb3B1cChwb3B1cF9iOWQ1NGNmZWJmZDM0MTBmOWQyZjE3NGVhZTZmMjE0Yik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl84Mjc4YzJlNGM2NmY0MTBkYjEzMDdiN2Y0NjQ1YmE2OSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjgwNjY4NjI5OTk5OTk5NiwtNzkuMTk0MzUzNDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiI2ZmYjM2MCIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiNmZmIzNjAiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZmM0NjFmMTA0ZmJjNGViNmE5NjIxNmQzMTMwNGE4YTYgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYzU0NGRmOTgyMzJmNGMwNGEwNjAyN2JlZTQxNmZjYzIgPSAkKCc8ZGl2IGlkPSJodG1sX2M1NDRkZjk4MjMyZjRjMDRhMDYwMjdiZWU0MTZmY2MyIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Sb3VnZSxNYWx2ZXJuIENsdXN0ZXIgNC4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9mYzQ2MWYxMDRmYmM0ZWI2YTk2MjE2ZDMxMzA0YThhNi5zZXRDb250ZW50KGh0bWxfYzU0NGRmOTgyMzJmNGMwNGEwNjAyN2JlZTQxNmZjYzIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfODI3OGMyZTRjNjZmNDEwZGIxMzA3YjdmNDY0NWJhNjkuYmluZFBvcHVwKHBvcHVwX2ZjNDYxZjEwNGZiYzRlYjZhOTYyMTZkMzEzMDRhOGE2KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2QyOWRlMTYyMjViMzQ1YjI5MDcxM2Y4MzEwYWJjZmZlID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzQ1OTA1Nzk5OTk5OTk2LC03OS4zNTIxODhdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNmMwOWI0NmI5ZTNmNDljNDg2MTQ5YWEzZTZhZGU2NzMgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNGQ0OTlmYWExMTNlNGYxZGE0NjY4N2JlYzhmYzg2YTcgPSAkKCc8ZGl2IGlkPSJodG1sXzRkNDk5ZmFhMTEzZTRmMWRhNDY2ODdiZWM4ZmM4NmE3IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Eb24gTWlsbHMgTm9ydGggQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzZjMDliNDZiOWUzZjQ5YzQ4NjE0OWFhM2U2YWRlNjczLnNldENvbnRlbnQoaHRtbF80ZDQ5OWZhYTExM2U0ZjFkYTQ2Njg3YmVjOGZjODZhNyk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9kMjlkZTE2MjI1YjM0NWIyOTA3MTNmODMxMGFiY2ZmZS5iaW5kUG9wdXAocG9wdXBfNmMwOWI0NmI5ZTNmNDljNDg2MTQ5YWEzZTZhZGU2NzMpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNWIwZDE1MjMzMGZmNDIwODhjOTJhMTM3YzZkZTYzZmIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MDYzOTcyLC03OS4zMDk5MzddLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYmVkODg4NjdiMzQ5NGY2NjhjZTI2NmQ2YzI2NmFkNWYgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNzA2NDI5MzAyM2ZhNDMwMmI5ZDI3M2E5ZDlmYmM1YTkgPSAkKCc8ZGl2IGlkPSJodG1sXzcwNjQyOTMwMjNmYTQzMDJiOWQyNzNhOWQ5ZmJjNWE5IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Xb29kYmluZSBHYXJkZW5zLFBhcmt2aWV3IEhpbGwgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2JlZDg4ODY3YjM0OTRmNjY4Y2UyNjZkNmMyNjZhZDVmLnNldENvbnRlbnQoaHRtbF83MDY0MjkzMDIzZmE0MzAyYjlkMjczYTlkOWZiYzVhOSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl81YjBkMTUyMzMwZmY0MjA4OGM5MmExMzdjNmRlNjNmYi5iaW5kUG9wdXAocG9wdXBfYmVkODg4NjdiMzQ5NGY2NjhjZTI2NmQ2YzI2NmFkNWYpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMDNhNWFlNzkzNjNhNDhiYzk1ZDMxZjdmMWU4YmNhODggPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NTcxNjE4LC03OS4zNzg5MzcwOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF81NjIyODc0NDcxODI0NjIwOTdiNjhkMjU5ZDc1NWQ4MiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8xN2JiMzA5NzExMTY0MzU3YjQxOTliNDZkOTIzMWE1ZCA9ICQoJzxkaXYgaWQ9Imh0bWxfMTdiYjMwOTcxMTE2NDM1N2I0MTk5YjQ2ZDkyMzFhNWQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlJ5ZXJzb24sR2FyZGVuIERpc3RyaWN0IENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF81NjIyODc0NDcxODI0NjIwOTdiNjhkMjU5ZDc1NWQ4Mi5zZXRDb250ZW50KGh0bWxfMTdiYjMwOTcxMTE2NDM1N2I0MTk5YjQ2ZDkyMzFhNWQpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMDNhNWFlNzkzNjNhNDhiYzk1ZDMxZjdmMWU4YmNhODguYmluZFBvcHVwKHBvcHVwXzU2MjI4NzQ0NzE4MjQ2MjA5N2I2OGQyNTlkNzU1ZDgyKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2JkYzIzZjM0MTlhNzRhN2I5ZDM4MmMyNzlkNDZhOWY4ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzA5NTc3LC03OS40NDUwNzI1OTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF85OTljYmE5NjMwN2E0MTk2ODY2MzRiMGJlOGVjNWMwNSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF84MTljY2I1ZjJlOTU0Njk4YjA5Mjg2NTVkMThlNWFkMyA9ICQoJzxkaXYgaWQ9Imh0bWxfODE5Y2NiNWYyZTk1NDY5OGIwOTI4NjU1ZDE4ZTVhZDMiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkdsZW5jYWlybiBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfOTk5Y2JhOTYzMDdhNDE5Njg2NjM0YjBiZThlYzVjMDUuc2V0Q29udGVudChodG1sXzgxOWNjYjVmMmU5NTQ2OThiMDkyODY1NWQxOGU1YWQzKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2JkYzIzZjM0MTlhNzRhN2I5ZDM4MmMyNzlkNDZhOWY4LmJpbmRQb3B1cChwb3B1cF85OTljYmE5NjMwN2E0MTk2ODY2MzRiMGJlOGVjNWMwNSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9jNzBjNDQxMGVmMjU0ZjY0YTU5NjhmNWY2MDA3MmNiOSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY1MDk0MzIsLTc5LjU1NDcyNDQwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MGZmYjQiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODBmZmI0IiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzkzMTEyNDJmMTM4NjRkYTRiZDc0MWY0NzZiMmFjZjliID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzVkMmNlMDVhYTMxZDRkODhhNTQwYmZkNDBjOGRkMDVmID0gJCgnPGRpdiBpZD0iaHRtbF81ZDJjZTA1YWEzMWQ0ZDg4YTU0MGJmZDQwYzhkZDA1ZiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2xvdmVyZGFsZSxJc2xpbmd0b24sTWFydGluIEdyb3ZlLFByaW5jZXNzIEdhcmRlbnMsV2VzdCBEZWFuZSBQYXJrIENsdXN0ZXIgMy4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF85MzExMjQyZjEzODY0ZGE0YmQ3NDFmNDc2YjJhY2Y5Yi5zZXRDb250ZW50KGh0bWxfNWQyY2UwNWFhMzFkNGQ4OGE1NDBiZmQ0MGM4ZGQwNWYpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYzcwYzQ0MTBlZjI1NGY2NGE1OTY4ZjVmNjAwNzJjYjkuYmluZFBvcHVwKHBvcHVwXzkzMTEyNDJmMTM4NjRkYTRiZDc0MWY0NzZiMmFjZjliKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2VhNTk5NzQ2ZjA3MjRkMDA4ODYxNjAzMmQ4MDZhNGZmID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzg0NTM1MSwtNzkuMTYwNDk3MDk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMmM0NmMxZDIyOTAxNGE5Nzk1OTE3MzllOTAyMjI3ZDAgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMmNmZWQwN2ZjNzcxNDI3ZThmZjljYjkyMDBjZDUzYjkgPSAkKCc8ZGl2IGlkPSJodG1sXzJjZmVkMDdmYzc3MTQyN2U4ZmY5Y2I5MjAwY2Q1M2I5IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5IaWdobGFuZCBDcmVlayxSb3VnZSBIaWxsLFBvcnQgVW5pb24gQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzJjNDZjMWQyMjkwMTRhOTc5NTkxNzM5ZTkwMjIyN2QwLnNldENvbnRlbnQoaHRtbF8yY2ZlZDA3ZmM3NzE0MjdlOGZmOWNiOTIwMGNkNTNiOSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9lYTU5OTc0NmYwNzI0ZDAwODg2MTYwMzJkODA2YTRmZi5iaW5kUG9wdXAocG9wdXBfMmM0NmMxZDIyOTAxNGE5Nzk1OTE3MzllOTAyMjI3ZDApOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYjJiMGQxZTY2OTVmNDgzZjkzNWZjZDVmZGU1ZGQ0OTggPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MjU4OTk3MDAwMDAwMSwtNzkuMzQwOTIzXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzhmNTY0MDZjNTBjZjQ3OGY4MjVjMjgyMTI3Y2QxOTBlID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzVmM2E5NjhmMzk2MjQ0OGZhOTYyZjI3Y2M1NTM1NjA4ID0gJCgnPGRpdiBpZD0iaHRtbF81ZjNhOTY4ZjM5NjI0NDhmYTk2MmYyN2NjNTUzNTYwOCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RmxlbWluZ2RvbiBQYXJrLERvbiBNaWxscyBTb3V0aCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfOGY1NjQwNmM1MGNmNDc4ZjgyNWMyODIxMjdjZDE5MGUuc2V0Q29udGVudChodG1sXzVmM2E5NjhmMzk2MjQ0OGZhOTYyZjI3Y2M1NTM1NjA4KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2IyYjBkMWU2Njk1ZjQ4M2Y5MzVmY2Q1ZmRlNWRkNDk4LmJpbmRQb3B1cChwb3B1cF84ZjU2NDA2YzUwY2Y0NzhmODI1YzI4MjEyN2NkMTkwZSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl82ZDk5NGZkNWZjNTk0OWI5YjcxZTRiZWRkNWY0ZWRkZiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY5NTM0MzkwMDAwMDAwNSwtNzkuMzE4Mzg4N10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF83OTgxN2M5NmY1YWE0YmU1ODlhYjA1MmEzNTFjMjM5ZSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8yNDBjYWZmOTJmOWY0NDhmOGZlNmY5MTA5NzY5MTc3MSA9ICQoJzxkaXYgaWQ9Imh0bWxfMjQwY2FmZjkyZjlmNDQ4ZjhmZTZmOTEwOTc2OTE3NzEiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPldvb2RiaW5lIEhlaWdodHMgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzc5ODE3Yzk2ZjVhYTRiZTU4OWFiMDUyYTM1MWMyMzllLnNldENvbnRlbnQoaHRtbF8yNDBjYWZmOTJmOWY0NDhmOGZlNmY5MTA5NzY5MTc3MSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl82ZDk5NGZkNWZjNTk0OWI5YjcxZTRiZWRkNWY0ZWRkZi5iaW5kUG9wdXAocG9wdXBfNzk4MTdjOTZmNWFhNGJlNTg5YWIwNTJhMzUxYzIzOWUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMzEwMDJhODg4ZGY1NDdjYTlhMTY3ODZiZmFhMDZmODEgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NTE0OTM5LC03OS4zNzU0MTc5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2NmMmU1Y2QzNjA2MDQzMWJhNjQyMjI3Y2VmMDM4YjE0ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzZlMzMyZjkxMDY0YTQ1NWJiYmY4NDc4ZTVhZjdjZDE1ID0gJCgnPGRpdiBpZD0iaHRtbF82ZTMzMmY5MTA2NGE0NTViYmJmODQ3OGU1YWY3Y2QxNSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+U3QuIEphbWVzIFRvd24gQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2NmMmU1Y2QzNjA2MDQzMWJhNjQyMjI3Y2VmMDM4YjE0LnNldENvbnRlbnQoaHRtbF82ZTMzMmY5MTA2NGE0NTViYmJmODQ3OGU1YWY3Y2QxNSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8zMTAwMmE4ODhkZjU0N2NhOWExNjc4NmJmYWEwNmY4MS5iaW5kUG9wdXAocG9wdXBfY2YyZTVjZDM2MDYwNDMxYmE2NDIyMjdjZWYwMzhiMTQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYTZjNDFmNDkwOGZmNDk2MmIxYzdjYjVmMDQ4YjRjZjEgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42OTM3ODEzLC03OS40MjgxOTE0MDAwMDAwMl0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9mOTA4YzJkMTJmZTM0ZDkxOGNlNGZiMDFkMTE3NGU1NiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9iZGQ5YjNkM2YwYTA0OTUyODcxMWJhMjFlNzAxYjNiNCA9ICQoJzxkaXYgaWQ9Imh0bWxfYmRkOWIzZDNmMGEwNDk1Mjg3MTFiYTIxZTcwMWIzYjQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkh1bWV3b29kLUNlZGFydmFsZSBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZjkwOGMyZDEyZmUzNGQ5MThjZTRmYjAxZDExNzRlNTYuc2V0Q29udGVudChodG1sX2JkZDliM2QzZjBhMDQ5NTI4NzExYmEyMWU3MDFiM2I0KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2E2YzQxZjQ5MDhmZjQ5NjJiMWM3Y2I1ZjA0OGI0Y2YxLmJpbmRQb3B1cChwb3B1cF9mOTA4YzJkMTJmZTM0ZDkxOGNlNGZiMDFkMTE3NGU1Nik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8yZDkxZGI1OTRmMjU0ZmUwYWQ1OWNjZTY1YjQ1YjQzMSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY0MzUxNTIsLTc5LjU3NzIwMDc5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzIzMWZlYjBkNmI3MzQwYjJhNmFmZmQxODJjMDMxYTc3ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzZmYjVhMzBmNzgyNzQxOWJiY2YxYmNmZDQ5Y2MwNTA1ID0gJCgnPGRpdiBpZD0iaHRtbF82ZmI1YTMwZjc4Mjc0MTliYmNmMWJjZmQ0OWNjMDUwNSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Qmxvb3JkYWxlIEdhcmRlbnMsRXJpbmdhdGUsTWFya2xhbmQgV29vZCxPbGQgQnVybmhhbXRob3JwZSBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMjMxZmViMGQ2YjczNDBiMmE2YWZmZDE4MmMwMzFhNzcuc2V0Q29udGVudChodG1sXzZmYjVhMzBmNzgyNzQxOWJiY2YxYmNmZDQ5Y2MwNTA1KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzJkOTFkYjU5NGYyNTRmZTBhZDU5Y2NlNjViNDViNDMxLmJpbmRQb3B1cChwb3B1cF8yMzFmZWIwZDZiNzM0MGIyYTZhZmZkMTgyYzAzMWE3Nyk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8wZmMyZTY4NWEwOGE0ZDZmYTY2MDBlODQ4MTJiZDEwOSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc2MzU3MjYsLTc5LjE4ODcxMTVdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNzcyYzk1NTVhYWViNDc1Yjk5OTdmZjBiMzNmNjE5Y2MgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYzliMjFjMTMyNjM2NDRmZmIwZDcwN2JlOGMxNDU0MmUgPSAkKCc8ZGl2IGlkPSJodG1sX2M5YjIxYzEzMjYzNjQ0ZmZiMGQ3MDdiZThjMTQ1NDJlIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5HdWlsZHdvb2QsTW9ybmluZ3NpZGUsV2VzdCBIaWxsIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF83NzJjOTU1NWFhZWI0NzViOTk5N2ZmMGIzM2Y2MTljYy5zZXRDb250ZW50KGh0bWxfYzliMjFjMTMyNjM2NDRmZmIwZDcwN2JlOGMxNDU0MmUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMGZjMmU2ODVhMDhhNGQ2ZmE2NjAwZTg0ODEyYmQxMDkuYmluZFBvcHVwKHBvcHVwXzc3MmM5NTU1YWFlYjQ3NWI5OTk3ZmYwYjMzZjYxOWNjKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2JjY2Y5NDlkNmM3MjQwOTQ5NDZlMjc2NWY1OWFiODVjID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjc2MzU3Mzk5OTk5OTksLTc5LjI5MzAzMTJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZWEwNjY0YzlmYTBlNGNmODkxNjJjMmY2NTI5NjNjZTIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMjY4NjI1MTI0ZGE2NDE4Mjg0N2ZiNjdhMzgxOGI2OTMgPSAkKCc8ZGl2IGlkPSJodG1sXzI2ODYyNTEyNGRhNjQxODI4NDdmYjY3YTM4MThiNjkzIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5UaGUgQmVhY2hlcyBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZWEwNjY0YzlmYTBlNGNmODkxNjJjMmY2NTI5NjNjZTIuc2V0Q29udGVudChodG1sXzI2ODYyNTEyNGRhNjQxODI4NDdmYjY3YTM4MThiNjkzKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2JjY2Y5NDlkNmM3MjQwOTQ5NDZlMjc2NWY1OWFiODVjLmJpbmRQb3B1cChwb3B1cF9lYTA2NjRjOWZhMGU0Y2Y4OTE2MmMyZjY1Mjk2M2NlMik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8yMTg4YzBhZjllN2Y0N2YxYWYxYjI2NWJmNDhhNGUxMCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY0NDc3MDc5OTk5OTk5NiwtNzkuMzczMzA2NF0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF81ZjM4MDllNmJlYTA0NDdjYmVjOTk1MjFhY2FkYjA1ZiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF84ZmNkNDA3OTk1MjQ0Yjk0YjVhMGM3YjliNWFiMDEzMyA9ICQoJzxkaXYgaWQ9Imh0bWxfOGZjZDQwNzk5NTI0NGI5NGI1YTBjN2I5YjVhYjAxMzMiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkJlcmN6eSBQYXJrIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF81ZjM4MDllNmJlYTA0NDdjYmVjOTk1MjFhY2FkYjA1Zi5zZXRDb250ZW50KGh0bWxfOGZjZDQwNzk5NTI0NGI5NGI1YTBjN2I5YjVhYjAxMzMpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMjE4OGMwYWY5ZTdmNDdmMWFmMWIyNjViZjQ4YTRlMTAuYmluZFBvcHVwKHBvcHVwXzVmMzgwOWU2YmVhMDQ0N2NiZWM5OTUyMWFjYWRiMDVmKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzIzMGYwMjI4ZDFmZjRkMGI5NjUzY2EzNGJlN2JjMmVkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjg5MDI1NiwtNzkuNDUzNTEyXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiMwMGI1ZWIiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMDBiNWViIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzg3ZTNiODUxMjEyOTQwM2RiYzY5MWZlMTk4OTQ5YzI5ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzVkNmFhNWRlNmY4ZTQwNmFiYzZkZGY4NGRiMTFlMzYyID0gJCgnPGRpdiBpZD0iaHRtbF81ZDZhYTVkZTZmOGU0MDZhYmM2ZGRmODRkYjExZTM2MiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2FsZWRvbmlhLUZhaXJiYW5rcyBDbHVzdGVyIDIuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfODdlM2I4NTEyMTI5NDAzZGJjNjkxZmUxOTg5NDljMjkuc2V0Q29udGVudChodG1sXzVkNmFhNWRlNmY4ZTQwNmFiYzZkZGY4NGRiMTFlMzYyKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzIzMGYwMjI4ZDFmZjRkMGI5NjUzY2EzNGJlN2JjMmVkLmJpbmRQb3B1cChwb3B1cF84N2UzYjg1MTIxMjk0MDNkYmM2OTFmZTE5ODk0OWMyOSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8yODc4Nzg2ZGI5YWU0ZTEwYTE3NzJmN2Y1ZWQ1NWQxNiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc3MDk5MjEsLTc5LjIxNjkxNzQwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzJlMDEzNGJmNGMwMTQ2ZjlhNGZjOWFkNTI4MTA0Zjk3ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2JiYjAxODFlMWI0OTQ3YzJiODQzMjQwMzg4NTA0NWRmID0gJCgnPGRpdiBpZD0iaHRtbF9iYmIwMTgxZTFiNDk0N2MyYjg0MzI0MDM4ODUwNDVkZiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+V29idXJuIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8yZTAxMzRiZjRjMDE0NmY5YTRmYzlhZDUyODEwNGY5Ny5zZXRDb250ZW50KGh0bWxfYmJiMDE4MWUxYjQ5NDdjMmI4NDMyNDAzODg1MDQ1ZGYpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMjg3ODc4NmRiOWFlNGUxMGExNzcyZjdmNWVkNTVkMTYuYmluZFBvcHVwKHBvcHVwXzJlMDEzNGJmNGMwMTQ2ZjlhNGZjOWFkNTI4MTA0Zjk3KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzI4Y2ZiN2ExYTY0YjRiMmJiZGU2OGFmNzEzMDQ1N2JjID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzA5MDYwNCwtNzkuMzYzNDUxN10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8yZDcxZmJmZDg1NzI0NWVkOGQxY2UwOGQ0YjY1NDc4ZCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9jZmI4NTcxOTdkMDE0ZGM4YmY5YTc3YzYyZTI4MmU2ZSA9ICQoJzxkaXYgaWQ9Imh0bWxfY2ZiODU3MTk3ZDAxNGRjOGJmOWE3N2M2MmUyODJlNmUiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkxlYXNpZGUgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzJkNzFmYmZkODU3MjQ1ZWQ4ZDFjZTA4ZDRiNjU0NzhkLnNldENvbnRlbnQoaHRtbF9jZmI4NTcxOTdkMDE0ZGM4YmY5YTc3YzYyZTI4MmU2ZSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8yOGNmYjdhMWE2NGI0YjJiYmRlNjhhZjcxMzA0NTdiYy5iaW5kUG9wdXAocG9wdXBfMmQ3MWZiZmQ4NTcyNDVlZDhkMWNlMDhkNGI2NTQ3OGQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMTNlMzlmY2MyMmU3NDc5Zjk1N2Q1MjFmYzEyMTE0ZDYgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NTc5NTI0LC03OS4zODczODI2XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2FiYmI5N2JlOTdjYTQ0YWNhYjA0YmU1MzdlMTIxZWMwID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzBlZDA1NDk0NDQzZDQzMzg5ZjU2NjU1OTIxZWUzYTNhID0gJCgnPGRpdiBpZD0iaHRtbF8wZWQwNTQ5NDQ0M2Q0MzM4OWY1NjY1NTkyMWVlM2EzYSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2VudHJhbCBCYXkgU3RyZWV0IENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9hYmJiOTdiZTk3Y2E0NGFjYWIwNGJlNTM3ZTEyMWVjMC5zZXRDb250ZW50KGh0bWxfMGVkMDU0OTQ0NDNkNDMzODlmNTY2NTU5MjFlZTNhM2EpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMTNlMzlmY2MyMmU3NDc5Zjk1N2Q1MjFmYzEyMTE0ZDYuYmluZFBvcHVwKHBvcHVwX2FiYmI5N2JlOTdjYTQ0YWNhYjA0YmU1MzdlMTIxZWMwKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2QzOWQ5MTNlNzRkOTRkNGFhODU5MWI0NmRhYTEyZjA4ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjY5NTQyLC03OS40MjI1NjM3XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzdiMTI2YjdhNzRlYTQ4MDY4OGQ0NTVhNjMxYmY2MWFhID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzNkNTYxMmY0OWU2ODRjMDFhMzAwOGJhNjY4OGI3NTJlID0gJCgnPGRpdiBpZD0iaHRtbF8zZDU2MTJmNDllNjg0YzAxYTMwMDhiYTY2ODhiNzUyZSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2hyaXN0aWUgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzdiMTI2YjdhNzRlYTQ4MDY4OGQ0NTVhNjMxYmY2MWFhLnNldENvbnRlbnQoaHRtbF8zZDU2MTJmNDllNjg0YzAxYTMwMDhiYTY2ODhiNzUyZSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9kMzlkOTEzZTc0ZDk0ZDRhYTg1OTFiNDZkYWExMmYwOC5iaW5kUG9wdXAocG9wdXBfN2IxMjZiN2E3NGVhNDgwNjg4ZDQ1NWE2MzFiZjYxYWEpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYTFhOGFlNDQ3MmQzNDM3NDhjOTVmZWZkOTFmZWJkZGUgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NzMxMzYsLTc5LjIzOTQ3NjA5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzllMjgyMmIzNzI1NTQ1ZTU5MmIwNzg4OGUxYTA5ZWFiID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzYyYTgyOTkyNWJiMzQ4NTE5NDEyYmRlZTBkMmI0YWFlID0gJCgnPGRpdiBpZD0iaHRtbF82MmE4Mjk5MjViYjM0ODUxOTQxMmJkZWUwZDJiNGFhZSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2VkYXJicmFlIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF85ZTI4MjJiMzcyNTU0NWU1OTJiMDc4ODhlMWEwOWVhYi5zZXRDb250ZW50KGh0bWxfNjJhODI5OTI1YmIzNDg1MTk0MTJiZGVlMGQyYjRhYWUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYTFhOGFlNDQ3MmQzNDM3NDhjOTVmZWZkOTFmZWJkZGUuYmluZFBvcHVwKHBvcHVwXzllMjgyMmIzNzI1NTQ1ZTU5MmIwNzg4OGUxYTA5ZWFiKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzlkMmMzMjVhZGQ3MTRlOTY4ZDExNTNmZTMzYmY1MjU4ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuODAzNzYyMiwtNzkuMzYzNDUxN10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9hYzg1YTAzMTQ5NDQ0NzNlOWZkZjYyNmY3OGRlOTFhNyA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF84ODRkODUyZTQzNmI0YWU2ODljYzkwNmFlMTkzYWQ4ZSA9ICQoJzxkaXYgaWQ9Imh0bWxfODg0ZDg1MmU0MzZiNGFlNjg5Y2M5MDZhZTE5M2FkOGUiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkhpbGxjcmVzdCBWaWxsYWdlIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9hYzg1YTAzMTQ5NDQ0NzNlOWZkZjYyNmY3OGRlOTFhNy5zZXRDb250ZW50KGh0bWxfODg0ZDg1MmU0MzZiNGFlNjg5Y2M5MDZhZTE5M2FkOGUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfOWQyYzMyNWFkZDcxNGU5NjhkMTE1M2ZlMzNiZjUyNTguYmluZFBvcHVwKHBvcHVwX2FjODVhMDMxNDk0NDQ3M2U5ZmRmNjI2Zjc4ZGU5MWE3KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2M2NTFkZTY3MTkxZTQ3YzE4N2YzMzdkMDE3NjI4MTNiID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzU0MzI4MywtNzkuNDQyMjU5M10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9jOWQ5MWNhMWIwOTY0ZDA4OTM0MjllMmUwM2IzZmM4YiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9iMDM4NzdiMDUyODA0YmQwOWQzZjQxMTlkNTZiMmYxZiA9ICQoJzxkaXYgaWQ9Imh0bWxfYjAzODc3YjA1MjgwNGJkMDlkM2Y0MTE5ZDU2YjJmMWYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkJhdGh1cnN0IE1hbm9yLERvd25zdmlldyBOb3J0aCxXaWxzb24gSGVpZ2h0cyBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYzlkOTFjYTFiMDk2NGQwODkzNDI5ZTJlMDNiM2ZjOGIuc2V0Q29udGVudChodG1sX2IwMzg3N2IwNTI4MDRiZDA5ZDNmNDExOWQ1NmIyZjFmKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2M2NTFkZTY3MTkxZTQ3YzE4N2YzMzdkMDE3NjI4MTNiLmJpbmRQb3B1cChwb3B1cF9jOWQ5MWNhMWIwOTY0ZDA4OTM0MjllMmUwM2IzZmM4Yik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8xMDhmMTMzOWZlZjA0NTUyOTEzNjMzNzMzYjAwZTViOSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcwNTM2ODksLTc5LjM0OTM3MTkwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzBlZmIwY2Y3OWQ1MzQ4NzE4YWM3ZDMzNGNlNDM1YmJjID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzQ0NjE5MTA5N2QyNjQ3OGZhNDM0MjgxMDVlZDk5ZTBjID0gJCgnPGRpdiBpZD0iaHRtbF80NDYxOTEwOTdkMjY0NzhmYTQzNDI4MTA1ZWQ5OWUwYyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+VGhvcm5jbGlmZmUgUGFyayBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMGVmYjBjZjc5ZDUzNDg3MThhYzdkMzM0Y2U0MzViYmMuc2V0Q29udGVudChodG1sXzQ0NjE5MTA5N2QyNjQ3OGZhNDM0MjgxMDVlZDk5ZTBjKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzEwOGYxMzM5ZmVmMDQ1NTI5MTM2MzM3MzNiMDBlNWI5LmJpbmRQb3B1cChwb3B1cF8wZWZiMGNmNzlkNTM0ODcxOGFjN2QzMzRjZTQzNWJiYyk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8yYjc2ZmNmNmNjNDY0ODJmODg5YWNiMDliM2Y4MDE0YSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY1MDU3MTIwMDAwMDAxLC03OS4zODQ1Njc1XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzVmZTA4ZDM1YjUwZDQ2M2U4ODc4OGQ1ZTAwMGM0MzYxID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2I1NGUxODk3OTFlYzQ4YmM4ZGQ1YTllMWMyNmQxZmFhID0gJCgnPGRpdiBpZD0iaHRtbF9iNTRlMTg5NzkxZWM0OGJjOGRkNWE5ZTFjMjZkMWZhYSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+QWRlbGFpZGUsS2luZyxSaWNobW9uZCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNWZlMDhkMzViNTBkNDYzZTg4Nzg4ZDVlMDAwYzQzNjEuc2V0Q29udGVudChodG1sX2I1NGUxODk3OTFlYzQ4YmM4ZGQ1YTllMWMyNmQxZmFhKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzJiNzZmY2Y2Y2M0NjQ4MmY4ODlhY2IwOWIzZjgwMTRhLmJpbmRQb3B1cChwb3B1cF81ZmUwOGQzNWI1MGQ0NjNlODg3ODhkNWUwMDBjNDM2MSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9lZWVjODU5N2FlZjk0OWFiYmJhYWE0MjYyN2ViZGMwMiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2OTAwNTEwMDAwMDAxLC03OS40NDIyNTkzXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzczYWYxNjI5ODQ5MjRjMjNhMDBkNjFmNjc2MDBjMmFlID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzcxMTk3YzgxMDU3YzQ4YzJhOTRlYjk5ODVhMjhjYjg0ID0gJCgnPGRpdiBpZD0iaHRtbF83MTE5N2M4MTA1N2M0OGMyYTk0ZWI5OTg1YTI4Y2I4NCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RG92ZXJjb3VydCBWaWxsYWdlLER1ZmZlcmluIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF83M2FmMTYyOTg0OTI0YzIzYTAwZDYxZjY3NjAwYzJhZS5zZXRDb250ZW50KGh0bWxfNzExOTdjODEwNTdjNDhjMmE5NGViOTk4NWEyOGNiODQpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZWVlYzg1OTdhZWY5NDlhYmJiYWFhNDI2MjdlYmRjMDIuYmluZFBvcHVwKHBvcHVwXzczYWYxNjI5ODQ5MjRjMjNhMDBkNjFmNjc2MDBjMmFlKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzE4YzgzZGI2YWJiYjRjYWRiNGJmYWRhMTA2OTk4MzM4ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzQ0NzM0MiwtNzkuMjM5NDc2MDk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfOWI2MmRmY2EzYmJmNGI4M2EyOTE1MWNjZmIwNjdlYWIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMDg3NDg0ZmViZjAxNDdkYTgwZDdhODJlNjVhODU1NTcgPSAkKCc8ZGl2IGlkPSJodG1sXzA4NzQ4NGZlYmYwMTQ3ZGE4MGQ3YTgyZTY1YTg1NTU3IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5TY2FyYm9yb3VnaCBWaWxsYWdlIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF85YjYyZGZjYTNiYmY0YjgzYTI5MTUxY2NmYjA2N2VhYi5zZXRDb250ZW50KGh0bWxfMDg3NDg0ZmViZjAxNDdkYTgwZDdhODJlNjVhODU1NTcpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMThjODNkYjZhYmJiNGNhZGI0YmZhZGExMDY5OTgzMzguYmluZFBvcHVwKHBvcHVwXzliNjJkZmNhM2JiZjRiODNhMjkxNTFjY2ZiMDY3ZWFiKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzc3N2FiZWE0M2FmODRhZjk5ODlmMTliZTk2YzI4NDc2ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzc4NTE3NSwtNzkuMzQ2NTU1N10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9jMTU3MThhZjE1NTE0MjNiYjlkNDYwZWMxZTZlZjcxYyA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF84ZGM5OTlkOTY0NDU0YmQ4YjVlODFiOGU0OWFjMTZkMSA9ICQoJzxkaXYgaWQ9Imh0bWxfOGRjOTk5ZDk2NDQ1NGJkOGI1ZTgxYjhlNDlhYzE2ZDEiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkZhaXJ2aWV3LEhlbnJ5IEZhcm0sT3Jpb2xlIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9jMTU3MThhZjE1NTE0MjNiYjlkNDYwZWMxZTZlZjcxYy5zZXRDb250ZW50KGh0bWxfOGRjOTk5ZDk2NDQ1NGJkOGI1ZTgxYjhlNDlhYzE2ZDEpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNzc3YWJlYTQzYWY4NGFmOTk4OWYxOWJlOTZjMjg0NzYuYmluZFBvcHVwKHBvcHVwX2MxNTcxOGFmMTU1MTQyM2JiOWQ0NjBlYzFlNmVmNzFjKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzkxOTExOThjMDgyZjQ3ODBiMTRiOGNiYTI3N2ZmN2VjID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzY3OTgwMywtNzkuNDg3MjYxOTAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYzkyMGJlYzgzNWQzNGNlOGE4ZWE0ZDI2MjE3MWE1YzMgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZjRlMTk0ZDhiYzMzNDY3ZmI1M2UwZWEzNDg1ZjE0YWMgPSAkKCc8ZGl2IGlkPSJodG1sX2Y0ZTE5NGQ4YmMzMzQ2N2ZiNTNlMGVhMzQ4NWYxNGFjIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Ob3J0aHdvb2QgUGFyayxZb3JrIFVuaXZlcnNpdHkgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2M5MjBiZWM4MzVkMzRjZThhOGVhNGQyNjIxNzFhNWMzLnNldENvbnRlbnQoaHRtbF9mNGUxOTRkOGJjMzM0NjdmYjUzZTBlYTM0ODVmMTRhYyk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl85MTkxMTk4YzA4MmY0NzgwYjE0YjhjYmEyNzdmZjdlYy5iaW5kUG9wdXAocG9wdXBfYzkyMGJlYzgzNWQzNGNlOGE4ZWE0ZDI2MjE3MWE1YzMpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZGRiZjRlZDc4ZDJiNDI3NmEzYzU1MTFmOTA0Y2JlNDkgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42ODUzNDcsLTc5LjMzODEwNjVdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYzZiYjVlZTMxM2E2NGQ0MWFiOWI5ODlkNzc3OWE1YWUgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfODI1NmI3ZjBmMTQ3NGE2MWE0ZmZhOGZiMDQwZmRlMTUgPSAkKCc8ZGl2IGlkPSJodG1sXzgyNTZiN2YwZjE0NzRhNjFhNGZmYThmYjA0MGZkZTE1IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5FYXN0IFRvcm9udG8gQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2M2YmI1ZWUzMTNhNjRkNDFhYjliOTg5ZDc3NzlhNWFlLnNldENvbnRlbnQoaHRtbF84MjU2YjdmMGYxNDc0YTYxYTRmZmE4ZmIwNDBmZGUxNSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9kZGJmNGVkNzhkMmI0Mjc2YTNjNTUxMWY5MDRjYmU0OS5iaW5kUG9wdXAocG9wdXBfYzZiYjVlZTMxM2E2NGQ0MWFiOWI5ODlkNzc3OWE1YWUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMWY5OWZhNWJhMTA0NGE2MWFiMTUyMGRiZjY1MDM4NjIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NDA4MTU3LC03OS4zODE3NTIyOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF80ZTBjNTZkZTIwOGU0ZWU3YmJhNzg1MDBmNGE1MWI1YSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9iMjI5YThkMDU2Yjc0NDRlYWNmZWZmYWQ2N2E2YTcxYSA9ICQoJzxkaXYgaWQ9Imh0bWxfYjIyOWE4ZDA1NmI3NDQ0ZWFjZmVmZmFkNjdhNmE3MWEiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkhhcmJvdXJmcm9udCBFYXN0LFRvcm9udG8gSXNsYW5kcyxVbmlvbiBTdGF0aW9uIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF80ZTBjNTZkZTIwOGU0ZWU3YmJhNzg1MDBmNGE1MWI1YS5zZXRDb250ZW50KGh0bWxfYjIyOWE4ZDA1NmI3NDQ0ZWFjZmVmZmFkNjdhNmE3MWEpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMWY5OWZhNWJhMTA0NGE2MWFiMTUyMGRiZjY1MDM4NjIuYmluZFBvcHVwKHBvcHVwXzRlMGM1NmRlMjA4ZTRlZTdiYmE3ODUwMGY0YTUxYjVhKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2I5NDMwMzA1NjYzNjQ0MjRiY2NhYjQxYzA0NWVhMGY4ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjQ3OTI2NzAwMDAwMDA2LC03OS40MTk3NDk3XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2Q0ZGRhZjhhY2U2MjQzNjZhMjMxNmRiNmMxNjQyMzg5ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzEzMTM3N2E5MGM1ZTRhODU5YjRhMDRlOWQxOWQxMDlkID0gJCgnPGRpdiBpZD0iaHRtbF8xMzEzNzdhOTBjNWU0YTg1OWI0YTA0ZTlkMTlkMTA5ZCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+TGl0dGxlIFBvcnR1Z2FsLFRyaW5pdHkgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2Q0ZGRhZjhhY2U2MjQzNjZhMjMxNmRiNmMxNjQyMzg5LnNldENvbnRlbnQoaHRtbF8xMzEzNzdhOTBjNWU0YTg1OWI0YTA0ZTlkMTlkMTA5ZCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9iOTQzMDMwNTY2MzY0NDI0YmNjYWI0MWMwNDVlYTBmOC5iaW5kUG9wdXAocG9wdXBfZDRkZGFmOGFjZTYyNDM2NmEyMzE2ZGI2YzE2NDIzODkpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMWFkYTgwNmY0MTIzNDAwZWJhOTA0ZTk0NmI1YTg0YWMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43Mjc5MjkyLC03OS4yNjIwMjk0MDAwMDAwMl0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF83N2JmNzRiOWY2ZDU0MzU5OWE3NmM4MGI2ZDBiNzk1MSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8yZTMzNzliZGJmZTE0MmE4OTI2NGI1ZjM3NGM0OGU5MyA9ICQoJzxkaXYgaWQ9Imh0bWxfMmUzMzc5YmRiZmUxNDJhODkyNjRiNWYzNzRjNDhlOTMiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkVhc3QgQmlyY2htb3VudCBQYXJrLElvbnZpZXcsS2VubmVkeSBQYXJrIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF83N2JmNzRiOWY2ZDU0MzU5OWE3NmM4MGI2ZDBiNzk1MS5zZXRDb250ZW50KGh0bWxfMmUzMzc5YmRiZmUxNDJhODkyNjRiNWYzNzRjNDhlOTMpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMWFkYTgwNmY0MTIzNDAwZWJhOTA0ZTk0NmI1YTg0YWMuYmluZFBvcHVwKHBvcHVwXzc3YmY3NGI5ZjZkNTQzNTk5YTc2YzgwYjZkMGI3OTUxKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2Q3ZjlkYTY2ZTM0OTQ0MjdiZmI2YzExNzJhODliZDE0ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzg2OTQ3MywtNzkuMzg1OTc1XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzA4MWUyMzkyOWRmZjQ5MTlhZmI2OGEwNzQzYjg5ZTUxID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2VmMjk0YTNjMDk2NjQzYmNiODVkNzY2YTBhZGNkZjU1ID0gJCgnPGRpdiBpZD0iaHRtbF9lZjI5NGEzYzA5NjY0M2JjYjg1ZDc2NmEwYWRjZGY1NSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+QmF5dmlldyBWaWxsYWdlIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8wODFlMjM5MjlkZmY0OTE5YWZiNjhhMDc0M2I4OWU1MS5zZXRDb250ZW50KGh0bWxfZWYyOTRhM2MwOTY2NDNiY2I4NWQ3NjZhMGFkY2RmNTUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZDdmOWRhNjZlMzQ5NDQyN2JmYjZjMTE3MmE4OWJkMTQuYmluZFBvcHVwKHBvcHVwXzA4MWUyMzkyOWRmZjQ5MTlhZmI2OGEwNzQzYjg5ZTUxKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzJhMDEyYWE5YWIyYTRlYzY4OWZiOTk1YWM0ODgyNGYwID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzM3NDczMjAwMDAwMDA0LC03OS40NjQ3NjMyOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjMDBiNWViIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzAwYjVlYiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9kZGFhNjAzYjlkNTQ0OGJmYmE1MDRhNDI0ZDU1NGI4MiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9mNDliYTVjMzdmNjg0NjJjOTU2MTA1Y2MyNTFlMDZiNCA9ICQoJzxkaXYgaWQ9Imh0bWxfZjQ5YmE1YzM3ZjY4NDYyYzk1NjEwNWNjMjUxZTA2YjQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNGQiBUb3JvbnRvLERvd25zdmlldyBFYXN0IENsdXN0ZXIgMi4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9kZGFhNjAzYjlkNTQ0OGJmYmE1MDRhNDI0ZDU1NGI4Mi5zZXRDb250ZW50KGh0bWxfZjQ5YmE1YzM3ZjY4NDYyYzk1NjEwNWNjMjUxZTA2YjQpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMmEwMTJhYTlhYjJhNGVjNjg5ZmI5OTVhYzQ4ODI0ZjAuYmluZFBvcHVwKHBvcHVwX2RkYWE2MDNiOWQ1NDQ4YmZiYTUwNGE0MjRkNTU0YjgyKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2E4MDRmZTAxYzA2YzQ2Nzg5NjhkMWY1ZTAwYTExMzkyID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjc5NTU3MSwtNzkuMzUyMTg4XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2Q2MDEyNTgwY2Q4MTRiMzZiYTAzYzEzZTg1MDU2MjMzID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzQ4NjdlOTVlYTdkMTRlMGM5MjRkMmQzZTU4Y2Q1ZTZjID0gJCgnPGRpdiBpZD0iaHRtbF80ODY3ZTk1ZWE3ZDE0ZTBjOTI0ZDJkM2U1OGNkNWU2YyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+VGhlIERhbmZvcnRoIFdlc3QsUml2ZXJkYWxlIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9kNjAxMjU4MGNkODE0YjM2YmEwM2MxM2U4NTA1NjIzMy5zZXRDb250ZW50KGh0bWxfNDg2N2U5NWVhN2QxNGUwYzkyNGQyZDNlNThjZDVlNmMpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYTgwNGZlMDFjMDZjNDY3ODk2OGQxZjVlMDBhMTEzOTIuYmluZFBvcHVwKHBvcHVwX2Q2MDEyNTgwY2Q4MTRiMzZiYTAzYzEzZTg1MDU2MjMzKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzUwMDA3M2QwNjc4NTQ3NzRiNzc2OGY4NDE2ZTgwMTRkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjQ3MTc2OCwtNzkuMzgxNTc2NDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZjlmZWFkMzJkNDA0NDc5YWI0NzYzZTZiYjY1YWY5Y2YgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYzdhNDYyYzZiYjA3NDY2NWIwY2MwMWQyMjQ2ZWI3NjMgPSAkKCc8ZGl2IGlkPSJodG1sX2M3YTQ2MmM2YmIwNzQ2NjViMGNjMDFkMjI0NmViNzYzIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5EZXNpZ24gRXhjaGFuZ2UsVG9yb250byBEb21pbmlvbiBDZW50cmUgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2Y5ZmVhZDMyZDQwNDQ3OWFiNDc2M2U2YmI2NWFmOWNmLnNldENvbnRlbnQoaHRtbF9jN2E0NjJjNmJiMDc0NjY1YjBjYzAxZDIyNDZlYjc2Myk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl81MDAwNzNkMDY3ODU0Nzc0Yjc3NjhmODQxNmU4MDE0ZC5iaW5kUG9wdXAocG9wdXBfZjlmZWFkMzJkNDA0NDc5YWI0NzYzZTZiYjY1YWY5Y2YpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfN2VkOTJkYmNkMGZiNDJiNjg2ODZhOWVhNGZlZDZhZWMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42MzY4NDcyLC03OS40MjgxOTE0MDAwMDAwMl0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF80YjEwYzhlN2QwNmU0NmMxYTk4ODAzMzFjZWQwZjc0MSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF84OTQ2YmVmNWNjZWQ0Y2I3ODNmYTA3OTA1Yzc5MzFlZiA9ICQoJzxkaXYgaWQ9Imh0bWxfODk0NmJlZjVjY2VkNGNiNzgzZmEwNzkwNWM3OTMxZWYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkJyb2NrdG9uLEV4aGliaXRpb24gUGxhY2UsUGFya2RhbGUgVmlsbGFnZSBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNGIxMGM4ZTdkMDZlNDZjMWE5ODgwMzMxY2VkMGY3NDEuc2V0Q29udGVudChodG1sXzg5NDZiZWY1Y2NlZDRjYjc4M2ZhMDc5MDVjNzkzMWVmKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzdlZDkyZGJjZDBmYjQyYjY4Njg2YTllYTRmZWQ2YWVjLmJpbmRQb3B1cChwb3B1cF80YjEwYzhlN2QwNmU0NmMxYTk4ODAzMzFjZWQwZjc0MSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8zMDYxNTM2M2E0ZTE0NmFjYWNmZjYyZWM2YzkxMDg0OSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcxMTExMTcwMDAwMDAwNCwtNzkuMjg0NTc3Ml0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9hY2E4ZmU3ZWJkYjc0MGM3OGMyN2Q3ZGYxZGNkMzljOCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9iNzdkM2ZmZWM0YTM0YmU0YmU0ZGJkM2QxZThhYTJkOSA9ICQoJzxkaXYgaWQ9Imh0bWxfYjc3ZDNmZmVjNGEzNGJlNGJlNGRiZDNkMWU4YWEyZDkiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNsYWlybGVhLEdvbGRlbiBNaWxlLE9ha3JpZGdlIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9hY2E4ZmU3ZWJkYjc0MGM3OGMyN2Q3ZGYxZGNkMzljOC5zZXRDb250ZW50KGh0bWxfYjc3ZDNmZmVjNGEzNGJlNGJlNGRiZDNkMWU4YWEyZDkpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMzA2MTUzNjNhNGUxNDZhY2FjZmY2MmVjNmM5MTA4NDkuYmluZFBvcHVwKHBvcHVwX2FjYThmZTdlYmRiNzQwYzc4YzI3ZDdkZjFkY2QzOWM4KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzNmOGUwMTk1NzNjZjQ4YjRiMjM2YjQ0MDMxODcyZGM2ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzU3NDkwMiwtNzkuMzc0NzE0MDk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzAwYjVlYiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMwMGI1ZWIiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNTAwZjExODZlYWVkNDExMzhjZWVmZmM1M2RmOTk4N2EgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYmI2OGU0NGU2NzNiNDJjNmJjZjMxYjg3MjZmZWQzZjcgPSAkKCc8ZGl2IGlkPSJodG1sX2JiNjhlNDRlNjczYjQyYzZiY2YzMWI4NzI2ZmVkM2Y3IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5TaWx2ZXIgSGlsbHMsWW9yayBNaWxscyBDbHVzdGVyIDIuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNTAwZjExODZlYWVkNDExMzhjZWVmZmM1M2RmOTk4N2Euc2V0Q29udGVudChodG1sX2JiNjhlNDRlNjczYjQyYzZiY2YzMWI4NzI2ZmVkM2Y3KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzNmOGUwMTk1NzNjZjQ4YjRiMjM2YjQ0MDMxODcyZGM2LmJpbmRQb3B1cChwb3B1cF81MDBmMTE4NmVhZWQ0MTEzOGNlZWZmYzUzZGY5OTg3YSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl80YzM4YzE2ZTM0Mzc0ZDA0YTczMWYwMzM3YWJmOWE4MiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjczOTAxNDYsLTc5LjUwNjk0MzZdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNDA2NmQ1Nzk3MGQ3NDE1Y2ExZTdiODQwNDU4NzEzN2QgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNTdmYmMxNDhkZDg3NDNlOTgzZTVmZGYxMjkxMmVkYzMgPSAkKCc8ZGl2IGlkPSJodG1sXzU3ZmJjMTQ4ZGQ4NzQzZTk4M2U1ZmRmMTI5MTJlZGMzIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Eb3duc3ZpZXcgV2VzdCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNDA2NmQ1Nzk3MGQ3NDE1Y2ExZTdiODQwNDU4NzEzN2Quc2V0Q29udGVudChodG1sXzU3ZmJjMTQ4ZGQ4NzQzZTk4M2U1ZmRmMTI5MTJlZGMzKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzRjMzhjMTZlMzQzNzRkMDRhNzMxZjAzMzdhYmY5YTgyLmJpbmRQb3B1cChwb3B1cF80MDY2ZDU3OTcwZDc0MTVjYTFlN2I4NDA0NTg3MTM3ZCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9lMmZiN2Y5OGNkMWI0MjdjYTUwZGJlZGMyZDcyYjNmMSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2ODk5ODUsLTc5LjMxNTU3MTU5OTk5OTk4XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2ViYzE1MWIzYzBjZDRmMTc5Nzk2M2ZiYmE0MjQ3MGI4ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzJjOTg3ZDZkZDZiZTQ5ZmViNmM3MmNmNjg3OGEwNWY5ID0gJCgnPGRpdiBpZD0iaHRtbF8yYzk4N2Q2ZGQ2YmU0OWZlYjZjNzJjZjY4NzhhMDVmOSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+VGhlIEJlYWNoZXMgV2VzdCxJbmRpYSBCYXphYXIgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2ViYzE1MWIzYzBjZDRmMTc5Nzk2M2ZiYmE0MjQ3MGI4LnNldENvbnRlbnQoaHRtbF8yYzk4N2Q2ZGQ2YmU0OWZlYjZjNzJjZjY4NzhhMDVmOSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9lMmZiN2Y5OGNkMWI0MjdjYTUwZGJlZGMyZDcyYjNmMS5iaW5kUG9wdXAocG9wdXBfZWJjMTUxYjNjMGNkNGYxNzk3OTYzZmJiYTQyNDcwYjgpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMGRmNzZhNGM5YjRiNDllMThlNTA0MThjNWVhNDI3ZWIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NDgxOTg1LC03OS4zNzk4MTY5MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9hZDFlMjc2ZTliMDQ0ZWEzODAzNTg2OTA0MGQ5ODI1NyA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8zYjA0MzFmN2NiMzE0NTU3YTE1NGYwZWUyOGZkN2Q1ZiA9ICQoJzxkaXYgaWQ9Imh0bWxfM2IwNDMxZjdjYjMxNDU1N2ExNTRmMGVlMjhmZDdkNWYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNvbW1lcmNlIENvdXJ0LFZpY3RvcmlhIEhvdGVsIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9hZDFlMjc2ZTliMDQ0ZWEzODAzNTg2OTA0MGQ5ODI1Ny5zZXRDb250ZW50KGh0bWxfM2IwNDMxZjdjYjMxNDU1N2ExNTRmMGVlMjhmZDdkNWYpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMGRmNzZhNGM5YjRiNDllMThlNTA0MThjNWVhNDI3ZWIuYmluZFBvcHVwKHBvcHVwX2FkMWUyNzZlOWIwNDRlYTM4MDM1ODY5MDQwZDk4MjU3KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzYwODQ5Zjk1Mzc0MTRhY2JiYzE1MzJmMDNjNmUyZmFkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzEzNzU2MjAwMDAwMDA2LC03OS40OTAwNzM4XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzE5NmExNTc4ODI5ODRiNTdiNzViNWY0M2I2Njg1NTk0ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzAyOGU4MjQwMGQyZDQyYzA4MzM5ZDI5ZTgzOWRjNzdiID0gJCgnPGRpdiBpZD0iaHRtbF8wMjhlODI0MDBkMmQ0MmMwODMzOWQyOWU4MzlkYzc3YiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RG93bnN2aWV3LE5vcnRoIFBhcmssVXB3b29kIFBhcmsgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzE5NmExNTc4ODI5ODRiNTdiNzViNWY0M2I2Njg1NTk0LnNldENvbnRlbnQoaHRtbF8wMjhlODI0MDBkMmQ0MmMwODMzOWQyOWU4MzlkYzc3Yik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl82MDg0OWY5NTM3NDE0YWNiYmMxNTMyZjAzYzZlMmZhZC5iaW5kUG9wdXAocG9wdXBfMTk2YTE1Nzg4Mjk4NGI1N2I3NWI1ZjQzYjY2ODU1OTQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfY2Y3NzZlYjEyZmNkNDY0YmFmMjEwNjZhMWE2NTNmNjggPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NTYzMDMzLC03OS41NjU5NjMyOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9mZWE5OWJiZTAwODQ0ZDY4OTYwOGJkMDVmMzMwNGE4NSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9jMjRkY2E4ZTc2YWQ0MGZiOTM4YWU0OWMyMjQzOGM2ZCA9ICQoJzxkaXYgaWQ9Imh0bWxfYzI0ZGNhOGU3NmFkNDBmYjkzOGFlNDljMjI0MzhjNmQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkh1bWJlciBTdW1taXQgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2ZlYTk5YmJlMDA4NDRkNjg5NjA4YmQwNWYzMzA0YTg1LnNldENvbnRlbnQoaHRtbF9jMjRkY2E4ZTc2YWQ0MGZiOTM4YWU0OWMyMjQzOGM2ZCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9jZjc3NmViMTJmY2Q0NjRiYWYyMTA2NmExYTY1M2Y2OC5iaW5kUG9wdXAocG9wdXBfZmVhOTliYmUwMDg0NGQ2ODk2MDhiZDA1ZjMzMDRhODUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfM2E3MTBhODhhMzY1NDlkMWIyOWRiMjViODljODNlZmMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MTYzMTYsLTc5LjIzOTQ3NjA5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzE3MTM5MDA3NzljNDQwMjc5YTk1MGE0N2IwMDRjMjI5ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzFlZTU5NTdhNzI4ZDRhNDI4YjMwMGJkYTAxNjY1MTIyID0gJCgnPGRpdiBpZD0iaHRtbF8xZWU1OTU3YTcyOGQ0YTQyOGIzMDBiZGEwMTY2NTEyMiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2xpZmZjcmVzdCxDbGlmZnNpZGUsU2NhcmJvcm91Z2ggVmlsbGFnZSBXZXN0IENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8xNzEzOTAwNzc5YzQ0MDI3OWE5NTBhNDdiMDA0YzIyOS5zZXRDb250ZW50KGh0bWxfMWVlNTk1N2E3MjhkNGE0MjhiMzAwYmRhMDE2NjUxMjIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfM2E3MTBhODhhMzY1NDlkMWIyOWRiMjViODljODNlZmMuYmluZFBvcHVwKHBvcHVwXzE3MTM5MDA3NzljNDQwMjc5YTk1MGE0N2IwMDRjMjI5KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzUxMGU5Y2QzMzVmMjRmMjg4NjcyNDkyM2ZiYmMzZTA1ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzg5MDUzLC03OS40MDg0OTI3OTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9hM2FmODQzYTg1ZmU0ZTRmOWMzZTkwZGY2YzZhZmEyNSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF81NTYwYjIxYzMyNzY0ZDMyOGUwODIzM2M4ZDE1ZTAxOSA9ICQoJzxkaXYgaWQ9Imh0bWxfNTU2MGIyMWMzMjc2NGQzMjhlMDgyMzNjOGQxNWUwMTkiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPk5ld3RvbmJyb29rLFdpbGxvd2RhbGUgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2EzYWY4NDNhODVmZTRlNGY5YzNlOTBkZjZjNmFmYTI1LnNldENvbnRlbnQoaHRtbF81NTYwYjIxYzMyNzY0ZDMyOGUwODIzM2M4ZDE1ZTAxOSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl81MTBlOWNkMzM1ZjI0ZjI4ODY3MjQ5MjNmYmJjM2UwNS5iaW5kUG9wdXAocG9wdXBfYTNhZjg0M2E4NWZlNGU0ZjljM2U5MGRmNmM2YWZhMjUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNGYxNzY1YzAwOGFmNDhkNmI0MWVjZjU2NTllNmM0YjUgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43Mjg0OTY0LC03OS40OTU2OTc0MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjZmYwMDAwIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiI2ZmMDAwMCIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF84ZGE4MTc2MTU5YjA0Nzg5ODNkMjNjMzA1N2FiMjc3NiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9lZGZlMjkyYTBkNzg0ZDFmOThhZWY4NDJmYWVkNDQ1NyA9ICQoJzxkaXYgaWQ9Imh0bWxfZWRmZTI5MmEwZDc4NGQxZjk4YWVmODQyZmFlZDQ0NTciIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkRvd25zdmlldyBDZW50cmFsIENsdXN0ZXIgMC4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF84ZGE4MTc2MTU5YjA0Nzg5ODNkMjNjMzA1N2FiMjc3Ni5zZXRDb250ZW50KGh0bWxfZWRmZTI5MmEwZDc4NGQxZjk4YWVmODQyZmFlZDQ0NTcpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNGYxNzY1YzAwOGFmNDhkNmI0MWVjZjU2NTllNmM0YjUuYmluZFBvcHVwKHBvcHVwXzhkYTgxNzYxNTliMDQ3ODk4M2QyM2MzMDU3YWIyNzc2KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2U5ZWFmNzc3NjIyMTRjZTVhNWUyYTVjZWE2MWFmODljID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjU5NTI1NSwtNzkuMzQwOTIzXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2M0ZGZhZDM3NzkzZTQ0ZTZiNDU1YzhiZjE5ODU2YjU0ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzNkNWJkNmNhYjNiNDRjMTlhMmQ2NDhjMzA5MTdkYjQ5ID0gJCgnPGRpdiBpZD0iaHRtbF8zZDViZDZjYWIzYjQ0YzE5YTJkNjQ4YzMwOTE3ZGI0OSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+U3R1ZGlvIERpc3RyaWN0IENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9jNGRmYWQzNzc5M2U0NGU2YjQ1NWM4YmYxOTg1NmI1NC5zZXRDb250ZW50KGh0bWxfM2Q1YmQ2Y2FiM2I0NGMxOWEyZDY0OGMzMDkxN2RiNDkpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZTllYWY3Nzc2MjIxNGNlNWE1ZTJhNWNlYTYxYWY4OWMuYmluZFBvcHVwKHBvcHVwX2M0ZGZhZDM3NzkzZTQ0ZTZiNDU1YzhiZjE5ODU2YjU0KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzFiYWFiNWEzYTQ2ZDRjNWM5Y2QzZDViNjcxMzMzNDAyID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzMzMjgyNSwtNzkuNDE5NzQ5N10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF81ODg3ZWZiNGEwZWI0NDcwYWU3ZjI3YzRhOGU3M2Y5MSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF82ZWViYzVmMmZlNDg0YjZkYjdjOWZjNTYyOWNjNmMyMyA9ICQoJzxkaXYgaWQ9Imh0bWxfNmVlYmM1ZjJmZTQ4NGI2ZGI3YzlmYzU2MjljYzZjMjMiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkJlZGZvcmQgUGFyayxMYXdyZW5jZSBNYW5vciBFYXN0IENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF81ODg3ZWZiNGEwZWI0NDcwYWU3ZjI3YzRhOGU3M2Y5MS5zZXRDb250ZW50KGh0bWxfNmVlYmM1ZjJmZTQ4NGI2ZGI3YzlmYzU2MjljYzZjMjMpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMWJhYWI1YTNhNDZkNGM1YzljZDNkNWI2NzEzMzM0MDIuYmluZFBvcHVwKHBvcHVwXzU4ODdlZmI0YTBlYjQ0NzBhZTdmMjdjNGE4ZTczZjkxKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzdlNjhmNGU2MWE3ZjQxNzlhMjBlMzRjNThkNmI4ODYyID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjkxMTE1OCwtNzkuNDc2MDEzMjk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNThmODZiOGRiNTU0NGUwZjlhNzA5M2I2NjFiODE3ZjIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYzVhMzU0Nzk3NTM3NGQ0NWIxYTA0Yzc4YmFiYjE0OTIgPSAkKCc8ZGl2IGlkPSJodG1sX2M1YTM1NDc5NzUzNzRkNDViMWEwNGM3OGJhYmIxNDkyIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5EZWwgUmF5LEtlZWxlc2RhbGUsTW91bnQgRGVubmlzLFNpbHZlcnRob3JuIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF81OGY4NmI4ZGI1NTQ0ZTBmOWE3MDkzYjY2MWI4MTdmMi5zZXRDb250ZW50KGh0bWxfYzVhMzU0Nzk3NTM3NGQ0NWIxYTA0Yzc4YmFiYjE0OTIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfN2U2OGY0ZTYxYTdmNDE3OWEyMGUzNGM1OGQ2Yjg4NjIuYmluZFBvcHVwKHBvcHVwXzU4Zjg2YjhkYjU1NDRlMGY5YTcwOTNiNjYxYjgxN2YyKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2UwZmVkMmY5M2NhNDQ2ZDg5NDVjNDNhZTViYTAzYzcwID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzI0NzY1OSwtNzkuNTMyMjQyNDAwMDAwMDJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiI2ZmMDAwMCIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiNmZjAwMDAiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMDg2ODY2ZmJjZWIzNDc2YTg3MjBmZWE0ZTljODQzYjIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYmQ3ZGY5NWVkZmZiNDU3YWI3OTE5MWI4YTNiZmNhMWQgPSAkKCc8ZGl2IGlkPSJodG1sX2JkN2RmOTVlZGZmYjQ1N2FiNzkxOTFiOGEzYmZjYTFkIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5FbWVyeSxIdW1iZXJsZWEgQ2x1c3RlciAwLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzA4Njg2NmZiY2ViMzQ3NmE4NzIwZmVhNGU5Yzg0M2IyLnNldENvbnRlbnQoaHRtbF9iZDdkZjk1ZWRmZmI0NTdhYjc5MTkxYjhhM2JmY2ExZCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9lMGZlZDJmOTNjYTQ0NmQ4OTQ1YzQzYWU1YmEwM2M3MC5iaW5kUG9wdXAocG9wdXBfMDg2ODY2ZmJjZWIzNDc2YTg3MjBmZWE0ZTljODQzYjIpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfN2Q3YmNhYTZhNDQ0NGE2Y2JiNzFiM2FiMTE0NTEzM2UgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42OTI2NTcwMDAwMDAwMDQsLTc5LjI2NDg0ODFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMTE2Njk4NzMzZWFmNGZkOWFhZmE1OWJiZjUzZDQ3YjEgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZTMzMmU3MTQ2ZjY2NDdjMWFhMGViOGU0MDY5ZWIxOWQgPSAkKCc8ZGl2IGlkPSJodG1sX2UzMzJlNzE0NmY2NjQ3YzFhYTBlYjhlNDA2OWViMTlkIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5CaXJjaCBDbGlmZixDbGlmZnNpZGUgV2VzdCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMTE2Njk4NzMzZWFmNGZkOWFhZmE1OWJiZjUzZDQ3YjEuc2V0Q29udGVudChodG1sX2UzMzJlNzE0NmY2NjQ3YzFhYTBlYjhlNDA2OWViMTlkKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzdkN2JjYWE2YTQ0NDRhNmNiYjcxYjNhYjExNDUxMzNlLmJpbmRQb3B1cChwb3B1cF8xMTY2OTg3MzNlYWY0ZmQ5YWFmYTU5YmJmNTNkNDdiMSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl80OWJlZTUyZTViZDg0OTRmODM5ZGQ5NDMwOTA1Zjg5MCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc3MDExOTksLTc5LjQwODQ5Mjc5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzgxNDEzNjhmNWQ3MzQwNzFhMTIwODI5ZjI1OTdkMjEwID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzY5NDNiNjUxZTY4ODQyNDVhMjkxYTJiZjkxN2ZlODZkID0gJCgnPGRpdiBpZD0iaHRtbF82OTQzYjY1MWU2ODg0MjQ1YTI5MWEyYmY5MTdmZTg2ZCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+V2lsbG93ZGFsZSBTb3V0aCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfODE0MTM2OGY1ZDczNDA3MWExMjA4MjlmMjU5N2QyMTAuc2V0Q29udGVudChodG1sXzY5NDNiNjUxZTY4ODQyNDVhMjkxYTJiZjkxN2ZlODZkKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzQ5YmVlNTJlNWJkODQ5NGY4MzlkZDk0MzA5MDVmODkwLmJpbmRQb3B1cChwb3B1cF84MTQxMzY4ZjVkNzM0MDcxYTEyMDgyOWYyNTk3ZDIxMCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8xYjNmZjg3YWVkNmE0MTA4OTU3OGM0MTgwYzQ0YzM5YiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc2MTYzMTMsLTc5LjUyMDk5OTQwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzY3YTE1N2VhMjBlYzQ5OWFiN2RkNWM3M2ZhZmNkN2YyID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzBlYzE2YTE2NDM0YzRiMWZiZGQzOGI0NGYxYjkzMzU2ID0gJCgnPGRpdiBpZD0iaHRtbF8wZWMxNmExNjQzNGM0YjFmYmRkMzhiNDRmMWI5MzM1NiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RG93bnN2aWV3IE5vcnRod2VzdCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNjdhMTU3ZWEyMGVjNDk5YWI3ZGQ1YzczZmFmY2Q3ZjIuc2V0Q29udGVudChodG1sXzBlYzE2YTE2NDM0YzRiMWZiZGQzOGI0NGYxYjkzMzU2KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzFiM2ZmODdhZWQ2YTQxMDg5NTc4YzQxODBjNDRjMzliLmJpbmRQb3B1cChwb3B1cF82N2ExNTdlYTIwZWM0OTlhYjdkZDVjNzNmYWZjZDdmMik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl83OTMwNGM4MzdiYWQ0OGJhYmQ5ZDlmYjU3MWY1NGU0YyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcyODAyMDUsLTc5LjM4ODc5MDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMDdmMzBhYmVlMDRjNGY1OGJiODc3ZmNiZGE5ZTQ0NmMgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNWJlYzk2ZjliMDdkNDU2NGJiM2I0MGNiODc1MjY3MGUgPSAkKCc8ZGl2IGlkPSJodG1sXzViZWM5NmY5YjA3ZDQ1NjRiYjNiNDBjYjg3NTI2NzBlIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5MYXdyZW5jZSBQYXJrIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8wN2YzMGFiZWUwNGM0ZjU4YmI4NzdmY2JkYTllNDQ2Yy5zZXRDb250ZW50KGh0bWxfNWJlYzk2ZjliMDdkNDU2NGJiM2I0MGNiODc1MjY3MGUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNzkzMDRjODM3YmFkNDhiYWJkOWQ5ZmI1NzFmNTRlNGMuYmluZFBvcHVwKHBvcHVwXzA3ZjMwYWJlZTA0YzRmNThiYjg3N2ZjYmRhOWU0NDZjKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzk4M2NiNGY4NmNiOTRiNzI5ZGM3Zjk5NDQ5MzM1ZGFlID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzExNjk0OCwtNzkuNDE2OTM1NTk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMGM4ZWQ0ZDI5ZmEzNDgxYzhlNDQ4NTZjMGY2M2ZjZjUgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfOTcxNWVjZWQwNDYwNDkzZjlmZWU4YTQzYTg1NTdiMmMgPSAkKCc8ZGl2IGlkPSJodG1sXzk3MTVlY2VkMDQ2MDQ5M2Y5ZmVlOGE0M2E4NTU3YjJjIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Sb3NlbGF3biBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMGM4ZWQ0ZDI5ZmEzNDgxYzhlNDQ4NTZjMGY2M2ZjZjUuc2V0Q29udGVudChodG1sXzk3MTVlY2VkMDQ2MDQ5M2Y5ZmVlOGE0M2E4NTU3YjJjKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzk4M2NiNGY4NmNiOTRiNzI5ZGM3Zjk5NDQ5MzM1ZGFlLmJpbmRQb3B1cChwb3B1cF8wYzhlZDRkMjlmYTM0ODFjOGU0NDg1NmMwZjYzZmNmNSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9lMDg1MjgzZTNkYjk0MTU3YjA5ODk5NzNkNTZmNWJlNCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY3MzE4NTI5OTk5OTk5LC03OS40ODcyNjE5MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF81MGUxMjBlZjFkNGU0YzY3OWM5NzgxOTZmZWI0ZGQ0ZCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9kOWNmMjExZTViODk0Mjg4OTYyOGZkOTIyZDMxZGU5NCA9ICQoJzxkaXYgaWQ9Imh0bWxfZDljZjIxMWU1Yjg5NDI4ODk2MjhmZDkyMmQzMWRlOTQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlRoZSBKdW5jdGlvbiBOb3J0aCxSdW5ueW1lZGUgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzUwZTEyMGVmMWQ0ZTRjNjc5Yzk3ODE5NmZlYjRkZDRkLnNldENvbnRlbnQoaHRtbF9kOWNmMjExZTViODk0Mjg4OTYyOGZkOTIyZDMxZGU5NCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9lMDg1MjgzZTNkYjk0MTU3YjA5ODk5NzNkNTZmNWJlNC5iaW5kUG9wdXAocG9wdXBfNTBlMTIwZWYxZDRlNGM2NzljOTc4MTk2ZmViNGRkNGQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMDcxMWNmN2E1ZDg3NGNlMWJjYjNmYmU1MzUwYTk3M2EgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MDY4NzYsLTc5LjUxODE4ODQwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2ZiN2VkMDhiZGIzZTRkNzRhZjVkYzczMDRjOWVkN2NhID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzdlYzJhZDdiOTIzMjQyNWViYjJmNTU3YTRmOTBmOWM1ID0gJCgnPGRpdiBpZD0iaHRtbF83ZWMyYWQ3YjkyMzI0MjVlYmIyZjU1N2E0ZjkwZjljNSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+V2VzdG9uIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9mYjdlZDA4YmRiM2U0ZDc0YWY1ZGM3MzA0YzllZDdjYS5zZXRDb250ZW50KGh0bWxfN2VjMmFkN2I5MjMyNDI1ZWJiMmY1NTdhNGY5MGY5YzUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMDcxMWNmN2E1ZDg3NGNlMWJjYjNmYmU1MzUwYTk3M2EuYmluZFBvcHVwKHBvcHVwX2ZiN2VkMDhiZGIzZTRkNzRhZjVkYzczMDRjOWVkN2NhKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzZjYWRlY2E5Mjk3YTQ5NDBiYjk3OWVjMmE3NDU4ZjE4ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzU3NDA5NiwtNzkuMjczMzA0MDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNWU4MzQ5ZDJiYTE4NDU5MzljZmQzODgwMjUwOGJjZmEgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZmRmOWVhZmEwYjQyNGE5MmE5ZjIxMjQ1MzhmNDM5OTQgPSAkKCc8ZGl2IGlkPSJodG1sX2ZkZjllYWZhMGI0MjRhOTJhOWYyMTI0NTM4ZjQzOTk0IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Eb3JzZXQgUGFyayxTY2FyYm9yb3VnaCBUb3duIENlbnRyZSxXZXhmb3JkIEhlaWdodHMgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzVlODM0OWQyYmExODQ1OTM5Y2ZkMzg4MDI1MDhiY2ZhLnNldENvbnRlbnQoaHRtbF9mZGY5ZWFmYTBiNDI0YTkyYTlmMjEyNDUzOGY0Mzk5NCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl82Y2FkZWNhOTI5N2E0OTQwYmI5NzllYzJhNzQ1OGYxOC5iaW5kUG9wdXAocG9wdXBfNWU4MzQ5ZDJiYTE4NDU5MzljZmQzODgwMjUwOGJjZmEpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfOTk1ZGU0MWVkZjljNGU3MGE4NTRiNTJkZDk1OWE3YjcgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NTI3NTgyOTk5OTk5OTYsLTc5LjQwMDA0OTNdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzAwYjVlYiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMwMGI1ZWIiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMWMzNzk4ZmFjZTE1NDUwNTk1YjY2YjViNjY3MGQyZDMgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZWI1Mzc5YmEyYTBhNDZiOGIxMzljZmI2ZjNmMzI1ZDkgPSAkKCc8ZGl2IGlkPSJodG1sX2ViNTM3OWJhMmEwYTQ2YjhiMTM5Y2ZiNmYzZjMyNWQ5IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Zb3JrIE1pbGxzIFdlc3QgQ2x1c3RlciAyLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzFjMzc5OGZhY2UxNTQ1MDU5NWI2NmI1YjY2NzBkMmQzLnNldENvbnRlbnQoaHRtbF9lYjUzNzliYTJhMGE0NmI4YjEzOWNmYjZmM2YzMjVkOSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl85OTVkZTQxZWRmOWM0ZTcwYTg1NGI1MmRkOTU5YTdiNy5iaW5kUG9wdXAocG9wdXBfMWMzNzk4ZmFjZTE1NDUwNTk1YjY2YjViNjY3MGQyZDMpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMTdlMDIzY2M3MWNkNGQxMDgzY2QxMDQyYmQ3ZWE5YTAgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MTI3NTExLC03OS4zOTAxOTc1XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2E0MDlkNGE2NzE1MzRkNGVhMzNhMWQzZTQwZDJhOGI3ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzMwZTI4NGVlOTdlZDQ1MTY4NzNlNmQ5ZTkxZjRmY2U5ID0gJCgnPGRpdiBpZD0iaHRtbF8zMGUyODRlZTk3ZWQ0NTE2ODczZTZkOWU5MWY0ZmNlOSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RGF2aXN2aWxsZSBOb3J0aCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYTQwOWQ0YTY3MTUzNGQ0ZWEzM2ExZDNlNDBkMmE4Yjcuc2V0Q29udGVudChodG1sXzMwZTI4NGVlOTdlZDQ1MTY4NzNlNmQ5ZTkxZjRmY2U5KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzE3ZTAyM2NjNzFjZDRkMTA4M2NkMTA0MmJkN2VhOWEwLmJpbmRQb3B1cChwb3B1cF9hNDA5ZDRhNjcxNTM0ZDRlYTMzYTFkM2U0MGQyYThiNyk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8zMGUzMjZmZDk5YjI0MzIyOTM2MGNjMjBmOWJmNjkyMSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY5Njk0NzYsLTc5LjQxMTMwNzIwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2U4ZGM3ZTFmMzBiMDRkYmI4OTc5ZjkwYmU4OGZiMDg0ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2I1ZmU3Y2M2OWMzNjRkNzZiYzI2MTFlMWE2MmE2MDU4ID0gJCgnPGRpdiBpZD0iaHRtbF9iNWZlN2NjNjljMzY0ZDc2YmMyNjExZTFhNjJhNjA1OCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Rm9yZXN0IEhpbGwgTm9ydGgsRm9yZXN0IEhpbGwgV2VzdCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZThkYzdlMWYzMGIwNGRiYjg5NzlmOTBiZTg4ZmIwODQuc2V0Q29udGVudChodG1sX2I1ZmU3Y2M2OWMzNjRkNzZiYzI2MTFlMWE2MmE2MDU4KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzMwZTMyNmZkOTliMjQzMjI5MzYwY2MyMGY5YmY2OTIxLmJpbmRQb3B1cChwb3B1cF9lOGRjN2UxZjMwYjA0ZGJiODk3OWY5MGJlODhmYjA4NCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9lMTUyZTRlMGJjMGI0NjJkYTQ2YzYzMDRkZjIxZmZkZiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2MTYwODMsLTc5LjQ2NDc2MzI5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzY4N2FkYmU4NjI4ZTQ2OGFhZjRkMmZmNWVlZjY0YmJmID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzY3Y2M5OTdkOGY3OTQ1MTlhYTkwNWJhMDA4OTgwMDNlID0gJCgnPGRpdiBpZD0iaHRtbF82N2NjOTk3ZDhmNzk0NTE5YWE5MDViYTAwODk4MDAzZSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+SGlnaCBQYXJrLFRoZSBKdW5jdGlvbiBTb3V0aCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNjg3YWRiZTg2MjhlNDY4YWFmNGQyZmY1ZWVmNjRiYmYuc2V0Q29udGVudChodG1sXzY3Y2M5OTdkOGY3OTQ1MTlhYTkwNWJhMDA4OTgwMDNlKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2UxNTJlNGUwYmMwYjQ2MmRhNDZjNjMwNGRmMjFmZmRmLmJpbmRQb3B1cChwb3B1cF82ODdhZGJlODYyOGU0NjhhYWY0ZDJmZjVlZWY2NGJiZik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8yYTUzMTFhMzg2ZjU0NDI2OWJkNTdjNDYwZWViMTA3MiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY5NjMxOSwtNzkuNTMyMjQyNDAwMDAwMDJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfOGJiNDg0M2FiYTRmNDQ1MzkzMmIxOGEzZTBlMTRmMzAgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfM2YyYTk5ZDUyM2EzNGRhMzg3ZDQyOTMwOThiNTg3MGMgPSAkKCc8ZGl2IGlkPSJodG1sXzNmMmE5OWQ1MjNhMzRkYTM4N2Q0MjkzMDk4YjU4NzBjIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5XZXN0bW91bnQgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzhiYjQ4NDNhYmE0ZjQ0NTM5MzJiMThhM2UwZTE0ZjMwLnNldENvbnRlbnQoaHRtbF8zZjJhOTlkNTIzYTM0ZGEzODdkNDI5MzA5OGI1ODcwYyk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8yYTUzMTFhMzg2ZjU0NDI2OWJkNTdjNDYwZWViMTA3Mi5iaW5kUG9wdXAocG9wdXBfOGJiNDg0M2FiYTRmNDQ1MzkzMmIxOGEzZTBlMTRmMzApOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZDhmNGM0MDhjMWQ0NDg2NjgwODNmODI4NGY4ZDI3MGQgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43NTAwNzE1MDAwMDAwMDQsLTc5LjI5NTg0OTFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNWFjNzI5ODllZGFiNGVjYTk1OWYyMDJhZWIyOWRmNzQgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMmFmZDgyYzBmNWQ0NDJiZDgzZDkyNmM0MjJiMWY0MTEgPSAkKCc8ZGl2IGlkPSJodG1sXzJhZmQ4MmMwZjVkNDQyYmQ4M2Q5MjZjNDIyYjFmNDExIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5NYXJ5dmFsZSxXZXhmb3JkIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF81YWM3Mjk4OWVkYWI0ZWNhOTU5ZjIwMmFlYjI5ZGY3NC5zZXRDb250ZW50KGh0bWxfMmFmZDgyYzBmNWQ0NDJiZDgzZDkyNmM0MjJiMWY0MTEpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZDhmNGM0MDhjMWQ0NDg2NjgwODNmODI4NGY4ZDI3MGQuYmluZFBvcHVwKHBvcHVwXzVhYzcyOTg5ZWRhYjRlY2E5NTlmMjAyYWViMjlkZjc0KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2Y4ZjNhMzZkMDgwMDQ5OGI4MTZhNzg4ZjY1Yzk2NzMxID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzgyNzM2NCwtNzkuNDQyMjU5M10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9jMWFkN2VhZjU3Mjk0YTExOTFjZmYyNzQzNDU5MDUzZSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9iNWE1NzA0MTE1MGM0MjFhYTMwODc0Y2I0OTNkYTg0OCA9ICQoJzxkaXYgaWQ9Imh0bWxfYjVhNTcwNDExNTBjNDIxYWEzMDg3NGNiNDkzZGE4NDgiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPldpbGxvd2RhbGUgV2VzdCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYzFhZDdlYWY1NzI5NGExMTkxY2ZmMjc0MzQ1OTA1M2Uuc2V0Q29udGVudChodG1sX2I1YTU3MDQxMTUwYzQyMWFhMzA4NzRjYjQ5M2RhODQ4KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2Y4ZjNhMzZkMDgwMDQ5OGI4MTZhNzg4ZjY1Yzk2NzMxLmJpbmRQb3B1cChwb3B1cF9jMWFkN2VhZjU3Mjk0YTExOTFjZmYyNzQzNDU5MDUzZSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8zZjUxNTA1ZGEwYjg0YWRmOTJlZTc1NjBlZGJhYmFjYyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcxNTM4MzQsLTc5LjQwNTY3ODQwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzhmMGUwMzY5YmIxMDQ4YmFhNDhhMmQ1MDZhMjFlMDFmID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2EyMmU4YzFmZDdkNDQxNzBiOTRmYWZlZTE1ZDEwOWMwID0gJCgnPGRpdiBpZD0iaHRtbF9hMjJlOGMxZmQ3ZDQ0MTcwYjk0ZmFmZWUxNWQxMDljMCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Tm9ydGggVG9yb250byBXZXN0IENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF84ZjBlMDM2OWJiMTA0OGJhYTQ4YTJkNTA2YTIxZTAxZi5zZXRDb250ZW50KGh0bWxfYTIyZThjMWZkN2Q0NDE3MGI5NGZhZmVlMTVkMTA5YzApOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfM2Y1MTUwNWRhMGI4NGFkZjkyZWU3NTYwZWRiYWJhY2MuYmluZFBvcHVwKHBvcHVwXzhmMGUwMzY5YmIxMDQ4YmFhNDhhMmQ1MDZhMjFlMDFmKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2I1MTI1OTk5MmZlZDRiODBiY2ExYTUzMDhlYjkyNTEyID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjcyNzA5NywtNzkuNDA1Njc4NDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNDgxMWNmNzYzMmQwNGE1Y2E3OGQ3NDYyYzUwNTUyOGIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMWEzMjRjYjAwMGJmNGMwMWFkOGJjNzEzOTEzZGU3YjcgPSAkKCc8ZGl2IGlkPSJodG1sXzFhMzI0Y2IwMDBiZjRjMDFhZDhiYzcxMzkxM2RlN2I3IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5UaGUgQW5uZXgsTm9ydGggTWlkdG93bixZb3JrdmlsbGUgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzQ4MTFjZjc2MzJkMDRhNWNhNzhkNzQ2MmM1MDU1MjhiLnNldENvbnRlbnQoaHRtbF8xYTMyNGNiMDAwYmY0YzAxYWQ4YmM3MTM5MTNkZTdiNyk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9iNTEyNTk5OTJmZWQ0YjgwYmNhMWE1MzA4ZWI5MjUxMi5iaW5kUG9wdXAocG9wdXBfNDgxMWNmNzYzMmQwNGE1Y2E3OGQ3NDYyYzUwNTUyOGIpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNTA1NmQ1MGM4ODlkNDA4ZWFlMWE2MGExYWE0Y2Q4OTUgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NDg5NTk3LC03OS40NTYzMjVdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZWE5NjFmMjE0Yjg3NGJjNTliMjQyNjlmOTg3NDM2YzggPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYzcyZTk1NjdjMTM4NGIzZWIxOTA0MWUzNjc1YmYxNmMgPSAkKCc8ZGl2IGlkPSJodG1sX2M3MmU5NTY3YzEzODRiM2ViMTkwNDFlMzY3NWJmMTZjIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5QYXJrZGFsZSxSb25jZXN2YWxsZXMgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2VhOTYxZjIxNGI4NzRiYzU5YjI0MjY5Zjk4NzQzNmM4LnNldENvbnRlbnQoaHRtbF9jNzJlOTU2N2MxMzg0YjNlYjE5MDQxZTM2NzViZjE2Yyk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl81MDU2ZDUwYzg4OWQ0MDhlYWUxYTYwYTFhYTRjZDg5NS5iaW5kUG9wdXAocG9wdXBfZWE5NjFmMjE0Yjg3NGJjNTliMjQyNjlmOTg3NDM2YzgpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMWE0NGRjZDliMDI4NGU3MDkxNjA5NDgwNTI4ZGNlY2QgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42MzY5NjU2LC03OS42MTU4MTg5OTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9kMTM2NWY4YTEyYzQ0NTA3YjRmNDUzMDViZjEzYjU2NCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8yMGM5MzlhN2I2M2Y0NjgxYTU2NWE1ZWE5MDc4NjIxYSA9ICQoJzxkaXYgaWQ9Imh0bWxfMjBjOTM5YTdiNjNmNDY4MWE1NjVhNWVhOTA3ODYyMWEiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNhbmFkYSBQb3N0IEdhdGV3YXkgUHJvY2Vzc2luZyBDZW50cmUgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2QxMzY1ZjhhMTJjNDQ1MDdiNGY0NTMwNWJmMTNiNTY0LnNldENvbnRlbnQoaHRtbF8yMGM5MzlhN2I2M2Y0NjgxYTU2NWE1ZWE5MDc4NjIxYSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8xYTQ0ZGNkOWIwMjg0ZTcwOTE2MDk0ODA1MjhkY2VjZC5iaW5kUG9wdXAocG9wdXBfZDEzNjVmOGExMmM0NDUwN2I0ZjQ1MzA1YmYxM2I1NjQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMDhkZTgzY2M4Y2U1NDBiNzk1YTlhZWViODRmNWU1MzUgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42ODg5MDU0LC03OS41NTQ3MjQ0MDAwMDAwMV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF84NzU1Yzc5NWEyOGY0NGIxOGU1Nzk5MjVkOTE5MzBhZCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8wYTQ5ZTJhNzFjN2M0ZTIyOGM2YzAyNWIyMzJlYWEzNyA9ICQoJzxkaXYgaWQ9Imh0bWxfMGE0OWUyYTcxYzdjNGUyMjhjNmMwMjViMjMyZWFhMzciIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPktpbmdzdmlldyBWaWxsYWdlLE1hcnRpbiBHcm92ZSBHYXJkZW5zLFJpY2h2aWV3IEdhcmRlbnMsU3QuIFBoaWxsaXBzIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF84NzU1Yzc5NWEyOGY0NGIxOGU1Nzk5MjVkOTE5MzBhZC5zZXRDb250ZW50KGh0bWxfMGE0OWUyYTcxYzdjNGUyMjhjNmMwMjViMjMyZWFhMzcpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMDhkZTgzY2M4Y2U1NDBiNzk1YTlhZWViODRmNWU1MzUuYmluZFBvcHVwKHBvcHVwXzg3NTVjNzk1YTI4ZjQ0YjE4ZTU3OTkyNWQ5MTkzMGFkKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2YzNjFhZWE5NDE3MDQ0Y2Y5OGM1NjY0NTc5NjQ0NmRkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNzk0MjAwMywtNzkuMjYyMDI5NDAwMDAwMDJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMzBmNmZlYTMwYTZhNDVjZjlkM2E0NGM5YzQ1MjkxZDIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMjBiMDMwZmJkMmY2NDcwM2I0MjVmZGM1ZGMyM2Y2MmUgPSAkKCc8ZGl2IGlkPSJodG1sXzIwYjAzMGZiZDJmNjQ3MDNiNDI1ZmRjNWRjMjNmNjJlIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5BZ2luY291cnQgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzMwZjZmZWEzMGE2YTQ1Y2Y5ZDNhNDRjOWM0NTI5MWQyLnNldENvbnRlbnQoaHRtbF8yMGIwMzBmYmQyZjY0NzAzYjQyNWZkYzVkYzIzZjYyZSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9mMzYxYWVhOTQxNzA0NGNmOThjNTY2NDU3OTY0NDZkZC5iaW5kUG9wdXAocG9wdXBfMzBmNmZlYTMwYTZhNDVjZjlkM2E0NGM5YzQ1MjkxZDIpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNDdjNGEzMWEyYzY5NDg2YWJlNGYzYTFiZjYwYjI3NDIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43MDQzMjQ0LC03OS4zODg3OTAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzk3YzJhMGFlYjIyMDRmYjY5ZWY0YTRlYjVhM2RkNDA0ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2ZmOTBiZWMxODQ3NDQ4NDY4M2U0ZGIyYTc3ZGNjNDA5ID0gJCgnPGRpdiBpZD0iaHRtbF9mZjkwYmVjMTg0NzQ0ODQ2ODNlNGRiMmE3N2RjYzQwOSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RGF2aXN2aWxsZSBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfOTdjMmEwYWViMjIwNGZiNjllZjRhNGViNWEzZGQ0MDQuc2V0Q29udGVudChodG1sX2ZmOTBiZWMxODQ3NDQ4NDY4M2U0ZGIyYTc3ZGNjNDA5KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzQ3YzRhMzFhMmM2OTQ4NmFiZTRmM2ExYmY2MGIyNzQyLmJpbmRQb3B1cChwb3B1cF85N2MyYTBhZWIyMjA0ZmI2OWVmNGE0ZWI1YTNkZDQwNCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8yN2VjOTI3Y2Q3NGM0YzUxYWU4YWQ0NjUxYmU3M2NkNyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2MjY5NTYsLTc5LjQwMDA0OTNdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMWJjNDI3M2Y1NjhiNDI4Njg2NzJjYWJhMjBkNTk1MTcgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZDA3OGRhODY1NWM3NDZhZDllYmYyOTMyZDc4NDAzNTYgPSAkKCc8ZGl2IGlkPSJodG1sX2QwNzhkYTg2NTVjNzQ2YWQ5ZWJmMjkzMmQ3ODQwMzU2IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5IYXJib3JkLFVuaXZlcnNpdHkgb2YgVG9yb250byBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMWJjNDI3M2Y1NjhiNDI4Njg2NzJjYWJhMjBkNTk1MTcuc2V0Q29udGVudChodG1sX2QwNzhkYTg2NTVjNzQ2YWQ5ZWJmMjkzMmQ3ODQwMzU2KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzI3ZWM5MjdjZDc0YzRjNTFhZThhZDQ2NTFiZTczY2Q3LmJpbmRQb3B1cChwb3B1cF8xYmM0MjczZjU2OGI0Mjg2ODY3MmNhYmEyMGQ1OTUxNyk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9kMzRiZGJiYThmZmY0ZmEwODEyZmJlZWExZTRhMzViNyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY1MTU3MDYsLTc5LjQ4NDQ0OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMjg2NmM5OTAyZWEzNDg3YmJlNDFjZTU5MmVjMmM2NGEgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMjM3ZTVkMWU4MzE0NGMxY2FhZGE3MjNhODRlODRmYjQgPSAkKCc8ZGl2IGlkPSJodG1sXzIzN2U1ZDFlODMxNDRjMWNhYWRhNzIzYTg0ZTg0ZmI0IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5SdW5ueW1lZGUsU3dhbnNlYSBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMjg2NmM5OTAyZWEzNDg3YmJlNDFjZTU5MmVjMmM2NGEuc2V0Q29udGVudChodG1sXzIzN2U1ZDFlODMxNDRjMWNhYWRhNzIzYTg0ZTg0ZmI0KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2QzNGJkYmJhOGZmZjRmYTA4MTJmYmVlYTFlNGEzNWI3LmJpbmRQb3B1cChwb3B1cF8yODY2Yzk5MDJlYTM0ODdiYmU0MWNlNTkyZWMyYzY0YSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl82YzM0MzlhOGQ1MjY0ODBiYWM2YjMwOTI4NmZkMmRiMiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjc4MTYzNzUsLTc5LjMwNDMwMjFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMjc2MzAyOTJkM2VmNDBmZmE0MDI3NmRjZjg4ZDk0YmYgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNzk1NTQzM2I3YzY5NGQzMThlMDVjODZjNzhmN2VjODMgPSAkKCc8ZGl2IGlkPSJodG1sXzc5NTU0MzNiN2M2OTRkMzE4ZTA1Yzg2Yzc4ZjdlYzgzIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5DbGFya3MgQ29ybmVycyxTdWxsaXZhbixUYW0gTyYjMzk7U2hhbnRlciBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMjc2MzAyOTJkM2VmNDBmZmE0MDI3NmRjZjg4ZDk0YmYuc2V0Q29udGVudChodG1sXzc5NTU0MzNiN2M2OTRkMzE4ZTA1Yzg2Yzc4ZjdlYzgzKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzZjMzQzOWE4ZDUyNjQ4MGJhYzZiMzA5Mjg2ZmQyZGIyLmJpbmRQb3B1cChwb3B1cF8yNzYzMDI5MmQzZWY0MGZmYTQwMjc2ZGNmODhkOTRiZik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8yNmIzZWY2NDk3YTQ0ZGI0YmY5ODMxOTA4YTY0Yjk4ZCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY4OTU3NDMsLTc5LjM4MzE1OTkwMDAwMDAxXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiMwMGI1ZWIiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjMDBiNWViIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2ZkZDA1NzY5Zjg2MDQ2ODQ5NmM5N2Y5YmU1ZmJlMzAwID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzQ0MGI3NWJmNDc4YTRlNjliMjg2ZTU0YjZmY2NhZTk5ID0gJCgnPGRpdiBpZD0iaHRtbF80NDBiNzViZjQ3OGE0ZTY5YjI4NmU1NGI2ZmNjYWU5OSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+TW9vcmUgUGFyayxTdW1tZXJoaWxsIEVhc3QgQ2x1c3RlciAyLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2ZkZDA1NzY5Zjg2MDQ2ODQ5NmM5N2Y5YmU1ZmJlMzAwLnNldENvbnRlbnQoaHRtbF80NDBiNzViZjQ3OGE0ZTY5YjI4NmU1NGI2ZmNjYWU5OSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8yNmIzZWY2NDk3YTQ0ZGI0YmY5ODMxOTA4YTY0Yjk4ZC5iaW5kUG9wdXAocG9wdXBfZmRkMDU3NjlmODYwNDY4NDk2Yzk3ZjliZTVmYmUzMDApOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYjk3MzU1ODdkYWUxNDc4ZTg1OGI4MGNlOWVkZGE4MDIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NTMyMDU3LC03OS40MDAwNDkzXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzc5OWY0OTU0Mjc0ZTRlNzE5YTFiMzc1MWE3OWE2ODE3ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzI5Yjg2ZTYxZTVjZTRjN2Y5Mjk2M2M0YTQyMGQ5MDIxID0gJCgnPGRpdiBpZD0iaHRtbF8yOWI4NmU2MWU1Y2U0YzdmOTI5NjNjNGE0MjBkOTAyMSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2hpbmF0b3duLEdyYW5nZSBQYXJrLEtlbnNpbmd0b24gTWFya2V0IENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF83OTlmNDk1NDI3NGU0ZTcxOWExYjM3NTFhNzlhNjgxNy5zZXRDb250ZW50KGh0bWxfMjliODZlNjFlNWNlNGM3ZjkyOTYzYzRhNDIwZDkwMjEpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYjk3MzU1ODdkYWUxNDc4ZTg1OGI4MGNlOWVkZGE4MDIuYmluZFBvcHVwKHBvcHVwXzc5OWY0OTU0Mjc0ZTRlNzE5YTFiMzc1MWE3OWE2ODE3KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2Y0ZGFlNDcyZDliNjRhM2JhOTY5YWQwNjI1NGIyYjJiID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuODE1MjUyMiwtNzkuMjg0NTc3Ml0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjMDBiNWViIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzAwYjVlYiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9iYzk4YTM2ZTVkNGI0M2QzOTIxMzRhNTkxYjYzZGJjMSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF83NjNjMTQwYzhjMjQ0ZTA0OTc4NmJlYjJiOWJmNDNiNCA9ICQoJzxkaXYgaWQ9Imh0bWxfNzYzYzE0MGM4YzI0NGUwNDk3ODZiZWIyYjliZjQzYjQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkFnaW5jb3VydCBOb3J0aCxMJiMzOTtBbW9yZWF1eCBFYXN0LE1pbGxpa2VuLFN0ZWVsZXMgRWFzdCBDbHVzdGVyIDIuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYmM5OGEzNmU1ZDRiNDNkMzkyMTM0YTU5MWI2M2RiYzEuc2V0Q29udGVudChodG1sXzc2M2MxNDBjOGMyNDRlMDQ5Nzg2YmViMmI5YmY0M2I0KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2Y0ZGFlNDcyZDliNjRhM2JhOTY5YWQwNjI1NGIyYjJiLmJpbmRQb3B1cChwb3B1cF9iYzk4YTM2ZTVkNGI0M2QzOTIxMzRhNTkxYjYzZGJjMSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8zNDk4OTVlODljZTA0ODBjOTQ0N2FhODIwMDZiZjk1NyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY4NjQxMjI5OTk5OTk5LC03OS40MDAwNDkzXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2FjZWJlY2RhMWJlOTRjNjRiZGEyMTE0NDVmZjExMzVjID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzE3ZGQ5Y2Q2OGQ3NDQwNzQ4NjQ4NzQ3MzJmNTNiOWY5ID0gJCgnPGRpdiBpZD0iaHRtbF8xN2RkOWNkNjhkNzQ0MDc0ODY0ODc0NzMyZjUzYjlmOSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RGVlciBQYXJrLEZvcmVzdCBIaWxsIFNFLFJhdGhuZWxseSxTb3V0aCBIaWxsLFN1bW1lcmhpbGwgV2VzdCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYWNlYmVjZGExYmU5NGM2NGJkYTIxMTQ0NWZmMTEzNWMuc2V0Q29udGVudChodG1sXzE3ZGQ5Y2Q2OGQ3NDQwNzQ4NjQ4NzQ3MzJmNTNiOWY5KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzM0OTg5NWU4OWNlMDQ4MGM5NDQ3YWE4MjAwNmJmOTU3LmJpbmRQb3B1cChwb3B1cF9hY2ViZWNkYTFiZTk0YzY0YmRhMjExNDQ1ZmYxMTM1Yyk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl80YWQwOTc2MWM1ZmM0ZDc3OTAyNTYzYWQ4OWIwYzlhYyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjYyODk0NjcsLTc5LjM5NDQxOTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYmQ5MWNjOWIzYWUyNGU4Mjk1MTE1NGE5MWNkYmE5ZGEgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfODYzMzFmYThmZTQzNGJhMjk1NzFhYTBjMTU4NzBjZmQgPSAkKCc8ZGl2IGlkPSJodG1sXzg2MzMxZmE4ZmU0MzRiYTI5NTcxYWEwYzE1ODcwY2ZkIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5DTiBUb3dlcixCYXRodXJzdCBRdWF5LElzbGFuZCBhaXJwb3J0LEhhcmJvdXJmcm9udCBXZXN0LEtpbmcgYW5kIFNwYWRpbmEsUmFpbHdheSBMYW5kcyxTb3V0aCBOaWFnYXJhIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9iZDkxY2M5YjNhZTI0ZTgyOTUxMTU0YTkxY2RiYTlkYS5zZXRDb250ZW50KGh0bWxfODYzMzFmYThmZTQzNGJhMjk1NzFhYTBjMTU4NzBjZmQpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNGFkMDk3NjFjNWZjNGQ3NzkwMjU2M2FkODliMGM5YWMuYmluZFBvcHVwKHBvcHVwX2JkOTFjYzliM2FlMjRlODI5NTExNTRhOTFjZGJhOWRhKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2Y5YWJlN2VlYjIxNzRhYzRiY2JiZWFkOTljNDFjZjhiID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjA1NjQ2NiwtNzkuNTAxMzIwNzAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfY2ZhOGNlMGEzMThmNDJkNjk5M2NhMGJjODQ3OGYwYjggPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYmVmYzgzZDk3OThmNDY5YmJjMDNjMjg1MjQ0YjY4ZDIgPSAkKCc8ZGl2IGlkPSJodG1sX2JlZmM4M2Q5Nzk4ZjQ2OWJiYzAzYzI4NTI0NGI2OGQyIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5IdW1iZXIgQmF5IFNob3JlcyxNaW1pY28gU291dGgsTmV3IFRvcm9udG8gQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2NmYThjZTBhMzE4ZjQyZDY5OTNjYTBiYzg0NzhmMGI4LnNldENvbnRlbnQoaHRtbF9iZWZjODNkOTc5OGY0NjliYmMwM2MyODUyNDRiNjhkMik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9mOWFiZTdlZWIyMTc0YWM0YmNiYmVhZDk5YzQxY2Y4Yi5iaW5kUG9wdXAocG9wdXBfY2ZhOGNlMGEzMThmNDJkNjk5M2NhMGJjODQ3OGYwYjgpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNWU2YjJhM2ZjYjkxNDdjZDlhZWIzYTE3OGUxNDI5ZGEgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43Mzk0MTYzOTk5OTk5OTYsLTc5LjU4ODQzNjldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYjk5ODkyNjBmZDFmNGZjMGI1ZGM5ZWZkYjdlYmQ2Y2IgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYjA0YmEzOTEyZDRlNDIyN2E3OTUzNDA1YzM3OTYxMDQgPSAkKCc8ZGl2IGlkPSJodG1sX2IwNGJhMzkxMmQ0ZTQyMjdhNzk1MzQwNWMzNzk2MTA0IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5BbGJpb24gR2FyZGVucyxCZWF1bW9uZCBIZWlnaHRzLEh1bWJlcmdhdGUsSmFtZXN0b3duLE1vdW50IE9saXZlLFNpbHZlcnN0b25lLFNvdXRoIFN0ZWVsZXMsVGhpc3RsZXRvd24gQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2I5OTg5MjYwZmQxZjRmYzBiNWRjOWVmZGI3ZWJkNmNiLnNldENvbnRlbnQoaHRtbF9iMDRiYTM5MTJkNGU0MjI3YTc5NTM0MDVjMzc5NjEwNCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl81ZTZiMmEzZmNiOTE0N2NkOWFlYjNhMTc4ZTE0MjlkYS5iaW5kUG9wdXAocG9wdXBfYjk5ODkyNjBmZDFmNGZjMGI1ZGM5ZWZkYjdlYmQ2Y2IpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfY2M5NmFiMmI2YTkxNGJhMGJmMjE1NGJmNjk0NjY1NGMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My43OTk1MjUyMDAwMDAwMDUsLTc5LjMxODM4ODddLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYjMyZjgzOGRkZWZjNGFkYWE1NWE0YzRkMWMzNzA0NjEgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYzQ5ZDgyOGNhMmY0NGI1Nzg4ZGEzMmM2ZmRkM2Q4NDYgPSAkKCc8ZGl2IGlkPSJodG1sX2M0OWQ4MjhjYTJmNDRiNTc4OGRhMzJjNmZkZDNkODQ2IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5MJiMzOTtBbW9yZWF1eCBXZXN0IENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9iMzJmODM4ZGRlZmM0YWRhYTU1YTRjNGQxYzM3MDQ2MS5zZXRDb250ZW50KGh0bWxfYzQ5ZDgyOGNhMmY0NGI1Nzg4ZGEzMmM2ZmRkM2Q4NDYpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfY2M5NmFiMmI2YTkxNGJhMGJmMjE1NGJmNjk0NjY1NGMuYmluZFBvcHVwKHBvcHVwX2IzMmY4MzhkZGVmYzRhZGFhNTVhNGM0ZDFjMzcwNDYxKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2I5NjQxMGYzNTc3ZTQ5OWNiMTRlMmU5MWM1ODBjZTRkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjc5NTYyNiwtNzkuMzc3NTI5NDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzAwYjVlYiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMwMGI1ZWIiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZGZkMzRmMjNkYjcxNDFmZTllMjBlNGNlZGJlZTdlZDMgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMThmYTFlZDM3N2UwNGQ0NzgxMTYzNDNiNzYxYTM1ZWEgPSAkKCc8ZGl2IGlkPSJodG1sXzE4ZmExZWQzNzdlMDRkNDc4MTE2MzQzYjc2MWEzNWVhIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Sb3NlZGFsZSBDbHVzdGVyIDIuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZGZkMzRmMjNkYjcxNDFmZTllMjBlNGNlZGJlZTdlZDMuc2V0Q29udGVudChodG1sXzE4ZmExZWQzNzdlMDRkNDc4MTE2MzQzYjc2MWEzNWVhKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2I5NjQxMGYzNTc3ZTQ5OWNiMTRlMmU5MWM1ODBjZTRkLmJpbmRQb3B1cChwb3B1cF9kZmQzNGYyM2RiNzE0MWZlOWUyMGU0Y2VkYmVlN2VkMyk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9hNzFiZjhkM2U1OTk0NDQwYmQ4ZjYwNjYzN2QyOGNlMCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY0NjQzNTIsLTc5LjM3NDg0NTk5OTk5OTk5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzQ2ODUxYmU5YWY4NTQ4ODE5Yjc0YTlkY2MxMjk3YTViKTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzcyNmU0OGRlYTc5MjQwOGRhZjA4MzYxYzJjMjc3ZWQwID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzIxYjE4MGZlYjMwMjQ0MDQ5NjVlMjMxMWM2ZWE4ZDEwID0gJCgnPGRpdiBpZD0iaHRtbF8yMWIxODBmZWIzMDI0NDA0OTY1ZTIzMTFjNmVhOGQxMCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+U3RuIEEgUE8gQm94ZXMgMjUgVGhlIEVzcGxhbmFkZSBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNzI2ZTQ4ZGVhNzkyNDA4ZGFmMDgzNjFjMmMyNzdlZDAuc2V0Q29udGVudChodG1sXzIxYjE4MGZlYjMwMjQ0MDQ5NjVlMjMxMWM2ZWE4ZDEwKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2E3MWJmOGQzZTU5OTQ0NDBiZDhmNjA2NjM3ZDI4Y2UwLmJpbmRQb3B1cChwb3B1cF83MjZlNDhkZWE3OTI0MDhkYWYwODM2MWMyYzI3N2VkMCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl83MzAzNzI4ZjBjYjc0MWNhOGExZTY4NWY3MjI2MzU1YyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjYwMjQxMzcwMDAwMDAxLC03OS41NDM0ODQwOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8xODJkMzhkYWI4ZTY0ODIxODI2MzQ0NmE2OGMyNjFmNSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF82M2JiZDg3OGJjNmE0NGYyYTE3NGIxNjc0ZDFmZTA1NiA9ICQoJzxkaXYgaWQ9Imh0bWxfNjNiYmQ4NzhiYzZhNDRmMmExNzRiMTY3NGQxZmUwNTYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkFsZGVyd29vZCxMb25nIEJyYW5jaCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMTgyZDM4ZGFiOGU2NDgyMTgyNjM0NDZhNjhjMjYxZjUuc2V0Q29udGVudChodG1sXzYzYmJkODc4YmM2YTQ0ZjJhMTc0YjE2NzRkMWZlMDU2KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzczMDM3MjhmMGNiNzQxY2E4YTFlNjg1ZjcyMjYzNTVjLmJpbmRQb3B1cChwb3B1cF8xODJkMzhkYWI4ZTY0ODIxODI2MzQ0NmE2OGMyNjFmNSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8zNTA3ZTNiMWExOGE0MTNlYjkyMDYzY2M2M2E5NGIxNCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjcwNjc0ODI5OTk5OTk5NCwtNzkuNTk0MDU0NF0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8wMDFjN2FlNTA2MjA0MzVlYTUxNTQzMjZmOGI3NThkOSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8wNzhkMWNjYjU2NjM0ZmY5ODU0ZmRjOGVjNjhmNWFmNyA9ICQoJzxkaXYgaWQ9Imh0bWxfMDc4ZDFjY2I1NjYzNGZmOTg1NGZkYzhlYzY4ZjVhZjciIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPk5vcnRod2VzdCBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMDAxYzdhZTUwNjIwNDM1ZWE1MTU0MzI2ZjhiNzU4ZDkuc2V0Q29udGVudChodG1sXzA3OGQxY2NiNTY2MzRmZjk4NTRmZGM4ZWM2OGY1YWY3KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzM1MDdlM2IxYTE4YTQxM2ViOTIwNjNjYzYzYTk0YjE0LmJpbmRQb3B1cChwb3B1cF8wMDFjN2FlNTA2MjA0MzVlYTUxNTQzMjZmOGI3NThkOSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9mMDFkZjhhNzE5YjY0NzAzYTNhY2I4YzRiNjY4M2YxNSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjgzNjEyNDcwMDAwMDAwNiwtNzkuMjA1NjM2MDk5OTk5OTldLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMzBmMDJiMWU5ZTczNGQwNmEwZjU5MjMxMjI0MTRjOTMgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfODU1ZWZhZDJmZTVkNDUwZTkwOGNlMjQwMGU4ZjA4NTEgPSAkKCc8ZGl2IGlkPSJodG1sXzg1NWVmYWQyZmU1ZDQ1MGU5MDhjZTI0MDBlOGYwODUxIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5VcHBlciBSb3VnZSBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMzBmMDJiMWU5ZTczNGQwNmEwZjU5MjMxMjI0MTRjOTMuc2V0Q29udGVudChodG1sXzg1NWVmYWQyZmU1ZDQ1MGU5MDhjZTI0MDBlOGYwODUxKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2YwMWRmOGE3MTliNjQ3MDNhM2FjYjhjNGI2NjgzZjE1LmJpbmRQb3B1cChwb3B1cF8zMGYwMmIxZTllNzM0ZDA2YTBmNTkyMzEyMjQxNGM5Myk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl84ZWUyODZiNmJiNDU0N2EyYWQ4MGU2NGRiMjg4Y2UwZiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2Nzk2NywtNzkuMzY3Njc1M10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF80ZWQ4MmE1NDQ1MzM0NDlkYjhlNmZjZjk2ODU5Y2I3ZiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9kZjkzOWE1ZGRlMjU0NDc1YmM1ZWRjMDkyN2JjNDdhZCA9ICQoJzxkaXYgaWQ9Imh0bWxfZGY5MzlhNWRkZTI1NDQ3NWJjNWVkYzA5MjdiYzQ3YWQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNhYmJhZ2V0b3duLFN0LiBKYW1lcyBUb3duIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF80ZWQ4MmE1NDQ1MzM0NDlkYjhlNmZjZjk2ODU5Y2I3Zi5zZXRDb250ZW50KGh0bWxfZGY5MzlhNWRkZTI1NDQ3NWJjNWVkYzA5MjdiYzQ3YWQpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfOGVlMjg2YjZiYjQ1NDdhMmFkODBlNjRkYjI4OGNlMGYuYmluZFBvcHVwKHBvcHVwXzRlZDgyYTU0NDUzMzQ0OWRiOGU2ZmNmOTY4NTljYjdmKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzQ2ODE2MjhkZjAxZTQ0MzRhMDhhMDRlOWE5MjZkOGE1ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjQ4NDI5MiwtNzkuMzgyMjgwMl0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF83NTlmOTQ2ZDg0Mzk0MDBiYjJlYWY2ZDMzMmRmMDAyZSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9kMGY1YmIxMDBkMWM0OTA0OTBlZmEzMTVhYTkyNGViMSA9ICQoJzxkaXYgaWQ9Imh0bWxfZDBmNWJiMTAwZDFjNDkwNDkwZWZhMzE1YWE5MjRlYjEiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkZpcnN0IENhbmFkaWFuIFBsYWNlLFVuZGVyZ3JvdW5kIGNpdHkgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzc1OWY5NDZkODQzOTQwMGJiMmVhZjZkMzMyZGYwMDJlLnNldENvbnRlbnQoaHRtbF9kMGY1YmIxMDBkMWM0OTA0OTBlZmEzMTVhYTkyNGViMSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl80NjgxNjI4ZGYwMWU0NDM0YTA4YTA0ZTlhOTI2ZDhhNS5iaW5kUG9wdXAocG9wdXBfNzU5Zjk0NmQ4NDM5NDAwYmIyZWFmNmQzMzJkZjAwMmUpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfNzI1Yjc2ZTk4NDlhNGJmOGExMjZkZmI4OThiNzAyMzUgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42NTM2NTM2MDAwMDAwMDUsLTc5LjUwNjk0MzZdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzAwYjVlYiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiMwMGI1ZWIiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYTJlMGE3ZjIzMjIyNDQ4MGE1OWU1YTQ0NDE0MzI4NTIgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZTkyZWUwZTFiZTllNDhlOGE1NzFlNGRhMDE2ZGVjYjkgPSAkKCc8ZGl2IGlkPSJodG1sX2U5MmVlMGUxYmU5ZTQ4ZThhNTcxZTRkYTAxNmRlY2I5IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5UaGUgS2luZ3N3YXksTW9udGdvbWVyeSBSb2FkLE9sZCBNaWxsIE5vcnRoIENsdXN0ZXIgMi4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9hMmUwYTdmMjMyMjI0NDgwYTU5ZTVhNDQ0MTQzMjg1Mi5zZXRDb250ZW50KGh0bWxfZTkyZWUwZTFiZTllNDhlOGE1NzFlNGRhMDE2ZGVjYjkpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNzI1Yjc2ZTk4NDlhNGJmOGExMjZkZmI4OThiNzAyMzUuYmluZFBvcHVwKHBvcHVwX2EyZTBhN2YyMzIyMjQ0ODBhNTllNWE0NDQxNDMyODUyKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzg1OWVhYzRkNWUzNjQyZmY4Yzc4MWRkYTk3ZjhiN2QzID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjY1ODU5OSwtNzkuMzgzMTU5OTAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfODU2YTcyY2Y4MWM3NDBiNTkzNGJlZDQ1MjZjOWUyNjAgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYjllY2I4MzczY2M5NDc5NjhjNTQyYjMwNjk2ZWZmNDIgPSAkKCc8ZGl2IGlkPSJodG1sX2I5ZWNiODM3M2NjOTQ3OTY4YzU0MmIzMDY5NmVmZjQyIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5DaHVyY2ggYW5kIFdlbGxlc2xleSBDbHVzdGVyIDEuMDwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfODU2YTcyY2Y4MWM3NDBiNTkzNGJlZDQ1MjZjOWUyNjAuc2V0Q29udGVudChodG1sX2I5ZWNiODM3M2NjOTQ3OTY4YzU0MmIzMDY5NmVmZjQyKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzg1OWVhYzRkNWUzNjQyZmY4Yzc4MWRkYTk3ZjhiN2QzLmJpbmRQb3B1cChwb3B1cF84NTZhNzJjZjgxYzc0MGI1OTM0YmVkNDUyNmM5ZTI2MCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl84YmQzZmEzNjBiNWY0NDdiYTk0ZGJmYTE1YzQzNmM2YyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQzLjY2Mjc0MzksLTc5LjMyMTU1OF0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF85YzIxMWU3MGIwZGY0ZWEzOTNlZjhmYzU0NmYxOTU0MSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8wYTg5YzhkNTIxYWI0MmZjOWZhMTUxZGVmOGIwMThkYSA9ICQoJzxkaXYgaWQ9Imh0bWxfMGE4OWM4ZDUyMWFiNDJmYzlmYTE1MWRlZjhiMDE4ZGEiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkJ1c2luZXNzIFJlcGx5IE1haWwgUHJvY2Vzc2luZyBDZW50cmUgOTY5IEVhc3Rlcm4gQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzljMjExZTcwYjBkZjRlYTM5M2VmOGZjNTQ2ZjE5NTQxLnNldENvbnRlbnQoaHRtbF8wYTg5YzhkNTIxYWI0MmZjOWZhMTUxZGVmOGIwMThkYSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl84YmQzZmEzNjBiNWY0NDdiYTk0ZGJmYTE1YzQzNmM2Yy5iaW5kUG9wdXAocG9wdXBfOWMyMTFlNzBiMGRmNGVhMzkzZWY4ZmM1NDZmMTk1NDEpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfY2ViOGY4OGExZGE1NDE2Y2E3ZjQ4OWZiNDNiYjczNTYgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0My42MzYyNTc5LC03OS40OTg1MDkwOTk5OTk5OV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF80Njg1MWJlOWFmODU0ODgxOWI3NGE5ZGNjMTI5N2E1Yik7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF83M2MwZDA4MzMwZjU0NTcxODEwZjY4MTAxZGViY2Q3YyA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9jNDAyNWNlMWI3OWU0ZmJjODEyMjUyYmFmZmJkZDAyNCA9ICQoJzxkaXYgaWQ9Imh0bWxfYzQwMjVjZTFiNzllNGZiYzgxMjI1MmJhZmZiZGQwMjQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkh1bWJlciBCYXksS2luZyYjMzk7cyBNaWxsIFBhcmssS2luZ3N3YXkgUGFyayBTb3V0aCBFYXN0LE1pbWljbyBORSxPbGQgTWlsbCBTb3V0aCxUaGUgUXVlZW5zd2F5IEVhc3QsUm95YWwgWW9yayBTb3V0aCBFYXN0LFN1bm55bGVhIENsdXN0ZXIgMS4wPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF83M2MwZDA4MzMwZjU0NTcxODEwZjY4MTAxZGViY2Q3Yy5zZXRDb250ZW50KGh0bWxfYzQwMjVjZTFiNzllNGZiYzgxMjI1MmJhZmZiZGQwMjQpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfY2ViOGY4OGExZGE1NDE2Y2E3ZjQ4OWZiNDNiYjczNTYuYmluZFBvcHVwKHBvcHVwXzczYzBkMDgzMzBmNTQ1NzE4MTBmNjgxMDFkZWJjZDdjKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2UwMmJhYjU5ODU4NTQ5NmQ4MWJjOGI0ZTQ0YzIwZDg5ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDMuNjI4ODQwOCwtNzkuNTIwOTk5NDAwMDAwMDFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNDY4NTFiZTlhZjg1NDg4MTliNzRhOWRjYzEyOTdhNWIpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZjYyOWZhMTdhMWM5NGJlYzgxOTVmZDUxZjA1YjBiM2UgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNDljNzQ3ZWYwZGI1NDQyOWI0Y2Q0NDM0OTk5MWMxNGUgPSAkKCc8ZGl2IGlkPSJodG1sXzQ5Yzc0N2VmMGRiNTQ0MjliNGNkNDQzNDk5OTFjMTRlIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5LaW5nc3dheSBQYXJrIFNvdXRoIFdlc3QsTWltaWNvIE5XLFRoZSBRdWVlbnN3YXkgV2VzdCxSb3lhbCBZb3JrIFNvdXRoIFdlc3QsU291dGggb2YgQmxvb3IgQ2x1c3RlciAxLjA8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2Y2MjlmYTE3YTFjOTRiZWM4MTk1ZmQ1MWYwNWIwYjNlLnNldENvbnRlbnQoaHRtbF80OWM3NDdlZjBkYjU0NDI5YjRjZDQ0MzQ5OTkxYzE0ZSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9lMDJiYWI1OTg1ODU0OTZkODFiYzhiNGU0NGMyMGQ4OS5iaW5kUG9wdXAocG9wdXBfZjYyOWZhMTdhMWM5NGJlYzgxOTVmZDUxZjA1YjBiM2UpOwoKICAgICAgICAgICAgCiAgICAgICAgCjwvc2NyaXB0Pg==" style="position:absolute;width:100%;height:100%;left:0;top:0;border:none !important;" allowfullscreen webkitallowfullscreen mozallowfullscreen></iframe></div></div>




```python
# create map
map_clusters_dataset_1 = folium.Map(location=[Latitude, Longitude], zoom_start=11)

# set color scheme for the clusters
x = np.arange(kclusters)
ys = [i + x + (i*x)**2 for i in range(kclusters)]
colors_array = cm.rainbow(np.linspace(0, 1, len(ys)))
rainbow = [colors.rgb2hex(i) for i in colors_array]

# add markers to the map
markers_colors = []
for lat, lon, poi, cluster in zip(manhattan_merged['Latitude'], manhattan_merged['Longitude'], manhattan_merged['Neighborhood'], manhattan_merged['Cluster Labels']):
    label = folium.Popup(str(poi) + ' Cluster ' + str(cluster), parse_html=True)
    folium.CircleMarker(
        [lat, lon],
        radius=5,
        popup=label,
        color=rainbow[int(cluster)-1],
        fill=True,
        fill_color=rainbow[int(cluster)-1],
        fill_opacity=0.7).add_to(map_clusters_dataset_1)
       
map_clusters_dataset_1
```




<div style="width:100%;"><div style="position:relative;width:100%;height:0;padding-bottom:60%;"><iframe src="data:text/html;charset=utf-8;base64,PCFET0NUWVBFIGh0bWw+CjxoZWFkPiAgICAKICAgIDxtZXRhIGh0dHAtZXF1aXY9ImNvbnRlbnQtdHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04IiAvPgogICAgPHNjcmlwdD5MX1BSRUZFUl9DQU5WQVMgPSBmYWxzZTsgTF9OT19UT1VDSCA9IGZhbHNlOyBMX0RJU0FCTEVfM0QgPSBmYWxzZTs8L3NjcmlwdD4KICAgIDxzY3JpcHQgc3JjPSJodHRwczovL2Nkbi5qc2RlbGl2ci5uZXQvbnBtL2xlYWZsZXRAMS4yLjAvZGlzdC9sZWFmbGV0LmpzIj48L3NjcmlwdD4KICAgIDxzY3JpcHQgc3JjPSJodHRwczovL2FqYXguZ29vZ2xlYXBpcy5jb20vYWpheC9saWJzL2pxdWVyeS8xLjExLjEvanF1ZXJ5Lm1pbi5qcyI+PC9zY3JpcHQ+CiAgICA8c2NyaXB0IHNyYz0iaHR0cHM6Ly9tYXhjZG4uYm9vdHN0cmFwY2RuLmNvbS9ib290c3RyYXAvMy4yLjAvanMvYm9vdHN0cmFwLm1pbi5qcyI+PC9zY3JpcHQ+CiAgICA8c2NyaXB0IHNyYz0iaHR0cHM6Ly9jZG5qcy5jbG91ZGZsYXJlLmNvbS9hamF4L2xpYnMvTGVhZmxldC5hd2Vzb21lLW1hcmtlcnMvMi4wLjIvbGVhZmxldC5hd2Vzb21lLW1hcmtlcnMuanMiPjwvc2NyaXB0PgogICAgPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL2Nkbi5qc2RlbGl2ci5uZXQvbnBtL2xlYWZsZXRAMS4yLjAvZGlzdC9sZWFmbGV0LmNzcyIvPgogICAgPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL21heGNkbi5ib290c3RyYXBjZG4uY29tL2Jvb3RzdHJhcC8zLjIuMC9jc3MvYm9vdHN0cmFwLm1pbi5jc3MiLz4KICAgIDxsaW5rIHJlbD0ic3R5bGVzaGVldCIgaHJlZj0iaHR0cHM6Ly9tYXhjZG4uYm9vdHN0cmFwY2RuLmNvbS9ib290c3RyYXAvMy4yLjAvY3NzL2Jvb3RzdHJhcC10aGVtZS5taW4uY3NzIi8+CiAgICA8bGluayByZWw9InN0eWxlc2hlZXQiIGhyZWY9Imh0dHBzOi8vbWF4Y2RuLmJvb3RzdHJhcGNkbi5jb20vZm9udC1hd2Vzb21lLzQuNi4zL2Nzcy9mb250LWF3ZXNvbWUubWluLmNzcyIvPgogICAgPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL2NkbmpzLmNsb3VkZmxhcmUuY29tL2FqYXgvbGlicy9MZWFmbGV0LmF3ZXNvbWUtbWFya2Vycy8yLjAuMi9sZWFmbGV0LmF3ZXNvbWUtbWFya2Vycy5jc3MiLz4KICAgIDxsaW5rIHJlbD0ic3R5bGVzaGVldCIgaHJlZj0iaHR0cHM6Ly9yYXdnaXQuY29tL3B5dGhvbi12aXN1YWxpemF0aW9uL2ZvbGl1bS9tYXN0ZXIvZm9saXVtL3RlbXBsYXRlcy9sZWFmbGV0LmF3ZXNvbWUucm90YXRlLmNzcyIvPgogICAgPHN0eWxlPmh0bWwsIGJvZHkge3dpZHRoOiAxMDAlO2hlaWdodDogMTAwJTttYXJnaW46IDA7cGFkZGluZzogMDt9PC9zdHlsZT4KICAgIDxzdHlsZT4jbWFwIHtwb3NpdGlvbjphYnNvbHV0ZTt0b3A6MDtib3R0b206MDtyaWdodDowO2xlZnQ6MDt9PC9zdHlsZT4KICAgIAogICAgICAgICAgICA8c3R5bGU+ICNtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQgewogICAgICAgICAgICAgICAgcG9zaXRpb24gOiByZWxhdGl2ZTsKICAgICAgICAgICAgICAgIHdpZHRoIDogMTAwLjAlOwogICAgICAgICAgICAgICAgaGVpZ2h0OiAxMDAuMCU7CiAgICAgICAgICAgICAgICBsZWZ0OiAwLjAlOwogICAgICAgICAgICAgICAgdG9wOiAwLjAlOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICA8L3N0eWxlPgogICAgICAgIAo8L2hlYWQ+Cjxib2R5PiAgICAKICAgIAogICAgICAgICAgICA8ZGl2IGNsYXNzPSJmb2xpdW0tbWFwIiBpZD0ibWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0IiA+PC9kaXY+CiAgICAgICAgCjwvYm9keT4KPHNjcmlwdD4gICAgCiAgICAKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGJvdW5kcyA9IG51bGw7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgdmFyIG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCA9IEwubWFwKAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ21hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCcsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7Y2VudGVyOiBbNDAuNzAxMzYyMTAyNzI1NjUsLTczLjk0NjI1NDE5ODI4NDY5XSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHpvb206IDExLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWF4Qm91bmRzOiBib3VuZHMsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsYXllcnM6IFtdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd29ybGRDb3B5SnVtcDogZmFsc2UsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcnM6IEwuQ1JTLkVQU0czODU3CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0pOwogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgdGlsZV9sYXllcl80MzlhNDQzZDhlZmM0YzJjOWEzMmU1ZDE4YzBlYTVlMyA9IEwudGlsZUxheWVyKAogICAgICAgICAgICAgICAgJ2h0dHBzOi8ve3N9LnRpbGUub3BlbnN0cmVldG1hcC5vcmcve3p9L3t4fS97eX0ucG5nJywKICAgICAgICAgICAgICAgIHsKICAiYXR0cmlidXRpb24iOiBudWxsLAogICJkZXRlY3RSZXRpbmEiOiBmYWxzZSwKICAibWF4Wm9vbSI6IDE4LAogICJtaW5ab29tIjogMSwKICAibm9XcmFwIjogZmFsc2UsCiAgInN1YmRvbWFpbnMiOiAiYWJjIgp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfY2YzNTYyMTI4N2FjNDNmM2EzMGMxN2I3NTNmNGY4ZWMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC44NzY1NTA3Nzg3OTk2NCwtNzMuOTEwNjU5NjU4NjI5ODFdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNzU1MDJmODQ0N2JkNDE5ZWI0NTYzNGQzNzk0YjZlYTAgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYmY4ZThjOWVjYmFiNDZlMzk1MDFjN2NhMTY2MzU3MTQgPSAkKCc8ZGl2IGlkPSJodG1sX2JmOGU4YzllY2JhYjQ2ZTM5NTAxYzdjYTE2NjM1NzE0IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5NYXJibGUgSGlsbCBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzc1NTAyZjg0NDdiZDQxOWViNDU2MzRkMzc5NGI2ZWEwLnNldENvbnRlbnQoaHRtbF9iZjhlOGM5ZWNiYWI0NmUzOTUwMWM3Y2ExNjYzNTcxNCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9jZjM1NjIxMjg3YWM0M2YzYTMwYzE3Yjc1M2Y0ZjhlYy5iaW5kUG9wdXAocG9wdXBfNzU1MDJmODQ0N2JkNDE5ZWI0NTYzNGQzNzk0YjZlYTApOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMjMzZmI3NjA4Zjk0NGVlM2JjMzc3ZjZkMTdjOTcyZjMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43MTU2MTg0MjIzMTQzMiwtNzMuOTk0Mjc5MzYyNTU5NzhdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYzc4Y2Q4ODRmZjFmNDNmODlmZmZkOTJjNDcyMTFkMGMgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZmRhM2U3NGIzNzRiNGRhYzg5YjViYTZkODU3ZmY1NDUgPSAkKCc8ZGl2IGlkPSJodG1sX2ZkYTNlNzRiMzc0YjRkYWM4OWI1YmE2ZDg1N2ZmNTQ1IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5DaGluYXRvd24gQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9jNzhjZDg4NGZmMWY0M2Y4OWZmZmQ5MmM0NzIxMWQwYy5zZXRDb250ZW50KGh0bWxfZmRhM2U3NGIzNzRiNGRhYzg5YjViYTZkODU3ZmY1NDUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMjMzZmI3NjA4Zjk0NGVlM2JjMzc3ZjZkMTdjOTcyZjMuYmluZFBvcHVwKHBvcHVwX2M3OGNkODg0ZmYxZjQzZjg5ZmZmZDkyYzQ3MjExZDBjKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzYzNzQ2ZDYxNTNlMDRhZDZiMzhjNTE1ZDdlNTE4YmEwID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuODUxOTAyNTI1NTUzMDUsLTczLjkzNjkwMDI3OTg1MjM0XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2YzNDFiMDA4NjkxZDQzMGM5NmU1Zjg4ODQyNTIwMTBmID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzU2MmNhNTcwZWQ1YzRjNTM5NzVhM2Y3MGM2NmM5ODIzID0gJCgnPGRpdiBpZD0iaHRtbF81NjJjYTU3MGVkNWM0YzUzOTc1YTNmNzBjNjZjOTgyMyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+V2FzaGluZ3RvbiBIZWlnaHRzIENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZjM0MWIwMDg2OTFkNDMwYzk2ZTVmODg4NDI1MjAxMGYuc2V0Q29udGVudChodG1sXzU2MmNhNTcwZWQ1YzRjNTM5NzVhM2Y3MGM2NmM5ODIzKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzYzNzQ2ZDYxNTNlMDRhZDZiMzhjNTE1ZDdlNTE4YmEwLmJpbmRQb3B1cChwb3B1cF9mMzQxYjAwODY5MWQ0MzBjOTZlNWY4ODg0MjUyMDEwZik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl82OGNkZGNkMDRjZDg0NWIzOTM1OGUxYTQzZGQ3NmE4NCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjg2NzY4Mzk2NDQ5OTE1LC03My45MjEyMTA0MjIwMzg5N10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9lZDNiNmRiMTY1NmI0YTJhYTk0MDQ0NTQ2ZmZhYTc3ZiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF81YjEzMGJhNmE1YWE0ZjU5ODgwNjZhZjBjMTU1MWE1YyA9ICQoJzxkaXYgaWQ9Imh0bWxfNWIxMzBiYTZhNWFhNGY1OTg4MDY2YWYwYzE1NTFhNWMiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPklud29vZCBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2VkM2I2ZGIxNjU2YjRhMmFhOTQwNDQ1NDZmZmFhNzdmLnNldENvbnRlbnQoaHRtbF81YjEzMGJhNmE1YWE0ZjU5ODgwNjZhZjBjMTU1MWE1Yyk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl82OGNkZGNkMDRjZDg0NWIzOTM1OGUxYTQzZGQ3NmE4NC5iaW5kUG9wdXAocG9wdXBfZWQzYjZkYjE2NTZiNGEyYWE5NDA0NDU0NmZmYWE3N2YpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZTg1YzVkMGFlODBhNDU2ZmFhMGE1ZGQxZTJjYjlkOTkgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC44MjM2MDQyODQ4MTE5MzUsLTczLjk0OTY4NzkxODgzMzY2XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2U3ZGYwM2E2NDcyMjQ5YmNhNWZiMTg2YmEzMGM2NDc2ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzY1NWNlYjFmNjA5NTRkOTk4MWM5MWM4NjkzYjU3YjFiID0gJCgnPGRpdiBpZD0iaHRtbF82NTVjZWIxZjYwOTU0ZDk5ODFjOTFjODY5M2I1N2IxYiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+SGFtaWx0b24gSGVpZ2h0cyBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2U3ZGYwM2E2NDcyMjQ5YmNhNWZiMTg2YmEzMGM2NDc2LnNldENvbnRlbnQoaHRtbF82NTVjZWIxZjYwOTU0ZDk5ODFjOTFjODY5M2I1N2IxYik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9lODVjNWQwYWU4MGE0NTZmYWEwYTVkZDFlMmNiOWQ5OS5iaW5kUG9wdXAocG9wdXBfZTdkZjAzYTY0NzIyNDliY2E1ZmIxODZiYTMwYzY0NzYpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMDkwYzFhMWJhM2I3NGU2Nzk4NGQ5ZjJiN2UwNGM3ODAgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC44MTY5MzQ0Mjk0OTc4LC03My45NTczODUzOTM1MTg4XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzU1OTZhMjgzNWQ1YTQ1OThhODZlYTQ5ZmIwMmJlODE3ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2FiMDNhNTUzZjZmODQ4ZjI5YmMzNWEzNDRiZTkwZTZiID0gJCgnPGRpdiBpZD0iaHRtbF9hYjAzYTU1M2Y2Zjg0OGYyOWJjMzVhMzQ0YmU5MGU2YiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+TWFuaGF0dGFudmlsbGUgQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF81NTk2YTI4MzVkNWE0NTk4YTg2ZWE0OWZiMDJiZTgxNy5zZXRDb250ZW50KGh0bWxfYWIwM2E1NTNmNmY4NDhmMjliYzM1YTM0NGJlOTBlNmIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMDkwYzFhMWJhM2I3NGU2Nzk4NGQ5ZjJiN2UwNGM3ODAuYmluZFBvcHVwKHBvcHVwXzU1OTZhMjgzNWQ1YTQ1OThhODZlYTQ5ZmIwMmJlODE3KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2IxMWEwMmU5NTcwNjQwMWJhY2JlMWY5YWNlNjUzZjJkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuODE1OTc2MDY3NDI0MTQsLTczLjk0MzIxMTEyNjAzOTA1XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzQwMGI3NmQ4YTg0YzRkMTliMjU2MzIyM2EzNjA4MjQxID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzE4YjZlMzA3N2M4YzRiOWFiMzgxMzA2YzM5ODcwY2I3ID0gJCgnPGRpdiBpZD0iaHRtbF8xOGI2ZTMwNzdjOGM0YjlhYjM4MTMwNmMzOTg3MGNiNyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2VudHJhbCBIYXJsZW0gQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF80MDBiNzZkOGE4NGM0ZDE5YjI1NjMyMjNhMzYwODI0MS5zZXRDb250ZW50KGh0bWxfMThiNmUzMDc3YzhjNGI5YWIzODEzMDZjMzk4NzBjYjcpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYjExYTAyZTk1NzA2NDAxYmFjYmUxZjlhY2U2NTNmMmQuYmluZFBvcHVwKHBvcHVwXzQwMGI3NmQ4YTg0YzRkMTliMjU2MzIyM2EzNjA4MjQxKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzVhZWI2NTMwZjA3ZDRhMjFiNmQzODk0MGNhYmEyMDFmID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuNzkyMjQ5NDY2NjMwMzMsLTczLjk0NDE4MjIzMTQ4NTI0XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzJjNTg4MDgzMWZiMTRlMjJhMWMyY2ZmNzNkYTUzYTE1ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2Y3MDhmZDE5NDU0NjQ1MGFiNDA3YTY0MjRlZDg4ODAyID0gJCgnPGRpdiBpZD0iaHRtbF9mNzA4ZmQxOTQ1NDY0NTBhYjQwN2E2NDI0ZWQ4ODgwMiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RWFzdCBIYXJsZW0gQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8yYzU4ODA4MzFmYjE0ZTIyYTFjMmNmZjczZGE1M2ExNS5zZXRDb250ZW50KGh0bWxfZjcwOGZkMTk0NTQ2NDUwYWI0MDdhNjQyNGVkODg4MDIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNWFlYjY1MzBmMDdkNGEyMWI2ZDM4OTQwY2FiYTIwMWYuYmluZFBvcHVwKHBvcHVwXzJjNTg4MDgzMWZiMTRlMjJhMWMyY2ZmNzNkYTUzYTE1KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzBlZTQ0NThkYjk2MjQ1MGI5OGYzNDU4Y2JlNDkyMzQxID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuNzc1NjM4NTczMzAxODA1LC03My45NjA1MDc2MzEzNV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF84ZTZkZGMwNmUxNGM0NGEyYWE1MTAxYmZhNTNjODUwYiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF83NTgxNDdkNWNmYzA0NTc1YTM2NTkyZmQ1NTk3NTMxNiA9ICQoJzxkaXYgaWQ9Imh0bWxfNzU4MTQ3ZDVjZmMwNDU3NWEzNjU5MmZkNTU5NzUzMTYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlVwcGVyIEVhc3QgU2lkZSBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzhlNmRkYzA2ZTE0YzQ0YTJhYTUxMDFiZmE1M2M4NTBiLnNldENvbnRlbnQoaHRtbF83NTgxNDdkNWNmYzA0NTc1YTM2NTkyZmQ1NTk3NTMxNik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8wZWU0NDU4ZGI5NjI0NTBiOThmMzQ1OGNiZTQ5MjM0MS5iaW5kUG9wdXAocG9wdXBfOGU2ZGRjMDZlMTRjNDRhMmFhNTEwMWJmYTUzYzg1MGIpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfM2M3ZjMwMzI4ODRiNDBhZWI2YzlmYWUyMDY3MTdlYTMgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43NzU5Mjk4NDk4ODQ4NzUsLTczLjk0NzExNzg0NDcxODI2XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzdiODE1NTEwY2ZhZjRkMmRhMWQxOGUwMWMxYTcxZjdhID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzY3MTBjMWM3ZTkwMDQ0MmY4NDlkZGU0ZTJhOGRkOWNjID0gJCgnPGRpdiBpZD0iaHRtbF82NzEwYzFjN2U5MDA0NDJmODQ5ZGRlNGUyYThkZDljYyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+WW9ya3ZpbGxlIENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfN2I4MTU1MTBjZmFmNGQyZGExZDE4ZTAxYzFhNzFmN2Euc2V0Q29udGVudChodG1sXzY3MTBjMWM3ZTkwMDQ0MmY4NDlkZGU0ZTJhOGRkOWNjKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzNjN2YzMDMyODg0YjQwYWViNmM5ZmFlMjA2NzE3ZWEzLmJpbmRQb3B1cChwb3B1cF83YjgxNTUxMGNmYWY0ZDJkYTFkMThlMDFjMWE3MWY3YSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9mYTFiMmY3MDc4ODk0OGQ1YjUwNWE4ODNiYzI3ZDllYyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjc2ODExMjY1ODI4NzMzLC03My45NTg4NTk2ODgxMzc2XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzNiYjA3YWVlYTZhMjQ1NGJiZTE3ZjFmZmFiNjM2OWMxID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzI4NmYwM2NhODg1MjRiMTk5ZWVmMDU0YTdhZmJlZjdiID0gJCgnPGRpdiBpZD0iaHRtbF8yODZmMDNjYTg4NTI0YjE5OWVlZjA1NGE3YWZiZWY3YiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+TGVub3ggSGlsbCBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzNiYjA3YWVlYTZhMjQ1NGJiZTE3ZjFmZmFiNjM2OWMxLnNldENvbnRlbnQoaHRtbF8yODZmMDNjYTg4NTI0YjE5OWVlZjA1NGE3YWZiZWY3Yik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9mYTFiMmY3MDc4ODk0OGQ1YjUwNWE4ODNiYzI3ZDllYy5iaW5kUG9wdXAocG9wdXBfM2JiMDdhZWVhNmEyNDU0YmJlMTdmMWZmYWI2MzY5YzEpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMDJhMzk5MTNkMzM0NGQ0ZDgxZGZiZGUzNGU4MGQ0NTkgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43NjIxNTk2MDU3NjI4MywtNzMuOTQ5MTY3NjkyMjc5NTNdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfOWY4Zjg3MTRiMzEyNDA0N2E3OTY0ZTZjYzQ0ZmU4M2YgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMzA2M2VlYjMwZjViNGUwMGI3NDg4YWQ2MWMyMDM3YzEgPSAkKCc8ZGl2IGlkPSJodG1sXzMwNjNlZWIzMGY1YjRlMDBiNzQ4OGFkNjFjMjAzN2MxIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Sb29zZXZlbHQgSXNsYW5kIENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfOWY4Zjg3MTRiMzEyNDA0N2E3OTY0ZTZjYzQ0ZmU4M2Yuc2V0Q29udGVudChodG1sXzMwNjNlZWIzMGY1YjRlMDBiNzQ4OGFkNjFjMjAzN2MxKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzAyYTM5OTEzZDMzNDRkNGQ4MWRmYmRlMzRlODBkNDU5LmJpbmRQb3B1cChwb3B1cF85ZjhmODcxNGIzMTI0MDQ3YTc5NjRlNmNjNDRmZTgzZik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl84ZDZjZWE2MTZlOGY0MGI1YWQyZmM5MjE1MmNkMGZjMiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjc4NzY1Nzk5ODUzNDg1NCwtNzMuOTc3MDU5MjM2MzA2MDNdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfODRjYTlkNTI5NTQ3NDUxZGFhZDc4NzI2ZTdhZDQ5MTkgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYWFmMjhlOGM4MzUzNDc5NWI2OGIzYTMxNDViOWQyYmMgPSAkKCc8ZGl2IGlkPSJodG1sX2FhZjI4ZThjODM1MzQ3OTViNjhiM2EzMTQ1YjlkMmJjIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5VcHBlciBXZXN0IFNpZGUgQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF84NGNhOWQ1Mjk1NDc0NTFkYWFkNzg3MjZlN2FkNDkxOS5zZXRDb250ZW50KGh0bWxfYWFmMjhlOGM4MzUzNDc5NWI2OGIzYTMxNDViOWQyYmMpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfOGQ2Y2VhNjE2ZThmNDBiNWFkMmZjOTIxNTJjZDBmYzIuYmluZFBvcHVwKHBvcHVwXzg0Y2E5ZDUyOTU0NzQ1MWRhYWQ3ODcyNmU3YWQ0OTE5KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2ZiODgxYmU1OWMzNzRlMGNhOWYwYmQ2YzUwNDEzYjUzID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuNzczNTI4ODg5NDIxNjYsLTczLjk4NTMzNzc3MDAxMjYyXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzBkZmQ0ZDZhNGZlNDQ1ODY4MWQ2ZDc0YTVjZTEzODI3ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzlkNzkzYmYzY2EwNzQxMzBiMWNhMmNjNTBhZDVkZDFhID0gJCgnPGRpdiBpZD0iaHRtbF85ZDc5M2JmM2NhMDc0MTMwYjFjYTJjYzUwYWQ1ZGQxYSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+TGluY29sbiBTcXVhcmUgQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8wZGZkNGQ2YTRmZTQ0NTg2ODFkNmQ3NGE1Y2UxMzgyNy5zZXRDb250ZW50KGh0bWxfOWQ3OTNiZjNjYTA3NDEzMGIxY2EyY2M1MGFkNWRkMWEpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfZmI4ODFiZTU5YzM3NGUwY2E5ZjBiZDZjNTA0MTNiNTMuYmluZFBvcHVwKHBvcHVwXzBkZmQ0ZDZhNGZlNDQ1ODY4MWQ2ZDc0YTVjZTEzODI3KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzgyNzU1MzY0ZGI3YTQ3ZGViM2FkOTU4ZTQ0ZTc4OWUwID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuNzU5MTAwODkxNDYyMTIsLTczLjk5NjExOTM2MzA5NDc5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzhlNWI3MzI2OGE3NTQyMzg4YjBlOTFmNzI1NGVjOTExID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2E1YTYzMjljZDU1MTQ2YzlhMzM2NmIwMzY2YjQ1NzEyID0gJCgnPGRpdiBpZD0iaHRtbF9hNWE2MzI5Y2Q1NTE0NmM5YTMzNjZiMDM2NmI0NTcxMiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2xpbnRvbiBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzhlNWI3MzI2OGE3NTQyMzg4YjBlOTFmNzI1NGVjOTExLnNldENvbnRlbnQoaHRtbF9hNWE2MzI5Y2Q1NTE0NmM5YTMzNjZiMDM2NmI0NTcxMik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl84Mjc1NTM2NGRiN2E0N2RlYjNhZDk1OGU0NGU3ODllMC5iaW5kUG9wdXAocG9wdXBfOGU1YjczMjY4YTc1NDIzODhiMGU5MWY3MjU0ZWM5MTEpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYzYwN2E5MTIyODg4NDM3YTkwNDgxNDU5OTkzNzJkNDggPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43NTQ2OTExMDI3MDYyMywtNzMuOTgxNjY4ODI3MzAzMDRdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfMzMzODY5MjcwZjdlNDBkNjhmOGIzNzE4OGZkYTRkNzkgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYzg2NmZkNjRiZjE1NDA3ZWIwNGJhMDM5ZjljOTBhYmYgPSAkKCc8ZGl2IGlkPSJodG1sX2M4NjZmZDY0YmYxNTQwN2ViMDRiYTAzOWY5YzkwYWJmIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5NaWR0b3duIENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMzMzODY5MjcwZjdlNDBkNjhmOGIzNzE4OGZkYTRkNzkuc2V0Q29udGVudChodG1sX2M4NjZmZDY0YmYxNTQwN2ViMDRiYTAzOWY5YzkwYWJmKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2M2MDdhOTEyMjg4ODQzN2E5MDQ4MTQ1OTk5MzcyZDQ4LmJpbmRQb3B1cChwb3B1cF8zMzM4NjkyNzBmN2U0MGQ2OGY4YjM3MTg4ZmRhNGQ3OSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl84YTI1OTgwZWRkOWM0YzVkOGI3Mjg3ZjJjY2RhODI4ZiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjc0ODMwMzA3NzI1MjE3NCwtNzMuOTc4MzMyMDc5MjQxMjddLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfODEwOGJhMzI0OTdkNGEyMzk0OTNkNjAzZjliZmY4ZmMgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfOWQ2ZTQwNmVhMjcxNDMxZmI4Y2FmMGM5Njk4NTdmNzQgPSAkKCc8ZGl2IGlkPSJodG1sXzlkNmU0MDZlYTI3MTQzMWZiOGNhZjBjOTY5ODU3Zjc0IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5NdXJyYXkgSGlsbCBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzgxMDhiYTMyNDk3ZDRhMjM5NDkzZDYwM2Y5YmZmOGZjLnNldENvbnRlbnQoaHRtbF85ZDZlNDA2ZWEyNzE0MzFmYjhjYWYwYzk2OTg1N2Y3NCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl84YTI1OTgwZWRkOWM0YzVkOGI3Mjg3ZjJjY2RhODI4Zi5iaW5kUG9wdXAocG9wdXBfODEwOGJhMzI0OTdkNGEyMzk0OTNkNjAzZjliZmY4ZmMpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZTc0MTFiZTdlYTE3NGE5ZTkxNDA4ZjRiZjliNDk3NWEgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43NDQwMzQ3MDY3NDc5NzUsLTc0LjAwMzExNjMzNDcyODEzXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzgxYmY2Mjk3MWFlNTQ1NWJhYTcxYjkwNTkwNGFhYWRhID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sX2E1NDEwNGIyOTI0ZDQ0ZmM5OGJmZmU4Yzc5OWY2YmQ0ID0gJCgnPGRpdiBpZD0iaHRtbF9hNTQxMDRiMjkyNGQ0NGZjOThiZmZlOGM3OTlmNmJkNCIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2hlbHNlYSBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzgxYmY2Mjk3MWFlNTQ1NWJhYTcxYjkwNTkwNGFhYWRhLnNldENvbnRlbnQoaHRtbF9hNTQxMDRiMjkyNGQ0NGZjOThiZmZlOGM3OTlmNmJkNCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9lNzQxMWJlN2VhMTc0YTllOTE0MDhmNGJmOWI0OTc1YS5iaW5kUG9wdXAocG9wdXBfODFiZjYyOTcxYWU1NDU1YmFhNzFiOTA1OTA0YWFhZGEpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfZGMwMzExM2Y3ZTUxNGJjNjk3MjFiZGVmOTFhMDEzMGEgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43MjY5MzI4ODUzNjEyOCwtNzMuOTk5OTE0MDI5NDU5MDJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfZDZmMWI3MTEwMGIwNDY0M2E5ODJiN2E4Zjk2MGJlMDQgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfZWFmYjFkM2IyM2IwNDhiNDk4OGQyMTQxYzZmNTkxMzAgPSAkKCc8ZGl2IGlkPSJodG1sX2VhZmIxZDNiMjNiMDQ4YjQ5ODhkMjE0MWM2ZjU5MTMwIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5HcmVlbndpY2ggVmlsbGFnZSBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2Q2ZjFiNzExMDBiMDQ2NDNhOTgyYjdhOGY5NjBiZTA0LnNldENvbnRlbnQoaHRtbF9lYWZiMWQzYjIzYjA0OGI0OTg4ZDIxNDFjNmY1OTEzMCk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9kYzAzMTEzZjdlNTE0YmM2OTcyMWJkZWY5MWEwMTMwYS5iaW5kUG9wdXAocG9wdXBfZDZmMWI3MTEwMGIwNDY0M2E5ODJiN2E4Zjk2MGJlMDQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYTIyZjQ2NDU3Y2JhNDRhNmExNDg4OTUyZmQxYzE1YTIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43Mjc4NDY3NzcyNzAyNDQsLTczLjk4MjIyNjE2NTA2NDE2XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2U0ODIwZjk0ZDI0NTQ4NjNiYmZkZjRjM2I1MDNhOWVhID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzIxNTc0MDk2OWYxZDQ5NDg4NTI2ZjlmYTNjZDE2Nzk5ID0gJCgnPGRpdiBpZD0iaHRtbF8yMTU3NDA5NjlmMWQ0OTQ4ODUyNmY5ZmEzY2QxNjc5OSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RWFzdCBWaWxsYWdlIENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZTQ4MjBmOTRkMjQ1NDg2M2JiZmRmNGMzYjUwM2E5ZWEuc2V0Q29udGVudChodG1sXzIxNTc0MDk2OWYxZDQ5NDg4NTI2ZjlmYTNjZDE2Nzk5KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2EyMmY0NjQ1N2NiYTQ0YTZhMTQ4ODk1MmZkMWMxNWEyLmJpbmRQb3B1cChwb3B1cF9lNDgyMGY5NGQyNDU0ODYzYmJmZGY0YzNiNTAzYTllYSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9iYzA0Yjk5YTg0MzY0ZWY2YjNhYWE1YzI3ZTJlYmNjNyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjcxNzgwNjc0ODkyNzY1LC03My45ODA4OTAzMTk5OTI5MV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9jYTJlNWU0YzVjZWQ0YjI1OGYwN2ZmMTdmMDJjZjQzYyA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8wOTc2MDZiMmIzOWY0NmIyYTU3NmJiYzM2MDFkMjFkMSA9ICQoJzxkaXYgaWQ9Imh0bWxfMDk3NjA2YjJiMzlmNDZiMmE1NzZiYmMzNjAxZDIxZDEiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkxvd2VyIEVhc3QgU2lkZSBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2NhMmU1ZTRjNWNlZDRiMjU4ZjA3ZmYxN2YwMmNmNDNjLnNldENvbnRlbnQoaHRtbF8wOTc2MDZiMmIzOWY0NmIyYTU3NmJiYzM2MDFkMjFkMSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9iYzA0Yjk5YTg0MzY0ZWY2YjNhYWE1YzI3ZTJlYmNjNy5iaW5kUG9wdXAocG9wdXBfY2EyZTVlNGM1Y2VkNGIyNThmMDdmZjE3ZjAyY2Y0M2MpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMmExMGYzNmM0MWNjNDE4N2JhNTQ5MjM1NjhlOTg3MDggPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43MjE1MjE5Njc0NDMyMTYsLTc0LjAxMDY4MzI4NTU5MDg3XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2U3MDZjYjQzMzlmMzQ0NDQ5M2I0YTU5NTk2OTdhYzIzID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzMwYTc1ZTVhZDRlMzQyNzI5NWE0ZGZmMGNhNGRlYTA5ID0gJCgnPGRpdiBpZD0iaHRtbF8zMGE3NWU1YWQ0ZTM0MjcyOTVhNGRmZjBjYTRkZWEwOSIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+VHJpYmVjYSBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwX2U3MDZjYjQzMzlmMzQ0NDQ5M2I0YTU5NTk2OTdhYzIzLnNldENvbnRlbnQoaHRtbF8zMGE3NWU1YWQ0ZTM0MjcyOTVhNGRmZjBjYTRkZWEwOSk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8yYTEwZjM2YzQxY2M0MTg3YmE1NDkyMzU2OGU5ODcwOC5iaW5kUG9wdXAocG9wdXBfZTcwNmNiNDMzOWYzNDQ0NDkzYjRhNTk1OTY5N2FjMjMpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYzhiNGNmODU3M2VmNDE4YWE5MWY0MTdjYzE2OWFlNGYgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43MTkzMjM3OTM5NTkwNywtNzMuOTk3MzA0NjcyMDgwNzNdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNzE2YzBiZWQyY2EwNDA5ZWFlMjFmYzhiOTk3NTQzNjkgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfNTI2YmFlYzlhNmZmNGFmYjlkZGFhYTRlYTNjOGZjYWIgPSAkKCc8ZGl2IGlkPSJodG1sXzUyNmJhZWM5YTZmZjRhZmI5ZGRhYWE0ZWEzYzhmY2FiIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5MaXR0bGUgSXRhbHkgQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF83MTZjMGJlZDJjYTA0MDllYWUyMWZjOGI5OTc1NDM2OS5zZXRDb250ZW50KGh0bWxfNTI2YmFlYzlhNmZmNGFmYjlkZGFhYTRlYTNjOGZjYWIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYzhiNGNmODU3M2VmNDE4YWE5MWY0MTdjYzE2OWFlNGYuYmluZFBvcHVwKHBvcHVwXzcxNmMwYmVkMmNhMDQwOWVhZTIxZmM4Yjk5NzU0MzY5KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzBiZTEzNWU2MDJjZDRmMGY5NTg1YTU3MDc3YzExMTRjID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuNzIyMTgzODQxMzE3OTQsLTc0LjAwMDY1NjY2OTU5NzU5XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzNiZTgyMjYwYzlhYjRkOGU4ODkwYjdiMzBhZDgxM2M3ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzM0ZGYwYWY4YTVkNjQ5MjE4M2QxZWRhYWQyZjM1MWQ2ID0gJCgnPGRpdiBpZD0iaHRtbF8zNGRmMGFmOGE1ZDY0OTIxODNkMWVkYWFkMmYzNTFkNiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+U29obyBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzNiZTgyMjYwYzlhYjRkOGU4ODkwYjdiMzBhZDgxM2M3LnNldENvbnRlbnQoaHRtbF8zNGRmMGFmOGE1ZDY0OTIxODNkMWVkYWFkMmYzNTFkNik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8wYmUxMzVlNjAyY2Q0ZjBmOTU4NWE1NzA3N2MxMTE0Yy5iaW5kUG9wdXAocG9wdXBfM2JlODIyNjBjOWFiNGQ4ZTg4OTBiN2IzMGFkODEzYzcpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfYWYyOTE5OTA0ZTJjNDNlZWFiYWJiNTY2N2M0MzhkMzkgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43MzQ0MzM5MzU3MjQzNCwtNzQuMDA2MTc5OTgxMjY4MTJdLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfYzk4NmU3Yzc4ZDI5NGUxNTk2NzkyMmU4MjMzYzBiNjEgPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfMmFmOWU0MzRiMjQwNGQ1ZGJlMDkxYWRkNzcyYmQ0NjggPSAkKCc8ZGl2IGlkPSJodG1sXzJhZjllNDM0YjI0MDRkNWRiZTA5MWFkZDc3MmJkNDY4IiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5XZXN0IFZpbGxhZ2UgQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9jOTg2ZTdjNzhkMjk0ZTE1OTY3OTIyZTgyMzNjMGI2MS5zZXRDb250ZW50KGh0bWxfMmFmOWU0MzRiMjQwNGQ1ZGJlMDkxYWRkNzcyYmQ0NjgpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYWYyOTE5OTA0ZTJjNDNlZWFiYWJiNTY2N2M0MzhkMzkuYmluZFBvcHVwKHBvcHVwX2M5ODZlN2M3OGQyOTRlMTU5Njc5MjJlODIzM2MwYjYxKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzM0ZWU0ZjE3MDI3YTRjNjZiOWZhM2QzOWU1OWNjMDI4ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuNzk3MzA3MDQxNzAyODY1LC03My45NjQyODYxNzc0MDY1NV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8xNDJiMzA1Yzg3ZmU0YTFjYTUxNjE2OTBkMDUyNmJmMSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9jZTgyZGQxOTk3MmI0N2JkYjk1YjJhYzJhMmRmZTUyNiA9ICQoJzxkaXYgaWQ9Imh0bWxfY2U4MmRkMTk5NzJiNDdiZGI5NWIyYWMyYTJkZmU1MjYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPk1hbmhhdHRhbiBWYWxsZXkgQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8xNDJiMzA1Yzg3ZmU0YTFjYTUxNjE2OTBkMDUyNmJmMS5zZXRDb250ZW50KGh0bWxfY2U4MmRkMTk5NzJiNDdiZGI5NWIyYWMyYTJkZmU1MjYpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMzRlZTRmMTcwMjdhNGM2NmI5ZmEzZDM5ZTU5Y2MwMjguYmluZFBvcHVwKHBvcHVwXzE0MmIzMDVjODdmZTRhMWNhNTE2MTY5MGQwNTI2YmYxKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyX2I1ZDFkZWFjODE4ZTQ3YWE4OTczMjQyZDhmYjViOWUwID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuODA3OTk5NzM4MTY1ODI2LC03My45NjM4OTYyNzkwNTMzMl0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF80MDdjM2NiZmU4Zjg0ODg4OWEzYTg1MTY3YTdkNGExYSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF82ZWNjMzllNWZiNTg0NDJlYjc3MGJiMzIxYTNjZWZmOSA9ICQoJzxkaXYgaWQ9Imh0bWxfNmVjYzM5ZTVmYjU4NDQyZWI3NzBiYjMyMWEzY2VmZjkiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPk1vcm5pbmdzaWRlIEhlaWdodHMgQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF80MDdjM2NiZmU4Zjg0ODg4OWEzYTg1MTY3YTdkNGExYS5zZXRDb250ZW50KGh0bWxfNmVjYzM5ZTVmYjU4NDQyZWI3NzBiYjMyMWEzY2VmZjkpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfYjVkMWRlYWM4MThlNDdhYTg5NzMyNDJkOGZiNWI5ZTAuYmluZFBvcHVwKHBvcHVwXzQwN2MzY2JmZThmODQ4ODg5YTNhODUxNjdhN2Q0YTFhKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzU3MzY0ZmFiNTgzMjRlNDhiNWRhODY3ODY3YjQyYWE1ID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuNzM3MjA5ODMyNzE1LC03My45ODEzNzU5NDgzMzU0MV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF83NmY1NTIwMmYxNDk0ZTRjYjczZDkzNDIyOWE0ZmFlOCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9iY2JkYjUzYjI2NDg0NDJiYjRlMTE0M2RjMTg4ZmRhNiA9ICQoJzxkaXYgaWQ9Imh0bWxfYmNiZGI1M2IyNjQ4NDQyYmI0ZTExNDNkYzE4OGZkYTYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkdyYW1lcmN5IENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNzZmNTUyMDJmMTQ5NGU0Y2I3M2Q5MzQyMjlhNGZhZTguc2V0Q29udGVudChodG1sX2JjYmRiNTNiMjY0ODQ0MmJiNGUxMTQzZGMxODhmZGE2KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzU3MzY0ZmFiNTgzMjRlNDhiNWRhODY3ODY3YjQyYWE1LmJpbmRQb3B1cChwb3B1cF83NmY1NTIwMmYxNDk0ZTRjYjczZDkzNDIyOWE0ZmFlOCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl83MmNiNDc3Y2JkYmE0N2YxOTAwZjBhMmM4NTVkY2RlZSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjcxMTkzMTk4Mzk0NTY1LC03NC4wMTY4NjkzMDUwODYxN10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9jZDY3MzkwNTJkNWU0MTI3OWUzMmFjNTE1NjNiZDFmZSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8xNWRmZTE2NTdiNDA0MDMzYjNlZDNkNGUzZTJlMThmNiA9ICQoJzxkaXYgaWQ9Imh0bWxfMTVkZmUxNjU3YjQwNDAzM2IzZWQzZDRlM2UyZTE4ZjYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkJhdHRlcnkgUGFyayBDaXR5IENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfY2Q2NzM5MDUyZDVlNDEyNzllMzJhYzUxNTYzYmQxZmUuc2V0Q29udGVudChodG1sXzE1ZGZlMTY1N2I0MDQwMzNiM2VkM2Q0ZTNlMmUxOGY2KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzcyY2I0NzdjYmRiYTQ3ZjE5MDBmMGEyYzg1NWRjZGVlLmJpbmRQb3B1cChwb3B1cF9jZDY3MzkwNTJkNWU0MTI3OWUzMmFjNTE1NjNiZDFmZSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9hM2E0ZmI2Mjc0YmU0Mjg4OTI3YmZkNjM0ZGUzMzc3MCA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjcwNzEwNzEwNzI3MDQ4LC03NC4wMTA2NjU0NDUyMTI3XSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzI4ZmExY2NjMzUwNDRiNTFiOTc3NjEyZGQxZjNkNjc2ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzkwOWQ0MjczZTJkNjQwNjA5ZTFhZTZiZjI3ZTkxZGRjID0gJCgnPGRpdiBpZD0iaHRtbF85MDlkNDI3M2UyZDY0MDYwOWUxYWU2YmYyN2U5MWRkYyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+RmluYW5jaWFsIERpc3RyaWN0IENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMjhmYTFjY2MzNTA0NGI1MWI5Nzc2MTJkZDFmM2Q2NzYuc2V0Q29udGVudChodG1sXzkwOWQ0MjczZTJkNjQwNjA5ZTFhZTZiZjI3ZTkxZGRjKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyX2EzYTRmYjYyNzRiZTQyODg5MjdiZmQ2MzRkZTMzNzcwLmJpbmRQb3B1cChwb3B1cF8yOGZhMWNjYzM1MDQ0YjUxYjk3NzYxMmRkMWYzZDY3Nik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl9lNGYxZmYwZDVlM2I0ZTFkOGJjZTcwY2M3NGJkZGViNSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjc4MjY4MjU2NzEyNTcsLTczLjk1MzI1NjQ2ODM3MTEyXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzI4ZDlkNzNmMzYxNTQxN2JiNjhmNzEwOWNmZDE2NTM0ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzcxMjBhNWY3OGZkMTQzNzM4YTVkODZlYTA1MmI2ZGRiID0gJCgnPGRpdiBpZD0iaHRtbF83MTIwYTVmNzhmZDE0MzczOGE1ZDg2ZWEwNTJiNmRkYiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+Q2FybmVnaWUgSGlsbCBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzI4ZDlkNzNmMzYxNTQxN2JiNjhmNzEwOWNmZDE2NTM0LnNldENvbnRlbnQoaHRtbF83MTIwYTVmNzhmZDE0MzczOGE1ZDg2ZWEwNTJiNmRkYik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl9lNGYxZmYwZDVlM2I0ZTFkOGJjZTcwY2M3NGJkZGViNS5iaW5kUG9wdXAocG9wdXBfMjhkOWQ3M2YzNjE1NDE3YmI2OGY3MTA5Y2ZkMTY1MzQpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfOTBjZGE5OGNmNzA2NGJjM2EwOGZlYzQ4MzJhZjY3N2QgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43MjMyNTkwMTg4NTc2OCwtNzMuOTg4NDMzNjgwMjM1OTddLAogICAgICAgICAgICAgICAgewogICJidWJibGluZ01vdXNlRXZlbnRzIjogdHJ1ZSwKICAiY29sb3IiOiAiIzgwMDBmZiIsCiAgImRhc2hBcnJheSI6IG51bGwsCiAgImRhc2hPZmZzZXQiOiBudWxsLAogICJmaWxsIjogdHJ1ZSwKICAiZmlsbENvbG9yIjogIiM4MDAwZmYiLAogICJmaWxsT3BhY2l0eSI6IDAuNywKICAiZmlsbFJ1bGUiOiAiZXZlbm9kZCIsCiAgImxpbmVDYXAiOiAicm91bmQiLAogICJsaW5lSm9pbiI6ICJyb3VuZCIsCiAgIm9wYWNpdHkiOiAxLjAsCiAgInJhZGl1cyI6IDUsCiAgInN0cm9rZSI6IHRydWUsCiAgIndlaWdodCI6IDMKfQogICAgICAgICAgICAgICAgKS5hZGRUbyhtYXBfNzhlMDY4YzQ2ZmEyNGUyNzk5MTcxNjdiYTkxNWEzYzQpOwogICAgICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgcG9wdXBfNTA5YzRmMjk2NDQ2NDdjMThjMDkyNzk3ZTlhMTBhNjggPSBMLnBvcHVwKHttYXhXaWR0aDogJzMwMCd9KTsKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgdmFyIGh0bWxfYzlkODU1YTc0MWIwNGNiZWE4MDc1MDg3NzZhYzliMjMgPSAkKCc8ZGl2IGlkPSJodG1sX2M5ZDg1NWE3NDFiMDRjYmVhODA3NTA4Nzc2YWM5YjIzIiBzdHlsZT0id2lkdGg6IDEwMC4wJTsgaGVpZ2h0OiAxMDAuMCU7Ij5Ob2hvIENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfNTA5YzRmMjk2NDQ2NDdjMThjMDkyNzk3ZTlhMTBhNjguc2V0Q29udGVudChodG1sX2M5ZDg1NWE3NDFiMDRjYmVhODA3NTA4Nzc2YWM5YjIzKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzkwY2RhOThjZjcwNjRiYzNhMDhmZWM0ODMyYWY2NzdkLmJpbmRQb3B1cChwb3B1cF81MDljNGYyOTY0NDY0N2MxOGMwOTI3OTdlOWExMGE2OCk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl82MTdkZWI3MDM2YjM0NjNlODQwZmVhNDMzYTUwNWM0MyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjcxNTIyODkyMDQ2MjgyLC03NC4wMDU0MTUyOTg3MzM1NV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8yMWEzNGJiZGUzYmE0MjkwYjgzMDU1YzYzOTdlMjdiNiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF8yYWIyMDAzYWJlNzI0MjVjOWQ2NjE4NzQ3ODE5YzY3MyA9ICQoJzxkaXYgaWQ9Imh0bWxfMmFiMjAwM2FiZTcyNDI1YzlkNjYxODc0NzgxOWM2NzMiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkNpdmljIENlbnRlciBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzIxYTM0YmJkZTNiYTQyOTBiODMwNTVjNjM5N2UyN2I2LnNldENvbnRlbnQoaHRtbF8yYWIyMDAzYWJlNzI0MjVjOWQ2NjE4NzQ3ODE5YzY3Myk7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl82MTdkZWI3MDM2YjM0NjNlODQwZmVhNDMzYTUwNWM0My5iaW5kUG9wdXAocG9wdXBfMjFhMzRiYmRlM2JhNDI5MGI4MzA1NWM2Mzk3ZTI3YjYpOwoKICAgICAgICAgICAgCiAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIGNpcmNsZV9tYXJrZXJfMmZhNzNjMWJkODI5NDg1Yzg0NjViOWEzMThlYzcwMTIgPSBMLmNpcmNsZU1hcmtlcigKICAgICAgICAgICAgICAgIFs0MC43NDg1MDk2NjQzMTIyLC03My45ODg3MTMxMzI4NTI0N10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9hOWM1NGE3MmNjM2U0ZjJhODg0MzliNmMzYzdlMWY2ZSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF83M2NhNTk0MzAzZTY0MjRkODI0MzI0MTVmNTcwNDViNSA9ICQoJzxkaXYgaWQ9Imh0bWxfNzNjYTU5NDMwM2U2NDI0ZDgyNDMyNDE1ZjU3MDQ1YjUiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPk1pZHRvd24gU291dGggQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF9hOWM1NGE3MmNjM2U0ZjJhODg0MzliNmMzYzdlMWY2ZS5zZXRDb250ZW50KGh0bWxfNzNjYTU5NDMwM2U2NDI0ZDgyNDMyNDE1ZjU3MDQ1YjUpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMmZhNzNjMWJkODI5NDg1Yzg0NjViOWEzMThlYzcwMTIuYmluZFBvcHVwKHBvcHVwX2E5YzU0YTcyY2MzZTRmMmE4ODQzOWI2YzNjN2UxZjZlKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzQyZWYxYmU0NjE5OTRiMzlhYjJhZWVjYzA4ODU2NDUwID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuNzYwMjgwMzMxMzEzNzQsLTczLjk2MzU1NjE0MDk0MzAzXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwX2U5OGFhY2YyMjdmYjQ5MGRhYTY1ZTYzNjFmNjBkMWI2ID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzUzZjYxOTNjN2ZiOTRkNWNhNmRlOWZhNjRiYTFkOWE3ID0gJCgnPGRpdiBpZD0iaHRtbF81M2Y2MTkzYzdmYjk0ZDVjYTZkZTlmYTY0YmExZDlhNyIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+U3V0dG9uIFBsYWNlIENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfZTk4YWFjZjIyN2ZiNDkwZGFhNjVlNjM2MWY2MGQxYjYuc2V0Q29udGVudChodG1sXzUzZjYxOTNjN2ZiOTRkNWNhNmRlOWZhNjRiYTFkOWE3KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzQyZWYxYmU0NjE5OTRiMzlhYjJhZWVjYzA4ODU2NDUwLmJpbmRQb3B1cChwb3B1cF9lOThhYWNmMjI3ZmI0OTBkYWE2NWU2MzYxZjYwZDFiNik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl83NzEwNzVmZjVmYjI0YTk5OTFmNThjNTRhMWVmY2ViNSA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjc1MjA0MjM2OTUwNzIyLC03My45Njc3MDgyNDU4MTgzNF0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF8yN2NkNjhmNTA4YTM0MjNkYjlhMWUxY2U5YmJiYWJlZCA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF85Njk4MTcyODBhNTU0OTg2YTkzZDllMWJjYTQ5NGI1YiA9ICQoJzxkaXYgaWQ9Imh0bWxfOTY5ODE3MjgwYTU1NDk4NmE5M2Q5ZTFiY2E0OTRiNWIiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlR1cnRsZSBCYXkgQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF8yN2NkNjhmNTA4YTM0MjNkYjlhMWUxY2U5YmJiYWJlZC5zZXRDb250ZW50KGh0bWxfOTY5ODE3MjgwYTU1NDk4NmE5M2Q5ZTFiY2E0OTRiNWIpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfNzcxMDc1ZmY1ZmIyNGE5OTkxZjU4YzU0YTFlZmNlYjUuYmluZFBvcHVwKHBvcHVwXzI3Y2Q2OGY1MDhhMzQyM2RiOWExZTFjZTliYmJhYmVkKTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzFkY2Y0NTZlYzg5YzQ0ZGRhNzQ1N2FmZjRmYTA4YzRhID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuNzQ2OTE3NDEwNzQwMTk1LC03My45NzEyMTkyODcyMjI2NV0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF84NmY0MjUyODAzNWY0N2E0OWRlMmJiZGFlZWNhNTk3OSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF84ZWJkOTA3Y2RmZTU0MDc2ODAxMzZiNmQ0ZDAxY2NhZCA9ICQoJzxkaXYgaWQ9Imh0bWxfOGViZDkwN2NkZmU1NDA3NjgwMTM2YjZkNGQwMWNjYWQiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPlR1ZG9yIENpdHkgQ2x1c3RlciAxPC9kaXY+JylbMF07CiAgICAgICAgICAgICAgICBwb3B1cF84NmY0MjUyODAzNWY0N2E0OWRlMmJiZGFlZWNhNTk3OS5zZXRDb250ZW50KGh0bWxfOGViZDkwN2NkZmU1NDA3NjgwMTM2YjZkNGQwMWNjYWQpOwogICAgICAgICAgICAKCiAgICAgICAgICAgIGNpcmNsZV9tYXJrZXJfMWRjZjQ1NmVjODljNDRkZGE3NDU3YWZmNGZhMDhjNGEuYmluZFBvcHVwKHBvcHVwXzg2ZjQyNTI4MDM1ZjQ3YTQ5ZGUyYmJkYWVlY2E1OTc5KTsKCiAgICAgICAgICAgIAogICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBjaXJjbGVfbWFya2VyXzVhZWYxY2ZmYmNlZjRjNGM4Y2IzZWIzOGU2ZWZhNzJkID0gTC5jaXJjbGVNYXJrZXIoCiAgICAgICAgICAgICAgICBbNDAuNzMwOTk5NTU0NzcwNjEsLTczLjk3NDA1MTcwNDY5MjAzXSwKICAgICAgICAgICAgICAgIHsKICAiYnViYmxpbmdNb3VzZUV2ZW50cyI6IHRydWUsCiAgImNvbG9yIjogIiM4MDAwZmYiLAogICJkYXNoQXJyYXkiOiBudWxsLAogICJkYXNoT2Zmc2V0IjogbnVsbCwKICAiZmlsbCI6IHRydWUsCiAgImZpbGxDb2xvciI6ICIjODAwMGZmIiwKICAiZmlsbE9wYWNpdHkiOiAwLjcsCiAgImZpbGxSdWxlIjogImV2ZW5vZGQiLAogICJsaW5lQ2FwIjogInJvdW5kIiwKICAibGluZUpvaW4iOiAicm91bmQiLAogICJvcGFjaXR5IjogMS4wLAogICJyYWRpdXMiOiA1LAogICJzdHJva2UiOiB0cnVlLAogICJ3ZWlnaHQiOiAzCn0KICAgICAgICAgICAgICAgICkuYWRkVG8obWFwXzc4ZTA2OGM0NmZhMjRlMjc5OTE3MTY3YmE5MTVhM2M0KTsKICAgICAgICAgICAgCiAgICAKICAgICAgICAgICAgdmFyIHBvcHVwXzAzMjA4YzFhOGM1MjQ5NjU4N2M5MTZlOGUwYjk5ZDZiID0gTC5wb3B1cCh7bWF4V2lkdGg6ICczMDAnfSk7CgogICAgICAgICAgICAKICAgICAgICAgICAgICAgIHZhciBodG1sXzkyMTg1MzdmNGU5NTRkNmQ5MWVhMzNhNDFjZGViNGM2ID0gJCgnPGRpdiBpZD0iaHRtbF85MjE4NTM3ZjRlOTU0ZDZkOTFlYTMzYTQxY2RlYjRjNiIgc3R5bGU9IndpZHRoOiAxMDAuMCU7IGhlaWdodDogMTAwLjAlOyI+U3R1eXZlc2FudCBUb3duIENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfMDMyMDhjMWE4YzUyNDk2NTg3YzkxNmU4ZTBiOTlkNmIuc2V0Q29udGVudChodG1sXzkyMTg1MzdmNGU5NTRkNmQ5MWVhMzNhNDFjZGViNGM2KTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzVhZWYxY2ZmYmNlZjRjNGM4Y2IzZWIzOGU2ZWZhNzJkLmJpbmRQb3B1cChwb3B1cF8wMzIwOGMxYThjNTI0OTY1ODdjOTE2ZThlMGI5OWQ2Yik7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8zOGYyZmZhYmVjNjU0M2Q0ODYwYjI4NzEwNmUwZDRlNyA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjczOTY3MzA0NzYzODQyNiwtNzMuOTkwOTQ3MTA1MjgyNl0sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF9hYTVjYmNiZTNmYjg0MDYzODgyMWM4YWQ1YWQ4YjZmZSA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF85ZGViMTRjMWNiODA0YThkODk5ZjliMmUwNmI3NTA5ZiA9ICQoJzxkaXYgaWQ9Imh0bWxfOWRlYjE0YzFjYjgwNGE4ZDg5OWY5YjJlMDZiNzUwOWYiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkZsYXRpcm9uIENsdXN0ZXIgMTwvZGl2PicpWzBdOwogICAgICAgICAgICAgICAgcG9wdXBfYWE1Y2JjYmUzZmI4NDA2Mzg4MjFjOGFkNWFkOGI2ZmUuc2V0Q29udGVudChodG1sXzlkZWIxNGMxY2I4MDRhOGQ4OTlmOWIyZTA2Yjc1MDlmKTsKICAgICAgICAgICAgCgogICAgICAgICAgICBjaXJjbGVfbWFya2VyXzM4ZjJmZmFiZWM2NTQzZDQ4NjBiMjg3MTA2ZTBkNGU3LmJpbmRQb3B1cChwb3B1cF9hYTVjYmNiZTNmYjg0MDYzODgyMWM4YWQ1YWQ4YjZmZSk7CgogICAgICAgICAgICAKICAgICAgICAKICAgIAogICAgICAgICAgICB2YXIgY2lyY2xlX21hcmtlcl8yYWFkMmQ4ZTFjYzg0ODFhOTVmYjU2NTEzY2Y3M2FlNiA9IEwuY2lyY2xlTWFya2VyKAogICAgICAgICAgICAgICAgWzQwLjc1NjY1ODA4MjI3NTE5LC03NC4wMDAxMTEzNjIwMjYzN10sCiAgICAgICAgICAgICAgICB7CiAgImJ1YmJsaW5nTW91c2VFdmVudHMiOiB0cnVlLAogICJjb2xvciI6ICIjODAwMGZmIiwKICAiZGFzaEFycmF5IjogbnVsbCwKICAiZGFzaE9mZnNldCI6IG51bGwsCiAgImZpbGwiOiB0cnVlLAogICJmaWxsQ29sb3IiOiAiIzgwMDBmZiIsCiAgImZpbGxPcGFjaXR5IjogMC43LAogICJmaWxsUnVsZSI6ICJldmVub2RkIiwKICAibGluZUNhcCI6ICJyb3VuZCIsCiAgImxpbmVKb2luIjogInJvdW5kIiwKICAib3BhY2l0eSI6IDEuMCwKICAicmFkaXVzIjogNSwKICAic3Ryb2tlIjogdHJ1ZSwKICAid2VpZ2h0IjogMwp9CiAgICAgICAgICAgICAgICApLmFkZFRvKG1hcF83OGUwNjhjNDZmYTI0ZTI3OTkxNzE2N2JhOTE1YTNjNCk7CiAgICAgICAgICAgIAogICAgCiAgICAgICAgICAgIHZhciBwb3B1cF83YWE3YzI1NjExZjM0Y2E1OTdhZWUyZjg2NDBhNDY4ZiA9IEwucG9wdXAoe21heFdpZHRoOiAnMzAwJ30pOwoKICAgICAgICAgICAgCiAgICAgICAgICAgICAgICB2YXIgaHRtbF9kNWVmN2I2Njc2ZmQ0MzgyYmQ4N2E2NTFlMTQ1NThiYiA9ICQoJzxkaXYgaWQ9Imh0bWxfZDVlZjdiNjY3NmZkNDM4MmJkODdhNjUxZTE0NTU4YmIiIHN0eWxlPSJ3aWR0aDogMTAwLjAlOyBoZWlnaHQ6IDEwMC4wJTsiPkh1ZHNvbiBZYXJkcyBDbHVzdGVyIDE8L2Rpdj4nKVswXTsKICAgICAgICAgICAgICAgIHBvcHVwXzdhYTdjMjU2MTFmMzRjYTU5N2FlZTJmODY0MGE0NjhmLnNldENvbnRlbnQoaHRtbF9kNWVmN2I2Njc2ZmQ0MzgyYmQ4N2E2NTFlMTQ1NThiYik7CiAgICAgICAgICAgIAoKICAgICAgICAgICAgY2lyY2xlX21hcmtlcl8yYWFkMmQ4ZTFjYzg0ODFhOTVmYjU2NTEzY2Y3M2FlNi5iaW5kUG9wdXAocG9wdXBfN2FhN2MyNTYxMWYzNGNhNTk3YWVlMmY4NjQwYTQ2OGYpOwoKICAgICAgICAgICAgCiAgICAgICAgCjwvc2NyaXB0Pg==" style="position:absolute;width:100%;height:100%;left:0;top:0;border:none !important;" allowfullscreen webkitallowfullscreen mozallowfullscreen></iframe></div></div>




```python
Toronto_merged['Cluster Labels'].value_counts()
```




    1.0    90
    2.0     9
    0.0     2
    3.0     1
    4.0     1
    Name: Cluster Labels, dtype: int64




```python
manhattan_merged['Cluster Labels'].value_counts()
```




    1    40
    Name: Cluster Labels, dtype: int64




```python

```
