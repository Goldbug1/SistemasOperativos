package com.theopentutorials.android.adapters;

import java.util.List;
import com.theopentutorials.android.R;
import com.theopentutorials.android.beans.Contact;
import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;
import com.theopentutorials.android.app.AppController;

/**
 * Created by gt on 28/03/2015.
 */
public class CustomListViewAdapter extends ArrayAdapter<Contact> {

    Context context;

    ImageLoader imageLoader = AppController.getInstance().getImageLoader();

    public CustomListViewAdapter(Context context, int resourceId,
                                 List<Contact> items) {
        super(context, resourceId, items);
        this.context = context;
    }

    /*private view holder class*/
    private class ViewHolder {
        //ImageView imageView;
        NetworkImageView smartImage;
        TextView name;
        TextView pWork;
        TextView pHome;
        TextView pMobile;
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder = null;
        Contact contact = getItem(position);

        LayoutInflater mInflater = (LayoutInflater) context
                .getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
        if (convertView == null) {
            convertView = mInflater.inflate(R.layout.list_item, null);

            holder = new ViewHolder();
            holder.name = (TextView) convertView.findViewById(R.id.name);
          //  holder.pWork = (TextView) convertView.findViewById(R.id.phoneWork);
            holder.pMobile = (TextView) convertView.findViewById(R.id.phoneMobile);
           // holder.pHome = (TextView) convertView.findViewById(R.id.phoneHome);

           // try load image
            if (imageLoader == null)
                imageLoader = AppController.getInstance().getImageLoader();

            holder.smartImage = (NetworkImageView) convertView.findViewById(R.id.photo);
            convertView.setTag(holder);

        } else
            holder = (ViewHolder) convertView.getTag();

        holder.name.setText(contact.getName());
       // holder.pWork.setText("Work :"+contact.getPhones().get(0));
       // holder.pHome.setText("Home :"+contact.getPhones().get(1));
        holder.pMobile.setText("Mobile :"+contact.getPhones().getMobile());
        holder.smartImage.setImageUrl(contact.getSmallImageURL(), imageLoader);

        return convertView;
    }
}