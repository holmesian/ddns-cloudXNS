#!/bin/sh

API_KEY=""   #API
SECRET_KEY=""  #KEY
INTERFACE=""  #在路由上有多WAN的时候指定，用--interface ppp0 指定网口，没有请留空
TARGET="ddns.holmesian.org"  #需要更新的域名
SCKEY="" #到http://sc.ftqq.com/注册获得

URL_D="https://www.cloudxns.net/api2/ddns"
URL_S="http://sc.ftqq.com/$SCKEY.send?text=DDNS-update&desp="
DATE=$(date)

DdnsCheck() {
        PARAM_BODY="{\"domain\":\"${1}\"}"
        if [ x."${2}" != "x." ]; then
                PARAM_BODY="{\"domain\":\"${2}.${1}\"}"
        fi
        echo $PARAM_BODY
        HMAC_U=$(echo -n "$API_KEY$URL_D$PARAM_BODY$DATE$SECRET_KEY"|md5sum|cut -d" " -f1)
        RESULT=$(curl $INTERFACE -k -s $URL_D --data $PARAM_BODY -H "API-KEY: $API_KEY" -H "API-REQUEST-DATE: $DATE" -H "API-HMAC: $HMAC_U" -H 'Content-Type: application/json')
        echo $RESULT

        if [ $(echo -n "$RESULT"|grep -o "message\":\"success\""|wc -l) = 1 ];then
            echo "$(date) -- Update success"
            RESULTs="$TARGET-Update-success"
        else
            echo "$(date) -- Update failed"
            RESULTs="$TARGET-DDNS-Update-failed"
        fi
        RESULT=$(curl  -k -s $URL_S$RESULTs)
}

DdnsCheck "$TARGET"