#!/usr/bin/env fish

function weather --description 'Fetch the weather for my current location'
	curl --connect-timeout 1 "https://wttr.in/?0mqn"
end
