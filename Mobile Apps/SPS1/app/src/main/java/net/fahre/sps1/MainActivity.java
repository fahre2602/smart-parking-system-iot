package net.fahre.sps1;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.RatingBar;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static android.view.View.GONE;

public class MainActivity extends AppCompatActivity {

    private static final int CODE_GET_REQUEST = 1024;
    private static final int CODE_POST_REQUEST = 1025;

    EditText editTextHeroId, editTextName, editTextRealname;
    ProgressBar progressBar;
    ListView listView;
    SwipeRefreshLayout pullToRefresh;
    Button buttonAddUpdate;
    String userId;
    TextView loggedin_userId;

    List<Slot> slotList;

    boolean isUpdating = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        progressBar = (ProgressBar) findViewById(R.id.progressBar);
        listView = (ListView) findViewById(R.id.listViewSlots);
        pullToRefresh = (SwipeRefreshLayout) findViewById(R.id.pullToRefresh);
        loggedin_userId = (TextView) findViewById(R.id.loggedin_userId);

        //get transferred data
        Intent intent = getIntent();
        userId = intent.getStringExtra("loggedin_userid");
        loggedin_userId.setText(userId);

//        if (savedInstanceState == null) {
//            Bundle extras = getIntent().getExtras();
//            if(extras == null) {
//                userId = null;
//            } else {
//                userId = extras.getStringExtra("loggedin_userid");
//                loggedin_userId.setText(loggedin_userId);
//            }
//        } else {
//            userId = (String) savedInstanceState.getSerializable("loggedin_userid");
//            loggedin_userId.setText(loggedin_userId);
//        }

        slotList = new ArrayList<>();
//        buttonAddUpdate.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                if (isUpdating) {
//                    updateHero();
//                } else {
//                    createHero();
//                }
//            }
//        });
        readSlots();
        pullToRefresh.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                readSlots();
//                Toast.makeText(MainActivity.this, "Refreshed List~", Toast.LENGTH_SHORT).show();
                pullToRefresh.setRefreshing(false);
            }
        });
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
                    refreshSlotList(object.getJSONArray("slots"));
                }
                else{
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

    private void refreshSlotList(JSONArray slots) throws JSONException {
        slotList.clear();

        for (int i = 0; i < slots.length(); i++) {
            JSONObject obj = slots.getJSONObject(i);

            slotList.add(new Slot(
                    obj.getInt("id"),
                    obj.getString("slot"),
                    obj.getString("status"),
                    obj.getInt("lock")
            ));
        }

        SlotAdapter adapter = new SlotAdapter(slotList);
        listView.setAdapter(adapter);
    }

    private void readSlots() {
        PerformNetworkRequest request = new PerformNetworkRequest(Api.URL_READ_SLOTS, null, CODE_GET_REQUEST);
        request.execute();
    }

    private void unlockSlot(int slotid, String userid) {
        PerformNetworkRequest request = new PerformNetworkRequest(Api.URL_UNLOCK_SLOT + slotid + "&userid=" + userid, null, CODE_GET_REQUEST);
        Log.d("useridnya2", Api.URL_UNLOCK_SLOT + slotid + userid);
        request.execute();
    }

    class SlotAdapter extends ArrayAdapter<Slot> {
        List<Slot> slotList;

        public SlotAdapter(List<Slot> slotList) {
            super(MainActivity.this, R.layout.custom_listview, slotList);
            this.slotList = slotList;
        }


        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            LayoutInflater inflater = getLayoutInflater();
            View listViewItem = inflater.inflate(R.layout.custom_listview, null, true);

            TextView textViewSlot = listViewItem.findViewById(R.id.textViewSlot);
            TextView textViewStatus = listViewItem.findViewById(R.id.textViewStatus);
            TextView textViewLock = listViewItem.findViewById(R.id.textViewLock);
            Button buttonBooking = listViewItem.findViewById(R.id.buttonBooking);
            Button buttonUnlock = listViewItem.findViewById(R.id.buttonUnlock);

            final Slot slot = slotList.get(position);

            textViewSlot.setText(slot.getSlot());
            textViewStatus.setText(slot.getStatus());
            textViewLock.setText(Integer.toString(slot.getLock()));

            buttonBooking.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    isUpdating = true;
                    int slotid = slot.getId();
                    Intent intent = new Intent(MainActivity.this, BookingActivity.class);

                    intent.putExtra("slotid", slotid);
                    intent.putExtra("userid", userId);
                    startActivity(intent);
                }
            });
//
            buttonUnlock.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {

                    AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);

                    builder.setTitle("Unlock " + slot.getSlot())
                            .setMessage("Are you sure you want to unlock it?")
                            .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int which) {
                                    String userid = loggedin_userId.getText().toString();
                                    Log.d("useridnya", userid);
                                    unlockSlot(slot.getId(), userid);
                                }
                            })
                            .setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int which) {

                                }
                            })
                            .setIcon(android.R.drawable.ic_dialog_alert)
                            .show();

                }
            });



            return listViewItem;
        }
    }
}
