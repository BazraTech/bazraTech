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
import Table from './Table';

export default function () {

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


    const [search, setSearch] = useState('');
    const [loading, setLoading] = useState(false);
    const [popup1, setPop1] = useState(true);

    const [totalPages, setTotalPage] = useState(1);

    // const url2 = "http://198.199.67.201:9090/Api/Admin/All/Vehicles";
    // const [dataSource2, setDataSource2] = useState([])
    // useEffect(() => {
    //     setLoading(true);
    //     fetch(url2, options)
    //         .then(respnse => respnse.json())
    //         .then(data => {
    //             setDataSource2(data.vehicles)
    //             setTotalPage(data.totalVehicles);
    //             // console.log(dataSource2)
    //             setLoading(false);

    //         })
    // }, [])

    const [id, setId] = useState("");
    const [role, setRole] = useState("");

    const [visiblelist, setvisiblelist] = useState(false);
    const [visible, setVisible] = useState(false);

    // let url2;

    const displaylist = () => {
        setVisible2(); 
    }
    const setVisible2 = () => {
        console.log(role)
        setVisible(!visible);
    }
   
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

   

    const [dataSource, setDataSource] = useState([])
    // const [Loading, setLoading] = useState([])
    const url = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/";
    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.vehicleOwnerINF)
                // setTotalPage(data.totalPages)

                console.log(dataSource)
                setLoading(false)
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
    let [active, setActive] = useState("");

    return (

        <div className="dashboard_container">

            {/*---------------navigation---------------*/}

            <Navigation path="/avialable_trip"></Navigation>

            {/* ---------------header--------------- */}

            <Header title="Avialable Trip"></Header>


            {/* ---------------contents--------------- */}

            <section className='register'>

                <div className='company_individual_header'>
                    <Link style={{ textDecoration: 'none' }} to="/avialable_trip"><p><h1 className='nmn'>Avialable Vehicles</h1></p></Link>
                    <Link style={{ textDecoration: 'none' }} to="/trip_history"><p><h1 className='nmnn'>Vehicles History</h1></p></Link>
                </div>

                <form className='form' onSubmit={handleSubmit(onSubmit)}>
                    <div className='allDiv'>

                        <div className='trip_date'>
                            <input onChange={(e) => setSearch(e.target.value)} placeholder='Search...' className='trip_date1' type="search" /><button>Search</button>
                        </div>
                        <div>
                            <h1 className='greentrip'>List Of Companys</h1>
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
                                        {
                                            dataSource.map(item => (
                                                <>
                                                    <div className='companyList' onClick={() => {
                                                        displaylist()
                                                        setvisiblelist(item.id)
                                                        setId(item.id)
                                                        setRole(item.role)
                                                    }} >
                                                        <p>Company id : <b className='green'>{item.id}</b></p>
                                                        <p>Available Vehicle : <b className='green'>{item.totalVehicles}</b></p>
                                                        <p className='dropdownVehicle'>{visible && item.id == visiblelist ? <AiOutlineMinus top="10px" size="1rem" color='White' onChange={displaylist}></AiOutlineMinus> :
                                                            <BsPlusLg size="1rem" color='White' onClick={() => {
                                                                displaylist()
                                                                setId(item.id)
                                                                setRole(item.role)
                                                                setvisiblelist(item.id)
                                                            }}></BsPlusLg>}</p>
                                                        {/* <td></td> */}
                                                    </div>
                                                    {visible && item.id == visiblelist && <Table style={{transition: "0.5s"}}  role={role} id={id} name={item.role == "OWNER" ? `${item.companyName}` : `${item.firstName}` + " " + `${item.lastName}`} />}
                                                     {/* <Table style={{transition: "0.5s"}}  role={role} id={id} name={item.role == "OWNER" ? `${item.companyName}` : `${item.firstName}` + " " + `${item.lastName}`} /> */}

                                                </>
                                            ))
                                        }
                                    </>
                            }

                        </div>

                    </div>
                </form>
            </section>


            {/* ---------------end contents--------------- */}


        </div>

    )
}
