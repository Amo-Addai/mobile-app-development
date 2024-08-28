package com.example.tab_layout_app.adapter

import android.os.Bundle
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.Lifecycle
import androidx.viewpager2.adapter.FragmentStateAdapter
import com.example.tab_layout_app.fragments.BooksFragment
import com.example.tab_layout_app.fragments.GamesFragment
import com.example.tab_layout_app.fragments.MoviesFragment


class ViewPagerAdapter(
    fragmentManager: FragmentManager,
    lifecycle: Lifecycle
): FragmentStateAdapter(
    fragmentManager,
    lifecycle
) {

    override fun getItemCount(): Int {
        return 3 // number of tabs
    }

    override fun createFragment(position: Int): Fragment {

        // TODO: Test return when position { 0 -> (..) .. }
        when (position) {
            0 -> return BooksFragment()
            1 -> return GamesFragment()
            // 2 -> return MoviesFragment()
        }
        return MoviesFragment()

    }

}