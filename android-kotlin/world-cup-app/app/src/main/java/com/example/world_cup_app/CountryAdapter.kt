package com.example.world_cup_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.BaseAdapter

class CountryAdapter(
    private var activity: Activity,
    private var items: ArrayList<CountryModel>
) : BaseAdapter() {

    override fun getCount(): Int {
        return items.size
    }

    override fun getItem(position: Int): CountryModel {
        return items[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getView(
        position: Int,
        convertView: View?,
        viewGroup: ViewGroup?
    ): View {

        val view: View?
        val viewHolder: ViewHolder

        if (convertView == null) {
            val inflater =
                activity
                    ?.getSystemService(
                        Context.LAYOUT_INFLATER_SERVICE
                    ) as LayoutInflater

            view =
                inflater.inflate(
                    R.layout.list_item,
                    null // root:
                )

            viewHolder = ViewHolder(view)
            view?.tag = viewHolder
        } else {
            view = convertView
            viewHolder = view.tag as ViewHolder
        }

        var country = item.get(position)

        viewHolder.flagImage?.setImageResource(country.flagImage)
        viewHolder.countryText?.text = country.name
        viewHolder.cupWinsText?.text = country.cupWins

        view.setOnClickListener {
            Toast.makeText(
                view.context, // or activity
                viewHolder.countryText?.text
                    ?? country.name
                    || "country",
                Toast.LENGTH_SHORT
            ).show()
        }

        return view as View

    }

}