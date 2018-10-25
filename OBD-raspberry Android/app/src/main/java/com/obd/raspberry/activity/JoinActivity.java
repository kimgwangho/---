package com.obd.raspberry.activity;

import android.app.Activity;
import android.os.Bundle;
import android.text.InputFilter;
import android.text.Spanned;
import android.view.View;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.Toast;

import com.obd.raspberry.R;
import com.obd.raspberry.async.JoinAPITask;

import java.util.regex.Pattern;

public class JoinActivity extends Activity  {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_join);

        ((EditText) findViewById(R.id.editId)).setFilters(new InputFilter[] {filterAlphaNum});
        ((EditText) findViewById(R.id.editPwd)).setFilters(new InputFilter[] {filterAlphaNum});

        findViewById(R.id.btnJoin).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                doJoin();
            }
        });

    }

    // 영문만 허용 (숫자 포함)
    protected InputFilter filterAlpha = new InputFilter() {
        public CharSequence filter(CharSequence source, int start, int end, Spanned dest, int dstart, int dend) {
            Pattern ps = Pattern.compile("^[a-zA-Z0-9]+$");

            if (!ps.matcher(source).matches()) {
                Toast.makeText(getBaseContext(), "영숫자만 입력가능합니다.", Toast.LENGTH_SHORT).show();
                return "";
            }

            return null;
        }
    };

    // 영문만 허용 (숫자 포함)
    protected InputFilter filterAlphaNum = new InputFilter() {
        public CharSequence filter(CharSequence source, int start, int end, Spanned dest, int dstart, int dend) {
            Pattern ps = Pattern.compile("^[a-zA-Z0-9]+$");

            if (!ps.matcher(source).matches()) {
                Toast.makeText(getBaseContext(), "영숫자만 입력가능합니다.", Toast.LENGTH_SHORT).show();
                return "";
            }
            return null;
        }
    };

    private void doJoin() {

        String id = ((EditText) (findViewById(R.id.editId))).getText().toString();
        String pwd = ((EditText) (findViewById(R.id.editPwd))).getText().toString();
        String name = ((EditText) (findViewById(R.id.editName))).getText().toString();
        String hpNum = ((EditText) (findViewById(R.id.editHpNum))).getText().toString();

        if (id == null || pwd == null || name == null || hpNum == null /*|| select_language_idx == null || select_grade == null*/) {
            Toast.makeText(JoinActivity.this, "입력되지 않은 정보가 있습니다.", Toast.LENGTH_SHORT).show();
            return;
        }

        // 회원가입 API
        JoinAPITask t = new JoinAPITask(JoinActivity.this);
        t.execute(id, pwd, name, hpNum);
    }



}
