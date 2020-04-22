set -l platform (uname -s)

function maybe_add_to_path
	if not contains $argv[1] $PATH; and test -d $argv[1]
		set -gx fish_user_paths $argv[1] $fish_user_paths
	end
end

switch $platform
	case "Darwin"
		for i in \
			(brew --prefix ruby)/bin \
			(brew --prefix python)/libexec/bin \
			(brew --prefix coreutils)/libexec/gnubin
			maybe_add_to_path $i
		end
	case "Linux"
		set -gx C_INCLUDE_PATH $HOME/.local/include $C_INCLUDE_PATH
		set -gx CPLUS_INCLUDE_PATH $HOME/.local/include $CPLUS_INCLUDE_PATH
		set -gx LIBRARY_PATH $HOME/.local/lib $LIBRARY_PATH
		set -gx PKG_CONFIG_PATH $HOME/.local/lib/pkgconfig $PKG_CONFIG_PATH
end

for directory in \
	/usr/local/bin \
	/usr/local/sbin \
	/usr/local/heroku/bin \
	$HOME/.local/java/latest/bin \
	$HOME/.local/ant/latest/bin \
	$HOME/.cargo/bin \
	(ruby -r rubygems -e 'puts Gem.user_dir')/bin \
	$HOME/.local/bin
	maybe_add_to_path $directory
end

if test -z "$TERM"; or [ $TERM = "dumb" ]
	exit
end

if which gpg >/dev/null 2>&1; and which gpg-agent >/dev/null 2>&1
	if not test -n (echo (pgrep gpg-agent))
		eval (gpg-agent --daemon)
	end

	set -x GPG_TTY (tty)
end

set -x -U GOPATH $HOME/.local/go

