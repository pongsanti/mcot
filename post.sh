source ./capture_config

post()
{
  curl -X POST -F "article[text]=$1" $POST_URL
}
