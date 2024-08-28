package com.example.simple_list_view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // ListView Adapter

        var listView: ListView = findViewById(R.id.list)

        // Data Source

        val worldCupCountries = arrayOf(
            "Brazil", "France", "Germany", "Qatar", "Saudi Arabia", "Spain", "United Kingdom", "United States",
        )

        // Adapter

        val arrayAdapter: ArrayAdapter<*>

        arrayAdapter = ArrayAdapter(
            this,
            R.layout.list_item,
            R.id.text, // use this elem alone as list-item-view (no custom view - only string data)
            worldCupCountries
        )

        // Set Adapter
        
        listView.adapter = arrayAdapter

    }
}