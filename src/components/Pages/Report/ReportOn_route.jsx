import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { FaParking } from "react-icons/fa";
import { GrSettingsOption } from "react-icons/gr";
import { RiGpsFill } from "react-icons/ri";
import { MdMonitor } from "react-icons/md";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BsFillChatDotsFill } from "react-icons/bs";
import { FaUserAlt } from "react-icons/fa";
import { AiFillSetting } from "react-icons/ai";
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import { IoSettingsOutline } from "react-icons/io5";
import { FiLogOut } from "react-icons/fi";
// import './total_no_of_vehicle.css';
import { Link, NavLink } from 'react-router-dom';
import { useLocation } from 'react-router-dom';
import { total } from './data/jsonData';
import { on_route } from './data/jsonData';
import { parked } from './data/jsonData';
import { maintenance } from './data/jsonData';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';



export default function () {

  function tableSearch() {

    let input, filter, table, tr, td, txtValue, errors;

    //Intialising Variables
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("myTable");
    tr = table.getElementsByTagName("tr");

    for (let i = 0; i < tr.length; i++) {
      td = tr[i].getElementsByTagName("td")[1];
      if (td) {
        txtValue = td.textContent || td.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
          tr[i].style.display = "";
        } else {
          tr[i].style.display = "none";
        }
      }
    }
  }

  let [active, setActive] = useState("total_vehicle");
  let [state, setState] = useState("false");
  // const color = () => {
  //     setState(state);
  // }
  const [popup, setPop] = useState(false);
  const handleClickopen = () => {
    setPop(!popup);
  }

  const location = useLocation();
  console.log(location.pathname);
  const [color, setColor] = useState("");
  const getColor = (curr) => {
    if (location.pathname === curr) {
      return 'green'
    }
    else {
      return 'white'
    }

  }

  const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

  const options = {
    headers: {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": `Bearer ${jwt}`
    },

  };

  const url = "http://198.199.67.201:9090/Api/Vehicle/Status/inroute";
  const [dataSource, setDataSource] = useState([])
  const [Loading, setLoading] = useState([])
  useEffect(() => {
    setLoading(true);
    fetch(url, options)
      .then(respnse => respnse.json())
      .then(data => {
        setDataSource(data.inRoutelist)
        console.log(dataSource)
        setLoading(false);

      })
  }, [])

  const url2 = "http://198.199.67.201:9090/Api/Vehicle/All";

  const [dataSource2, setDataSource2] = useState([])
  useEffect(() => {
    setLoading(true);
    fetch(url2, options)
      .then(respnse => respnse.json())
      .then(data => {
        setDataSource2(data.vehicles)
        console.log(dataSource2)
        setLoading(false);

      })
  }, [])

  return (

    <div className="vehicle_container">

      <Navigation path="/report"></Navigation>
      {/* --------------- header --------------- */}

      <Header title="On Route"></Header>

      {/* --------------- users --------------- */}

      <div className='main_content'>
        <div className='vehicle_contents'>
          <Link style={{ textDecoration: 'none' }} to="/report"> <div className='total_vehicle1 '>
            <h4>Total Vehicle</h4>
            <p><AiFillCar size="2.3rem" ></AiFillCar><b>{dataSource2.length}</b></p>

          </div></Link>
          <Link style={{ textDecoration: 'none' }} to="/ReportOn_route"><div className='activeNav' >
            <h4>On Route</h4>
            <p><FaRoute size="2.2rem" ></FaRoute><b>{dataSource.length}</b></p>
          </div></Link>
          <Link style={{ textDecoration: 'none' }} to="/ReportOn_stock">
            <div className='parked'>
              <h4>On Stock</h4>
              <p><FaParking size="2rem" ></FaParking><b></b></p>
            </div>
          </Link>
          <Link style={{ textDecoration: 'none' }} to="/ReportMaintenance">
            <div className='maintenance'>
              <h4>Maintenance</h4>
              <p><IoSettingsOutline size="2rem" ></IoSettingsOutline><b></b></p>
            </div>
          </Link>
        </div>

        {/* --------------- search --------------- */}

        <div className='vehicle_search'>
          <p title='search'>
            <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
            <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
            <button>Search</button>
          </p>
        </div>

        {/* <div className='vehicle_filter'>
          <p>
            <AiFillFilter className='fil' size="0.8rem" color='rgb(63, 63, 63)'></AiFillFilter>
            <h6>Filter</h6>
          </p>
        </div> */}

        {/* --------------------- Table ------------------- */}

        <div>
          {/* {active === "total_vehicle" && <Tables datas={total} title=" Total Vehicle" />}
                    {active === "on_route" && <Tables datas={on_route} title=" On Route" />}
                    {active === "parked" && <Tables datas={parked} title=" Parked" />}
                    {active === "maintenance" && <Tables datas={maintenance} title=" Maintenance" />} */}
        </div>

        <div className='outer_vehicle_tables' id='myTable'>
          <p>On Route</p>

          <table class="vehicle_table" id="myTable">

            <thead>
              <tr>
                <th>Profile</th>
                <th>Assigned Driver</th>
                <th>Vehicle ID</th>
                <th>Vehicle Type</th>
                <th>Plate Number</th>
                <th>Report</th>
                <th>History</th>
              </tr>
            </thead>
            <tbody>
              {dataSource.map(item => (
                <tr className='active_row'>

                  <td>{item.vehicleName}</td>
                  <td>{item.driver}</td>
                  <td>{item.id}</td>
                  <td>{item.vehicleCatagory.catagory}</td>
                  <td>{item.plateNumber}</td>
                  <td><Link to={`/report_detail/${item.id}`}><button>Report</button></Link></td>
                  <td><Link to="/trip_history"><button>History</button></Link></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

      </div>
    </div >
  )
}
