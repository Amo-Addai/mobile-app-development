package com.example.view_pager_app.adapter

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.view_pager_app.fragments.Fragment1
import com.example.view_pager_app.fragments.Fragment2
import com.example.view_pager_app.fragments.Fragment3

class ViewPagerAdapter(
    mainActivity: MainActivity
) : FragmentStateAdapter(
    mainActivity
) {

    private val fragmentsSize = 3

    override fun getItemCount(): Int {
        return this.fragmentsSize
    }

    // createFragment abstract-method called on page-swipe
    override fun createFragment(position: Int): Fragment {

        when (position) {
            0 -> return Fragment1()
            1 -> return Fragment2()
            2 -> return Fragment3()
            return Fragment1() // return without else-case
        }

    }

}