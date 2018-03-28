#!/usr/bin/env fish

function we --description 'Fetch the weather for my current location'
	curl --connect-timeout 1 "wttr.in/?0?q?n"
end
