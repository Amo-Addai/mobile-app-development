package com.example.sample

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class SampleActivity : AppCompatActivity() {

    private var edit: EditText

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        this.edit = findViewById(R.id.edit)
        var btn = findViewById<Button>(R.id.button) // <Type> if var-type isn't stated
        val text = findViewById<TextView>(R.id.button) // val constant

    }

    private fun meth(view: View) {

    }
}
