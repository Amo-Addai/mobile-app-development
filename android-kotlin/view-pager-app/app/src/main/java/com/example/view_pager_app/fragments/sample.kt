package com.example.view_pager_app.fragments

import android.os.Bundle

// TODO: create file as Fragment
class SampleFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return
            inflater
                .inflate(
                    R.layout.fragments.fragment_sample,
                    container,
                    false
                )
    }
}