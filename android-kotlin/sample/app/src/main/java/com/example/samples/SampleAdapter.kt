package com.example.samples_app

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.recyclerview.widget.RecyclerView


class SampleAdapter(
    val samplesList: ArrayList<SampleModel>
) : RecyclerView.Adapter<SampleAdapter.SampleViewHolder>() {

    // SampleAdapter.SampleViewHolder - 'inner-class', so parent class can use it
    // as if both defined on the same context/level/scope, statically

    inner class SampleViewHolder(itemView: View)
        : RecyclerView.ViewHolder(itemView) {

            lateinit var sampleImage: ImageView
            lateinit var sampleTitle: TextView

            init {
                sampleImage = itemView.findViewById(R.id.image)
                sampleTitle = itemView.findViewById(R.id.text)

                itemView.setOnClickListener {
                    Toast.makeText(
                        itemView.context,
                        // TODO: .kt - null-operator vs null-coalesce operator ("" - 'non-null' but empty value)
                        sampleTitle.text
                            || samplesList.get(adapterPosition)
                                .name
                                    ?? "Hello", // TODO: wrong - "" empty string on .name won't default-to "Hello"
                                    // "" empty string test with || null-operator will
                        Toast.LENGTH_SHORT
                    ).show()
                }
            }

        }

    // RecyclerView.Adapter abstract methods

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): SampleViewHolder {

        val v: View =
            LayoutInflater
                .from(parent.context)
                .inflate(
                    R.layout.recycler_item_layout,
                    parent,
                    false // attachToRoot:
                )

        return SampleViewHolder(v)

    }

    override fun onBindViewHolder(
        viewHolder: SampleViewHolder,
        position: Int
    ) {
        
        val sampleModel: SampleModel = samplesList[position] // .get(position)

        viewHolder
            .sampleTitle
            .setText(
                sampleModel.name
            )

        viewHolder
            .sampleImage
            .setImageResource(
                sampleModel.img // Int - drawable-id
            )

    }

    override fun getItemCount(): Int {
        return samplesList.size
    }

}