import { useState } from "react"
import { nuicallback } from '../../utils/nuicallback'


const JobSelection = (e) => {
    const data = e.data
    const [moneyinput, setMoneyInput] = useState(0);

    return (
        <>
        <div className="job-selection">
            <div className="title">Other Jobs</div>

            <div className="jobs-container">
                <div className="job">
                </div>
                <div className="job">
                </div>
                <div className="job">
                </div>
                <div className="job">
                </div>
                <div className="job">
                </div>
            </div>
        </div>
        </>
    )
}

export default JobSelection