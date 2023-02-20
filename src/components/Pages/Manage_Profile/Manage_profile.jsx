import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { FaParking } from "react-icons/fa";
import { GrSettingsOption } from "react-icons/gr";
import { IoSettingsOutline } from "react-icons/io5";
import './mangeProfile.css';
import { Link, NavLink } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
// import { total } from './data/jsonData';
// import { on_route } from './data/jsonData';
// import { parked } from './data/jsonData';
// import { maintenance } from './data/jsonData';
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
            td = tr[i].getElementsByTagName("td")[2];
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
    const phone = "0927272727";
    console.log(phone)

    const [totalPages, setTotalPage] = useState(1);
    const [dataSource, setDataSource] = useState([])
    const [Loading, setLoading] = useState([])
    const url = `http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/${phone}`;
    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data)
                setTotalPage(data.totalPages)

                console.log(dataSource)
                setLoading(false)
            })
    }, [])

    const url2 = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/";
    const [dataSourc2, setDataSource2] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.vehicleOwnerINF)
                // console.log(dataSource2)
                setLoading(false);

            })
    }, [])

    const [list, setList] = useState(dataSource);
    const [total, setTotal] = useState(dataSource.length);
    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(10);

    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }

    // useEffect(() => {
    //     setTotal([dataSource2.length])
    // }, []);

    const indexOfLastPage = page + postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    // const currentPage = dataSource.slice(indexOfFirstPage, indexOfLastPage);
    const [color, setColor] = useState("green");
    const [margin, setMargin] = useState("");


    return (

        <div className="vehicle_container">

            {/*---------------navigation---------------*/}

            <Navigation path="/Manage_profile"  title="Manage Profile"></Navigation>
            

            {/* --------------- header --------------- */}

            {/* <Header title="Manage Profile"></Header> */}

            {/* --------------- users --------------- */}
            <div className='main_content'>
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
                        <div style={{ marginTop: "20px" }} className='outer_vehicle_tables' id='myTable'>
                            <p>Super Admin</p>

                            <table class="vehicle_table" id="myTable">
                                <thead>
                                    <tr>
                                        <th>First Name</th>
                                        <th>Last Name</th>
                                        <th>Role</th>
                                        <th>Email</th>
                                        {/* <th>Total Driver</th> */}
                                        <th>Status</th>
                                        <th>Profile</th>
                                        <th>Change Password</th>
                                        {/* <th>Add Driver</th> */}
                                    </tr>
                                </thead>
                                <tbody>
                                 
                                        <tr className='active_row'>
                                            {/* <td></td> */}
                                            <td>{dataSource.role == "OWNER" ? `${dataSource.companyName}` : `${dataSource.firstName}` + " " + `${dataSource.lastName}`}</td>
                                            <td>Last Name</td>
                                            <td>{dataSource.role}</td>
                                            <td>{dataSource.totalVehicles}</td>
                                            <td>Active</td>
                                            <td><Link to={`/user_edit/${dataSource.role}/${dataSource.id}/${dataSource.companyId}`}>
                                                <button>Detail</button></Link></td>
                                                <td><Link style={{ textDecoration: 'none' }} to="#">
                                             <lable className='mangProfileButton' onClick={() => {
                                                 // handleClickopen()
                                                 // setOwnerPhone(item.phoneNumber)
                                             }}>Change Password</lable></Link></td>
                                        </tr>
                                    
                                </tbody>
                            </table>
                        </div>
                        <div className='page'>
                            <Pagination
                                onChange={(page) => setCurentPage(page)}
                                pageSize={postPerPage}
                                current={page}
                                total={total}
                                showQuickJumper
                                showSizeChanger
                                onShowSizeChange={onShowSizeChange}
                            />
                        </div>
                    </>
                }

                <div className='mangeProfile'>
                    <p title='search'>
                        <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" placeholder="Search"></input>
                        {/* onKeyUp={tableSearch} */}
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
                            <p>List of Admins</p>

                            <table class="vehicle_table" id="myTable">
                                <thead>
                                <tr>
                                        <th>Full Name</th>
                                        {/* <th>Last Name</th> */}
                                        <th>Role</th>
                                        <th>Email</th>
                                        {/* <th>Total Driver</th> */}
                                        <th>Status</th>
                                        <th>Assign Role</th>
                                        <th>Profile</th>
                                        <th>Change Password</th>
                                        <th>Account</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {dataSourc2.map(item => (
                                         <tr className='active_row'>
                                         <td>{item.role == "OWNER" ? `${item.companyName}` : `${item.firstName}` + " " + `${item.lastName}`}</td>
                                         <td>{item.role}</td>
                                         <td>username@gmail.com</td>
                                         <td>Active</td>
                                         <td><Link style={{ textDecoration: 'none' }} to={`/user_edit/${item.role}/${item.id}/${item.companyId}`}>
                                             <button className='mangProfileButton'>Assign</button></Link></td>
                                             <td><Link style={{ textDecoration: 'none' }} to={`/user_edit/${item.role}/${item.id}/${item.companyId}`}>
                                             <button className='mangProfileButton'>Detail</button></Link></td>
                                         <td><Link style={{ textDecoration: 'none' }} to="#">
                                             <lable className='mangProfileButton' onClick={() => {
                                             }}>Change Password</lable></Link></td>
                                         <td><Link style={{ textDecoration: 'none' }} to="#"><lable className='DeleteProfileButton'>Lock</lable></Link></td>
                                     </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                        <div className='page'>
                            <Pagination
                                onChange={(page) => setCurentPage(page)}
                                pageSize={postPerPage}
                                current={page}
                                total={total}
                                showQuickJumper
                                showSizeChanger
                                onShowSizeChange={onShowSizeChange}
                            />
                        </div>
                    </>
                }


            </div>

        </div>

    )
}
