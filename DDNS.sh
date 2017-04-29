#!/bin/sh

API_KEY=""   #API
SECRET_KEY=""  #KEY
INTERFACE=""  #��·�����ж�WAN��ʱ��ָ������--interface ppp0 ָ�����ڣ�û��������
TARGET="ddns.holmesian.org"  #��Ҫ���µ�����
SCKEY="" #��http://sc.ftqq.com/ע����

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