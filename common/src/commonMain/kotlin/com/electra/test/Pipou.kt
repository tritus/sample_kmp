package com.electra.test

class FirstViewModel(
    private val navController: NavController
) {
    fun onCLick() {
        navController.push(NavLink.SECOND)
    }

    fun onOpenSecondWithModalClicked() {
        navController.pushModaly(NavLink.SECOND)
    }
}

class SecondViewModel(
    private val navController: NavController
) {
    fun onCLick() {
        navController.push(NavLink.THIRD)
    }

    fun onGoBackClicked() {
        navController.pop()
    }
}

class ThirdViewModel(
    private val navController: NavController
) {
    fun onCLick() {
        navController.popTo(NavLink.FIRST)
    }
}

enum class NavLink {
    FIRST,
    SECOND,
    THIRD
}

object AppConstants {
    val rootScreen = NavLink.FIRST
}

interface NavController {
    fun push(navLink: NavLink)
    fun popTo(navLink: NavLink)
    fun pop()
    fun pushModaly(navLink: NavLink)
}