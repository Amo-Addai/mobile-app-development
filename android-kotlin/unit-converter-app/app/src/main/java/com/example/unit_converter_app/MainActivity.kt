package com.example.unit_converter_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView

class MainActivity : AppCompatActivity() {

    private var edit: EditText
    private var button: Button
    private var resultText: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        this.button = findViewById(R.id.kilo_edit)
        this.button = findViewById(R.id.button)
        this.resultText = findViewById(R.id.result_text)

        this.button.setOnClickListener {
            val kilos: Double =
                edit.text
                    .toString()
                    .toDouble()
            resultText.setText(
                this.convertToPounds(kilos)
                + "\nPounds"
            )
        }
    }

    fun convertToPounds(kilos: Double): Double {
        var pounds = kilos * 2.20642
        return pounds
    }

}
