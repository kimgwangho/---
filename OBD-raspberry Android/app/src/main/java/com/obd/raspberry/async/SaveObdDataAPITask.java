package com.obd.raspberry.async;

import android.content.Context;
import android.os.AsyncTask;
import android.widget.Toast;

import com.obd.raspberry.Result;
import com.obd.raspberry.activity.JoinActivity;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class SaveObdDataAPITask extends AsyncTask<String, Void, Result> {

    private Result result;
    private Context context;

        private final static String URL = "http://meadow142.cafe24.com/insert_obd_data.json";
//    private final static String URL = "http://211.177.82.117:8080/mango/insert_obd_data.json";

    public Result setObdData(String timestamp, String msgcnt, String cool_temp, String rpm, String time_after, String vehicle_spd, String engine_oil_temp, String fuel_type, String bettery_rmn, String remainOil, String consumeOil) {

        OkHttpClient client = new OkHttpClient();
        RequestBody body = null;
        body = new FormBody.Builder()
                .add("timestamp", timestamp)
                .add("msgcnt", msgcnt)
//                .add("auth", auth)
                .add("cool_temp", cool_temp)
                .add("rpm", rpm)
                .add("time_after", time_after)
                .add("vehicle_spd", vehicle_spd)
                .add("engine_oil_temp", engine_oil_temp)
                .add("fuel_type", fuel_type)
                .add("bettery_rmn", bettery_rmn)
                .add("remain_oil", remainOil)
                .add("consume_oil", consumeOil)
                .build();

        //request
        Request request = new Request.Builder()
                .url(URL)
                .post(body)
                .build();

        Response response = null;

        try {
            response = client.newCall(request).execute();
        } catch (IOException e) {
            e.printStackTrace();
        }


        String bodyString = "";
        try {

//            assert response != null;
//            if(response.request().url().host().contains("hexa.nmn.io")) {
//                logger.info("not logged in hexa");
//            } else {

            if (response == null) return null;


            bodyString = response.body().string();
//            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        JSONObject json = null;
        Result result = null;

        try {
            json = new JSONObject(bodyString);
            result = parseJSON(json);
        } catch (JSONException e) {
            e.printStackTrace();
        }


        return result;

    }


    private Result parseJSON(JSONObject json) throws JSONException {

        Result w = new Result();

//        w.setTemprature(json.getJSONObject("main").getInt("temp"));
        w.setReuslt(json.getString("result"));
//        w.setCloudy();
        return w;

    }

    public SaveObdDataAPITask(Context context) {
        this.context = context;
    }

    @Override
    public Result doInBackground(String... params) {

//        String id = params[0];
//        String pwd = params[1];
//        String name = params[2];
//        String hpNum = params[3];

        // API 호출
//        result = setObdData(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
        result = setObdData(params[0], params[1], params[2], params[3], params[4], params[5], params[6], "", "", params[9], params[10]);
        //System.out.println("Weather : "+result.getTemprature());

        return result;

    }

    @Override
    protected void onPostExecute(Result result) {
        super.onPostExecute(result);

        if (result == null) return;

        if (result.getReuslt().equals("0")) {
//            ((JoinActivity) context).finish();
//            Toast.makeText(context, "저장완료", Toast.LENGTH_SHORT).show();
        } else {
//            Toast.makeText(context, "저장실패", Toast.LENGTH_SHORT).show();
        }

    }
}



