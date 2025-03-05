import { createSlice } from "@reduxjs/toolkit";

const initialState = '';


export const appSlice = createSlice({
  name: "app",
  initialState,
  reducers: {
    update: (state, action) => {
      return action.payload
    }
  },
});

export const { update } = appSlice.actions;

export default appSlice.reducer;
