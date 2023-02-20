import React, { useState, useEffect } from 'react'
import { FaEdit } from "react-icons/fa";
import { MdDeleteForever } from "react-icons/md";
import './settings.css';
import { Link, NavLink } from 'react-router-dom';
import PopUp from './PopUp';
import { Truck_status } from "./data/Data"
import { service_needed } from "./data/Data"
import { user_catagory } from "./data/Data"
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import SyncLoader from "react-spinners/SyncLoader";

export default function () {

    const [popup, setPop] = useState(false);
    const [popup1, setPop1] = useState(false);
    const [active, setTitle] = useState("");
    const handleClickEdit = () => {
        setPop(!popup);
    }
    const closePopup = () => {
        setPop(false);
    }
    const [popupx, setPopx] = useState(false);
    const handleClickopenx = () => {
        setPopx(!popupx);
    }
    const handleClickEdit1 = () => {
        setPop1(!popup1);
    }
    const closePopup1 = () => {
        setPop1(false);
    }
    const [edit, setEdit] = useState("");
    const setVehicleValue = (variable) => {
        setEdit(`${variable}`)
    }
    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api
    const options = {
        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
    };
    const urlTwo = " http://198.199.67.201:9090/Api/Admin/All/NotificationMedium";
    const [dataSource2, setDataSource2] = useState([])
    useEffect(() => {
        setLoading(true)
        fetch(urlTwo, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.notificationMedias)
                // console.log(dataSource2)
                setLoading(false)
            })
    }, [])
    const urlthree = "http://198.199.67.201:9090/Api/Admin/All/VehicleCatagory";
    const [dataSource3, setDataSource3] = useState([])
    useEffect(() => {
        setLoading(true)
        fetch(urlthree, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.vehicleCatagories)
                // console.log(dataSource3)
                setLoading(false)
            })
    }, [])
    const urlFour = "http://198.199.67.201:9090/Api/Admin/All/VehicleCondition";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        setLoading(true)
        fetch(urlFour, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data.vehicleConditions)
                // console.log(dataSource4)
                setLoading(false)
            })
    }, [])
    const url = "http://198.199.67.201:9090/Api/Admin/All/CompanySector/";
    const [dataSource, setDataSource] = useState([])
    useEffect(() => {
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.companySectors)
                // console.log(dataSource)
            })
    }, [])
    const url5 = "http://198.199.67.201:9090/Api/Admin/All/CompanyType/";
    const [dataSourc5, setDataSource5] = useState([])
    useEffect(() => {
        fetch(url5, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource5(data.companyTypes)
                // console.log(dataSource)
            })
    }, [])
    const url6 = "http://198.199.67.201:9090/Api/Admin/All/Services";
    const [datasource6, setDataSource6] = useState([])
    useEffect(() => {
        fetch(url6, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource6(data.service)
                // console.log(dataSource4)
            })
    }, [])

    const url7 = "http://198.199.67.201:9090/Api/Admin/All";
    const [dataSource7, setDataSource7] = useState([])
    useEffect(() => {
        setLoading(true)
        fetch(url7, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource7(data.roles)
                // console.log(dataSource4)
                setLoading(false)
            })
    }, [])

    const url8 = "http://198.199.67.201:9090/Api/Admin/DriverStatus/All";
    const [dataSource8, setDataSource8] = useState([])
    useEffect(() => {
        setLoading(true)
        fetch(url8, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource8(data.driverStatus)
                // console.log(dataSource4)
                setLoading(false)
            })
    }, [])

    const url9 = "http://198.199.67.201:9090/Api/Admin/AlertType/All/";
    const [dataSource9, setDataSource9] = useState([])
    useEffect(() => {
        setLoading(true)
        fetch(url9, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource9(data.alertTypes)
                // console.log(dataSource4)
                setLoading(false)
            })
    }, [])

    const url10 = "http://198.199.67.201:9090/Api/Admin/TripType/All";
    const [dataSource10, setDataSource10] = useState([])
    useEffect(() => {
        setLoading(true)
        fetch(url10, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource10(data.triptypes)
                // console.log(dataSource4)
                setLoading(false)
            })
    }, [])

    const [Loading, setLoading] = useState([])
    let [color, setColor] = useState("green");
    let [margin, setMargin] = useState("");

    return (
        <div className="alert_container">

            {/*---------------navigation---------------*/}
            <Navigation path="/settings" title="Settings"></Navigation>

            {/* --------------- Settings header --------------- */}
            {/* <Header title="Settings"></Header> */}

            <div className='alert_main'>

                <div className='outer_setting'>
                    <div className='setting_header'>Roles</div>
                    <PopUp title="Create_Role" />
                    {Loading ?
                       <p className="loading" >
                            <SyncLoader
                            color={color}
                            Left={margin}
                            loading={Loading}
                            size={10}
                            aria-label="Loading Spinner"
                            data-testid="loader"
                        />
                        </p>
                        : <div>
                            <div className="outer_vehicle_table7" id='myTable'>
                                <table class="vehicle_table7" id="myTable">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Role</th>
                                            <th>Created Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {dataSource7.map(item => {
                                            return <tr className='active_row'>

                                                <td>{item.id}</td>
                                                <td>{item.rolename}</td>
                                                <td>{item.createdDate}</td>
                                                <td>
                                                    <p className='notification_actions'>
                                                        <FaEdit title='Edit' className='action_edit' size="1.4rem" color='green'
                                                            onClick={() => {
                                                                handleClickEdit()
                                                                setTitle("Edit Notification Preference")
                                                                setVehicleValue(item.rolename)
                                                            }}></FaEdit>
                                                        <MdDeleteForever title='Delete' className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                    </p>
                                                </td>
                                            </tr>
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    }
                </div>

                <div className='outer_setting'>
                    <div className='setting_header'>Driver Status</div>
                    <PopUp title="Create_Driver_Status" />
                    {Loading ?
                        <p className='loading'><SyncLoader
                            color={color}
                            Left={margin}
                            loading={Loading}
                            size={10}
                            aria-label="Loading Spinner"
                            data-testid="loader"
                        />
                        </p>
                        : <div>
                            <div className="outer_vehicle_table7" id='myTable'>
                                <table class="vehicle_table7" id="myTable">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Driver Status</th>
                                            <th>Created Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {dataSource8.map(item => {
                                            return <tr className='active_row'>

                                                <td>{item.id}</td>
                                                <td>{item.driverStatus}</td>
                                                <td></td>
                                                <td>
                                                    <p className='notification_actions'>
                                                        <FaEdit title='Edit' className='action_edit' size="1.4rem" color='green'
                                                            onClick={() => {
                                                                handleClickEdit()
                                                                setTitle("Edit Notification Preference")
                                                                setVehicleValue(item.driverStatus)
                                                            }}></FaEdit>
                                                        <MdDeleteForever title='Delete' className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                    </p>
                                                </td>
                                            </tr>
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    }
                </div>

                <div className='outer_setting'>
                    <div className='setting_header'>Alert Types</div>
                    <PopUp title="Create_Alert_Type" />
                    {Loading ?
                        <p className='loading'><SyncLoader
                            color={color}
                            Left={margin}
                            loading={Loading}
                            size={10}
                            aria-label="Loading Spinner"
                            data-testid="loader"
                        />
                        </p>
                        : <div>
                            <div className="outer_vehicle_table7" id='myTable'>
                                <table class="vehicle_table7" id="myTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Alert Type</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {dataSource9.map(item => {
                                            return <tr className='active_row'>

                                                <td>{item.id}</td>
                                                <td>{item.alertType}</td>
                                                <td>{item.createdDate}</td>
                                                <td>
                                                    <p className='notification_actions'>
                                                        <FaEdit title='Edit' className='action_edit' size="1.4rem" color='green'
                                                            onClick={() => {
                                                                handleClickEdit()
                                                                setTitle("Edit Notification Preference")
                                                                setVehicleValue(item.alertType)
                                                            }}></FaEdit>
                                                        <MdDeleteForever title='Delete' className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                    </p>
                                                </td>
                                            </tr>
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    }
                </div>

                <div className='outer_setting'>
                    <div className='setting_header'>Trip Management</div>
                    <PopUp title="Create_Trip_Type" />
                    {Loading ?
                        <p className='loading'><SyncLoader
                            color={color}
                            Left={margin}
                            loading={Loading}
                            size={10}
                            aria-label="Loading Spinner"
                            data-testid="loader"
                        />
                        </p>
                        : <div>
                            <div className="outer_vehicle_table7" id='myTable'>
                                <table class="vehicle_table7" id="myTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Trip Type</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {dataSource10.map(item => {
                                            return <tr className='active_row'>

                                                <td>{item.id}</td>
                                                <td>{item.tripType}</td>
                                                <td>{item.createdDate}</td>
                                                <td>
                                                    <p className='notification_actions'>
                                                        <FaEdit title='Edit' className='action_edit' size="1.4rem" color='green'
                                                            onClick={() => {
                                                                handleClickEdit()
                                                                setTitle("Edit Notification Preference")
                                                                setVehicleValue(item.tripType)
                                                            }}></FaEdit>
                                                        <MdDeleteForever title='Delete' className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                    </p>
                                                </td>
                                            </tr>
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    }
                </div>

                <div className='outer_setting'>
                    <div className='setting_header'>Notification Preference</div>
                    <PopUp title="Add_Notification" />
                    {Loading ?
                        <p className='loading'><SyncLoader
                            color={color}
                            Left={margin}
                            loading={Loading}
                            size={10}
                            aria-label="Loading Spinner"
                            data-testid="loader"
                        /></p>
                        : <div>
                            <div className="outer_vehicle_table7" id='myTable'>
                                <table class="vehicle_table7" id="myTable">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Notification Preference</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {dataSource2.map(item => {
                                            return <tr className='active_row'>

                                                <td>{item.id}</td>
                                                <td>{item.medium}</td>
                                                <td>{item.status}</td>
                                                <td>
                                                    <p className='notification_actions'>
                                                        <FaEdit title='Edit' className='action_edit' size="1.4rem" color='green'
                                                            onClick={() => {
                                                                handleClickEdit()
                                                                setTitle("Edit Notification Preference")
                                                                setVehicleValue(item.medium)
                                                            }}></FaEdit>
                                                        <MdDeleteForever title='Delete' className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                    </p>
                                                </td>
                                            </tr>
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    }
                </div>

                <div className='outer_setting'>
                    <div className='setting_header'>Vehicle Condition</div>
                    <PopUp title="Add_Vehicle_Condition" nandu={edit} />
                    <div>
                        {Loading ?
                            <p className='loading'><SyncLoader
                                color={color}
                                Left={margin}
                                loading={Loading}
                                size={10}
                                aria-label="Loading Spinner"
                                data-testid="loader"
                            /></p> :
                            <div className="outer_vehicle_table7" id='myTable'>
                                <table class="vehicle_table7" id="myTable">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Vehicle Condition</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {dataSource4.map(item => {
                                            return <tr className='active_row'>
                                                <td>{item.id}</td>
                                                <td>{item.conditionName}</td>
                                                <td>{item.status}</td>
                                                <td>
                                                    <p className='notification_actions'>
                                                        <FaEdit title='Edit' className='action_edit' size="1.4rem" color='green'
                                                            onClick={() => {
                                                                handleClickEdit()
                                                                setTitle("Edit Vehicle Condition")
                                                                setVehicleValue(item.conditionName)
                                                            }}></FaEdit>
                                                        <MdDeleteForever title='Delete' className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                    </p>
                                                </td>
                                            </tr>
                                        })}
                                    </tbody>
                                </table>
                            </div>
                        }
                    </div>

                </div>

                <div className='outer_setting'>
                    <div className='setting_header'>Service Needed</div>
                    <PopUp title="Add_Service_Needed" />
                    <div>
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
                            <div className="outer_vehicle_table7" id='myTable'>
                            <table class="vehicle_table7" id="myTable">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Service Needed</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {datasource6.map(item => {
                                        return <tr className='active_row'>
                                            <td>{item.id}</td>
                                            <td>{item.service}</td>
                                            <td>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit title='Edit' className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit Service Needed")
                                                            setVehicleValue(item.service_neended)
                                                        }}></FaEdit>
                                                    <MdDeleteForever title='Delete' className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>
                                        </tr>
                                    })}
                                </tbody>
                            </table>
                            </div>
                        }
                    </div>
                </div>

                <div className='outer_setting'>
                    <div className='setting_header'>Vehicle Category</div>
                    <PopUp title="Add_vehicle_category" />
                    <div>
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
                            <div className="outer_vehicle_table7" id='myTable'>
                            <table class="vehicle_table7" id="myTable">

                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Vehicle Category</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {dataSource3.map(item => {
                                        return <tr className='active_row'>
                                            <td>{item.id}</td>
                                            <td>{item.catagory}</td>
                                            <td>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit title='Edit' className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit Vehicle Category")
                                                            setVehicleValue(item.catagory)
                                                        }}></FaEdit>
                                                    <MdDeleteForever title='Delete' className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>
                                        </tr>
                                    })}
                                </tbody>
                            </table>
                            </div>
                        }
                    </div>
                </div>

                <div className='outer_setting'>
                    <div className='setting_header'>Company Type</div>
                    <PopUp title="Add_company_type" />
                    <div>
                        {Loading
                            ? <p className='loading'><SyncLoader
                                color={color}
                                Left={margin}
                                loading={Loading}
                                size={10}
                                aria-label="Loading Spinner"
                                data-testid="loader"
                            /></p>
                            : 
                            <div className="outer_vehicle_table7" id='myTable'>
                            <table class="vehicle_table7" id="myTable">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Company Type</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {dataSourc5.map(item => {
                                        return <tr className='active_row'>
                                            <td>{item.id}</td>
                                            <td>{item.companyType}</td>
                                            <td>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit title='Edit' className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit Company Sector")
                                                            setVehicleValue(item.sectorName)
                                                        }}></FaEdit>
                                                    <MdDeleteForever title='Delete' className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>
                                        </tr>
                                    })}
                                </tbody>
                            </table>
                            </div>
                        }
                    </div>
                </div>

                <div className='outer_setting'>
                    <div title='Company Sector' className='setting_header'>Company Sector</div>
                    <PopUp title="Add_company_sector" />
                    <div>
                        {Loading
                            ? <p className='loading'><SyncLoader
                                color={color}
                                Left={margin}
                                loading={Loading}
                                size={10}
                                aria-label="Loading Spinner"
                                data-testid="loader"
                            /></p>
                            : 
                            <div className="outer_vehicle_table7" id='myTable'>
                                <table class="vehicle_table7" id="myTable">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Company Sector</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {dataSource.map(item => {
                                        return <tr className='active_row'>
                                            <td title='Company Id'>{item.id}</td>
                                            <td title='Sector Name'>{item.sectorName}</td>
                                            <td title='Status'>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit title='Edit' className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit Company Sector")
                                                            setVehicleValue(item.sectorName)
                                                        }}></FaEdit>
                                                    <MdDeleteForever title='Delete' className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>
                                        </tr>
                                    })}
                                </tbody>
                            </table>
                            </div>
                        }
                    </div>
                </div>

                <div>
                    {popup ?
                        <div>
                            <div className='popup0'>
                                <div className='popup-innerq'>
                                    <div onClick={closePopup} className='close'>X</div>
                                    <div className='fgf'>
                                        <h2 className='mnm'>{active}</h2>
                                        <input value={edit} onChange={(e) => setEdit(e.target.value)}></input>
                                        <div className='send_button'>
                                            <button className='popup_add'>Save</button>
                                            <button onClick={closePopup} className='popup_cancle'>Cancle</button>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div> : ""}
                </div>

                <div>
                    {popup1 ?
                        <div>
                            <div className='popup0'>
                                <div className='popup-innerq'>
                                    <div onClick={closePopup1} className='close'>X</div>
                                    {/* <div className='fgf1'>
                                        <h2>{active}</h2>
                                    </div> */}
                                    {/* <button className='close-btn' onClick={closePopup}>X</button> */}
                                    <div className='fgf'>
                                        <h2 className='mnmn'>Are You Sure You want to delete this Item</h2>
                                        {/* <input placeholder={edit}></input> */}
                                        <div className='send_button'>
                                            <button className='popup_add'>Ok</button>
                                            <button onClick={closePopup1} className='popup_cancle'>Cancle</button>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div> : ""}
                </div>

                {/* <div>
                    {popup1 ?
                        <div className='popup_modal_delete'>
                            <div className='popup_close_button'>
                                <button className='x-press-report' onClick={closePopup1}>X</button>
                            </div>
                            <div className="item-report">
                                <div className="report-status-popup">
                                    <div class="popup_main_delete" >
                                        <h3>Are you sure you want to delete ?</h3>
                                        <div className='send_button'>
                                            <button className='popup_add'>Ok</button>
                                            <button onClick={closePopup1} className='popup_cancle'>Cancle</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> : ""}
                </div> */}
            </div>
        </div>
    )
}