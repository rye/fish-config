#!/usr/bin/env fish

function moon --description 'Look at the moon'
	curl --connect-timeout 1 "wttr.in/moon?0mqn"
end
