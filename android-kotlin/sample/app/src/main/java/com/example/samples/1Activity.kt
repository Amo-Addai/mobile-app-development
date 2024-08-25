package com.example.sample

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class `1Activity` : AppCompatActivity() {

    private var edit: EditText

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_1)

        this.edit = EditText()

        val button: Button = Button()

        button.setOnClickListener {
            // Explicit Intent
            var i = Intent(
                this,
                Activity2::class.java
            )
            i.putExtra("age", 30)
            startActivity(i)
        }

        button.setOnClickListener {
            // Implicit Intent
            var i = Intent(Intent.ACTION_SEND) // 'share' intent
            i.setType('text/plain')
            i.putExtra(
                Intent.EXTRA_SUBJECT,
                "value"
            )
            i.putExtra(
                Intent.EXTRA_TEXT,
                "value"
            )
            startActivity(i)
        }

    }
}
