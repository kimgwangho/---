package com.obd.raspberry.async;

import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.widget.Toast;

import com.obd.raspberry.JsonUtil;
import com.obd.raspberry.Result;
import com.obd.raspberry.activity.LoginActivity;
import com.obd.raspberry.activity.MainActivity;
import com.obd.raspberry.util.SPUtil;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class LoginAPITask extends AsyncTask<String, Void, Result> {

    private Result result;
    private Context context;

    private final static String URL = "http://meadow142.cafe24.com/get_account_info.json";
//    private final static String URL = "http://211.177.82.117:8080/mango/get_account_info.json";
    private String mId;

    public LoginAPITask(Context context) {
        this.context = context;
    }

    private Result getLogin(String id, String pwd) {

        OkHttpClient client = new OkHttpClient();
        RequestBody body = new FormBody.Builder()
                .add("user_id", id)
                .add("pwd", pwd)
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

    @Override
    public Result doInBackground(String... params) {

        mId = params[0];
        String pwd = params[1];

        // API 호출
        result = getLogin(mId, pwd);
        //System.out.println("Weather : "+result.getTemprature());

        return result;

    }

    @Override
    protected void onPostExecute(Result result) {
        super.onPostExecute(result);

        if (result.getReuslt().equals("1")) {
            Toast.makeText(context, "로그인 성공", Toast.LENGTH_SHORT).show();

            //성공이면 id 저장
            SPUtil.putSharedPreference(context, SPUtil.KEY_LOGIN_ID, mId);

            if (context instanceof LoginActivity)
            {
                context.startActivity(new Intent(context, MainActivity.class));
                ((LoginActivity) context).finish();
            }

        } else {
            Toast.makeText(context, "로그인 실패", Toast.LENGTH_SHORT).show();
        }
    }
}



