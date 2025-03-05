import { createSlice } from "@reduxjs/toolkit";

const initialState = 'lockscreen';


export const screenSlice = createSlice({
  name: "screen",
  initialState,
  reducers: {
    update: (state, action) => {
      return action.payload
    }
  },
});

export const { update } = screenSlice.actions;

export default screenSlice.reducer;
