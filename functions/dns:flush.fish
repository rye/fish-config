function dns:flush --description 'Flush DNS (on macOS)'
	sudo -p "(sudo) Enter your password to kill mDNSResponder with SIGHUP: " -k killall -v -HUP mDNSResponder
end
