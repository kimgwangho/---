package com.obd.raspberry.async;

import android.content.Context;
import android.os.AsyncTask;
import android.widget.Toast;

import com.obd.raspberry.Result;
import com.obd.raspberry.activity.JoinActivity;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class JoinAPITask extends AsyncTask<String, Void, Result> {

    private Result result;
    private Context context;

    private final static String URL = "http://meadow142.cafe24.com/insert_account_info.json";
//    private final static String URL = "http://211.177.82.117:8080/mango/insert_account_info.json";

    public Result getJoin(String id, String pwd, String name, String hpNum) {

        OkHttpClient client = new OkHttpClient();
        RequestBody body = null;
        body = new FormBody.Builder()
                .add("user_id", id)
                .add("pwd", pwd)
//                .add("auth", auth)
                .add("name", name)
                .add("hp_num", hpNum)
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

            assert response != null;
//            if(response.request().url().host().contains("hexa.nmn.io")) {
//                logger.info("not logged in hexa");
//            } else {
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

    public JoinAPITask(Context context) {
        this.context = context;
    }

    @Override
    public Result doInBackground(String... params) {

        String id = params[0];
        String pwd = params[1];
        String name = params[2];
        String hpNum = params[3];

        // API 호출
        result = getJoin(id, pwd, name, hpNum);
        //System.out.println("Weather : "+result.getTemprature());

        return result;

    }

    @Override
    protected void onPostExecute(Result result) {
        super.onPostExecute(result);

        if (result.getReuslt().equals("0")) {
            ((JoinActivity) context).finish();
            Toast.makeText(context, "가입완료", Toast.LENGTH_SHORT).show();
        } else {
            Toast.makeText(context, "가입실패", Toast.LENGTH_SHORT).show();
        }

    }
}



