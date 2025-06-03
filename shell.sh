#!/bin/bash

name="Wikipedia"
tlds=()

while IFS= read -r line; do
    [[ -n "$line" ]] && tlds+=("$line")
done < domaine.txt

# Clear output file before starting
> registered_domains.txt

for tld in "${tlds[@]}"; do
    domain="${name}.${tld}"
    result=$(whois "$domain" 2>&1)

    if ! echo "$result" | grep -qiE "No match|NOT FOUND|available"; then
        echo "$domain" >> registered_domains.txt
    fi
done
