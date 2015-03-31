package com.theopentutorials.android.activities;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.NetworkImageView;
import com.theopentutorials.android.R;
import com.theopentutorials.android.app.AppController;
import com.theopentutorials.android.beans.Address;
import com.theopentutorials.android.beans.Contact;
import com.theopentutorials.android.beans.DetailsContact;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by gt on 31/03/2015.
 */
public class DetailContact extends Activity {
    /** Called when the activity is pressed the contact . */
    private static final String TAG = DetailContact.class.getSimpleName();
    private ProgressDialog pDialog;
    private DetailsContact detailsContact;
    // contact selected
    private Contact contact;

    ImageLoader imageLoader = AppController.getInstance().getImageLoader();


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.details_item);
        Intent i = getIntent();
        // Receiving the Data

        pDialog = new ProgressDialog(this);
        // Showing progress dialog before making http request
        pDialog.setMessage("Loading details...");
        pDialog.show();

        // obtengo el contacto a mostrar el detalle.
      //  contact = (Contact) getIntent().getExtras().getSerializable("contact");
        contact= ListContacts.contact;

        final String detailsUrl = contact.getDetailsURL();

        Log.e("details URL:",  detailsUrl);

        Button  btnBack = (Button) findViewById(R.id.btnBack);

       // Creating volley request obj
        JsonObjectRequest contactReq = new JsonObjectRequest(detailsUrl,null,

                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                           hidePDialog();
               try {
                               JSONObject obj = response;

                               detailsContact = new DetailsContact();
                               detailsContact.setName(contact.getName());
                               detailsContact.setBirthdate(contact.getBirthdate());
                               detailsContact.setCompany(contact.getCompany());
                               detailsContact.setPhones(contact.getPhones());


                               detailsContact.setEmployeeId(obj.getString("employeeId"));
                               detailsContact.setEmail(obj.getString("email"));
                               detailsContact.setWebsite(obj.getString("website"));
                               detailsContact.setLargeImageURL(obj.getString("largeImageURL"));

                               JSONObject jsonAddress = obj.getJSONObject("address");

                                Address address=new Address();

                                address.setCountry(jsonAddress.getString("country"));
                                address.setCity(jsonAddress.getString("city"));
                                address.setLatitude(jsonAddress.getString("latitude"));
                                address.setLongitude(jsonAddress.getString("longitude"));
                                address.setState(jsonAddress.getString("state"));
                                address.setStreet(jsonAddress.getString("street"));
                                address.setZip(jsonAddress.getString("zip"));

                                detailsContact.setAddress(address);

                                buildUI(detailsContact);

                            } catch (JSONException e) {
                                e.printStackTrace();
                            }

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


        // Binding Click event to Button
        btnBack.setOnClickListener(new View.OnClickListener() {

            public void onClick(View arg0) {
                //Closing SecondScreen Activity
                finish();
            }
        });

    }

    private void buildUI(DetailsContact detailsContact){

        TextView txtName = (TextView) findViewById(R.id.name);
        TextView birthday = (TextView) findViewById(R.id.birthday);
        TextView company = (TextView)  findViewById(R.id.company);
        TextView email = (TextView)  findViewById(R.id.email);
        TextView address = (TextView)  findViewById(R.id.address);


        // phones
        TextView home = (TextView)  findViewById(R.id.home);
        TextView work = (TextView)  findViewById(R.id.work);
        TextView mobile = (TextView)  findViewById(R.id.mobile);

        txtName.setText(detailsContact.getName());
        birthday.setText(detailsContact.getBirthdate());
        company.setText(detailsContact.getCompany());
        email.setText(detailsContact.getEmail());
        address.setText(detailsContact.getAddress().getStreet()+","+detailsContact.getAddress().getCity());


        if (imageLoader == null)
            imageLoader = AppController.getInstance().getImageLoader();

        NetworkImageView largeImage = (NetworkImageView) findViewById(R.id.photo);

        largeImage.setImageUrl(detailsContact.getLargeImageURL(), imageLoader);

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
