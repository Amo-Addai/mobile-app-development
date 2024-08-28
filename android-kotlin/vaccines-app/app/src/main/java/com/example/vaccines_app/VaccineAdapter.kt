package com.example.vaccines_app

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.recyclerview.widget.RecyclerView


class VaccineAdapter(
    val vaccinesList: ArrayList<VaccineModel>
) : RecyclerView.Adapter<VaccineAdapter.VaccineViewHolder>() {

    // VaccineAdapter.VaccineViewHolder - 'inner-class', so parent class can use it
    // as if both defined on the same context/level/scope, statically

    inner class VaccineViewHolder(itemView: View)
        : RecyclerView.ViewHolder(itemView) {

            lateinit var vaccineImage: ImageView
            lateinit var vaccineTitle: TextView

            init {
                vaccineImage = itemView.findViewById(R.id.image)
                vaccineTitle = itemView.findViewById(R.id.text)

                itemView.setOnClickListener {
                    Toast.makeText(
                        itemView.context,
                        // TODO: .kt - null-operator vs null-coalesce operator ("" - 'non-null' but empty value)
                        vaccineTitle.text
                            || vaccinesList.get(adapterPosition)
                                .name
                                    ?? "Hello", // TODO: wrong - "" empty string on .name won't default-to "Hello"
                        Toast.LENGTH_SHORT
                    ).show()
                }
            }

        }

    // RecyclerView.Adapter abstract methods

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): VaccineViewHolder {

        val v: View =
            LayoutInflater
                .from(parent.context)
                .inflate(
                    R.layout.recycler_item_layout,
                    parent,
                    false // attachToRoot:
                )

        return VaccineViewHolder(v)

    }

    override fun onBindViewHolder(
        viewHolder: VaccineViewHolder,
        position: Int
    ) {

        val vaccineModel: VaccineModel = vaccinesList[position] // .get(position)

        viewHolder
            .vaccineTitle
            .setText(
                vaccineModel.name
            )

        viewHolder
            .vaccineImage
            .setImageResource(
                vaccineModel.img // Int - drawable-id
            )

    }

    override fun getItemCount(): Int {
        return vaccinesList.size
    }

}