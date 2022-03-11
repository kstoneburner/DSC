
---
## Title: Assignment 1

## Subtitle: Computer Performance, Reliability, and Scalability Calculation
## Author: Kurt Stoneburner
---

#### a. Data Sizes

| Data Item                                  | Size per Item | 
|--------------------------------------------|--------------:|
| 128 character message.                     | 128 or 256 Bytes       |
| 1024x768 PNG image                         | 1.2 MB (See Notes)  |
| 1024x768 RAW image                         | 18.1 MB          | 
| HD (1080p) HEVC Video (15 minutes)         | 2,943 MB          |
| HD (1080p) Uncompressed Video (15 minutes) | 1,343,692 MB          |
| 4K UHD HEVC Video (15 minutes)             | 9,000 MB          |
| 4k UHD Uncompressed Video (15 minutes)     | 5,374,771 MB          |
| Human Genome (Uncompressed)                | 200 GB          |

 
#### b. Scaling

|                                           | Size     | # HD | 
|-------------------------------------------|---------:|-----:|
| Daily Twitter Tweets (Uncompressed)       | 62,500 MB   | 1      |
| Daily Twitter Tweets (Snappy Compressed)  | 102,400 MB  | 1      |
| Daily Instagram Photos                    | 90 TB       | 27     |
| Daily YouTube Videos                      | 2.5 PB      | 777    |
| Yearly Twitter Tweets (Uncompressed)      | 22.8 TB     | 7      |
| Yearly Twitter Tweets (Snappy Compressed) | 36.5 TB     | 11     |
| Yearly Instagram Photos                   | 32.85 PB    | 9,855  |
| Yearly YouTube Videos                     | 946 PB      | 28,105 |

#### c. Reliability
|                                    | # HD | # Failures |
|------------------------------------|-----:|-----------:|
| Twitter Tweets (Uncompressed)      | 7        | < 1 |
| Twitter Tweets (Snappy Compressed) | 11       | < 1 |
| Instagram Photos                   | 9,855    | 109 |
| YouTube Videos                     | 28,105   | 310 |

#### d. Latency

|                           | One Way Latency      |
|---------------------------|---------------------:|
| Los Angeles to Amsterdam  | 13ms                |
| Low Earth Orbit Satellite | 466μs - 3ms        |
| Geostationary Satellite   | 119ms                       |
| Earth to the Moon         | 1.19s - 1.35s               |
| Earth to Mars             | 3.09 minutes - 22.2 minutes | 



#### a. Notes: Data Sizes
- **128 character message:** Using a text editor, I generated a 128 character message and saved the file in ANSI, UTF-8 and UTF-16 formats. ANSI & UTF-8 used 128 bytes while UTF-16 used 256 bytes. 

- **1024x768 PNG image:** PNG file sizes are variable based upon color depth, alpha channel, and compression. I derived the 1.2MB  above by sampling five random landscape images. Each was imported into GNU Image Manipulation Program (GIMP) and sized to 1024 x 768 pixels. Each file was saved as a PNG with 1.2MB being the averaged filesize.
    
    PNG file size is dependent on color type (indexed, greyscale, truecolor) and an alpha channel is included. Uncompressed PNGs filesizes can vary between 1 bit and 16 bits per color channel, and can vary between 1 to 4 channels depending on the color type. 
    - TrueColor + Alpha Channel:  64 bits * 4 Channels * 756,432 pixels = **25,165,824** bytes
    - Indexed Color with 1 bit color, 1 channel: 1bit * 1 channel * 756,432 pixels = **756,432 bytes**
    
    
- **1024x768 RAW image:** Assuming 3x 8bit color channels: 18,154,368 bytes

- **HD (1080p) HEVC Video (15 minutes):** 900 seconds @ 3.27 Mb/s: Based on Handbrake x.265 Encoding at Medium Preset. 
    
- **HD (1080p) Uncompressed Video (15 minutes):** 1080p (1920x1080): 2,073,600 Pixels * 24bits Color * 30fps * 900 secs = 1,343,692,800,000 bytes

- **4K UHD HEVC Video (15 minutes):** 900 seconds @ 10 Mbs: Based on Handbrake x.265 Encoding at Medium Preset.

- **4k UHD Uncompressed Video (15 minutes):** (3840 × 2160): 8,294,400 Pixels * 24bits Color * 30fps * 900 secs = 5,374,771,200,000 bytes

