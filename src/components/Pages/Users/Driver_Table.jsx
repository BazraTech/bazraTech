import React, { Component } from 'react'
import styles from './users_edit.module.css';
import { useForm } from 'react-hook-form';
import { Link, useParams } from 'react-router-dom';
import { HiMenuAlt1 } from "react-icons/hi";
import { useState, useEffect } from 'react';
import { Pagination } from 'antd';
import Driver_detail from '../Drivers/Driver_detail';

export default function Driver_Table({ id, role, title }) {

    const [state, setState] = useState(false);
    const toggle = () => {
        setState(!state);
    };

    const [diabled, setPop] = useState(true);
    const handleChange = () => {
        setPop(!diabled);
    }

    const [popup1, setPop1] = useState(false);
    const handleClickopen = () => {
        setPop1(!popup1);
    }

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
    };

    // const [Loading, setLoading] = useState(false)
    const [totalPages, setTotalPage] = useState(1);
    const [totalPages2, setTotalPage2] = useState(1);
    const [dataSource, setDataSource] = useState([])
    const [dataSource1, setDataSource1] = useState([])
    const [dataSource2, setDataSource2] = useState([])
    const [dataSource3, setDataSource3] = useState([])
    const [dataSource4, setDataSource4] = useState([])
    const [dataSource5, setDataSource5] = useState([])

    const [Loading, setLoading] = useState([]);
    // const { id, role, companyID } = useParams();

    let url;

    if (role === "OWNER") {
        url = `http://198.199.67.201:9090/Api/Admin/All/CompanyVehicleOwner/${id}`;
    }
    if (role === "INDIVIDUAL") {
        url = `http://198.199.67.201:9090/Api/Admin/All/IndividualVehicleOwner/${id}`;
    }

    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then((response) => response.json())
            .then((json) => {
                setDataSource(json.ownerINF)
                setDataSource1(json.ownerINF.drivers)
                setDataSource2(json.ownerINF.onRouteDriverINFs)
                setDataSource3(json.ownerINF.assignedDriverINFs)
                setDataSource4(json.ownerINF.unassignedDriverINFs)
                setDataSource5(json.ownerINF.permitDriverINFs)
                if (title == "Total Drivers") {
                    setTotalPage(json.ownerINF.drivers.length);
                }
                if (title == "On Route Drivers") {
                    setTotalPage(json.ownerINF.onRouteDriverINFs.length);
                }
                if (title == "Assigned Drivers") {
                    setTotalPage(json.ownerINF.assignedDriverINFs.length);
                }
                if (title == "Unassigned Drivers") {
                    setTotalPage(json.ownerINF.unassignedDriverINFs.length);
                }
                if (title == "Permit Vehicles") {
                    setTotalPage(json.ownerINF.permitDriverINFs.length);
                }

                setLoading(false)
            });
    }, [])

    const [selecttag, setSelectTag] = useState(false)
    const [inputtag, setinputTag] = useState(true)
    const select = () => {
        setSelectTag(!selecttag);
        setinputTag(!inputtag);
    }
    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(5);
    const indexOfLastPage = page * postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;

    let currentPage;
    if (title == "Total Drivers") {
        currentPage = dataSource1.slice(indexOfFirstPage, indexOfLastPage);
    }
    if (title == "On Route Drivers") {
        currentPage = dataSource2.slice(indexOfFirstPage, indexOfLastPage);
    }
    if (title == "Assigned Drivers") {
        currentPage = dataSource3.slice(indexOfFirstPage, indexOfLastPage);
    }
    if (title == "Unassigned Drivers") {
        currentPage = dataSource4.slice(indexOfFirstPage, indexOfLastPage);
    }
    if (title == "Permit Vehicles") {
        currentPage = dataSource5.slice(indexOfFirstPage, indexOfLastPage);
    }

    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }

    const [color, setColor] = useState("green");
    const [edit, setEdit] = useState("");
    let [active, setActive] = useState(false);
    let [name, setName] = useState("false");

    function changeName(name) {
        setName(name);
    }

    return (
        <>
            <div className={styles.outer_vehicle_table} id='myTable'>


                <label>{title}</label>

                <table className={styles.vehicle_table} id="myTable">

                    <thead>
                        <tr>
                            <th>Driver Name</th>
                            <th>License Number</th>
                            <th>Experience</th>
                            <th>LicenseGrade</th>
                            <th>Status</th>
                            <th>Company</th>
                            <th>Detail</th>
                            <th>Tracking</th>
                        </tr>
                    </thead>

                    <tbody>
                        {currentPage.map(item => (
                            <tr className={styles.active_row}>

                                <td>{item.driverName}</td>
                                <td>{item.licenseNumber}</td>
                                <td>{item.experience}</td>
                                <td>{item.licenseGrade}</td>
                                <td>{item.status}</td>
                                <td>{item.vehicleOwner}</td>
                                <td><button onClick={() => {
                                    setEdit(item.id)
                                    setName("true")
                                }}>Detail</button></td>
                                <td><button>Manage</button></td>
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
            {name === "true" && <Driver_detail data={edit} changeName={changeName} />}
        </>

    )
}
