wget --header="Host: hotspot.sbu.ac.ir" \
  --header="Content-Length: 62" \
  --header="Cache-Control: max-age=0" \
  --header='Sec-Ch-Ua: "-Not.A/Brand";v="8", "Chromium";v="102"' \
  --header="Sec-Ch-Ua-Mobile: ?0" \
  --header='Sec-Ch-Ua-Platform: "Linux"' \
  --header="Upgrade-Insecure-Requests: 1" \
  --header="Origin: https://hotspot.sbu.ac.ir" \
  --header="Content-Type: application/x-www-form-urlencoded" \
  --header="User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36" \
  --header="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" \
  --header="Sec-Fetch-Site: same-origin" \
  --header="Sec-Fetch-Mode: navigate" \
  --header="Sec-Fetch-User: ?1" \
  --header="Sec-Fetch-Dest: document" \
  --header="Referer: https://hotspot.sbu.ac.ir/login?" \
  --header="Accept-Encoding: gzip, deflate" \
  --header="Accept-Language: en-US,en;q=0.9" \
  --header="Connection: close" \
  --post-data="dst=&popup=true&username=CHANGEME&password=CHANGEME" \
  --no-check-certificate \
  --output-document - \
  https://hotspot.sbu.ac.ir/login
