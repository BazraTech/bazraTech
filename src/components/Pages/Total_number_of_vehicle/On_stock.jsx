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
import { useState, useEffect } from 'react';
import { RiGpsFill } from "react-icons/ri";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BsFillChatDotsFill } from "react-icons/bs";
import { FaUserAlt } from "react-icons/fa";
import { AiFillSetting } from "react-icons/ai";
import { BiTrip } from "react-icons/bi";
import { ImUserTie } from "react-icons/im";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { Pagination } from 'antd';
import SyncLoader from "react-spinners/SyncLoader";



export default function () {

    function tableSearch() {

        let input, filter, table, tr, td, txtValue, errors;

        //Intialising Variables
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        for (let i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[4];
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
                // console.log(dataSource)
                setLoading(false);

            })
    }, [])

    const [totalPages, setTotalPage] = useState(1);
    const url2 = "http://198.199.67.201:9090/Api/Admin/All/Vehicles";
    const [dataSource2, setDataSource2] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.vehicles)
                setTotalPage(data.totalVehicles);
                // console.log(dataSource2)
                setLoading(false);

            })
    }, [])

    const url3 = "http://198.199.67.201:9090/Api/Vehicle/Status/stocked";
    const [dataSource3, setDataSource3] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url3, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.stockedList)
                console.log(dataSource3)
                setLoading(false);

            })
    }, [])

    const url4 = "http://198.199.67.201:9090/Api/Vehicle/Status/maintaining";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url4, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data.maintainingList)
                console.log(dataSource4)
                setLoading(false);

            })
    }, [])

    const [list, setList] = useState([dataSource]);
    const [total, setTotal] = useState(dataSource.length);
    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(5);

    const indexOfLastPage = page * postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    const currentPage = dataSource2.slice(indexOfFirstPage, indexOfLastPage);

    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }

    // useEffect(() => {
    //     setTotal([dataSource2.length])
    // }, []);

    // const indexOfLastPage = page * postPerPage;
    // const indexOfFirstPage = indexOfLastPage - postPerPage;
    // const currentPage = dataSource2.slice(indexOfFirstPage, indexOfLastPage);
    const [color, setColor] = useState("green");
    const [margin, setMargin] = useState("");


    return (

        <div className="vehicle_container">

            {/*---------------navigation---------------*/}
            
            <Navigation path="/Total_number_of_vehicle"></Navigation>

            {/* --------------- header --------------- */}

            <Header title="On Stock"></Header>

            {/* --------------- users --------------- */}

            <div className='main_content'>
                <div className='vehicle_contents0'>
                    <Link to="/Total_number_of_vehicle" style={{ textDecoration: 'none' }}> <div className='on_route1 '>
                        <h4>Total Vehicle</h4>
                        <p><AiFillCar size="2.2rem"></AiFillCar><b>{dataSource2.length}</b></p>

                    </div></Link>

                    <Link style={{ textDecoration: 'none' }} to="/on_route"><div className='on_route1'>
                        <h4>On Route</h4>
                        <p><FaRoute size="2rem" ></FaRoute><b>{dataSource.length}</b></p>
                    </div></Link>

                    <Link style={{ textDecoration: 'none' }} to="/on_stock">
                        <div className='activeNav'>
                            <h4>On Stock</h4>
                            <p><FaParking size="2rem" ></FaParking><b>{dataSource3.length}</b></p>
                        </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/parked">
                        <div className='maintenance1'>
                            <h4>Parked</h4>
                            <p><IoSettingsOutline size="2rem" ></IoSettingsOutline><b>{dataSource4.length}</b></p>
                        </div>
                    </Link>
                    <Link style={{ textDecoration: 'none' }} to="/maintenance">
                        <div className='maintenance1'>
                            <h4>Maintenance</h4>
                            <p><IoSettingsOutline size="2rem" ></IoSettingsOutline><b>{dataSource4.length}</b></p>
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
                {Loading ?
                    <p className='loading'><SyncLoader
                        color={color}
                        Left={margin}
                        loading={Loading}
                        size={10}
                        aria-label="Loading Spinner"
                        data-testid="loader"
                    /></p>
                    :

                    <>
                        <div className='outer_vehicle_tables' id='myTable'>
                            <p>On Stock Vehicles</p>

                            <table className="vehicle_table" id="myTable">

                                <thead>
                                    <tr>
                                        <th>Profile</th>
                                        <th>Assigned Driver</th>
                                        <th>Vehicle ID</th>
                                        <th>Vehicle Type</th>
                                        <th>Plate Number</th>
                                        <th>Status</th>
                                        <th>Detail</th>
                                        <th>Tracking</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {/* {currentPage.map(item => (
                                        <tr className='active_row'>

                                            <td>{item.vehicleName}</td>
                                            <td>{item.driver == null ? "unassignd" : `${item.driver.driverName}`}</td>
                                            <td>{item.id}</td>
                                            <td>{item.vehicleCatagory.catagory}</td>
                                            <td>{item.plateNumber}</td>
                                            <td>{item.status}</td>
                                            <td><Link to={`/vehicle_detail/${item.id}`}><button>Detail</button></Link></td>
                                            <td><Link to="/tracking"><button>Tracking</button></Link></td>
                                        </tr>
                                    ))} */}
                                </tbody>
                            </table>
                        </div>
                        <div className='page'>
                        <Pagination
                            onChange={(page) => setCurentPage(page)}
                            pageSize={postPerPage}
                            current={page}
                            total={totalPages}
                            showQuickJumper
                            showSizeChanger
                            onShowSizeChange={onShowSizeChange}
                        />
                        </div>
                    </>

                }





            </div>

        </div >
    )
}
