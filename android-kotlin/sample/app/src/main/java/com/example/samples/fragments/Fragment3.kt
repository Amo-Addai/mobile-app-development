package com.example.samples.fragments

import android.os.Bundle

class Fragment3 : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return
        inflater
            .inflate(
                R.layout.fragments.fragment_3,
                container,
                false
            )
    }
}