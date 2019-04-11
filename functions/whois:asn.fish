function whois:asn --description 'Query whois.cymru.com for WHOIS information on an IP (getting ASN as well)'
	whois -h whois.cymru.com -v $argv
end
