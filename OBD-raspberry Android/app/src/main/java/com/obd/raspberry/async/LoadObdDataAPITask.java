package com.obd.raspberry.async;

import android.app.Activity;
import android.content.Context;
import android.os.AsyncTask;
import android.widget.Toast;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.obd.raspberry.ObdData;
import com.obd.raspberry.activity.ObdDataSearchActivity;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class LoadObdDataAPITask extends AsyncTask<String, Void, JSONArray> {

        private final static String URL = "http://meadow142.cafe24.com/select_obd_data_list.json";
//    private final static String URL = "http://211.177.82.117:8080/mango/select_obd_data_list.json";

    private ObdDataSearchActivity activity;

    public LoadObdDataAPITask(ObdDataSearchActivity activity)
    {
        this.activity = activity;
    }

    private JSONArray getObdInfo() {

        OkHttpClient client = new OkHttpClient();
        RequestBody body = new FormBody.Builder()
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

            if (response == null) return null;

            bodyString = response.body().string();
//            }
        } catch (IOException e) {
            e.printStackTrace();
        }

//        JSONObject json = null;
        JSONArray result = null;

        try {
            result = new JSONArray(bodyString);
//            result = parseJSON(json);
        } catch (JSONException e) {
            e.printStackTrace();
        }


        return result;
    }

    private JSONArray parseJSON(JSONObject json) throws JSONException {

//        Result w = new Result();
//
////        w.setTemprature(json.getJSONObject("main").getInt("temp"));
//        w.setReuslt(json.getString("result"));
////        w.setCloudy();
//        return w;


        JSONArray jsonArray = json.getJSONArray("");

        return jsonArray;
    }

    @Override
    public JSONArray doInBackground(String... params) {

//        PrdctInfoAPIClient client = new PrdctInfoAPIClient();

        // API 호출
        JSONArray result = getObdInfo();
        //System.out.println("Weather : "+result.getTemprature());

        return result;

    }

    @Override
    protected void onPostExecute(JSONArray jsonArray) {
        super.onPostExecute(jsonArray);

        if (jsonArray == null)
        {
            Toast.makeText(activity, "서버오류가 발생하였습니다.", Toast.LENGTH_SHORT).show();
            return;
        }

        ArrayList<ObdData> list = new Gson().fromJson(jsonArray.toString(), new TypeToken<List<ObdData>>() {
        }.getType());

        if (list != null && list.size() > 0)
        {
//            activity.adapter.arrayList = list;
//            activity.adapter.notifyDataSetChanged();



            activity.setData(list.get(list.size()-1));
        }
        else
        {
//            if(listener != null) listener.onFail();
        }

//        if (context != null && context instanceof PrdctBuyActivity)
//        {
//            ((PrdctBuyActivity)context).adapter.setmItems(list);
//            ((PrdctBuyActivity)context).adapter.notifyDataSetChanged();
//        }
    }
}



