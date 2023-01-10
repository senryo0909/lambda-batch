import { getLineCurrentMsgCount, createMsgFromLineRes, postSlackWebhookApi } from './utils.js'
// import fetch from 'node-fetch';
import 'date-utils'
// const env = process.env;
// let distSlackMsg;

export const handler = async (event) => {

    // LineAPI
    // const getLineCurrentMsgCount = async () => {
    //     const date = new Date().toFormat('yyyyMMdd');
    //     const params = `?date=${date}`;
    //     try{
    //         const resFromLineResponse = await fetch(`${env.lineApiUrl}${params}`, {
    //                 headers: { 'Authorization': `Bearer ${env.lineApiToken}` }
    //               });
    //         const { totalUsage } = await resFromLineResponse.json();
    //         return totalUsage;
    //     } catch(err){
    //         throw new err("LINEリクエスト失敗")
    //     }
    // }

    // Lineメッセージ残数とメッセージ対応付
    // const createMsgFromLineRes = async (resData) => {
    //     if(env.threshold < resData || env.threshold == resData) {
    //         distSlackMsg = `当月のpushメッセージ数が${env.threshold}以上! :alert: \n 追加申請をお願いします!当月pushメッセージ数:${resData}`;
    //     } else if(env.threshold > resData) {
    //         distSlackMsg = `当月のpushメッセージ数は${env.threshold}以内です。:sunny: \n 当月pushメッセージ数:${resData}`;
    //     }
    //     return distSlackMsg;
    // }
    
    // Slackのwebhook実行
    // const postSlackWebhookApi = async (distSlackMsg) => {
    //     let headers = {
    //         "Content-Type": "application/json",
    //         "Authorization": `Bearer ${env.slackBotToken}`
    //     }
    //     let body = {
    //         channel: env.slackChannelId,
    //         text: distSlackMsg
    //     }
    //     try{
    //         const webHookUrl = env.webHookUrl;
    //         const res = await fetch(webHookUrl, {method: 'POST', body: JSON.stringify(body), headers: headers});
    //         if(!res.ok) throw new Error("slackチャネルへのメッセージ送信に失敗しました");
    //     } catch(e) {
    //         error.log(e);
    //     }
    // }

    try {
        // LineAPI
        const totalUsageCounts = await getLineCurrentMsgCount()
        // msgの整形
        const result = await createMsgFromLineRes(totalUsageCounts);
        // slackのWebhook
        await postSlackWebhookApi(result);
    } catch(e) {
        console.log(`エラー！${e}`);
    }
}
