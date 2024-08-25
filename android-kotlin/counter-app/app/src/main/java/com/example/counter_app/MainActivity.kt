package com.example.counter_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {

    private var counter: Int = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val button = findViewById<Button>(R.id.button)
        val text = findViewById<TextView>(R.id.result_text)

        text.setText(this.counter) // TODO: check data-binding

        button.setOnClickListener {
            this.incrementCounter() // TODO: eternal check data-binding
        }

    }

    private fun incrementCounter() {
        this.counter++
    }

}