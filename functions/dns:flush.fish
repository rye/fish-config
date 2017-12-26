function dns:flush --description 'Flush DNS (on macOS)'
	echo "sudoing a killall on mDNSResponder..."
	sudo killall -v -HUP mDNSResponder
end
