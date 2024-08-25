package com.example.greetings_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {

    private var editText: EditText
    private var button: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        this.editText = findViewById(R.id.edit)
        this.button = findViewById<Button>(R.id.button)

        this.button.setOnClickListener {
            var enteredText = edit.text

            Toast.makeText(
                    this,
                    "Hello, "
                    + enteredText,
                    Toast.LENGTH_LONG
                )
                .show()
            )
        }

    }
}