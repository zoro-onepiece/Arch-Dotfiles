#!/usr/bin/env python3
import urllib.request
import json
import datetime
import os
import urllib.parse

def get_namaz_times():
    cache_file = "/tmp/namaz_times.json"
    today = datetime.datetime.now().strftime("%Y-%m-%d")
    
    if os.path.exists(cache_file):
        try:
            with open(cache_file, "r") as f:
                data = json.load(f)
                if data.get("date") == today:
                    return data.get("times")
        except Exception:
            pass

    try:
        req = urllib.request.Request("http://ip-api.com/json")
        with urllib.request.urlopen(req, timeout=5) as response:
            loc_data = json.loads(response.read().decode())
        
        city = loc_data.get("city", "")
        country = loc_data.get("country", "")

        if not city:
            return None

        city_encoded = urllib.parse.quote(city)
        country_encoded = urllib.parse.quote(country)
        url = f"http://api.aladhan.com/v1/timingsByCity?city={city_encoded}&country={country_encoded}&method=2"
        
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=5) as response:
            timing_data = json.loads(response.read().decode())
        
        timings = timing_data['data']['timings']
        
        result = {
            "date": today,
            "times": timings
        }
        with open(cache_file, "w") as f:
            json.dump(result, f)
            
        return timings

    except Exception as e:
        return None

def main():
    timings = get_namaz_times()
    if not timings:
        print("<span foreground='#a6adc8'>Namaz Timings Unavailable</span>")
        return

    fajr = timings.get("Fajr", "")
    dhuhr = timings.get("Dhuhr", "")
    asr = timings.get("Asr", "")
    maghrib = timings.get("Maghrib", "")
    isha = timings.get("Isha", "")

    # Clean aesthetic with subtle coloring (Catppuccin Mocha inspired)
    # Prayer names in Mauve (#cba6f7) or Subtext0 (#a6adc8), Times in White/Text (#cdd6f4)
    # Using small sleek dividers
    
    def format_item(name, time):
        return f"<span foreground='#a6adc8' font_weight='bold'>{name}</span> <span foreground='#cdd6f4'>{time}</span>"

    out = f"  <span foreground='#6c7086'>•</span>  ".join([
        format_item("Fajr", fajr),
        format_item("Dhuhr", dhuhr),
        format_item("Asr", asr),
        format_item("Maghrib", maghrib),
        format_item("Isha", isha)
    ])
    
    print(out)

if __name__ == "__main__":
    main()
