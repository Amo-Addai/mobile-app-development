package com.example.french_teacher_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    private fun sayColor(view: View) {
        val clickecButton: Button = view as Button
        
        val mediaPlayer: MediaPlayer =
            MediaPlayer.create(
                this,
                resources.getIdentifier(
                    clickedButton // button.tag == raw/soundfilename.mp3
                        .tag
                        .toString()
                    + ".mp3",
                    "raw", // TODO: recreate 'Android Resource Directory' - raw/
                    packageName
                )
                /* // TODO: Test
                    .getResourceEntryName(
                        // R.raw.audiofile // TODO: Test getting resource .prop via string
                        R.raw[
                            clickedButton.tag.toString()
                        ]
                    )
                 */
            )

        mediaPlayer.start()
    }

}