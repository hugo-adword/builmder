# Telegram send message helper method
tg(){
	bot_api=$bot_api 
	your_telegram_id=$1 
	msg=$2
	curl -s "https://api.telegram.org/bot${bot_api}/sendmessage" --data "text=$msg&chat_id=${your_telegram_id}&parse_mode=html"
}
id=-1001273969756

cd /tmp
com () 
{ 
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com ccache 1 # Compression level 1, its enough

tg $id "DerpFest Compile Status:
ccache uploading started at:- $(date)."

time rclone copy ccache.tar.gz drive:ccache -P 

tg $id "DerpFest Compile Status:
ccache uploaded at:- $(date)."
