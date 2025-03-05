import { configureStore } from '@reduxjs/toolkit'
import screenReducer from './screen/screenSlice.js'
import appReducer from './screen/appSlice.js'

export const store = configureStore({
    reducer: {
        screen: screenReducer,
        app: appReducer,
    },
})

