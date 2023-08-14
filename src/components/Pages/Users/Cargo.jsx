import React from 'react'
// import { FaHome } from 'react-icons/fa';
import { FaUsers } from "react-icons/fa";
import { FaUserAlt } from "react-icons/fa";
import { FaWarehouse } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
// import { FaStarOfLife } from 'react-icons/fa';
// import { useState } from 'react';
import styles from './users.module.css';
import { Link } from 'react-router-dom';
import { useState, useEffect } from 'react';
// import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import SyncLoader from "react-spinners/SyncLoader";
// import { useForm } from 'react-hook-form';
import swal from "sweetalert";
import { Pagination } from 'antd';
// import axios from "axios";


export default function () {

    // const { register, handleSubmit, watch, formState: { errors } } = useForm();

    {/*---------------- handle submit values ----------------- */ }

    function tableSearch() {

        let input, filter, table, tr, td, txtValue, errors;
        //Intialising Variables
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        for (let i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[0];
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

    let [active, setActive] = useState("total_users");
    let [state, setState] = useState("false");

    const closePopup5 = () => {
        setPop1(false);
        setPop(false);
    }

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
    };

    const [totalPages, setTotalPage] = useState(1);
    const [Loading, setLoading] = useState([])

    const [dataSource2, setDataSource2] = useState([])
    // const [Loading, setLoading] = useState([])

    const [individual, setIndividual] = useState([])
    // const [Loading, setLoading] = useState([])

    const [dataSource3, setDataSource3] = useState([])
    const url3 = "http://164.90.174.113:9090/Api/Admin/All/CargoOwners";
    useEffect(() => {
        setLoading(true)
        fetch(url3, options)
            .then(respnse => respnse.json())
            .then(response => {
                localStorage.setItem("message", JSON.stringify(response["message"])); 
                const mess = localStorage.getItem("message");
                console.log(response.status)
          if (response.status == 500) {
            throw new Error('Server Error');
          }else if(!response.ok){
            throw new Error('Failed to get the Cargo Owners');
          }
          else{
            setDataSource3(response.cargoOwners)
                setTotalPage(response.cargoOwners.length)
                setLoading(false)
        }
    })
        .catch(error => {

          setError(error.message);
          swal(`Failed ${error}`, "Error", "error");
        });
    }, [])
console.log(dataSource3)

    const [popup, setPop] = useState(false);
    const [popup1, setPop1] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }
    const handleClickopen1 = () => {
        setPop1(!popup1);
    }
    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(5);
    const indexOfLastPage = page * postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    const currentPage = dataSource3.slice(indexOfFirstPage, indexOfLastPage);


    const [error, setError] = useState(false);



    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }


    const [color, setColor] = useState("green");
    const ApiData = JSON.parse(localStorage.getItem('ApiData'))

    const totalUser = ApiData.CargoOwner + ApiData.CompanyOwner + ApiData.IndividualOwner
console.log(totalUser)
    return (

        <div className="containerr">

            {/*---------------navigation---------------*/}
            <Navigation path="/users" title="Users"></Navigation>

            {/* --------------- header --------------- */}

            {/* <Header title="Users"></Header> */}

            {/* --------------- users --------------- */}

            <div className={styles.main_content} >

                <div className={styles.allcards}>
                    <div className={styles.vehicle}>
                        <Link style={{ textDecoration: 'none' }} to="/users">
                            <div className={styles.innerContents}>
                                <h4>Total Users</h4>
                                <div>
                                    <p><FaUsers size="2.2rem"></FaUsers><b>{totalUser}</b></p>
                                </div>
                            </div>
                        </Link>
                    </div>
                    <div className={styles.vehicle}>
                        <Link style={{ textDecoration: 'none' }} to="/company">
                            <div className={styles.innerContents}>
                                <h4>Company</h4>
                                <div>
                                    <p><FaWarehouse size="2.2rem"></FaWarehouse><b>{ApiData.CompanyOwner}</b></p>
                                </div>
                            </div>
                        </Link>
                    </div>
                    <div className={styles.vehicle}>
                        <Link style={{ textDecoration: 'none' }} to="/register_individual">
                            <div className={styles.innerContents}>
                                <h4>Individual</h4>
                                <div>
                                    <p><FaUserAlt size="2rem"></FaUserAlt><b>{ApiData.IndividualOwner}</b></p>
                                </div>
                            </div>
                        </Link>
                    </div>
                    <div className={styles.activeCard}>
                        <Link style={{ textDecoration: 'none' }} to="/cargo">
                            <div className={styles.innerContents1}>
                                <h4>cargo</h4>
                                <div>
                                    <p><FaUserAlt size="2rem"></FaUserAlt><b>{ApiData.CargoOwner}</b></p>
                                </div>
                            </div>
                        </Link>
                    </div>


                </div>
              

                {/* --------------- search --------------- */}


                <div className={styles.vehicle_search}>
                    <p title='search'>
                        <BsSearch className={styles.icn} size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                        <button>Search</button>
                    </p>
                </div>

                {/* --------------------- Table ------------------- */}
                <div>
                  
                              <>
                                    <div className={styles.outer_vehicle_table} id='myTable'>
                                        <p>Cargo OWNERS</p>

                                        <table className={styles.vehicle_table} id="myTable">
                                            <thead>
                                                <tr>
                                                <th>Id</th>
                                                    <th>Owner Name</th>
                                                    <th>Phone Number</th>
                                                    <th>enabled</th>
                                                    <th>Detail</th>
                                                    </tr>
                                            </thead>
                                          {  Loading ?
                                <p className={styles.loading} >
                                    <SyncLoader
                                        loading={Loading}
                                        color={color}
                                        size={10}
                                        aria-label="Loading Spinner"
                                        data-testid="loader"
                                    /></p>
                                :
                                            <tbody>
                                                {currentPage.map(item => (
                                                    <tr className={styles.active_row} key={item.id}>
                                                        <td>{item.id}</td>
                                                        <td>{item.ownerName}</td>
                                                        <td>{item.phoneNumber}</td>
                                                        <td>{item.enabled ? 'Enabled' : 'Disabled'}</td>
                                                        <td><Link to={`/cargo/${item.id}`}>
                                                            <button>Detail</button></Link>
                                                            </td>
                                                        
                                                    </tr>
                                                ))}
                                            </tbody>}
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

                        


                </div>

            </div>
        </div >
    )
}
