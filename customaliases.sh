alias c='clear'
alias doc='cd /var/home/E226767L/reseau/Perso/Documents'
alias la='ls -a'
alias lt='ls --human-readable --size -1 -S --classify'
alias gh='history|grep'
alias td='cd TD'
function s4(){
	if [ $# -eq 0 ];
	then
		cd "/var/home/E226767L/reseau/Perso/Documents/2/S4" || return 0
	elif [ $# -ge 1 ]
		then
			for dir in /var/home/E226767L/reseau/Perso/Documents/2/S4/*
				do
				dir_minuscule=$(tr '[:upper:]' '[:lower:]' <<< "$dir")
				arg_minuscule=$(tr '[:upper:]' '[:lower:]' <<< "$1")
				if [[ $dir_minuscule =~ .*$arg_minuscule.* ]];
					then
						cd "$dir" || return 0
              if [ $# -eq 2 ]
              then
                arg_minuscule=$(tr '[:upper:]' '[:lower:]' <<< "$2")
                case $arg_minuscule in
                  td)
                    cd "TD" || return 0
                    ;;
                  cm)
                    cd "CM" || return 0
                    ;;
                  *)
                    echo "unknown second args must be 'td' or 'cm'"
                    ;;
                  esac
              fi
				fi
			done
			echo "folder not found"

				
	fi
}

function mb(){
	commande=$( history -w /dev/stdout | tail -2 | head -1)
	eval "sudo $commande"
}

# add autocompletion with _android func

function android(){


  if [ $#  -eq  3 ]; then
    cp -r ~/reseau/Perso/Documents/2/S4/Développement\ pour\ applications\ mobiles/TD/"$2"/"$3" ~/reseau/Perso/Documents/2/S4/Développement\ pour\ applications\ mobiles/TD/recovery/

    if [ "$1" = "pull" ]; then
      cp -rf ~/reseau/Perso/Documents/2/S4/Développement\ pour\ applications\ mobiles/TD/"$2"/"$3"  ~/AndroidStudioProjects/
    fi
    if [ "$1" = "push" ]; then
      if [ -d /var/home/E226767L/AndroidStudioProjects/ ]; then
        echo "AndroidStudioProjects folder exists"
      else
        mkdir /var/home/E226767L/AndroidStudioProjects/
        echo "AndroidStudioProjects folder created !"
      fi
      cp -rf ~/AndroidStudioProjects/"$3" -rf ~/reseau/Perso/Documents/2/S4/Développement\ pour\ applications\ mobiles/TD/"$2"/"$3"
    fi
  fi


}

# autocompletion for the android commad : if the first arguement is pull check in the ~/reseau/Perso/Documents/2/S4/Développement\ pour\ applications\ mobiles/TD folde and if the first arguement is push check in the ~/AndroidStudioProjects/ folder
_android()
{
  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  if [ "$COMP_CWORD" -eq 1 ]; then
    # shellcheck disable=SC2207
    COMPREPLY=( $( compgen -W "pull push" -- "$cur" ) )
    return 0
  fi
  # shellcheck disable=SC2086
  if [ $COMP_CWORD -eq 2 ]; then
    # shellcheck disable=SC2207
    COMPREPLY=( $( compgen -W "TD" -- "$cur" ) )
    return 0
  fi
  if [ "$COMP_CWORD" -eq 3 ]; then
    if [ "$prev" = "pull" ]; then
      # shellcheck disable=SC2207
      COMPREPLY=( $( compgen -W "$(ls ~/reseau/Perso/Documents/2/S4/Développement\ pour\ applications\ mobiles/TD/"$prev'"/)" -- "$cur" ) )
      return 0
    fi
    if [ "$prev" = "push" ]; then
      # shellcheck disable=SC2207
      COMPREPLY=( $( compgen -W "$(ls ~/AndroidStudioProjects/)" -- "$cur" ) )
      return 0
    fi
  fi
}

complete -F _android android