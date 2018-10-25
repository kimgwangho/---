package com.obd.raspberry.activity;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Paint;
import android.os.Bundle;
import android.text.InputFilter;
import android.text.Spanned;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.obd.raspberry.util.SPUtil;
import com.google.firebase.iid.FirebaseInstanceId;
import com.obd.raspberry.R;
import com.obd.raspberry.async.LoginAPITask;

import java.util.regex.Pattern;

public class LoginActivity extends Activity {

    private String loginId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        ((EditText) findViewById(R.id.editHpNum)).setFilters(new InputFilter[] {filter});

        findViewById(R.id.btnLogin).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                doLogin();
            }
        });

        findViewById(R.id.btnJoin).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(LoginActivity.this, JoinActivity.class));
            }
        });

    }

    @Override
    protected void onStart() {
        super.onStart();

        loginId = SPUtil.getSharedPreference(this, SPUtil.KEY_LOGIN_ID);

        if (loginId != null && !loginId.equals(""))
        {
//            findViewById(R.id.btnJoin).setEnabled(false);
//            findViewById(R.id.btnLogin).setEnabled(false);
            startActivity(new Intent(LoginActivity.this, MainActivity.class));
            finish();
        }
//        else
//        {
//            findViewById(R.id.btnJoin).setEnabled(true);
//            findViewById(R.id.btnLogin).setEnabled(true);
//        }
    }

    // 영문만 허용 (숫자 포함)
    protected InputFilter filter = new InputFilter() {
        public CharSequence filter(CharSequence source, int start, int end, Spanned dest, int dstart, int dend) {
            Pattern ps = Pattern.compile("^[a-zA-Z0-9]+$");

            if (!ps.matcher(source).matches()) {
                return "";
            }
            return null;
        }
    };


    private void doLogin() {
        String id = ((EditText) (findViewById(R.id.editHpNum))).getText().toString();
        String pwd = ((EditText) (findViewById(R.id.editPwd))).getText().toString();
        String token = FirebaseInstanceId.getInstance().getToken();

        if (id == null || pwd == null || token == null) {
            Toast.makeText(LoginActivity.this, "입력되지 않은 정보가 있습니다.", Toast.LENGTH_SHORT).show();
            return;
        }

        LoginAPITask t = new LoginAPITask(LoginActivity.this);
        t.execute(id, pwd, token);
    }
}
