import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { RiGpsFill } from "react-icons/ri";
import { MdMonitor } from "react-icons/md";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BsFillChatDotsFill } from "react-icons/bs";
import { FaUserAlt } from "react-icons/fa";
import { AiFillSetting } from "react-icons/ai";
import { FiLogOut } from "react-icons/fi";
import { FaStarOfLife } from 'react-icons/fa';
import { BsSearch } from "react-icons/bs";
import { HiMenuAlt1 } from "react-icons/hi"; 
import './tracking.css';
import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { Pagination } from 'antd';

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

  const [popup, setPop1] = useState(false);
  const handleClickopen = () => {
    setPop1(!popup);
  }

  const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

  const options = {

    headers: {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": `Bearer ${jwt}`
    },

  };

  const url2 = "http://198.199.67.201:9090/Api/Vehicle/Owner/All";
    const [dataSource2, setDataSource2] = useState([])
    const [Loading, setLoading] = useState([])
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

  // const [list, setList] = useState([dataSource]);
  // const [total, setTotal] = useState(dataSource.length);
  const [page, setCurentPage] = useState(1);
  const [postPerPage, setpostPerPage] = useState(5);

  const indexOfLastPage = page * postPerPage;
  const indexOfFirstPage = indexOfLastPage - postPerPage;
  const currentPage = dataSource2.slice(indexOfFirstPage, indexOfLastPage);

  const onShowSizeChange = (current, pageSize) => {
    setpostPerPage(pageSize);
  }
  const [color, setColor] = useState("green");
  const [margin, setMargin] = useState("");


  return (
    <div className="tacking_container">

      {/*---------------navigation---------------*/}

      <Navigation path="/tracking"></Navigation>

      {/* --------------- tracking header --------------- */}

      <Header title="Tracking"></Header>

      <div className='main_content'>


        {/*-----------------Search bar-------------- */}

        {/*-----------------Search bar rename-------------- */}

        {/* <div className='map_search'>
          <p>
            <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
            <input type="text"  placeholder="Search"></input>
            <button>Search</button>
          </p>
        </div> */}

        {/*---------------- map clone ------------------- */}
        <div className='mapAndSearch'>
          <div className="m-mapclone">
            {/* <p>anduamlak</p> */}
            <iframe width="100%" height="100%" id="gmap_canvas" src="https://maps.google.com/maps?q=ethio&t=&z=11&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
          </div>
          <div className='vehiclesOnMap'>
            <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search . . ."></input>
            <div className='outer_vehicle_tables' id='myTable'>
              <p>Total Vehicle</p>

              <table className="vehicle_table" id="myTable">

                <thead>
                  <tr>
                    {/* <th>Profile</th> */}
                    <th>Assigned Driver</th>
                    {/* <th>Vehicle ID</th> */}
                    {/* <th>Vehicle Type</th> */}
                    <th>Plate Number</th>
                    <th>Detail</th>
                    {/* <th>Tracking</th> */}
                  </tr>
                </thead>
                <tbody>
                  {currentPage.map(item => (
                    <tr className='active_row'>

                      {/* <td>{item.vehicleName}</td> */}
                      <td>{item.driver == null ? "unassignd" : `${item.driver.driverName}`}</td>
                      {/* <td>{item.id}</td> */}
                      {/* <td>{item.vehicleCatagory.catagory}</td> */}
                      <td>{item.plateNumber}</td>
                      <td><Link to={`/vehicle_detail/${item.id}`}><button>Detail</button></Link></td>
                      {/* <td><Link to="/tracking"><button>Tracking</button></Link></td> */}
                    </tr>
                  ))}
                </tbody>
              </table>
              <div className='page'>
              {/* <Pagination
                onChange={(page) => setCurentPage(page)}
                pageSize={postPerPage}
                current={page}
                total={totalPages}
                showQuickJumper
                showSizeChanger
                onShowSizeChange={onShowSizeChange}
              /> */}
            </div>
            </div>

          </div>
        </div>

        {/* <div>
          <Link to="/tracking_hitory"><button className='track_history'>Show Full History</button></Link>
        </div> */}

      </div>
    </div>


  )
}
