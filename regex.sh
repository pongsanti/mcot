SET="^SET .*[^M]$"
SET100="^SET100 .*[^M]$"

fn_match()
{
  if [[ "$1" =~ $SET ]]; then
    echo -e "\tfound SET!"
    echo "$(date) $1" >> log.txt
    return 1
  elif [[ "$1" =~ $SET100 ]]; then
    echo -e '\tfound SET100!'
    echo "$(date) $1" >> log.txt
    return 2
  fi
  return 0
}
