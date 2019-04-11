switch (uname -s)

	case "Darwin"
		for i in (brew --prefix ruby)/bin (brew --prefix coreutils)/libexec/gnubin /usr/local/bin /usr/local/sbin
			if not contains $i $PATH
				set -gx PATH $i $PATH
			end
		end

		if not contains (ruby -r rubygems -e 'puts Gem.user_dir')/bin $PATH
			set -gx PATH (ruby -r rubygems -e 'puts Gem.user_dir')/bin $PATH
		end
	case "Linux"
		set -gx PATH $HOME/.local/bin $PATH
		set -gx C_INCLUDE_PATH $HOME/.local/include $C_INCLUDE_PATH
		set -gx CPLUS_INCLUDE_PATH $HOME/.local/include $CPLUS_INCLUDE_PATH
		set -gx LIBRARY_PATH $HOME/.local/lib $LIBRARY_PATH
		set -gx PKG_CONFIG_PATH $HOME/.local/lib/pkgconfig $PKG_CONFIG_PATH

end

test -d /usr/local/heroku/bin; and set -gx fish_user_paths /usr/local/heroku/bin $fish_user_paths
test -L $HOME/.local/java/latest; and set -gx fish_user_paths $HOME/.local/java/latest/bin $fish_user_paths
test -L $HOME/.local/ant/latest; and set -gx fish_user_paths $HOME/.local/ant/latest/bin $fish_user_paths
test -d $HOME/.cargo/bin; and set -gx fish_user_paths $HOME/.cargo/bin $fish_user_paths

if test -d /Volumes/Tritium/Development/Android/sdk

	set -gx ANDROID_HOME /Volumes/Tritium/Development/Android/sdk
	test -d $ANDROID_HOME/tools; and set -gx fish_user_paths $ANDROID_HOME/tools $fish_user_paths
	test -d $ANDROID_HOME/platform-tools; and set -gx fish_user_paths $ANDROID_HOME/platform-tools $fish_user_paths

end

if test -z "$TERM"; or [ $TERM = "dumb" ]
	exit
end

if [ which gpg >/dev/null 2>&1; and which gpg-agent >/dev/null 2>&1 ]

	if not [ -n (pgrep gpg-agent) ]
		echo "[gpg] starting new daemon..."
		eval (gpg-agent --daemon)
	end

	set -gx GPG_TTY (tty)

end

if which thefuck >/dev/null 2>&1

	thefuck --alias | source

end
