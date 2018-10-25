//package com.obd.raspberry.activity;
//
//import android.app.Activity;
//import android.content.Context;
//import android.os.AsyncTask;
//import android.os.Bundle;
//import android.view.LayoutInflater;
//import android.view.View;
//import android.view.ViewGroup;
//import android.widget.BaseAdapter;
//import android.widget.ListView;
//import android.widget.TextView;
//
//import com.obd.raspberry.ObdData;
//import com.obd.raspberry.R;
//import com.obd.raspberry.async.LoadObdDataAPITask;
//
//import java.util.ArrayList;
//
//public class ObdDataSearchActivityBackup extends Activity {
//
////    public ArrayList<ObdData> list = new ArrayList<ObdData>();
//    public MyListAdapter adapter;
//    private ListView listView;
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_obd_data_search);
//
//        // 리스트뷰에 붙일 어뎁터 클래스 선언
//        adapter = new MyListAdapter(ObdDataSearchActivityBackup.this);
//
//        listView = findViewById(R.id.lv);
//        listView.setAdapter(adapter);
//
//        new LoadObdDataAPITask(ObdDataSearchActivityBackup.this).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
//    }
//
//    public class MyListAdapter extends BaseAdapter {
//
//        private Context context;
//        private ViewHolder viewholder;
//
//        public ArrayList<ObdData> arrayList;
//
//        public MyListAdapter(Context context) {
//            this.context = context;
////            this.arrayList = arrayList;
//            arrayList = new ArrayList<ObdData>();
//        }
//
//        @Override
//        public int getCount() {
//            return arrayList.size();
//        }
//
//        @Override
//        public Object getItem(int position) {
//            return arrayList.get(position);
//        }
//
//        @Override
//        public long getItemId(int position) {
//            return position;
//        }
//
//        @Override
//        public View getView(int position, View convertView, ViewGroup parent) {
//
//            if (convertView == null) {
//                convertView = LayoutInflater.from(context).inflate(R.layout.item, null);
//                viewholder = new MyListAdapter.ViewHolder();
//                viewholder.content_textView = (TextView) convertView.findViewById(R.id.content_textview);
////				viewholder.img_recipe = (ImageView) convertView.findViewById(R.id.img_recipe);
//                convertView.setTag(viewholder);
//            } else {
//                viewholder = (MyListAdapter.ViewHolder) convertView.getTag();
//            }
//
//            StringBuilder sb = new StringBuilder();
////            sb.append("timestamp : " + arrayList.get(position).getTimestamp() + "\n");
////            sb.append("msgcnt : " + arrayList.get(position).getMsgcnt() + "\n");
////            sb.append("cool_temp : " + arrayList.get(position).getCool_temp() + "\n");
////            sb.append("rpm : " + arrayList.get(position).getRpm() + "\n");
////            sb.append("time_after : " + arrayList.get(position).getTime_after() + "\n");
////            sb.append("vehicle_spd : " + arrayList.get(position).getVehicle_spd() + "\n");
////            sb.append("engine_oil_temp : " + arrayList.get(position).getEngine_oil_temp() + "\n");
////            sb.append("fuel_type : " + arrayList.get(position).getFuel_type() + "\n");
////            sb.append("bettery_rmn : " + arrayList.get(position).getBettery_rmn() + "\n");
//
//            sb.append("시간 : " + arrayList.get(position).getTimestamp() + "\n");
//            sb.append("메시지카운트 : " + arrayList.get(position).getMsgcnt() + "\n");
//            sb.append("냉각수 온도 : " + arrayList.get(position).getCool_temp() + "\n");
//            sb.append("rpm : " + arrayList.get(position).getRpm() + "\n");
////            sb.append("time_after : " + arrayList.get(position).getTime_after() + "\n");
//            sb.append("속도 : " + arrayList.get(position).getVehicle_spd() + "\n");
//            sb.append("엔진오일 온도 : " + arrayList.get(position).getEngine_oil_temp() + "\n");
////            sb.append("연로 타입 : " + arrayList.get(position).getFuel_type() + "\n");
////            sb.append("bettery_rmn : " + arrayList.get(position).getBettery_rmn() + "\n");
//
//            viewholder.content_textView.setText(sb.toString());
//
//            return convertView;
//        }
//
//        class ViewHolder {
//            TextView content_textView;
////			ImageView img_recipe;
//        }
//    }
//}
