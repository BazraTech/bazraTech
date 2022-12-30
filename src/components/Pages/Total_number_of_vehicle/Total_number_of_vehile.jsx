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
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { AiFillCaretDown } from "react-icons/ai";
import { GrFormNext } from "react-icons/gr";
import { GrFormPrevious } from "react-icons/gr";
import { FaParking } from "react-icons/fa";
import { GrSettingsOption } from "react-icons/gr";
import { HiMenuAlt1 } from "react-icons/hi";
import './total_no_of_vehicle.css';
import { Link, NavLink } from 'react-router-dom';
import { useState } from 'react';
import { useLocation} from 'react-router-dom';
import { total } from './data/jsonData';
import { on_route } from './data/jsonData';
import { parked } from './data/jsonData';
import { maintenance } from './data/jsonData';
import Tables from './Tables';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
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
    const getColor = (curr) =>{
        if (location.pathname === curr) 
        {
            return 'green'
        }
        else
        {
            return 'white'
        }

    }

    return (

        <div className="vehicle_container"> 

            {/*---------------navigation---------------*/}

           
                     <Navigation></Navigation>

            {/* --------------- header --------------- */}

            <Header title="Vehicles"></Header>

            {/* --------------- users --------------- */}

            <div className='vehicle_outer' type="button" >
                <div className='vehicle_contents'>
                    <div className='total_vehicle ' onClick={() => setActive("total_vehicle")}>
                        <h4>Total Vehicle</h4>

                        <p><AiFillCar size="2.3rem" color='black'></AiFillCar><b>100</b></p>

                    </div>
                    <div className='on_route' onClick={() => setActive("on_route")} >
                        <h4>On Route</h4>
                        <p><FaRoute size="2.2rem" color='black'></FaRoute><b>100</b></p>
                    </div>
                    <div className='parked' onClick={() => setActive("parked")}>
                        <h4>Parked</h4>
                        <p><FaParking size="2rem" color='black'></FaParking><b>10</b></p>
                    </div>
                    <div className='maintenance' onClick={() => setActive("maintenance")}>
                        <h4>Maintenance</h4>
                        <p><GrSettingsOption size="2rem" color='black'></GrSettingsOption><b>10</b></p>
                    </div>
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
                    {active === "total_vehicle" && <Tables datas={total} title=" Total Vehicle" />}
                    {active === "on_route" && <Tables datas={on_route} title=" On Route" />}
                    {active === "parked" && <Tables datas={parked} title=" Parked" />}
                    {active === "maintenance" && <Tables datas={maintenance} title=" Maintenance" />}
                </div>

            </div>
        </div >
    )
}
