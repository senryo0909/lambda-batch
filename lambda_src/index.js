// const { IncomingWebhook } = require("@slack/webhook");
// import { IncomingWebhook } from "@slack/webhook";
// const fetch = require('node-fetch'); 
import fetch from 'node-fetch';
// import 'date-utils' from 'date-utils';
import 'date-utils'
import { WebClient } from '@slack/web-api';
// const webHook = new IncomingWebhook("https://hooks.slack.com/services/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");
const apiToken = "kBAxlQ6FkEoG0syM8/xvSrnRa8iGd7AytyLa7DelOWsDg3dtnMSmgk9FrudaFrX6Xn/sP9taU5d74m9V4GRipczAxKlt1VQWmChqWoCF7YOFqIUgfC57j5Vh/xHSx8z9x2Mjqo2MMWeSuMWIYyodnwdB04t89/1O/w1cDnyilFU=";
const date = new Date().toFormat('yyyyMMdd');
const params = `?date=${date}`;
const botToken = "xoxb-16800578758-4637093126176-903mEa0aD7jCcZItUzFAHWvG";

export const handler = async (event) => {
    try {
        const resFromLineResponse = await fetch(`https://api.line.me/v2/bot/message/quota/consumption${params}`, {
            headers: { 'Authorization': `Bearer ${apiToken}` }
          });
        const { totalUsage } = await resFromLineResponse.json()
        console.log(totalUsage);

        const client = new WebClient(botToken);
        const text = totalUsage;
        const channel = "Takuy Sato"
        const res = await client.chat.postMessage({ channel, text })
    } catch(e) {
        console.log(`エラー！${e}`);
    }
}
