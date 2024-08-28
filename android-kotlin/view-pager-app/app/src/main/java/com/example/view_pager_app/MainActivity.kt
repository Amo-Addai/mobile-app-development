package com.example.view_pager_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.viewpager.widget.ViewPager
import androidx.viewpager2.widget.ViewPager
import com.example.view_pager_app.adapter.ViewPagerAdapter


class MainActivity : AppCompatActivity() {

    lateinit var viewPagerAdapter: ViewPagerAdapter
    lateinit var viewPager: ViewPager2

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        viewPager = findViewById(R.id.viewPager)

        viewPagerAdapter = ViewPagerAdapter(this)

        viewPager.orientation =
            ViewPager2.ORIENTATION_HORIZONTAL

        viewPager.adapter = viewPagerAdapter
    }
}