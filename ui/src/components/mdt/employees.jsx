import { useEffect, useState } from "react";
import { employdata, gradedata } from "./debugdata";
import { nuicallback } from "../../utils/nuicallback";
import Fade from "../../utils/Fade";

const Employees = (jdata) => {
  const [gradesdata, setGradesData] = useState(gradedata);
  const [searcheddata, setSearcheddata] = useState([]);
  const [data, setData] = useState([]);
  const [counter, setCounter] = useState(-1);
  const [filtereddata, setFiltereddata] = useState([]);
  const [maxpages, setMaxpages] = useState(0);
  const [page, setPage] = useState(1);

  const [activtystate, setActivityState] = useState(false);
  const [gradestate, setGradeState] = useState(false);

  const debug = {
    checkin: '',
    checkout: '',
    playtime: ''
  }

  useEffect(() => {
    nuicallback("GetJobPlayers", jdata.job).then((response) => {
      setData(response.players);
      setSearcheddata(response.players);
      setGradesData(response.grades);
    });
  }, []);

  const pageincrement = () => {
    if (page < maxpages) {
      setPage(page + 1);
    }
  };

  const pagedecrement = () => {
    if (page > 1) {
      setPage(page - 1);
    }
  };

  useEffect(() => {
    setMaxpages(Math.ceil(searcheddata.length / 10));

    var items = page * 10;
    var dat = [];
    for (let i = items - 10; i < items; i++) {
      if (searcheddata[i]) {
        dat.push(searcheddata[i]);
      }
    }
    setFiltereddata(dat);
    setCounter(-1);
  }, [page, searcheddata]);

  const handlepage = (newpage) => {
    setPage(newpage);
    var items = newpage * 10;
    var dat = [];
    for (let i = items - 10; i < items; i++) {
      if (searcheddata[i]) {
        dat.push(searcheddata[i]);
      }
    }
    setFiltereddata(dat);
  };

  const search = (event) => {
    if (event.target.value == "") {
      setSearcheddata(data);
    } else {
      const searchdata = [];
      for (const i in data) {
        if (data[i].name.includes(event.target.value)) {
          searchdata.push(data[i]);
        }
      }

      setSearcheddata(searchdata);
    }
    handlepage(1);
  };

  var pagebuttons = [];

  for (
    var i = page == maxpages ? page - 3 : page - 2;
    page == maxpages ? i <= page : i <= page + 1;
    i++
  ) {
    const key = i;
    pagebuttons.push(
      <div
        style={{
          backgroundColor: page == key ? "--var(maincolor)" : "transparent",
        }}
        onClick={() => handlepage(key)}
        className="page-button"
      >
        {i}
      </div>
    );
  }

  return (
    <>
      <div className="menu">
        <div className="employees-options">
          <div className="first">
            <input
              onInput={search}
              placeholder="search"
              className="searchbar"
              type="text"
            />
          </div>
          <div className="second">
            <div onClick={pagedecrement} className="page-button">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512">
                <path d="M9.4 278.6c-12.5-12.5-12.5-32.8 0-45.3l128-128c9.2-9.2 22.9-11.9 34.9-6.9s19.8 16.6 19.8 29.6l0 256c0 12.9-7.8 24.6-19.8 29.6s-25.7 2.2-34.9-6.9l-128-128z" />
              </svg>
            </div>

            {page < 4 ? (
              <>
                <div
                  style={{
                    backgroundColor:
                      page == 1 ? "var(--maincolor)" : "transparent",
                  }}
                  onClick={() => handlepage(1)}
                  className="page-button"
                >
                  1
                </div>
                <div
                  style={{
                    backgroundColor:
                      page == 2 ? "var(--maincolor)" : "transparent",
                  }}
                  onClick={() => handlepage(2)}
                  className="page-button"
                >
                  2
                </div>
                <div
                  style={{
                    backgroundColor:
                      page == 3 ? "var(--maincolor)" : "transparent",
                  }}
                  onClick={() => handlepage(3)}
                  className="page-button"
                >
                  3
                </div>
                <div
                  style={{
                    backgroundColor:
                      page == 4 ? "var(--maincolor)" : "transparent",
                  }}
                  onClick={() => handlepage(4)}
                  className="page-button"
                >
                  4
                </div>
              </>
            ) : (
              pagebuttons
            )}
            <div className="page-button">....</div>
            <div onClick={() => handlepage(maxpages)} className="page-button">
              {maxpages}
            </div>
            <div onClick={pageincrement} className="page-button">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512">
                <path d="M246.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-128-128c-9.2-9.2-22.9-11.9-34.9-6.9s-19.8 16.6-19.8 29.6l0 256c0 12.9 7.8 24.6 19.8 29.6s25.7 2.2 34.9-6.9l128-128z" />
              </svg>
            </div>
            <div
              onClick={() => {
                if (counter > -1) {
                  nuicallback("Fire", {
                    id: filtereddata[counter].id,
                    job: filtereddata[counter].job,
                  }).then((response) => {
                    setData(response.players);
                    setSearcheddata(response.players);
                  });
                }
              }}
              className={`employees-button ${
                counter > -1 ? "employeesaction" : "disabledbutton"
              }`}
            >
              <div className="fire-hover">Fire</div>
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                <path d="M96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM0 482.3C0 383.8 79.8 304 178.3 304l91.4 0C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7L29.7 512C13.3 512 0 498.7 0 482.3zM472 200l144 0c13.3 0 24 10.7 24 24s-10.7 24-24 24l-144 0c-13.3 0-24-10.7-24-24s10.7-24 24-24z" />
              </svg>
            </div>

            <div
              onClick={() => {
                if (counter > -1) {
                  setGradeState(true);
                }
              }}
              className={`employees-button ${
                counter > -1 ? "employeesaction" : "disabledbutton"
              }`}
            >
              <div className="fire-hover">Promote</div>
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                <path d="M96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM0 482.3C0 383.8 79.8 304 178.3 304l91.4 0C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7L29.7 512C13.3 512 0 498.7 0 482.3zM504 312l0-64-64 0c-13.3 0-24-10.7-24-24s10.7-24 24-24l64 0 0-64c0-13.3 10.7-24 24-24s24 10.7 24 24l0 64 64 0c13.3 0 24 10.7 24 24s-10.7 24-24 24l-64 0 0 64c0 13.3-10.7 24-24 24s-24-10.7-24-24z" />
              </svg>
            </div>

            <div
              onClick={() => {
                if (counter > -1) {
                  nuicallback('GetPlayerActivity',{job: jdata.job, id: filtereddata[counter].id}).then((response) => setActivityState(response))
                }
              }}
              className={`employees-button ${
                counter > -1 ? "employeesaction" : "disabledbutton"
              }`}
            >
              <div className="fire-hover">Activity</div>
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
                <path d="M160 80c0-26.5 21.5-48 48-48l32 0c26.5 0 48 21.5 48 48l0 352c0 26.5-21.5 48-48 48l-32 0c-26.5 0-48-21.5-48-48l0-352zM0 272c0-26.5 21.5-48 48-48l32 0c26.5 0 48 21.5 48 48l0 160c0 26.5-21.5 48-48 48l-32 0c-26.5 0-48-21.5-48-48L0 272zM368 96l32 0c26.5 0 48 21.5 48 48l0 288c0 26.5-21.5 48-48 48l-32 0c-26.5 0-48-21.5-48-48l0-288c0-26.5 21.5-48 48-48z" />
              </svg>
            </div>
          </div>
        </div>
        <div className="employees-wrapper">
          <div className="employee-title">
            <div className="name">NAME</div>
            <div className="gender">GENDER</div>
            <div className="rank">RANK</div>
            <div className="salary">SALARY</div>
            <div className="status">STATUS</div>
          </div>

          {filtereddata.map((data, index) => (
            <div
              onClick={() => setCounter(index)}
              style={{
                backgroundColor: counter == index ? "rgba(0, 0, 0, 0.25)" : "",
              }}
              className="employee"
            >
              <div className="name">{data.name}</div>
              <div className="gender">{data.gender}</div>
              <div className="rank">{data.rank}</div>
              <div style={{ color: "#86BF79" }} className="salary">
                {data.salary}$
              </div>
              {data.status ? (
                <div style={{ color: "#86BF79" }} className="status">
                  <p style={{ backgroundColor: "#86BF79" }}></p>nline
                </div>
              ) : (
                <div style={{ color: "#BB494B" }} className="status">
                  <p style={{ backgroundColor: "#BB494B" }}></p>ffline
                </div>
              )}
            </div>
          ))}
        </div>
      </div>

      <Fade in={gradestate}>
        <div className="grademenu">
          <div className="grademenu-container">
            <div className="grades-title">
              <div className="grades">GRADES</div>
              <div onClick={() => setGradeState(false)} className="x">
                X
              </div>
            </div>
            <div className="grademenu-options">
              {gradesdata.map((data) => (
                <div
                  onClick={() => {
                    nuicallback("SetGrade", {
                      id: filtereddata[counter].id,
                      job: filtereddata[counter].job,
                      grade: data.id,
                    }).then((response) => {
                      setData(response.players);
                      setSearcheddata(response.players);
                    });
                    setGradeState(false);
                  }}
                  className="grade-option"
                >
                  <div>{data.label}</div>
                  <div className="grade-rank">{data.id}</div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </Fade>

      <Fade in={activtystate ? true : false}>
        <div className="grademenu">
          
          <div className="activity-container">

                          <div onClick={() => setActivityState(false)} className="activty-close">X</div>
            <div style={{ flexDirection: "column",paddingTop: 15, }} className="profile">
              <div className="profile-image">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
                  <path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512l388.6 0c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304l-91.4 0z" />
                </svg>
              </div>
              <div style={{ alignItems: "center" }} className="profile-info">
                <div className="firstname">Osman Saleem</div>
 
              </div>
            </div>

            <div className="grademenu-options">

              <div className="grade-option">
                <div>{activtystate.checkin}</div>
                <div className="logs-icon">
                <div className="logs-hover">Check In</div>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M377.9 105.9L500.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L377.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1-128 0c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM160 96L96 96c-17.7 0-32 14.3-32 32l0 256c0 17.7 14.3 32 32 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-64 0c-53 0-96-43-96-96L0 128C0 75 43 32 96 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32z"/></svg>
                </div>
              </div>
              <div className="grade-option">
                <div>{activtystate.checkout}</div>
                <div className="logs-icon">
                <div className="logs-hover">Check Out</div>
                <svg style={{transform: 'rotate(180deg)'}} xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M377.9 105.9L500.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L377.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1-128 0c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM160 96L96 96c-17.7 0-32 14.3-32 32l0 256c0 17.7 14.3 32 32 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-64 0c-53 0-96-43-96-96L0 128C0 75 43 32 96 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32z"/></svg>
                </div>
              </div>
              <div className="grade-option">
                <div>{activtystate.playtime}</div>
                <div className="logs-icon">
                <div className="logs-hover">Playtime</div>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><path d="M160 80c0-26.5 21.5-48 48-48l32 0c26.5 0 48 21.5 48 48l0 352c0 26.5-21.5 48-48 48l-32 0c-26.5 0-48-21.5-48-48l0-352zM0 272c0-26.5 21.5-48 48-48l32 0c26.5 0 48 21.5 48 48l0 160c0 26.5-21.5 48-48 48l-32 0c-26.5 0-48-21.5-48-48L0 272zM368 96l32 0c26.5 0 48 21.5 48 48l0 288c0 26.5-21.5 48-48 48l-32 0c-26.5 0-48-21.5-48-48l0-288c0-26.5 21.5-48 48-48z"/></svg>
                </div>
              </div>

            </div>

          </div>
        </div>
      </Fade>
    </>
  );
};

export default Employees;
