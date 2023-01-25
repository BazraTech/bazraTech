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
import { FaWarehouse } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { AiFillCaretDown } from "react-icons/ai";
import { GrFormNext } from "react-icons/gr";
import { GrFormPrevious } from "react-icons/gr";
import { HiMenuAlt1 } from "react-icons/hi";
import './users.css';
// import { useState } from 'react';
import { Link, NavLink } from 'react-router-dom';
import { total } from './Data/Data';
import { on_route } from './Data/Data';
import { parked } from './Data/Data';
import { maintenance } from './Data/Data';
import Tables from './Tables';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import SyncLoader from "react-spinners/SyncLoader";
import { useForm } from 'react-hook-form';
import swal from "sweetalert";
import { Pagination } from 'antd';


export default function () {

    const { register, handleSubmit, watch, formState: { errors } } = useForm();

    {/*---------------- handle submit values ----------------- */ }
    const onSubmit = data => {
      validation();
    }

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
                    // swal("Successful", "Successful Added", "error", {
                    //     buttons: false,
                    //     timer: 2000,
                    //   })
                }
            }
        }
    }

    let [active, setActive] = useState("total_users");
    let [state, setState] = useState("false");
    const color = () => {
        setState(state);
    }
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
    const [dataSource, setDataSource] = useState([])
    const [Loading, setLoading] = useState([])
    const url = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners";
    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.vehicleOwnerINF)
                setTotalPage(data.totalPages)

                console.log(dataSource)
                setLoading(false)
            })
    }, [])

    const [dataSource2, setDataSource2] = useState([])
    // const [Loading, setLoading] = useState([])
    const url2 = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/Role/owner";
    useEffect(() => {
        setLoading(true)
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.vehicleOwners)
                setTotalPage(data.totalPages)
                setLoading(false)
            })
    }, [])

    const [dataSource3, setDataSource3] = useState([])
    // const [Loading, setLoading] = useState([])
    const url3 = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/Role/individual";
    useEffect(() => {
        setLoading(true)
        fetch(url3, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.vehicleOwners)
                setTotalPage(data.totalPages)
                setLoading(false)
            })
    }, [])


    const [popup, setPop] = useState(false);
    const [popup1, setPop1] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
        if (popup === true) {
          document.body.classList.add("active_modal")
        }
        else {
          document.body.classList.remove("active_modal")
        }
      }
      const handleClickopen1 = () => {
        setPop1(!popup1);
        if (popup === true) {
          document.body.classList.add("active_modal")
        }
        else {
          document.body.classList.remove("active_modal")
        }
      }
    const [list, setList] = useState([dataSource]);
    const [total, setTotal] = useState(dataSource.length);
    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(10);

    const indexOfLastPage = page + postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    // const currentPage = dataSource1.slice(indexOfFirstPage, indexOfLastPage);
    const [vehicleName, setvehicleName] = useState("");
    const [catagory, setVehicleCategory] = useState("");
    const [conditionName, setVehicleCondition] = useState("");
    const [plateNumber, setPlateNumber] = useState("");
    const [manufactureDate, setmanufactureDate] = useState("");
    const [deviceID, setdeviceId] = useState("");
    const [error, setError] = useState(false);
    const [error1, setError1] = useState(false);

    const validation = (e) => {
        e.preventDefault();
        if (catagory.length == 0 || vehicleName.length == 0 || conditionName.length == 0 || plateNumber.length == 0 || manufactureDate.length == 0 || deviceID.length == 0) {
            setError(true);
        }
        if (catagory && vehicleName && conditionName && plateNumber && manufactureDate && deviceID) {
            swal("Successful", "Successful Added", "success", {
                buttons: false,
                timer: 2000,
            })
        }
    }

    const validation1 = (e) => {
        e.preventDefault();
        if (catagory.length == 0 || vehicleName.length == 0 || conditionName.length == 0 || plateNumber.length == 0 || manufactureDate.length == 0 || deviceID.length == 0) {
          setError1(true);
        }
        if (catagory && vehicleName && conditionName && plateNumber && manufactureDate && deviceID) {
          swal("Successful", "Successful Added", "success", {
            buttons: false,
            timer: 2000,
          })
        }
      }
    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
      }



    return (

        <div className="containerr">

            {/*---------------navigation---------------*/}
            <Navigation></Navigation>

            {/* --------------- header --------------- */}

            <Header title="Users"></Header>

            {/* --------------- users --------------- */}

            <div className='user'>
                <div className='contents'>
                    <Link style={{ textDecoration: 'none' }} to="/users">
                        <div className='individual' onClick={() => setActive("total_users")}>
                            <h4>Total Users</h4>
                            <p><FaUsers size="2.2rem"></FaUsers><b>{dataSource.length}</b></p>
                        </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/company">
                        <div className='individual' onClick={() => setActive("company")}>
                            <h4>Company</h4>
                            <p><FaWarehouse size="2.2rem"></FaWarehouse><b>{dataSource2.length}</b></p>
                        </div>
                    </Link>
                    <Link style={{ textDecoration: 'none' }} to="/register_individual">
                        <div className='activeNav2' onClick={() => setActive("individual")}>
                            <h4>Individual</h4>
                            <p><FaUserAlt size="2rem"></FaUserAlt><b>{dataSource3.length}</b></p>
                        </div>
                    </Link>
                </div>

                {/* --------------- search --------------- */}
                <div className='users_search'>
                    <p>
                        <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                        <button>Search</button>
                    </p>
                </div>

                {/* <div className='filter'>
                    <p> 
                        <AiFillFilter className='fil' size="0.8rem" color='rgb(63, 63, 63)'></AiFillFilter>
                        <h6>Filter</h6> 
                    </p>
                </div> */}

                {/* --------------------- Table ------------------- */}
                <div>
                    <>
                        {
                            Loading ?
                                <p className='loading'><SyncLoader
                                    // color={color}
                                    // Left={margin}
                                    loading={Loading}
                                    // cssOverride={override}
                                    size={10}
                                    // margin= "100px 0px 0px 0px"
                                    // padding= "200px"
                                    aria-label="Loading Spinner"
                                    data-testid="loader"
                                /></p>
                                :
                                <div className='outer_vehicle_tables' id='myTable'>
                                    <p>Total</p>

                                    <table class="vehicle_table" id="myTable">
                                        <thead>
                                            <tr>
                                                <th>User</th>
                                                <th>Company ID</th>
                                                <th>Company Name</th>
                                                <th>Number Of Vehicle</th>
                                                <th>Number Of Driver</th>
                                                <th>Status</th>
                                                <th>Detail</th>
                                                <th>Add Vehicle</th>
                                                <th>Add Driver</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {dataSource3.map(item => (
                                                <tr className='active_row'>
                                                    {/* <td></td> */}
                                                    <td>{item.id}</td>
                                                    <td>{item.phoneNumber}</td>
                                                    <td>{item.firstName}</td>
                                                    <td>{item.lastName}</td>
                                                    <td>{item.role.rolename}</td>
                                                    <td></td>
                                                    <td><Link to={`/user_edit/${item.role.rolename}/${item.id}`}>
                                                        <button>Detail</button></Link></td>
                                                    <td><Link to="#"><button onClick={() => { handleClickopen() }}>Vehicle</button></Link></td>
                                                    <td><Link to="#"><button onClick={() => { handleClickopen1() }}>Driver</button></Link></td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>

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

                                        <form onSubmit={handleSubmit(onSubmit)}>
                                            {popup ?
                                                <div>
                                                    <div className='popup3'>
                                                        <div className='popup-inner'>
                                                            <lable className="zxc">Add Vehicle</lable>
                                                            <div className='ewq'>
                                                                <div className='qwe'>
                                                                    <div className='asd'>
                                                                        <button className='close-btn' onClick={closePopup5}>X</button>
                                                                        <lable>Vehicle Cataegory</lable>
                                                                        <select className='select' placeholder='Select Vecicle Catagory'
                                                                            {...register("catagory1", { required: '*Vehicle catagoty  is required' })}
                                                                            name="catagory"
                                                                            // value={catagory}
                                                                            onChange={e => setVehicleCategory(e.target.value)} >
                                                                            <option value="">Select Vecicle Catagory</option>
                                                                            <option>Select Vecicle Catagory 1</option>
                                                                            <option>Select Vecicle Catagory 2</option>
                                                                            <option>Select Vecicle Catagory 3</option>
                                                                            <option>Select Vecicle Catagory 4</option>
                                                                        </select>
                                                                        {catagory <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Vehicle Name</lable>
                                                                        <input name='vehicleName' type="text"
                                                                            // value={vehicleName}
                                                                            {...register("vehicleName", { required: true })}
                                                                            placeholder='Enter Vehicle Name'
                                                                            onChange={(e) => setvehicleName(e.target.value)} ></input>
                                                                        {vehicleName <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Vehicle Condition</lable>
                                                                        <select className='select' name='conditionName'
                                                                            // value={conditionName}

                                                                            {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                                                            onChange={e => setVehicleCondition(e.target.value)} >
                                                                            <option value="">Select Vecicle Condition</option>
                                                                            <option>Select Vecicle Condition 1</option>
                                                                            <option>Select Vecicle Condition 2</option>
                                                                            <option>Select Vecicle Condition 3</option>
                                                                            <option>Select Vecicle Condition 4</option>
                                                                        </select>
                                                                        {conditionName <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Plate Number</lable>
                                                                        <input placeholder='Please Enter Plate Number' name='conditionName'
                                                                            // value={plateNumber} 
                                                                            {...register("plateNumber", { required: '*please choose service needed' })}
                                                                            onChange={(e) => setPlateNumber(e.target.value)} >
                                                                        </input>
                                                                        {plateNumber <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Manufacture Date</lable>
                                                                        <input name='manufacture_date' type="date"
                                                                            // value={manufactureDate}
                                                                            {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                                                            placeholder='Enter Manufactureing Date'
                                                                            onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                                                                        {manufactureDate <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Device ID</lable>
                                                                        <input name='deviceID' type="text"
                                                                            // value={deviceID}
                                                                            {...register("deviceID", { required: '*Device ID is required' })}
                                                                            placeholder='Enter Device ID'
                                                                            onChange={(e) => setdeviceId(e.target.value)} ></input>
                                                                        {deviceID <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                    </div>
                                                                    <div className='asdy'>
                                                                        {/* <button>Back</button> */}
                                                                    </div>
                                                                    <div className='asdy'>
                                                                        <button onClick={validation}>Submit </button>
                                                                    </div>
                                                                    <div className='asdy'>
                                                                        {/* <button onClick={() => { handleClickopen2() }}>Add Vehicle</button> */}
                                                                        <button type='reset'>Clear</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> : ""}
                                        </form>
                                        {popup1 ?
                                            <div>
                                                <div className='popup3'>
                                                    <div className='popup-inner'>
                                                        <lable className="zxc">Add Driver</lable>
                                                        <div className='ewq'>
                                                            <div className='qwe'>
                                                                <div className='asd'>
                                                                    <button className='close-btn' onClick={closePopup5}>X</button>
                                                                    <lable>First Name</lable>
                                                                    <input name='vehicleName' type="text"
                                                                        // value={vehicleName}
                                                                        {...register("vehicleName", { required: true })}
                                                                        placeholder='Enter Vehicle Name'
                                                                        onChange={(e) => setvehicleName(e.target.value)} ></input>
                                                                    {vehicleName <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                </div>

                                                                <div className='asd'>
                                                                    <lable>Last Name</lable>
                                                                    <input name='vehicleName' type="text"
                                                                        // value={vehicleName}
                                                                        {...register("vehicleName", { required: true })}
                                                                        placeholder='Enter Vehicle Name'
                                                                        onChange={(e) => setvehicleName(e.target.value)} ></input>
                                                                    {vehicleName <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                </div>

                                                                <div className='asd'>
                                                                    <lable>Driver Licence </lable>
                                                                    <input placeholder='Please Enter Plate Number' name='conditionName'
                                                                        // value={plateNumber} 
                                                                        {...register("plateNumber", { required: '*please choose service needed' })}
                                                                        onChange={(e) => setPlateNumber(e.target.value)} >
                                                                    </input>
                                                                    {plateNumber <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                </div>

                                                                <div className='asd'>
                                                                    <lable> Phone Number</lable>
                                                                    <input name='manufacture_date' type="text"
                                                                        // value={manufactureDate}
                                                                        {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                                                        placeholder='Enter Manufactureing Date'
                                                                        onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                                                                    {manufactureDate <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                </div>

                                                                <div className='asd'>
                                                                    <lable>Email</lable>
                                                                    <input name='deviceID' type="text"
                                                                        // value={deviceID}
                                                                        {...register("deviceID", { required: '*Device ID is required' })}
                                                                        placeholder='Enter Device ID'
                                                                        onChange={(e) => setdeviceId(e.target.value)} ></input>
                                                                    {deviceID <= 0 && error ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                                                                </div>

                                                                <div className='asd'>

                                                                </div>

                                                                <div className='asdy'>
                                                                    {/* <button>Back</button> */}
                                                                </div>
                                                                <div className='asdy'>
                                                                    <button onClick={validation1}>Submit </button>
                                                                </div>
                                                                <div className='asdy'>
                                                                    {/* <button onClick={() => { handleClickopen2() }}>Add Vehicle</button> */}
                                                                    <button type='reset'>Clear</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> : ""}
                                    </div>
                                </div>

                        }

                    </>

                </div>

            </div>
        </div >
    )
}
