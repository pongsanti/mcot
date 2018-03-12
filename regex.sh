SET="^SET .*[^M]$"
SET50="^SET50 .*[^M]$"

fn_match()
{
  if [[ "$1" =~ $SET ]]; then
    echo -e "\tfound SET!"
    echo "$(date) $1" >> log.txt
    return 1
  elif [[ "$1" =~ $SET50 ]]; then
    echo -e '\tfound SET50!'
    echo "$(date) $1" >> log.txt
    return 2
  fi
  return 0
}
