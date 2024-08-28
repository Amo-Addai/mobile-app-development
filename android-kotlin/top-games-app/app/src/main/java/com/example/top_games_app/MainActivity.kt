package com.example.top_games_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Adapter View - Card RecyclerView

        val recyclerView: Recycler = findViewById(R.id.recycler)

        recyclerView.layoutManager =
            LinearLayoutManager(
                LinearLayoutManager.VERTICAL,
                false
            )

        // Data Source - Games List

        val gamesList: ArrayList<GameModel> = ArrayList()

        // gamesList.add(GameModel(R.drawable.card0, "Uncharted")) // * TODO: Get
        gamesList.add(GameModel(R.drawable.card1, "Horizon Chase"))
        gamesList.add(GameModel(R.drawable.card2, "PUBG"))
        gamesList.add(GameModel(R.drawable.card3, "Head Ball 2"))
        gamesList.add(GameModel(R.drawable.card4, "Hooked on You"))
        gamesList.add(GameModel(R.drawable.card5, "FIFA 2020"))
        gamesList.add(GameModel(R.drawable.card6, "Fortnite"))

        // Adapter
        val adapter: GameAdapter = GameAdapter(gamesList)

        // Set RecyclerView's Adapter
        recyclerView.adapter = adapter

    }
}