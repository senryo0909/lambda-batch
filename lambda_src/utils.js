import fetch from 'node-fetch';
import 'date-utils'
let distSlackMsg;
const env = process.env;
// LineAPI
export const getLineCurrentMsgCount = async () => {
    const date = new Date().toFormat('yyyyMMdd');
    const params = `?date=${date}`;
    try{
        const resFromLineResponse = await fetch(`${env.lineApiUrl}${params}`, {
                headers: { 'Authorization': `Bearer ${env.lineApiToken}` }
              });
        const { totalUsage } = await resFromLineResponse.json();
        return totalUsage;
    } catch(err){
        console.error(err)
    }
}

// Lineメッセージ残数とメッセージ対応付
export const createMsgFromLineRes = async (resData) => {
    if(env.threshold < resData || env.threshold == resData) {
        distSlackMsg = `当月のpushメッセージ数が${env.threshold}以上! :alert: \n 追加申請をお願いします!当月pushメッセージ数:${resData}`;
    } else if(env.threshold > resData) {
        let leftAvailMsgNum = env.threshold - resData;
        distSlackMsg = `当月のpushメッセージ数は${env.threshold}以内です。:sunny: \n 残pushメッセージ数:${leftAvailMsgNum}`;
    }
    return distSlackMsg;
}

// Slackのwebhook実行
export const postSlackWebhookApi = async (distSlackMsg) => {
    let headers = {
        "Content-Type": "application/json",
        // "Authorization": `Bearer ${env.slackBotToken}`
    }
    let body = {
        channel: env.slackChannelId,
        text: distSlackMsg
    }
    try{
        const webHookUrl = env.webHookUrl;
        const res = await fetch(webHookUrl, {method: 'POST', body: JSON.stringify(body), headers: headers});
        if(!res.ok) throw new Error("slackチャネルへのメッセージ送信に失敗しました");
    } catch(err) {
        console.error(err);
    }
}