package com.example.vaccines_app

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

        // Data Source - List of VaccineModel objects

        var vaccinesList: ArrayList<VaccineModel> = ArrayList()

        vaccinesList.add(VaccineModel("COVID-19", R.drawable.vaccine1))
        vaccinesList.add(VaccineModel("Hepatitis B Vaccine", R.drawable.vaccine4))
        vaccinesList.add(VaccineModel("Tetanus Vaccine", R.drawable.vaccine5))
        vaccinesList.add(VaccineModel("Pneumococal Vaccine", R.drawable.vaccine6))
        vaccinesList.add(VaccineModel("Rotavirus Vaccine", R.drawable.vaccine7))
        vaccinesList.add(VaccineModel("Measles Vaccine", R.drawable.vaccine8))
        vaccinesList.add(VaccineModel("Chickenpox Vaccine", R.drawable.vaccine9))

        // List Adapter - Vaccine Adapter
        val adapter = VaccineAdapter(vaccinesList)

        // Set RecyclerView's adapter to Vaccine's List Adapter
        recyclerView.adapter = adapter

    }
}