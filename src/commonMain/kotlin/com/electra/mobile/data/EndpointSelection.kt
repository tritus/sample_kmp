package com.electra.mobile.data

sealed class EndpointSelection(val value: String) {
    object Local : EndpointSelection(value = "http://10.0.2.2:3000")

    object Staging : EndpointSelection(value = "https://backend-staging.go-electra.com")

    class Custom(value: String) : EndpointSelection(value = value)
}