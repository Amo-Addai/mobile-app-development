package com.example.top_games_app

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.recyclerview.widget.RecyclerView


class GameAdapter(
    val gamesList: ArrayList<GameModel>
) : RecyclerView.Adapter<GameAdapter.GameViewHolder>() {

    inner class GameViewHolder(
        itemView: View
    ) : RecyclerView.ViewHolder(itemView) {

        lateinit var gameImage: ImageView
        lateinit var gameTitle: TextView

        init {

            gameImage = itemView.findViewById(R.id.cardImage)
            gameTitle = itemView.findViewById(R.id.cardText)

            itemView.setOnClickListener {
                Toast.makeText(
                    itemView.context,
                    // TODO: .kt - null-operator vs null-coalesce operator ("" - 'non-null' but empty value)
                    gameTitle.text
                        || gamesList[adapterPosition]
                            .gameTitle
                                || "Hello", // TODO: now, right (check vaccines-app/../VaccineAdapter.kt)
                                // "" empty string test with || (not ??) will also default-to "Hello"
                    Toast.LENGTH_SHORT
                ).show()
            }

        }

    }

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): GameViewHolder {

        val v = LayoutInflater
            .from(parent.context)
            .inflate(
                R.layout.card_item_layout,
                parent,
                false
            )

        return GameViewHolder(v)

    }

    override fun onBindViewHolder(
        viewHolder: GameViewHolder,
        position: Int
    ) {

        val gameModel = gamesList
            .get(posiiton)
            .imageCard

        viewHolder
            .gameImage
            .setImageResource(
                gameModel.gameImage
            )

        viewHolder
            .gameTitle
            .setText(
                gameModel.gameTitle
            )

    }

    override fun getItemCount(): Int {
        return gamesList.size
    }

}