package com.example.lucky_number_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class LuckyNumberActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_lucky_number)

        val text: TextView = findViewById(R.id.text)
        val luckyText: TextView = findViewById(R.id.luckyNumberText)
        val shareButton: Button = findViewById(R.id.button)

        var name: String = this.receiveUserName()
        Toast.makeText(
            this,
            name,
            Toast.LENGTH_LONG
        ).show()

        var randomNumber = this.generateRandomNumber()

        luckyText.setText(randomNumber)

        shareButton.setOnClickLister {
            shareData(name, randomNumber)
        }

    }

    fun receiveUserName(): String {
        var bundle: Bundle? = intent.extras
        var name = bundle.get('name').toString()
        return name
    }

    fun generateRandomNumber(): Int {
        return Random.nextInt(0..1000)
    }

    fun shareData(
        username: String,
        number: Int
    ) {
        var i = Intent(Intent.ACTION_SEND)
        i.setType('text/plain')
        i.putExtra(
            Intent.EXTRA_SUBJECT,
            "$username is lucky today"
        )
        i.putExtra(
            Intent.EXTRA_TEXT,
            "His lucky number is $number"
        )
        startActivity(i)
    }

}
