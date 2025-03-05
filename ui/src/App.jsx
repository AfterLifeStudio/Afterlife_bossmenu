import { useState } from "react";
import "./App.scss";
import { Provider } from "react-redux";
import { store } from "./store/store.js";
import MDT from "./components/mdt/mdt.jsx";
import Interaction from "./components/interaction/interaction.jsx";


function App() {
  return (
    <>
      <Provider store={store}>
        <MDT />
      </Provider>
    </>
  );
}

export default App;
