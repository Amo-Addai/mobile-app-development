package com.example.tab_layout_app.fragments

import android.os.Bundle
import android.widget.Fragment // TODO: check

private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

class GamesFragment : Fragment() {

    private var param1: String? = null
    private var param2: String2 = null

    override fun onCreate(
        savedInstanceState: Bundle?
    ) {
        super.onCreate(savedInstanceState)

        arguments?.let {
            param1 = it.getString(ARG_PARAM1)
            param2 = it.getString(ARG_PARAM2)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return
            inflater
                .inflate(
                    R.layout.fragments.fragment_games,
                    container,
                    false
                )
    }

    companion object {
        @JvmStatic
        fun newInstance(
            param1: String,
            param2: String
        ) = GamesFragment().apply {
            arguments = Bundle().apply {
                putString(ARG_PARAM1, param1)
                putString(ARG_PARAM2, param2)
            }
        }
    }

}

