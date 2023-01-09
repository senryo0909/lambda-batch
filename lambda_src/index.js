const { IncomingWebhook } = require("@slack/webhook");
const fetch = require('node-fetch'); 
require('date-utils');
const webHook = new IncomingWebhook("https://hooks.slack.com/services/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");
const apiToken = "kBAxlQ6FkEoG0syM8/xvSrnRa8iGd7AytyLa7DelOWsDg3dtnMSmgk9FrudaFrX6Xn/sP9taU5d74m9V4GRipczAxKlt1VQWmChqWoCF7YOFqIUgfC57j5Vh/xHSx8z9x2Mjqo2MMWeSuMWIYyodnwdB04t89/1O/w1cDnyilFU=";
const date = new Date().toFormat('yyyyMMdd');
const params = `?date=${date}`;

(async () => {
    try {
        const resFromLineResponse = await fetch(`https://api.line.me/v2/bot/message/quota/consumption${params}`, {
            headers: { 'Authorization': `Bearer ${apiToken}` }
          });
        const { totalUsage } = await resFromLineResponse.json()
        console.log(process.env);

        await webHook.send({
            text: `Line response are ${totalUsage}`,
            username: "Username", 
            icon_emoji: ":ghost:", 
        })
    } catch(e) {
        console.log(e);
    }
})();

