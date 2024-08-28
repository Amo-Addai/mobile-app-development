package com.example.world_cup_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {

    // Data Source

    val worldCupCountries = run { // TODO: Test auto-'run' (& in static-env)
        var result = ArrayList<CountryModel>()
        result.add(CountryModel("Brazil", "5", R.drawable.brazil))
        result.add(CountryModel("France", "2", R.drawable.france))
        result.add(CountryModel("Germany", "4", R.drawable.germany))
        result.add(CountryModel("Saudi Arabia", "0", R.drawable.saudiarabia))
        result.add(CountryModel("Spain", "1", R.drawable.spain))
        result.add(CountryModel("England", "1", R.drawable.unitedkingdom))
        result.add(CountryModel("United States", "0", R.drawable.unitedstates))
        return result
    }//() // TODO: Test auto-exec

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // ListView Adapter

        var listView: ListView = findViewById(R.id.list)

        // Adapter

        var countryAdapter = CountryAdapter(
            this,
            worldCupCountries,
        )

        // Set Adapter

        listView?.adapter = countryAdapter

        countryAdapter?.notifyDataSetChanged()

    }

}