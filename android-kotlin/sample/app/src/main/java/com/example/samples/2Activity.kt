package com.example.sample

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class `2Activity` : AppCompatActivity() {

    private var edit: EditText

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.samples.activity_2)

        this.edit = EditText()

        val bundle: Bundle? = intent.extras

        val age = bundle?.get("age")

        Toast.makeText(
            this,
            "Age: " + age,
            Toast.LENGTH_LONG
        ).show()

    }
}