- **Human Genome (Uncompressed):** The completed sequence would ideally be 700MB to account for the 3billion character sequence. 200GB is required as part of the actual sequencing process.


#### b. Notes: Scaling
- **Daily Twitter Tweets (Uncompressed):** 128b * 500,000,000 

- **Daily Twitter Tweets (Snappy Compressed):** Snappy Compression multiplies Plaint Text filesize by 1.5x to 1.7x (accoriding to the Github Snappy Page). A multiplier of 1.6 was applied. 128b * 500,000,000 * 1.6

- **Daily Instagram Photos:** 1.2MB PNG * 75,000,000

- **Daily YouTube Videos** Ideal Youtube Bitrate is 8Mbps (1MBps) for 1080p Video with x.264 Compression. 1440 Minutes per day * 1,800,000 seconds of Video Uploaded per minute * 1MBps = 2,592,000,000 MB or 2.5 PB / day. Hadoop Storage Requirement: (2,592 * 3 TB) / 10 TB = 777 10TB Drives

- **Yearly Twitter Tweets (Uncompressed):** 62,500 * 365 = 22,812,500MB or Storage Calc: (22.81TB * 3) / 10TB Drives = 6.8 * 10 TB Drives.

- **Yearly Twitter Tweets (Snappy Compressed):** 22,812,500 * 1.6 Storage; (36.5TB * 3) / 10 = 10.95 (11 * 10TB Drives)

- **Yearly Instagram Photos:** 90TB * 365 = (32,850 TB * 3) / 10 TB Drives = 9,855 * 10TB Drives

- **Yearly YouTube Videos:** 2,592TB * 365 = 946 PB; 777 Drives * 365

#### c. Notes: Reliability             
- Current Blackblaze Annualized Failure Rate: .011

#### d. Notes: Latency
 - All electro magnetic radiation moves at the speed of light, which is 299, 792, 458 m/s.

- **Los Angeles to Amsterdam:** The straight line distance is 3912.32 km. Latency varies by a variety on conditions. But it could be absolutely no less than 13.04ms (3912.32km / 299,792km/s) = .01304 seconds.

- **Low Earth Orbit Satellite:** Low earth orbit defined by Mirriam Webster is 140 to 970 kilometers. [ 140km / 299,792 km/s ] = 466 μs, [ 970km / 299,792 km/s ] = 3ms 

- **Geostationary Satellite:**   Equatorial Geostationary orbit is 35,786km. [35,786km / 299,792 km/s ] = 119ms

- **Earth to the Moon:** The moon has an elliptical orbit with daily varying apogee and perigee. On December 4th 2021 the moon's distance from my hometown will vary between 356,794km & 406,320km. [356,794km / 299,792 km/s] = 1.19s  [ 406,320km / 299,792 km/s] = 1.35s

- **Earth to Mars:** The distance to Mars from Earth varies between 55.76 Million km & 400.2 Million km. [55,760,000km / 299,792 km/s] = 3.09 Minutes; [ 400,200,000km / 299,792 km/s ] = 22.2 minutes



-----

#### References #### 
PNG Compression and Filtering: 
- http://www.libpng.org/pub/png/book/chapter09.html
- https://lizsscribbles.com/drawing-formats/what-compression-does-png-use.html
- https://en.wikipedia.org/wiki/Portable_Network_Graphics

Raw File Format
- https://en.wikipedia.org/wiki/Raw_image_format

HEVC Bitrate
- https://handbrake.fr/docs/en/1.3.0/technical/performance.html

HEVC 4:2:0 Explained
- https://allhomecinema.com/what-does-4-2-0-mean-chroma-subsampling-explained/?id=23688268690

Genome Size:
- https://medium.com/precision-medicine/how-big-is-the-human-genome-e90caa3409b0

Snappy Compression:
- https://github.com/google/snappy

Youtube Recommended Bitrates
- https://support.google.com/youtube/answer/1722171?hl=en#zippy=%2Cvideo-codec-h%2Cbitrate

Electro Magnetism
- https://en.wikipedia.org/wiki/Electromagnetic_radiation

Low Earth Orbit
- https://www.merriam-webster.com/dictionary/low%20earth%20orbit

Geostationary Orbit
- https://en.wikipedia.org/wiki/Geostationary_orbit

Lunar Perigee and Apogee
- https://www.timeanddate.com/astronomy/moon/distance.html

Martian Orbit
- https://en.wikipedia.org/wiki/Orbit_of_Mars

