import fetch from 'node-fetch';
import 'date-utils'
// import { WebClient, ErrorCode } from '@slack/web-api';
const apiToken = "kBAxlQ6FkEoG0syM8/xvSrnRa8iGd7AytyLa7DelOWsDg3dtnMSmgk9FrudaFrX6Xn/sP9taU5d74m9V4GRipczAxKlt1VQWmChqWoCF7YOFqIUgfC57j5Vh/xHSx8z9x2Mjqo2MMWeSuMWIYyodnwdB04t89/1O/w1cDnyilFU=";
const date = new Date().toFormat('yyyyMMdd');
const params = `?date=${date}`;
const botToken = "xoxb-16800578758-4637093126176-903mEa0aD7jCcZItUzFAHWvG";

export const handler = async (event) => {
    // (async () => {
        try {
            const resFromLineResponse = await fetch(`https://api.line.me/v2/bot/message/quota/consumption${params}`, {
                headers: { 'Authorization': `Bearer ${apiToken}` }
              });
            const { totalUsage } = await resFromLineResponse.json()
            console.log(totalUsage);
            const channel = "D02SA1FKTUP";
            let headers = {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${botToken}`
            }
            let body = {
                channel: channel,
                text: totalUsage
            }
            const webHookUrl = "https://hooks.slack.com/services/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";
            const res = await fetch(webHookUrl, {method: 'POST', body: JSON.stringify(body), headers: headers});
            // const client = new WebClient(botToken);
            // const text = totalUsage;
            // const res = await client.chat.postMessage({ text: text, channel: channel })
            console.log(res.data);
        } catch(e) {
            // if(e.code === ErrorCode.PlatformError){
            //     console.log(e.data);
            // }
            console.log(`エラー！${e}`);
        }
    // })();
}
