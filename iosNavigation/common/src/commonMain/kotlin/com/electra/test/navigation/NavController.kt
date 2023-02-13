package com.electra.test.navigation

interface NavController {
    fun push(navLink: NavLink)
    fun popTo(navLink: NavLink)
    fun pop()
    fun pushModal(navLink: NavLink)
}