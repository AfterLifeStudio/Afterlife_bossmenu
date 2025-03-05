import React, { useRef } from "react"
import { CSSTransition } from "react-transition-group"

const FadeSlide = props => {
  const nodeRef = useRef(null)

  return (
    <CSSTransition
      nodeRef={nodeRef}
      in={props.in}
      timeout={400}
      classNames="transition-slide-up"
      unmountOnExit
    >
      {React.cloneElement(props.children, { ref: nodeRef })}
    </CSSTransition>
  );
}

export default FadeSlide