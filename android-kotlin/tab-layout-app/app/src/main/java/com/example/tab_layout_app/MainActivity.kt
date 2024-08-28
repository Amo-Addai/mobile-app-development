package com.example.tab_layout_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.viewpager2.widget.ViewPager2
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator
import com.example.tab_layout_app.adapter.ViewPagerAdapter


class MainActivity : AppCompatActivity() {

    private val tabsArray = arrayOf(
        "Books", "Games", "Movies"
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val tabLayout = findViewById<TabLayout>(R.id.tabLayout)
        val viewPager = findViewById<ViewPager2>(R.id.viewPager)

        val viewPagerAdapter = ViewPagerAdapter(
            supportFragmentManager,
            lifecycle
        )

        viewPager.adapter = viewPagerAdapter

        // Connect/Attach the view-pager with tab-layout
        TabLayoutMediator(
            tabLayout,
            viewPager
        ) {
            tab, position -> // set tab-title with index
                tab.text = tabsArray[position]
        }.attach()

    }
}