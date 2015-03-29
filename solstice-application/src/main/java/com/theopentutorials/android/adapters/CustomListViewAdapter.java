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

/**
 * Created by gt on 28/03/2015.
 */
public class CustomListViewAdapter extends ArrayAdapter<Contact> {

    Context context;

    public CustomListViewAdapter(Context context, int resourceId,
                                 List<Contact> items) {
        super(context, resourceId, items);
        this.context = context;
    }

    /*private view holder class*/
    private class ViewHolder {
        ImageView imageView;
        TextView name;
       // TextView txtDesc;
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder = null;
        Contact contact = getItem(position);

        LayoutInflater mInflater = (LayoutInflater) context
                .getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
        if (convertView == null) {
            convertView = mInflater.inflate(R.layout.list_item, null);
            holder = new ViewHolder();
       //     holder.txtDesc = (TextView) convertView.findViewById(R.id.desc);
            holder.name = (TextView) convertView.findViewById(R.id.name);
         //   holder.imageView = (ImageView) convertView.findViewById(R.id.icon);
            convertView.setTag(holder);
        } else
            holder = (ViewHolder) convertView.getTag();

        holder.name.setText(contact.getName());
     //   holder.txtTitle.setText(contact.getTitle());
       // holder.imageView.setImageResource(contact.getImageId());

        return convertView;
    }
}