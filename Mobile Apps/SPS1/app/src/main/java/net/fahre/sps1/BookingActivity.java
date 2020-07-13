package net.fahre.sps1;

import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.support.v4.app.DialogFragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Text;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

import static android.view.View.GONE;

public class BookingActivity extends AppCompatActivity implements DatePickerDialog.OnDateSetListener, TimePickerDialog.OnTimeSetListener {

    public static final int FLAG_DATE_FROM = 0;
    public static final int FLAG_DATE_UNTIL = 1;
    public static final int FLAG_TIME_FROM = 0;
    private static final int CODE_GET_REQUEST = 1024;
    private static final int CODE_POST_REQUEST = 1025;

    private int flag = 0;
    ProgressBar progressBar;

    EditText editTextDateFrom, editTextDateUntil, editTextTimeFrom, editTextTimeUntil;
    TextView textViewSlotId, textViewUserId;

    public void setFlag(int i) {
        flag = i;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_booking);

        Intent intent = getIntent();
        Bundle b = intent.getExtras();

        editTextDateFrom = (EditText) findViewById(R.id.editTextDateFrom);
        editTextDateUntil = (EditText) findViewById(R.id.editTextDateUntil);
        editTextTimeFrom = (EditText) findViewById(R.id.editTextTimeFrom);
        editTextTimeUntil = (EditText) findViewById(R.id.editTextTimeUntil);
        Button buttonDF = (Button) findViewById(R.id.buttonDateFrom);
        Button buttonTF = (Button) findViewById(R.id.buttonTimeFrom);
        Button buttonDU = (Button) findViewById(R.id.buttonDateUntil);
        Button buttonTU = (Button) findViewById(R.id.buttonTimeUntil);
        Button buttonB = (Button) findViewById(R.id.buttonBook);
        progressBar = (ProgressBar) findViewById(R.id.progressBar);
        textViewSlotId = (TextView) findViewById(R.id.textViewSlotId);
        textViewUserId = (TextView) findViewById(R.id.textViewUserId);

        if(b!=null) {
            int slotid = (int) b.get("slotid");
            String userId = (String) b.get("userid");
            textViewSlotId.setText(String.valueOf(slotid));
            textViewUserId.setText(userId);
        }

        buttonB.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                createBooking();
                finish();
            }
        });

        buttonDF.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setFlag(0);
                DialogFragment datePicker1 = new DatePickerFragment();
                datePicker1.show(getSupportFragmentManager(), "date picker");
            }
        });

        buttonTF.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setFlag(0);
                DialogFragment timePicker1 = new TimePickerFragment();
                timePicker1.show(getSupportFragmentManager(), "time picker");
            }
        });

        buttonDU.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setFlag(1);
                DialogFragment datePicker2 = new DatePickerFragment();
                datePicker2.show(getSupportFragmentManager(), "date picker");
            }
        });

        buttonTU.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setFlag(1);
                DialogFragment timePicker2 = new TimePickerFragment();
                timePicker2.show(getSupportFragmentManager(), "time picker");
            }
        });
    }

    @Override
    public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, month);
        c.set(Calendar.DAY_OF_MONTH, dayOfMonth);
        SimpleDateFormat formattingdate = new SimpleDateFormat("MM/dd/yyyy");
        String currentDateString = formattingdate.format(c.getTime());

        if(flag == FLAG_DATE_FROM) {
            EditText textDateFrom = (EditText) findViewById(R.id.editTextDateFrom);
            textDateFrom.setText(currentDateString);
        }
        else if (flag == FLAG_DATE_UNTIL) {
            EditText textDateUntil = (EditText) findViewById(R.id.editTextDateUntil);
            textDateUntil.setText(currentDateString);
        }
    }

    public void onTimeSet(TimePicker view, int hourOfDay, int minute) {
        if(flag == FLAG_DATE_FROM) {
            EditText textTimeFrom = (EditText) findViewById(R.id.editTextTimeFrom);
            textTimeFrom.setText(hourOfDay + ":" + minute + ":00");
        }
        else if (flag == FLAG_DATE_UNTIL) {
            EditText textTimeUntil = (EditText) findViewById(R.id.editTextTimeUntil);
            textTimeUntil.setText(hourOfDay + ":" + minute + ":00");
        }
    }

    private void createBooking() {
        String bookFromDate = editTextDateFrom.getText().toString().trim();
        String bookUntilDate = editTextDateUntil.getText().toString().trim();
        String bookFromTime = editTextTimeFrom.getText().toString().trim();
        String bookUntilTime = editTextTimeUntil.getText().toString().trim();
        String textViewSlotIdValue = textViewSlotId.getText().toString();
        int slotId = Integer.parseInt(textViewSlotIdValue);
        String userId = textViewUserId.getText().toString().trim();

        if (TextUtils.isEmpty(bookFromDate)) {
            editTextDateFrom.setError("Please enter Booking From Date");
            editTextDateFrom.requestFocus();
            return;
        }

        if (TextUtils.isEmpty(bookFromTime)) {
            editTextTimeFrom.setError("Please enter Booking From Time");
            editTextTimeFrom.requestFocus();
            return;
        }

        if (TextUtils.isEmpty(bookUntilDate)) {
            editTextDateUntil.setError("Please enter Booking Until Date");
            editTextDateUntil.requestFocus();
            return;
        }

        if (TextUtils.isEmpty(bookUntilTime)) {
            editTextTimeUntil.setError("Please enter Booking Until Time");
            editTextTimeUntil.requestFocus();
            return;
        }

        HashMap<String, String> params = new HashMap<>();
        params.put("bookfromdate", bookFromDate);
        params.put("bookfromtime", bookFromTime);
        params.put("bookuntildate", bookUntilDate);
        params.put("bookuntiltime", bookUntilTime);
        params.put("slotid", String.valueOf(slotId));
        params.put("userid", userId);

        PerformNetworkRequest request = new PerformNetworkRequest(Api.URL_CREATE_BOOKING, params, CODE_POST_REQUEST);
        request.execute();
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
                }
                else {
                    Toast.makeText(getApplicationContext(), object.getString("message"), Toast.LENGTH_SHORT).show();
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

