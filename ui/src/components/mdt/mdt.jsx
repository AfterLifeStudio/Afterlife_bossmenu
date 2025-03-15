import { useEffect, useLayoutEffect, useState } from "react";
import { employdata, dasboarddata, gradedata } from "./debugdata";
import Employees from "./employees";
import Fade from "../../utils/Fade"
import Dashboard from "./dashboard";
import Login from "./login";
import { NuiEvent } from "../../hooks/NuiEvent";
import { nuicallback } from "../../utils/nuicallback";
import JobSelection from "./jobselection";

function MDT() {
  // const [loginstate, setLoginState] = useState(false);
  // const [loadingstate, setLoadingState] = useState(false);
  const [mainjob, setMainJob] = useState(false)
  const [jobselectstate, setJobSelectState] = useState(false);
  const [data, setData] = useState(false)


  useEffect(() => {
    if (mainjob){ 
    nuicallback('GetDashboardData',mainjob).then((response) => setData(response))
  }
  }, [mainjob])
  

  const [menu, setMenu] = useState('dashboard');


  NuiEvent("mdt", (data) => {
    let r = document.querySelector(':root');
    r.style.setProperty('--background', data.theme.background);
    r.style.setProperty('--maincolor', data.theme.maincolor);
    r.style.setProperty('--lightmaincolor', data.theme.lightmaincolor);
    r.style.setProperty('--blackhighlight', data.theme.blackhighlight);
    r.style.setProperty('--white', data.theme.white);
    r.style.setProperty('--gradient', data.theme.gradient);
    r.style.setProperty('--gradient2', data.theme.gradient2);
    setMainJob(data.job)
  });



  const updateaccountbalance = (newamount) => {
    setData({...data, accountmoney: newamount})
  }

  const updatenearbyplayers = (players) => {
    setData({...data, nearbyplayers: players})
  }

  // const loginmdt = () =>{

  //   setLoginState(true)
  //   setLoadingState(true)

  //   setTimeout(() => {
  //     setLoadingState(false)
  //   }, 2000);
  // }


  useEffect(() => {

    const handlekey = (e) => {
      if (data && e.code == 'Escape') {
        setMainJob(false);
        setData(false);
        nuicallback("exit")
      }
    };

    window.addEventListener('keydown',handlekey);
    return () => window.removeEventListener('keydown',handlekey);
  })



  return (
    data &&
    <div className="mdt-wrapper">

      <div className="mdt-navbar">
        <div className="mdt-navbar-items">



          <div onClick={() => setMenu('dashboard')} style={{backgroundColor: menu == 'dashboard' ? 'var(--maincolor)' : ''}} className="navbar-item">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
              <path d="M0 96C0 78.3 14.3 64 32 64l384 0c17.7 0 32 14.3 32 32s-14.3 32-32 32L32 128C14.3 128 0 113.7 0 96zM0 256c0-17.7 14.3-32 32-32l384 0c17.7 0 32 14.3 32 32s-14.3 32-32 32L32 288c-17.7 0-32-14.3-32-32zM448 416c0 17.7-14.3 32-32 32L32 448c-17.7 0-32-14.3-32-32s14.3-32 32-32l384 0c17.7 0 32 14.3 32 32z" />
            </svg>
            <div>Dashboard</div>
          </div>
          <div onClick={() => setMenu('employees')} style={{backgroundColor: menu == 'employees' ? 'var(--maincolor)' : ''}} className="navbar-item">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
              <path d="M144 0a80 80 0 1 1 0 160A80 80 0 1 1 144 0zM512 0a80 80 0 1 1 0 160A80 80 0 1 1 512 0zM0 298.7C0 239.8 47.8 192 106.7 192l42.7 0c15.9 0 31 3.5 44.6 9.7c-1.3 7.2-1.9 14.7-1.9 22.3c0 38.2 16.8 72.5 43.3 96c-.2 0-.4 0-.7 0L21.3 320C9.6 320 0 310.4 0 298.7zM405.3 320c-.2 0-.4 0-.7 0c26.6-23.5 43.3-57.8 43.3-96c0-7.6-.7-15-1.9-22.3c13.6-6.3 28.7-9.7 44.6-9.7l42.7 0C592.2 192 640 239.8 640 298.7c0 11.8-9.6 21.3-21.3 21.3l-213.3 0zM224 224a96 96 0 1 1 192 0 96 96 0 1 1 -192 0zM128 485.3C128 411.7 187.7 352 261.3 352l117.3 0C452.3 352 512 411.7 512 485.3c0 14.7-11.9 26.7-26.7 26.7l-330.7 0c-14.7 0-26.7-11.9-26.7-26.7z" />
            </svg>
            <div>Employees</div>
          </div>
          {/* <div onClick={() => setMenu('accounts')} className="navbar-item">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
              <path d="M512 80c0 18-14.3 34.6-38.4 48c-29.1 16.1-72.5 27.5-122.3 30.9c-3.7-1.8-7.4-3.5-11.3-5C300.6 137.4 248.2 128 192 128c-8.3 0-16.4 .2-24.5 .6l-1.1-.6C142.3 114.6 128 98 128 80c0-44.2 86-80 192-80S512 35.8 512 80zM160.7 161.1c10.2-.7 20.7-1.1 31.3-1.1c62.2 0 117.4 12.3 152.5 31.4C369.3 204.9 384 221.7 384 240c0 4-.7 7.9-2.1 11.7c-4.6 13.2-17 25.3-35 35.5c0 0 0 0 0 0c-.1 .1-.3 .1-.4 .2c0 0 0 0 0 0s0 0 0 0c-.3 .2-.6 .3-.9 .5c-35 19.4-90.8 32-153.6 32c-59.6 0-112.9-11.3-148.2-29.1c-1.9-.9-3.7-1.9-5.5-2.9C14.3 274.6 0 258 0 240c0-34.8 53.4-64.5 128-75.4c10.5-1.5 21.4-2.7 32.7-3.5zM416 240c0-21.9-10.6-39.9-24.1-53.4c28.3-4.4 54.2-11.4 76.2-20.5c16.3-6.8 31.5-15.2 43.9-25.5l0 35.4c0 19.3-16.5 37.1-43.8 50.9c-14.6 7.4-32.4 13.7-52.4 18.5c.1-1.8 .2-3.5 .2-5.3zm-32 96c0 18-14.3 34.6-38.4 48c-1.8 1-3.6 1.9-5.5 2.9C304.9 404.7 251.6 416 192 416c-62.8 0-118.6-12.6-153.6-32C14.3 370.6 0 354 0 336l0-35.4c12.5 10.3 27.6 18.7 43.9 25.5C83.4 342.6 135.8 352 192 352s108.6-9.4 148.1-25.9c7.8-3.2 15.3-6.9 22.4-10.9c6.1-3.4 11.8-7.2 17.2-11.2c1.5-1.1 2.9-2.3 4.3-3.4l0 3.4 0 5.7 0 26.3zm32 0l0-32 0-25.9c19-4.2 36.5-9.5 52.1-16c16.3-6.8 31.5-15.2 43.9-25.5l0 35.4c0 10.5-5 21-14.9 30.9c-16.3 16.3-45 29.7-81.3 38.4c.1-1.7 .2-3.5 .2-5.3zM192 448c56.2 0 108.6-9.4 148.1-25.9c16.3-6.8 31.5-15.2 43.9-25.5l0 35.4c0 44.2-86 80-192 80S0 476.2 0 432l0-35.4c12.5 10.3 27.6 18.7 43.9 25.5C83.4 438.6 135.8 448 192 448z" />
            </svg>
            <div>Accounts</div>
          </div> */}
        </div>

        <div className="mdt-navbar-items">
          <div onClick={() => setJobSelectState(true)}  style={{backgroundColor: menu == 'jobselect' ? 'var(--maincolor)' : ''}} className="navbar-item">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M64 32C28.7 32 0 60.7 0 96l0 64c0 35.3 28.7 64 64 64l384 0c35.3 0 64-28.7 64-64l0-64c0-35.3-28.7-64-64-64L64 32zm280 72a24 24 0 1 1 0 48 24 24 0 1 1 0-48zm48 24a24 24 0 1 1 48 0 24 24 0 1 1 -48 0zM64 288c-35.3 0-64 28.7-64 64l0 64c0 35.3 28.7 64 64 64l384 0c35.3 0 64-28.7 64-64l0-64c0-35.3-28.7-64-64-64L64 288zm280 72a24 24 0 1 1 0 48 24 24 0 1 1 0-48zm56 24a24 24 0 1 1 48 0 24 24 0 1 1 -48 0z"/></svg>
            <div>{mainjob}</div>
          </div>
        </div>
      </div>

      <div className="mdt-container">
        {/* {menu == 'employees' ? <Employees /> : <></> } */}
        <Fade in={menu == 'dashboard'}>
        <Dashboard data={data} updateaccountbalance={updateaccountbalance} updatenearbyplayers={updatenearbyplayers} /> 
        </Fade>
        <Fade in={menu == 'employees'}>
        <Employees job={mainjob} /> 
        </Fade>
        <Fade in={menu == 'jobselect'}>
        <JobSelection /> 
        </Fade>
      </div>

      <Fade in={jobselectstate}>
        <div className="grademenu">
          <div className="grademenu-container">
            <div className="grades-title">
            <div className="grades">Jobs</div>
            <div
            onClick={() => setJobSelectState(false)}
             className="x">X</div>
            </div>
            <div className="grademenu-options">
              {data.otherjobs && data.otherjobs.map((data,index) => (
                <div onClick={() => {
                  setMainJob(data.job)
                  setJobSelectState(false)
                }} className="grade-option">
                  <div>
                  {data.label}
                  </div>
                  <div  className="grade-rank">
                    {index}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
        
      </Fade>

    </div>
  );
}

export default MDT;
