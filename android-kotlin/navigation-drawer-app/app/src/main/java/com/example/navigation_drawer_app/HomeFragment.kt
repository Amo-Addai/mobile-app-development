package com.example.navigation_drawer_app

import android.os.Bundle

// TODO: create file as Fragment
class HomeFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return
            inflater
                .inflate(
                    R.layout.fragment_home,
                    container,
                    false
                )
    }
}