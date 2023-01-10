import { getLineCurrentMsgCount, createMsgFromLineRes, postSlackWebhookApi } from './utils.js'
// import fetch from 'node-fetch';
import 'date-utils'
// const env = process.env;
// let distSlackMsg;

export const handler = async (event) => {
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
