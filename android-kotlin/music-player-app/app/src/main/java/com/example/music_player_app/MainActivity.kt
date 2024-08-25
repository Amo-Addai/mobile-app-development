package com.example.music_player_app

import androidx.appcompat.app.AppCompatActivity
import java.util.concurrent.TimeUnit
import android.os.Bundle
import android.os.Handler
import android.media.MediaPlayer
import android.provider.MediaStore.Audio.Media
import android.widget.Button
import android.widget.SeekBar
import android.widget.TextView
import android.widget.Toast


class MainActivity : AppCompatActivity() {

    private var startTime = 0.0
    private var finalTime = 0.0
    private var forwardTime = 10000
    private var backwardTime = 10000
    private var oneTimeOnly = 0

    private lateinit var songTitle
    private lateinit var timeText
    private lateinit var seekBar

    private lateinit var playButton
    private lateinit var pauseButton
    private lateinit var backButton
    private lateinit var forwardButton

    private var handler: Handler = Handler() // todo: check can instantiate in static env
    private var mediaPlayer

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        this.playButton = findViewById<Button>(R.id.playButton)
        this.pauseButton = findViewById<Button>(R.id.pauseButton)
        this.backButton = findViewById<Button>(R.id.backButton)
        this.forwardButton = findViewById<Button>(R.id.forwardButton)

        this.songTitle = findViewById<TextView>(R.id.songTitle)
        this.timeText = findViewById<TextView>(R.id.timeText)
        this.seekBar = findViewById<SeekBar>(R.id.seekBar)

        this.mediaPlayer = MediaPlayer
            .create(
                this, // TODO: recreate 'Android Resource Directory' - raw/
                R.raw.astronaut // TODO: replace with any .mp3 file
            )

        this.seekBar.isClickable = false

        this.playButton.setOnClickListener {
            this.mediaPlayer.start()
            this.finalTime =
                this.mediaPlayer
                    .duration
                    .toDouble()
            this.startTime =
                this.mediaPlayer
                    .currentPosition
                    .toDouble()

            if (oneTimeOnly == 0) {
                this.seekBar.max = this.finalTime.toInt()
                this.oneTimeOnly = 1
            }

            this.timeText.text = this.startTime.toString()
            this.seekBar.setProgress(
                this.startTime.toInt()
            )
            this.handler.postDelayed(
                UpdateSongTime,
                100
            )
        }

        this.titleText.text =
            resources.getResourceEntryName(
                R.raw.astronaut // TODO: replace with any .mp3 file
            )
            /* // TODO: Test option
                .getIndentifier(
                    "astronaut.mp3", // TODO: replace with any .mp3 file
                    "raw", // TODO: recreate 'Android Resource Directory' - raw/
                    packageName
                )
            */

        this.pauseButton.setOnClickListener {
            this.mediaPlayer.pause()
        }

        this.forwardButton.setOnClickListener {
            var temp = this.startTime
            if (
                temp + this.forwardTime
                <= this.finalTime
            ) {
                this.startTime =
                    this.startTime
                    + this.forwardTime
                this.mediaPlayer.seekTo(
                    this.startTime.toInt()
                )
            } else {
                Toast.makeText(
                    this,
                    "Cannot jump forward",
                    Toast.LENGTH_LONG
                ).show()
            }
        }

        this.backButton.setOnClickListener {
            var temp = this.startTime.toInt()

            if (
                temp
                - this.backwardTime
                > 0
            ) {
                this.startTime =
                    this.startTime
                    - this.backwardTime
                this.mediaPlayer
                    .seekTo(
                        this.startTime.toInt()
                    )
            } else {
                Toast.makeText(
                    this,
                    "Cannot jump backward",
                    Toast.LENGTH_LONG
                ).show()
            }
        }

    }

    // Runnable object (extends Runnable interface; implements run() method) - use for Runnable-typed call-backs
    private val UpdateSongTime: Runnable = object : Runnable {

        override fun run() {
            this.startTime =
                this.mediaPlayer
                    .currentPosition
                    .toDouble()
            this.timeText.text =
                String.format(
                    "%d min, %d sec",
                    TimeUnit
                        .MILLISECONDS
                        .toMinutes(
                            this.startTime.toLong()
                        ),
                    TimeUnit
                        .MILLISECONDS
                        .toSeconds(
                            this.startTime.toLong()
                            - TimeUnit
                                .MINUTES
                                .toSeconds(
                                    TimeUnit
                                        .MILLISECONDS
                                        .toMinutes(
                                            this.startTime.toLong()
                                        )
                                )
                        )
                )

            this.seekBar.progress = this.startTime.toInt()
            this.handler.postDelayed(this, 100)

        }

    }

}