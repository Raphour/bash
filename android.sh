function android() {

  if [ $# -eq 3 ]; then
    cp -r ~/reseau/Perso/Documents/2/S4/Développement\ pour\ applications\ mobiles/TD/"$2"/"$3" ~/reseau/Perso/Documents/2/S4/Développement\ pour\ applications\ mobiles/TD/recovery/

    if [ "$1" = "pull" ]; then
      cp -rf ~/reseau/Perso/Documents/2/S4/Développement\ pour\ applications\ mobiles/TD/"$2"/"$3" ~/AndroidStudioProjects/
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

_android() {
  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  if [ "$COMP_CWORD" -eq 1 ]; then
    # shellcheck disable=SC2207
    COMPREPLY=($(compgen -W "pull push" -- "$cur"))
    return 0
  fi
  # shellcheck disable=SC2086
  if [ $COMP_CWORD -eq 2 ]; then
    # shellcheck disable=SC2207
    COMPREPLY=($(compgen -W "TD" -- "$cur"))
    return 0
  fi
  if [ "$COMP_CWORD" -eq 3 ]; then
    if [ "$prev" = "pull" ]; then
      # shellcheck disable=SC2207
      COMPREPLY=($(compgen -W "$(ls ~/reseau/Perso/Documents/2/S4/Développement\ pour\ applications\ mobiles/TD/"$prev'"/)" -- "$cur"))
      return 0
    fi
    if [ "$prev" = "push" ]; then
      # shellcheck disable=SC2207
      COMPREPLY=($(compgen -W "$(ls ~/AndroidStudioProjects/)" -- "$cur"))
      return 0
    fi
  fi
}

complete -F _android android
