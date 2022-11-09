package com.electra.mobile.storage

import com.electra.mobile.config.data.Endpoint
import com.electra.mobile.data.EndpointSelection

internal class DebugConfigPrefs {
    fun getEndpointSelection(): EndpointSelection {
        return prefs
            .getString(endpointSelectionKey, null)
            ?.let { endpoint ->
                when (endpoint) {
                    Staging.endpoint.value -> Staging
                    Local.endpoint.value -> Local
                    else -> Custom(endpoint = Endpoint(endpoint))
                }
            } ?: EndpointSelection.Local
    }

    fun storeEndpointSelection(selection: EndpointSelection) {
        prefs.edit().putString(endpointSelectionKey, selection.endpoint.value).apply()
    }
}