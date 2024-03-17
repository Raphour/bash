function s4() {
  if [ $# -eq 0 ]; then
    cd "/var/home/E226767L/reseau/Perso/Documents/2/S4" || return 0
  elif [ $# -ge 1 ]; then
    for dir in /var/home/E226767L/reseau/Perso/Documents/2/S4/*; do
      dir_minuscule=$(tr '[:upper:]' '[:lower:]' <<<"$dir")
      arg_minuscule=$(tr '[:upper:]' '[:lower:]' <<<"$1")
      if [[ $dir_minuscule =~ .*$arg_minuscule.* ]]; then
        cd "$dir" || return 0
        if [ $# -eq 2 ]; then
          arg_minuscule=$(tr '[:upper:]' '[:lower:]' <<<"$2")
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
