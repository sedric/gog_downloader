cd $(dirname $0)
cat list.txt | while read url
do
    redirect=$(wget -qS --load-cookies=cookies.txt "$url" --max-redirect=0 2>&1 | grep 'Location' | sed -r 's/.*(http[^?]*).*/\1/')
    filename=$(echo "$redirect" | sed -r 's/(http[^?]*).*/\1/;s/.*\/([^/]*)/\1/')
    if [ -f "$filename" ]
    then
	echo "Skipping $filename"
    else
	wget --load-cookies=cookies.txt "$url" -O "$filename"
    fi
done
