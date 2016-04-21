env | sort | awk -v P="$1" 'BEGIN{FS=OFS="=";if(P!=""){P=P " "}}/TOKEN/{$2="********"}{print P $0}'
