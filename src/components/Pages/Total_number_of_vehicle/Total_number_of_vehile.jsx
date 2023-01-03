import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { FaParking } from "react-icons/fa";
import { GrSettingsOption } from "react-icons/gr";
import { IoSettingsOutline } from "react-icons/io5";
import './total_no_of_vehicle.css';
import { Link, NavLink } from 'react-router-dom';
import { useState } from 'react';
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

    return (

        <div className="vehicle_container">

            {/*---------------navigation---------------*/}

            <Navigation></Navigation>

            {/* --------------- header --------------- */}

            <Header title="Total Vehicles"></Header>

            {/* --------------- users --------------- */}

            <div className='main_content'>
                <div className='vehicle_contents'>
                   <Link to="/Total_number_of_vehicle" style={{ textDecoration: 'none' }}> <div className='activeNav '>
                        <h4>Total Vehicle</h4>
                        <p><AiFillCar size="2.3rem"></AiFillCar><b>100</b></p>

                    </div></Link>

                    <Link style={{ textDecoration: 'none' }} to="/on_route"><div className='on_route'>
                        <h4>On Route</h4>
                        <p><FaRoute size="2.2rem" ></FaRoute><b>100</b></p>
                    </div></Link>

                    <Link style={{ textDecoration: 'none' }} to="/on_stock">
                    <div className='parked'>
                        <h4>On Stock</h4>
                        <p><FaParking size="2rem" ></FaParking><b>10</b></p>
                    </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/maintenance">
                    <div className='maintenance'>
                        <h4>Maintenance</h4>
                        <p><IoSettingsOutline size="2rem" ></IoSettingsOutline><b>10</b></p>
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

                <div className='vehicle_filter'>
                    <p>
                        <AiFillFilter className='fil' size="0.8rem" color='rgb(63, 63, 63)'></AiFillFilter>
                        <h6>Filter</h6>
                    </p>
                </div>

                {/* --------------------- Table ------------------- */}

                <div>
                    {/* {active === "total_vehicle" && <Tables datas={total} title=" Total Vehicle" />}
                    {active === "on_route" && <Tables datas={on_route} title=" On Route" />}
                    {active === "parked" && <Tables datas={parked} title=" Parked" />}
                    {active === "maintenance" && <Tables datas={maintenance} title=" Maintenance" />} */}
                </div>

                <div className='outer_vehicle_tables' id='myTable'>
        <p>Total Vehicle</p>

        <table class="vehicle_table" id="myTable">

          <thead>
            <tr>
              <th>Profile</th>
              <th>Assigned Driver</th>
              <th>Vehicle ID</th>
              <th>Vehicle Type</th>
              <th>Plate Number</th>
              <th>Detail</th>
              <th>Tracking</th>
            </tr>
          </thead>
          <tbody>
            {total[0].map(item => (
              <tr className='active_row'>

                <td>{item.user}</td>
                <td>{item.assignedDriver}</td>
                <td>{item.vehicleId}</td>
                <td>{item.vehicleType}</td>
                <td>{item.planeNumber}</td>
                <td><Link to="/vehicle_detail"><button className="button">Detail</button></Link></td>
                <td><Link to="/tracking"><button>Tracking</button></Link></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

            </div>
        </div >
    )
}
