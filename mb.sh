function mb() {
  commande=$(history -w /dev/stdout | tail -2 | head -1)
  eval "sudo $commande"
}
