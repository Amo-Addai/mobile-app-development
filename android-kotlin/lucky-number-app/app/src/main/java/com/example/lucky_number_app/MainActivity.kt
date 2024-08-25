package com.example.lucky_number_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val text: TextView findViewById(R.id.text)
        val edit: EditText = findViewById(R.id.edit)
        val button: Button = findVewById(R.id.button)

        button.setOnClickListener {
            var name = edit.text
            var i = Intent(
                this,
                LuckyNumberActivity::class.java
            )
            i.putExtra(
                'name',
                name
            )
            startActivity(i)
        }

    }
}