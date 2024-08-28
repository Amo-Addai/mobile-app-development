package com.example.samples_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // AdapterView - RecyclerView

        val recyclerView: RecyclerView
            = findViewById(R.id.recycler)

        recyclerView.layoutManager =
            LinearLayoutManager(
                this,
                LinearLayoutManager.VERTICAL,
                false, // reverseLayout:
            )

        // Data Source - List of SampleModel objects

        var samplesList: ArrayList<SampleModel> = ArrayList()

        samplesList.add(SampleModel("COVID-19", R.drawable.sample1))
        samplesList.add(SampleModel("Hepatitis B Sample", R.drawable.sample4))
        samplesList.add(SampleModel("Tetanus Sample", R.drawable.sample5))
        samplesList.add(SampleModel("Pneumococal Sample", R.drawable.sample6))
        samplesList.add(SampleModel("Rotavirus Sample", R.drawable.sample7))
        samplesList.add(SampleModel("Measles Sample", R.drawable.sample8))
        samplesList.add(SampleModel("Chickenpox Sample", R.drawable.sample9))

        // List Adapter - Sample Adapter
        val adapter = SampleAdapter(samplesList)

        // Set RecyclerView's adapter to Sample's List Adapter
        recyclerView.adapter = adapter

    }
}