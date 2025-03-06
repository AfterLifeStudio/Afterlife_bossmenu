import { createSlice } from "@reduxjs/toolkit";

const initialState = false;


export const screenSlice = createSlice({
  name: "dashboard",
  initialState,
  reducers: {
    update: (state, action) => {
      return action.payload
    }
  },
});

export const { update } = dashboardSlice.actions;

export default dashboardSlice.reducer;
