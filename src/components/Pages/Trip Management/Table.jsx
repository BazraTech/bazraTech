import React from 'react'
import './available.css';
import { Link } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { useForm } from 'react-hook-form';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { total } from './data/data';
import { IoMdArrowDropdownCircle } from "react-icons/io";
import { IoMdArrowDropupCircle } from "react-icons/io";
import { BsPlusLg } from "react-icons/bs";
import { AiOutlineMinus } from "react-icons/ai";
import SyncLoader from "react-spinners/SyncLoader";
import { Pagination } from 'antd';
import { getRoles } from '@testing-library/react';

export default function ({ id, role, name }) {

    const {
        register,
        handleSubmit,
        watch,
        formState: { errors },
    } = useForm();
    const onSubmit = (data) => {
        console.log(data);
    };

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api
    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
    };

    const urlFour = "http://198.199.67.201:9090/Api/SignIn/Admin";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        fetch(urlFour, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data)
                console.log(dataSource4)
            })
    }, [])


    const [popup, setPop] = useState(false);
    const [state, setState] = useState("");
    const handleClickopen = () => {
        setPop(!popup);
    }
    // {
    //     total[0]
    //     .map((item) => {
    //         setState(item.assignedDriver.toLowerCase().includes(search))
    //     })}


    const [search, setSearch] = useState('');
    // if (search === state) {
    //   alert("success")
    //  }

    const [loading, setLoading] = useState(false);
    const [popup1, setPop1] = useState(true);

    const [totalPages, setTotalPage] = useState(1);
    // const [id, setId] = useState()
    // id="13";
    const [dataSource01, setDataSource501] = useState([])
    // const [dataSource2, setDataSource2] = useState([])
    const [dataSource3, setDataSource3] = useState([])
    const [dataSource5, setDataSource5] = useState([])


    // const [id, setId] = useState()
    // const [role, setRole] = useState()

    const [visiblelist, setvisiblelist] = useState(true);
    const [visible, setVisible] = useState(true);
    const displaylist = () => {
        setVisible(!visible);
        console.log(id);
        console.log(role);
    }


    let url2;

    if (role === "OWNER") {
        url2 = `http://198.199.67.201:9090/Api/Admin/All/CompanyVehicleOwner/${id}`;
    }
    if (role === "INDIVIDUAL") {
        url2 = `http://198.199.67.201:9090/Api/Admin/All/IndividualVehicleOwner/${id}`;
    }
    const [dataSource, setDataSource] = useState([])
    useEffect(() => {
        setLoading(true)
        fetch(url2, options)
            .then((response) => response.json())
            .then((json) => {
                // setDataSource(json)
                // setDataSource2(json.companyAddressINF)
                // setDataSource3(json.drivers)
                setDataSource(json.ownerINF.vehicles)
                console.log(json)
                setLoading(false)
            });
    }, [])




    // const [dataSource, setDataSource] = useState([])
    // // const [Loading, setLoading] = useState([])
    // const url = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/";
    // useEffect(() => {
    //     setLoading(true)
    //     fetch(url, options)
    //         .then(respnse => respnse.json())
    //         .then(data => {
    //             setDataSource(data.vehicleOwnerINF)
    //             // setTotalPage(data.totalPages)

    //             console.log(dataSource)
    //             setLoading(false)
    //         })
    // }, [])

    const [list, setList] = useState([dataSource]);
    const [total, setTotal] = useState(dataSource.length);
    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(5);

    const indexOfLastPage = page * postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    const currentPage = dataSource.slice(indexOfFirstPage, indexOfLastPage);

    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }



    return (



        <form className='form' onSubmit={handleSubmit(onSubmit)}>
            <div className='' >
                {visible ?
                    <>
 
                        <div className='trip_date'>
                            <input onChange={(e) => setSearch(e.target.value)} placeholder='Search...' className='trip_date1' type="search" /><button>Search</button>
                        </div>

                        {

                            loading ?
                                <p className='loading'><SyncLoader
                                    // color={color}
                                    // Left={margin}
                                    loading={loading}
                                    // cssOverride={override}
                                    size={10}
                                    // margin= "100px 0px 0px 0px"
                                    // padding= "200px"
                                    aria-label="Loading Spinner"
                                    data-testid="loader"
                                /></p>
                                :
                                <>
                                    <div className='outer_vehicle_tables' id='myTable'>
                                        <p>{name}</p>

                                        <table class="vehicle_table" id="myTable">

                                            <thead>
                                                <tr>
                                                    <th>Vehicle Name</th>
                                                    <th>Assigned Driver</th>
                                                    <th>Current Location</th>
                                                    <th>Vehicle Type</th>
                                                    <th>Plate Number</th>
                                                    <th>Set Trip</th>
                                                    {/* <th>History</th> */}
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {dataSource.map(item => (
                                                    <tr className='active_row'>

                                                        <td>{item.vehicleName}</td>
                                                        <td>{item.driverName == "null" ? "unassignd" : `${item.driverName}`}</td>
                                                        <td>{item.id}</td>
                                                        <td>{item.vehicleCatagory}</td>
                                                        <td>{item.plateNumber}</td>
                                                        {/* <td><Link to={`/set_trip`}><button>Set Trip</button></Link></td> */}
                                                        <td><Link to={`/set_trip/${item.plateNumber}/${item.driver == "null" ? "unassignd" : `${item.driver}`}`}><button>Set Trip</button></Link></td>
                                                        {/* <td><Link to="/tracking"><button>Tracking</button></Link></td> */}
                                                    </tr>
                                                ))}
                                            </tbody>
                                        </table>
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

                                    </div>

                                </>
                        }

                    </> : ""}




            </div>
        </form>


    )
}
