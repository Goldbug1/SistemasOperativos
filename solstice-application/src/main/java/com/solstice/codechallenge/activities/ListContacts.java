package com.solstice.codechallenge.activities;

import java.util.ArrayList;
import java.util.List;
import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

import com.theopentutorials.android.R;
import com.solstice.codechallenge.adapters.CustomListViewAdapter;
import com.solstice.codechallenge.beans.Contact;
import com.solstice.codechallenge.app.AppController;




import android.app.ProgressDialog;
import android.graphics.drawable.ColorDrawable;
import com.android.volley.toolbox.JsonArrayRequest;
import android.graphics.Color;
import com.android.volley.Response;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.util.Log;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.solstice.codechallenge.beans.Phones;

import android.content.Intent;


/**
 * Created by gt on 28/03/2015.
 */
public class ListContacts extends Activity implements
        OnItemClickListener {

    public ListView listView;
    public List<Contact> contacts;
    // contact selected
    public static Contact contact;
    private CustomListViewAdapter adapter;


    private ProgressDialog pDialog;
    private static final String url = "https://solstice.applauncher.com/external/contacts.json";
    private static final String TAG = ListContacts.class.getSimpleName();


    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        contacts = new ArrayList<Contact>();

        listView = (ListView) findViewById(R.id.list);
        adapter = new CustomListViewAdapter(this,R.layout.list_item, contacts);

        listView.setAdapter(adapter);
        listView.setOnItemClickListener(this);

        // adding volley invoke

        pDialog = new ProgressDialog(this);
        // Showing progress dialog before making http request
        pDialog.setMessage("Loading contacts...");
        pDialog.show();

        // changing action bar color
        getActionBar().setBackgroundDrawable(
                new ColorDrawable(Color.parseColor("#1b1b1b")));

        // Creating volley request obj
        JsonArrayRequest contactReq = new JsonArrayRequest(url,
                new Response.Listener<JSONArray>() {
                    @Override
                    public void onResponse(JSONArray response) {
                        Log.d(TAG, response.toString());
                        hidePDialog();

                        // Parsing json
                        for (int i = 0; i < response.length(); i++) {
                            try {

                                JSONObject obj = response.getJSONObject(i);
                                Contact contact = new Contact();
                                contact.setName(obj.getString("name"));
                                contact.setEmployeeId(obj.getString("employeeId"));
                                contact.setCompany(obj.getString("company"));
                                contact.setDetailsURL(obj.getString("detailsURL"));
                                contact.setSmallImageURL(obj.getString("smallImageURL"));

                                contact.setBirthdate(obj.getString("birthdate"));

                                JSONObject phones = obj.getJSONObject("phone");

                                Phones phonesAux= new Phones();

                                phonesAux.setWork(phones.getString("work"));
                                phonesAux.setHome(phones.getString("home"));
                                phonesAux.setMobile(phones.getString("mobile"));

                                contact.setPhones(phonesAux);

                                contacts.add(contact);

                            } catch (JSONException e) {
                                e.printStackTrace();
                            }

                        }

                        // notifying list adapter about data changes
                        // so that it renders the list view with updated data
                        adapter.notifyDataSetChanged();
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                VolleyLog.d(TAG, "Error: " + error.getMessage());
                hidePDialog();

            }
        });

        // Adding request to request queue
        AppController.getInstance().addToRequestQueue(contactReq);

    }


    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position,
                            long id) {
        Intent nextScreen = new Intent(getApplicationContext(), DetailContact.class);
       // TODO ver por que no me toma la clase serializada , me arroja
    //
    //   Bundle bundle = new Bundle();
    //   Contact contactAux= contacts.get(position);
    //    bundle.putSerializable("contact",contactAux);

        //Sending data to another Activity
    //    nextScreen.putExtras(bundle);
        contact=contacts.get(position);
        startActivity(nextScreen);

    }


    @Override
    public void onDestroy() {
    super.onDestroy();
        hidePDialog();
    }

    private void hidePDialog() {
    if (pDialog != null) {
          pDialog.dismiss();
          pDialog = null;
    }
    }
}