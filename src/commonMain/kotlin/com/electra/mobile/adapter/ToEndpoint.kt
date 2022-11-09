package com.electra.mobile.adapter

import com.electra.mobile.config.data.Endpoint
import com.electra.mobile.data.EndpointSelection

fun EndpointSelection.toEndpoint() = when (this) {
    is EndpointSelection.Custom -> Endpoint.CUSTOM
    EndpointSelection.Local -> Endpoint.LOCAL
    EndpointSelection.Staging -> Endpoint.STAGING
}