import requests


def get_location():
    response = requests.get(f'https://ipinfo.io').json()
    location_data = {
        "city": response.get("city"),
        "region": response.get("region"),
        "country": response.get("country")
    }
    return location_data
