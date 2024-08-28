package com.example.world_cup_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class CountryModel {

    var name: String = ""
    var cupWins: String = ""
    var flagImage: Int = 0

    constructor(
        name: String,
        cupWins: String,
        flagImage: Int
    ) {
        this.name = name
        this.cupWins = cupWins
        this.flagImage = flagImage
    }

}