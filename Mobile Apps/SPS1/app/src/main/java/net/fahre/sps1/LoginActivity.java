package net.fahre.sps1;

import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.util.Log;

import android.content.Intent;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

import static android.view.View.GONE;

//import butterknife.ButterKnife;
//import butterknife.InjectView;


public class LoginActivity extends AppCompatActivity {
    private static final String TAG = "LoginActivity";
    private static final int REQUEST_SIGNUP = 0;

    private static final int CODE_GET_REQUEST = 1024;
    private static final int CODE_POST_REQUEST = 1025;

//    @InjectView(R.id.input_userid) EditText _userId;
//    @InjectView(R.id.input_password) EditText _passwordText;
//    @InjectView(R.id.btn_login) Button _loginButton;
//    @InjectView(R.id.link_signup) TextView _signupLink;
    EditText _userId, _passwordText;
    Button _loginButton;

    ProgressBar progressBar;
    String userId;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        _userId = (EditText) findViewById(R.id.input_userid);
        _passwordText = (EditText) findViewById(R.id.input_password);
        _loginButton = (Button) findViewById(R.id.btn_login);

        progressBar = (ProgressBar) findViewById(R.id.progressBar);
//        ButterKnife.inject(this);

        _loginButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                login();
            }
        });

//        _signupLink.setOnClickListener(new View.OnClickListener() {
//
//            @Override
//            public void onClick(View v) {
//                // Start the Signup activity
//                Intent intent = new Intent(getApplicationContext(), SignupActivity.class);
//                startActivityForResult(intent, REQUEST_SIGNUP);
//            }
//        });
    }

    public void login() {
        Log.d(TAG, "Login");

        if (!validate()) {
            onLoginFailed();
            return;
        }

        _loginButton.setEnabled(false);

        userId = _userId.getText().toString().trim();
        String password = _passwordText.getText().toString().trim();
        String s = "";

        // TODO: Implement your own authentication logic here.
        if (TextUtils.isEmpty(userId)) {
            _userId.setError("Please enter User ID");
            _userId.requestFocus();
            return;
        }

        if (TextUtils.isEmpty(password)) {
            _passwordText.setError("Please enter Password");
            _passwordText.requestFocus();
            return;
        }

        HashMap<String, String> params = new HashMap<>();
        params.put("userid", userId);
        params.put("password", password);

        PerformNetworkRequest request = new PerformNetworkRequest(Api.URL_LOGIN, params, CODE_POST_REQUEST);
        request.execute();

        onLogin(s);

//        new android.os.Handler().postDelayed(
//                new Runnable() {
//                    public void run() {
//                        // On complete call either onLoginSuccess or onLoginFailed
////                        onLogin();
//                        // onLoginFailed();
//                    }
//                }, 3000);
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == REQUEST_SIGNUP) {
            if (resultCode == RESULT_OK) {

                // TODO: Implement successful signup logic here
                // By default we just finish the Activity and log them in automatically
                this.finish();
            }
        }
    }

    @Override
    public void onBackPressed() {
        // disable going back to the MainActivity
        moveTaskToBack(true);
    }

    public void onLogin(String s) {

        final ProgressDialog progressDialog = new ProgressDialog(LoginActivity.this);
        progressDialog.setIndeterminate(true);
        progressDialog.setMessage("Authenticating...");
        progressDialog.show();

        _loginButton.setEnabled(true);

        if(s.equals("Login success")){
            finish();
            progressDialog.dismiss();
            Intent intent = new Intent(LoginActivity.this, MainActivity.class);
            intent.putExtra("loggedin_userid", userId);
            startActivity(intent);
        }
        else{
            progressDialog.dismiss();
            _loginButton.setEnabled(true);
        }
    }

    public void onLoginFailed() {
        Toast.makeText(getBaseContext(), "Login failed", Toast.LENGTH_LONG).show();

        _loginButton.setEnabled(true);
    }

    public boolean validate() {
        boolean valid = true;

        String userid = _userId.getText().toString();
        String password = _passwordText.getText().toString();

        if (userid.isEmpty()) {
            _userId.setError("User ID tidak boleh kosong");
            valid = false;
        } else {
            _userId.setError(null);
        }

        if (password.isEmpty() || password.length() < 3) {
            _passwordText.setError("minimal 3 alphanumeric characters");
            valid = false;
        } else {
            _passwordText.setError(null);
        }

        return valid;
    }

    private class PerformNetworkRequest extends AsyncTask<Void, Void, String> {
        String url;
        HashMap<String, String> params;
        int requestCode;

        PerformNetworkRequest(String url, HashMap<String, String> params, int requestCode) {
            this.url = url;
            this.params = params;
            this.requestCode = requestCode;
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            progressBar.setVisibility(View.VISIBLE);
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            progressBar.setVisibility(GONE);
            try {
                JSONObject object = new JSONObject(s);
                if (!object.getBoolean("error")) {
                    Toast.makeText(getApplicationContext(), object.getString("message"), Toast.LENGTH_SHORT).show();
                    onLogin(object.getString("message"));
                }
                else {
                    Toast.makeText(getApplicationContext(), object.getString("message"), Toast.LENGTH_SHORT).show();
                    onLogin(object.getString("message"));
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        @Override
        protected String doInBackground(Void... voids) {
            RequestHandler requestHandler = new RequestHandler();

            if (requestCode == CODE_POST_REQUEST)
                return requestHandler.sendPostRequest(url, params);


            if (requestCode == CODE_GET_REQUEST)
                return requestHandler.sendGetRequest(url);

            return null;
        }
    }
}