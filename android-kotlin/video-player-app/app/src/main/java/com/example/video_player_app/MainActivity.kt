package com.example.video_player_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.VideoView

class MainActivity : AppCompatActivity() {

    private var videoView1: VideoView
    private var videoView2: VideoView

    private var mediaController1: MediaController
    private var mediaController2: MediaController

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        this.videoView1 = findViewById(R.id.videoView1)
        this.videoView2 = findViewById(R.id.videoView2)

        this.mediaController1 = MediaController(this)
        this.mediaController2 = MediaController(this)

        this.displayVideoFromLocalStorage()
        this.displayVideoFromInternet()

    }

    private fun displayVideoFromLocalStorage() {
        this.videoView1.setVideoPath(
            "android.resource://"
                    + packageName
                    + "/"
                    + R.raw.mountains
        )

        this.mediaController1.setAnchorView(this.videoView1)
        this.mediaController1.setMediaPlayer(this.videoView1)

        this.videoView1.setMediaController(this.mediaController1)
        this.videoView1.start()
    }

    private fun displayVideoFromInternet() {
        val uri = Uri.parse(
            "https://static.videezy.com/system/resources/previews/000/002/231/original/5226496.mp4"
        )
        this.videoView2.setVideoURI(uri)

        this.mediaController2.setAnchorView(this.videoView2)
        this.mediaController2.setMediaPlayer(this.videoView2)

        this.videoView2.setMediaController(this.mediaController2)
        this.videoView2.start()
    }

}