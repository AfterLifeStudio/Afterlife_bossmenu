import { useEffect, useState } from "react";
import { employdata, gradedata } from "./debugdata";
import { nuicallback } from "../../utils/nuicallback";
import Fade from "../../utils/Fade"


const Employees = () => {
  const [gradesdata, setGradesData] = useState(gradedata)
  const [searcheddata, setSearcheddata] = useState(employdata);
  const [data, setData] = useState(employdata);
  const [counter, setCounter] = useState(-1);
  const [filtereddata, setFiltereddata] = useState([]);
  const [maxpages, setMaxpages] = useState(0);
  const [page, setPage] = useState(1);

  const [gradestate, setGradeState] = useState(false);
  const [firestate, setFireState] = useState(false);

  useEffect(() => {
    nuicallback('GetJobPlayers').then((response) => {
      setData(response.players)
      setSearcheddata(response.players)
      setGradesData(response.grades)
    })
  }, [])



  const pageincrement = () => {
    if (page < maxpages) {
      setPage(page + 1)
    }
  }


  const pagedecrement = () => {
    if (page > 1) {
      setPage(page - 1)
    }
  }


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
    setCounter(-1)
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

    if (event.target.value == '') {
      setSearcheddata(data)
    } else {

      const searchdata = []
      for (const i in data) {

        if (data[i].name.includes(event.target.value)) {
          searchdata.push(data[i])
        }
      }

      setSearcheddata(searchdata)
    }
    handlepage(1)
  }




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
          backgroundColor: page == key ? "rgba(0, 0, 0, 0.25)" : "transparent",
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
                      page == 1 ? "rgba(0, 0, 0, 0.25)" : "transparent",
                  }}
                  onClick={() => handlepage(1)}
                  className="page-button"
                >
                  1
                </div>
                <div
                  style={{
                    backgroundColor:
                      page == 2 ? "rgba(0, 0, 0, 0.25)" : "transparent",
                  }}
                  onClick={() => handlepage(2)}
                  className="page-button"
                >
                  2
                </div>
                <div
                  style={{
                    backgroundColor:
                      page == 3 ? "rgba(0, 0, 0, 0.25)" : "transparent",
                  }}
                  onClick={() => handlepage(3)}
                  className="page-button"
                >
                  3
                </div>
                <div
                  style={{
                    backgroundColor:
                      page == 4 ? "rgba(0, 0, 0, 0.25)" : "transparent",
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
                  setFireState(true)
                }
              }}
              className={`employees-button ${counter > -1 ? "employeesaction" : "disabledbutton"
                }`}
            >
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                <path d="M96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM0 482.3C0 383.8 79.8 304 178.3 304l91.4 0C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7L29.7 512C13.3 512 0 498.7 0 482.3zM472 200l144 0c13.3 0 24 10.7 24 24s-10.7 24-24 24l-144 0c-13.3 0-24-10.7-24-24s10.7-24 24-24z" />
              </svg>
            </div>
            <div
              onClick={() => {
                if (counter > -1) {
                  setGradeState(true)
                }
              }}
              className={`employees-button ${counter > -1 ? "employeesaction" : "disabledbutton"
                }`}
            >
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                <path d="M96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM0 482.3C0 383.8 79.8 304 178.3 304l91.4 0C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7L29.7 512C13.3 512 0 498.7 0 482.3zM504 312l0-64-64 0c-13.3 0-24-10.7-24-24s10.7-24 24-24l64 0 0-64c0-13.3 10.7-24 24-24s24 10.7 24 24l0 64 64 0c13.3 0 24 10.7 24 24s-10.7 24-24 24l-64 0 0 64c0 13.3-10.7 24-24 24s-24-10.7-24-24z" />
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
              <div style={{color: '#86BF79'}} className="salary">{data.salary}$</div>
              {data.status 
                ? <div style={{ color: '#86BF79' }} className="status"><p style={{backgroundColor: '#86BF79'}}></p>nline</div>
                : <div style={{ color: '#BB494B' }} className="status"><p style={{backgroundColor: '#BB494B'}}></p>ffline</div>
              }

            </div>
          ))}
        </div>
      </div>

      <Fade in={gradestate}>
        <div className="grademenu">
          <div className="grademenu-container">
            <div className="grademenu-options">
              {gradesdata.map(data => (
                <div onClick={() => {
                  nuicallback('SetGrade', { id: filtereddata[counter].id,job: filtereddata[counter].job, grade: data.id }).then((response) => {
                    setData(response.players)
                    setSearcheddata(response.players)
                  })
                  setGradeState(false)
                }} className="grade-option">{data.label}</div>
              ))}
            </div>
          </div>
        </div>
      </Fade>

      <Fade in={firestate}>
        <div className="grademenu">
          <div className="firemenu-container">
            <div onClick={() => {
              nuicallback('Fire', { id: filtereddata[counter].id,job: 'umemployed', grade: 0 }).then((response) => {
                setData(response.players)
                setSearcheddata(response.players)
              })
              setFireState(false)
            }} className="fire-confirm">Fire</div>
          </div>
        </div>
      </Fade>
    </>
  );
};

export default Employees;
