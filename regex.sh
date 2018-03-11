SET="^SET .*[^M]$"
SET100="^SET100 .*[^M]$"

if [[ "$1" =~ $SET ]]; then
  echo "SET!"
  echo "$(date) $1" >> log.txt
elif [[ "$1" =~ $SET100 ]]; then
  echo 'SET100!'
  echo "$(date) $1" >> log.txt
fi
