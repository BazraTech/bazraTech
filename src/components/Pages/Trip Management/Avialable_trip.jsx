import React from 'react'
// import './available.css';
import styles from './available.module.css';
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
import { BsSearch } from "react-icons/bs";
import Table from './Table';

export default function () {

    function tableSearch() {

        let input, filter, table, tr, td, txtValue, errors;

        //Intialising Variables for search bar
        input = document.getElementById("myInputs");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTables");
        tr = table.getElementsByTagName("trs");

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

    const [popup, setPop] = useState(false);
    const [state, setState] = useState("");
    const handleClickopen = () => {
        setPop(!popup);
    }


    const [search, setSearch] = useState('');
    const [loading, setLoading] = useState(false);
    const [popup1, setPop1] = useState(true);

    const [totalPages, setTotalPage] = useState(1);

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

    const url2 = "http://198.199.67.201:9090/Api/Vehicle/Owner/All";
    const [dataSource2, setDataSource2] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.vehiclesINF)
                setTotalPage(data.totalVehicles);
                setLoading(false);
            })
    }, [])

    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(5);
    const indexOfLastPage = page * postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    const currentPage = dataSource2.slice(indexOfFirstPage, indexOfLastPage);

    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }
    let [active, setActive] = useState("");
    const [color, setColor] = useState("green");
    const [margin, setMargin] = useState("");

    const user = JSON.parse(localStorage.getItem("user"));

    return (

        <div className="">

            {/*---------------navigation---------------*/}

            <Navigation path="/avialable_trip" title="Avialable Trip"></Navigation>

            {/* ---------------contents--------------- */}

            <section className={styles.main_content}>

                <div className={styles.tripHeader}>
                    <Link style={{ textDecoration: 'none' }} to="/avialable_trip"><p><h1 className={styles.avaliableVehicles}>Avialable Vehicles</h1></p></Link>
                    <Link style={{ textDecoration: 'none' }} to="/trip_history"><p><h1>Trip History</h1></p></Link>
                </div>

                <form className='form' onSubmit={handleSubmit(onSubmit)}>
                    <div className={styles.allDiv}>
                        <div>
                            <div className={styles.vehicle_search}>
                                <p title='search'>
                                    <BsSearch className={styles.icn} size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                                    <input type="text" id="myInputa" placeholder="Search"></input>
                                    <button>Search</button>
                                </p>
                            </div>
                            <h1 className={styles.greentrip}>{user.name}</h1>
                            {

                                loading ?
                                    <p className={styles.loading} >
                                        <SyncLoader
                                            color={color}
                                            loading={loading}
                                            size={10}
                                            aria-label="Loading Spinner"
                                            data-testid="loader"
                                        /></p>
                                    :
                                    <>
                                        <>
                                            <div className={styles.companyList}>
                                                <p>Company id : <b className='green'>{user.id}</b></p>
                                                <label>Available Vehicle : <b className='green'>{dataSource2.length}</b></label>
                                                <p className={styles.dropdownVehicle}><AiOutlineMinus top="10px" size="1rem" color='White' onChange={displaylist}></AiOutlineMinus></p>
                                            </div>
                                            {/* {<Table style={{ transition: "0.5s" }} role={role} id={id} name={item.role == "OWNER" ? `${item.companyName}` : `${item.firstName}` + " " + `${item.lastName}`} from={"availavleCars"} />} */}


                                            <div className={styles.outer_vehicle_table} id='myTable'>

                                                <div className={styles.vehicle_search}>
                                                    <p title='search'>
                                                        <BsSearch className={styles.icn} size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                                                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                                                        <button>Search</button>
                                                    </p>
                                                </div>

                                                <p>LIst of Vehicles</p>

                                                <table className={styles.vehicle_table} id="myTable">

                                                    <thead>
                                                        <tr>
                                                            <th>Vehicle Name</th>
                                                            <th>Assigned Driver</th>
                                                            <th>Current Location</th>
                                                            <th>Vehicle Type</th>
                                                            <th>Plate Number</th>
                                                            <th>Set Trip</th>
                                                            <th>Available</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        {currentPage.map(item => (
                                                            <tr className='active_row'>

                                                                <td>{item.vehicleName}</td>
                                                                <td>{item.driverName == "null" ? "unassignd" : `${item.driverName}`}</td>
                                                                <td></td>
                                                                <td>{item.vehicleCatagory}</td>
                                                                <td>{item.plateNumber}</td>
                                                                <td><Link to={`/set_trip/${item.plateNumber}/${item.driver == "null" ? "unassignd" : `${item.driverName}`}`}><button>Set Trip</button></Link></td>
                                                                <td onClick={() => {
                                                                    displaylist()
                                                                    setvisiblelist(item.id)
                                                                }}><lable className={visible && item.id == visiblelist ? "mangProfileButton2" : "mangProfileButton"}>{visible && item.id == visiblelist ? "Cancle" : "Available"}</lable></td>
                                                            </tr>
                                                        ))}
                                                    </tbody>
                                                </table>
                                            </div>

                                            <div className={styles.page}>
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
