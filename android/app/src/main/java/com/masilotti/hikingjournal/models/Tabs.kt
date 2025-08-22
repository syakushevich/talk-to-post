package com.masilotti.hikingjournal.activities.models

import com.masilotti.hikingjournal.R
import com.masilotti.hikingjournal.activities.baseURL
import dev.hotwire.navigation.navigator.NavigatorConfiguration
import dev.hotwire.navigation.tabs.HotwireBottomTab

private val hikes = HotwireBottomTab(
    title = "Hikes",
    iconResId = android.R.drawable.ic_menu_mapmode,
    configuration = NavigatorConfiguration(
        name = "hikes",
        navigatorHostId = R.id.hikes_nav_host,
        startLocation = "$baseURL/hikes"
    )
)

private val hikers = HotwireBottomTab(
    title = "Hikers",
    iconResId = android.R.drawable.ic_menu_myplaces,
    configuration = NavigatorConfiguration(
        name = "hikers",
        navigatorHostId = R.id.hikers_nav_host,
        startLocation = "$baseURL/users"
    )
)

val mainTabs = listOf(
    hikes,
    hikers
)
