import React from 'react'
import './users.css';
import { Link } from 'react-router-dom';
import { Table } from "antd";
import "antd/dist/antd"
import { useState, useEffect, CSSProperties } from 'react';
import { Pagination } from 'antd';
import { FaStarOfLife } from 'react-icons/fa';
import { useForm } from 'react-hook-form';
import swal from "sweetalert";
import Popup from './Popup';
import './popup.css';
import SyncLoader from "react-spinners/SyncLoader";
import { createStoreHook } from 'react-redux';

export default function Cards({ title, data }) {




  const { register, handleSubmit, watch, formState: { errors } } = useForm();

  {/*---------------- handle submit values ----------------- */ }
  const onSubmit = data => {
    validation();
  }

  const [buttonPopup, setButtonPopup] = useState(false);
  const [popup2, setPop2] = useState(false);
  const [popup, setPop] = useState(false);
  const [popup3, setPop3] = useState(false);
  const [popup4, setPop4] = useState(false);
  const [popup5, setPop5] = useState(false);
  const [popup6, setPop6] = useState(false);
  const [popup7, setPop7] = useState(false);
  const [popup8, setPop8] = useState(false);
  const [popup9, setPop9] = useState(false);
  const [popup10, setPop10] = useState(false);

  const handleClickopen = () => {
    setPop(!popup);
    if (popup === true) {
      document.body.classList.add("active_modal")
    }
    else {
      document.body.classList.remove("active_modal")
    }
  }

  const handleClickopen2 = () => {
    setPop2(!popup2);
  }
  const handleClickopen3 = () => {
    setPop3(!popup3);
  }
  const handleClickopen4 = () => {
    setPop4(!popup4);
  }
  const handleClickopen5 = () => {
    setPop5(!popup5);
  }
  const handleClickopen6 = () => {
    setPop6(!popup6);
  }
  const handleClickopen7 = () => {
    setPop7(!popup7);
  }
  const handleClickopen8 = () => {
    setPop8(!popup8);
  }

  const handleClickopen9 = () => {
    setPop9(!popup9);
  }

  const handleClickopen10 = () => {
    setPop10(!popup10);
  }
  const closePopup0 = () => {
    setPop2(false);
    // setPop(false);
  }

  const closePopup5 = () => {
    setPop10(false);
    setPop9(false);
    setPop8(false);
    setPop7(false);
    setPop6(false);
    setPop5(false);
    setPop4(false);
    setPop3(false);
    setPop2(false);
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


  // const [Loading, setLoading] = useState(false)
  const [totalPages, setTotalPage] = useState(1);
  const [dataSource, setDataSource] = useState([])
  const [Loading, setLoading] = useState([])
  const url = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners";
  useEffect(() => {
    setLoading(true)
    fetch(url, options)
      .then(respnse => respnse.json())
      .then(data => {
        setDataSource(data.vehicleOwners)
        setTotalPage(data.totalPages)

        console.log(dataSource)
        setLoading(false)
      })
  }, [])

  const urlthree = "http://198.199.67.201:9090/Api/Admin/All/VehicleCatagory";
  const [dataSource3, setDataSource3] = useState([])
  useEffect(() => {
    fetch(urlthree, options)
      .then(respnse => respnse.json())
      .then(data => {
        setDataSource3(data.vehicleCatagories)
        console.log(dataSource3)
      })
  }, [])
  const urlFour = "http://198.199.67.201:9090/Api/Admin/All/VehicleCondition";
  const [dataSource4, setDataSource4] = useState([])
  useEffect(() => {
    fetch(urlFour, options)
      .then(respnse => respnse.json())
      .then(data => {
        setDataSource4(data.vehicleConditions)
        console.log(dataSource4)
      })
  }, [])

  const [list, setList] = useState([dataSource]);
  const [total, setTotal] = useState(dataSource.length);
  const [page, setCurentPage] = useState(1);
  const [postPerPage, setpostPerPage] = useState(10);

  const onShowSizeChange = (current, pageSize) => {
    setpostPerPage(pageSize);
  }

  useEffect(() => {
    setTotal([dataSource.length])
  }, []);


  const indexOfLastPage = page + postPerPage;
  const indexOfFirstPage = indexOfLastPage - postPerPage;
  const currentPage = dataSource.slice(indexOfFirstPage, indexOfLastPage);


  const [vehicleName, setvehicleName] = useState("");
  const [catagory, setVehicleCategory] = useState("");
  const [conditionName, setVehicleCondition] = useState("");
  const [plateNumber, setPlateNumber] = useState("");
  // const [plate_number2, setPlateNumber2] = useState("");
  // const [plate_number3, setPlateNumber3] = useState("");
  const [manufactureDate, setmanufactureDate] = useState("");
  const [deviceID, setdeviceId] = useState("");
  const [error, setError] = useState(false);
  const [error2, setError2] = useState(false);
  const [error3, setError3] = useState(false);

  const validation = (e) => {
    e.preventDefault();
    if (catagory.length == 0 || vehicleName.length == 0 || conditionName.length == 0 || plateNumber.length == 0 || manufactureDate.length == 0 || deviceID.length == 0) {
      setError(true);
    }
    if (catagory && vehicleName) {
      swal("Successful", "Successful Added", "success", {
        buttons: false,
        timer: 2000,
      })
    }
  }
  const validation2 = (e) => {
    e.preventDefault();
    if (catagory.length == 0 || vehicleName.length == 0 || conditionName.length == 0 || plateNumber.length == 0 || manufactureDate.length == 0 || deviceID.length == 0) {
      setError2(true);
    }
    if (catagory && vehicleName && conditionName && plateNumber && manufactureDate && deviceID) {
      swal("Successful", "Successful Added", "success", {
        buttons: false,
        timer: 2000,
      })
    }
  }


  const handleClickMessage = () => {
    swal("Successful", "Successful Added", "success", {
      buttons: false,
      timer: 2000,
    })
  }

  const [individual, setIndividual] = useState();
  return (
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
            <p>{title}</p>

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
                </tr>
              </thead>
              <tbody>
                {dataSource.map(item => (
                  <tr className='active_row'>
                    <td>{item.firstName}</td>
                    <td>{item.companyInfo.id}</td> 
                    <td>{item.companyInfo.name}</td>
                    <td>{item.number_of_vehicle}</td>
                    <td>{item.number_of_driver}</td>
                    <td>{item.number_of_driver}</td>
                    <td><Link to={`/user_edit/${item.id}/${item.companyInfo.id}`}>
                      <button>Detail</button></Link></td>
                    <td><Link to="#"><button onClick={() => { handleClickopen() }}>Add </button></Link></td>
                  </tr>
                ))}
              </tbody>
            </table>



            <div className='page'>


              {/* <Pagination
                onChange={10}
                pageSize={postPerPage}
                current={page}
                total={5}
                showQuickJumper
                showSizeChanger
                onShowSizeChange={onShowSizeChange}

              /> */}
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
                        <lable className="zxc">Add Vehicle 1</lable>
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

                {popup2 ?
                  <div>
                    <div className='popup2'>
                      <div className='popup-inner'>
                        <lable className="zxc">Add Vehicle 2</lable>
                        <div className='ewq'>
                          <div className='qwe'>
                            <div className='asd'>
                              <button className='close-btn' onClick={closePopup5}>X</button>
                              <lable>Vehicle Cataegory</lable>
                              <select className='select' placeholder='Select Vecicle Catagory'
                                {...register("catagory", { required: '*Vehicle catagoty  is required' })}
                                name="catagory1"
                                value={catagory}
                                onChange={e => (e.target.value)} >
                                <option selected disabled value="">Select Vecicle Catagory</option>
                                <option value="1">Select Vecicle Catagory 1</option>
                                <option value="1">Select Vecicle Catagory 2</option>
                                <option value="1">Select Vecicle Catagory 3</option>
                                <option value="1">Select Vecicle Catagory 4</option>
                              </select>
                              {catagory <= 0 && error2 ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Name</lable>
                              <input name='vehicleName' type="text" value={vehicleName}
                                {...register("vehicleName", { required: true })}
                                placeholder='Enter Vehicle Name'
                                onChange={(e) => setvehicleName(e.target.value)} ></input>
                              {vehicleName <= 0 && error2 ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Condition</lable>
                              <select className='select' value={conditionName} name='conditionName'

                                {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                onChange={e => setVehicleCondition(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                              </select>
                              {conditionName <= 0 && error2 ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                            </div>


                            <div className='asd'>
                              <lable>Plate Number</lable>
                              <input placeholder='Please Enter Plate Number'
                                value={plateNumber} name='conditionName'
                                {...register("plateNumber", { required: '*please choose service needed' })}
                                onChange={(e) => setPlateNumber(e.target.value)} >
                              </input>
                              {plateNumber <= 0 && error2 ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                            </div>

                            <div className='asd'>
                              <lable>Manufacture Date</lable>
                              <input name='manufacture_date' type="date" value={manufactureDate}
                                {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                placeholder='Enter Manufactureing Date'
                                onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                              {manufactureDate <= 0 && error2 ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                            </div>

                            <div className='asd'>
                              <lable>Device ID</lable>
                              <input name='deviceID' type="text" value={deviceID}
                                {...register("deviceID", { required: '*Device ID is required' })}
                                placeholder='Enter Device ID'
                                onChange={(e) => setdeviceId(e.target.value)} ></input>
                              {deviceID <= 0 && error2 ? <span className='validate_text'>*please enter vehicle name</span> : ""}
                            </div>
                            <div className='asdy'>
                              <h4 onClick={() => { handleClickopen2() }}>Back</h4>
                            </div>
                            <div className='asdy'>
                              <button onClick={validation2}>Submit </button>
                            </div>
                            <div className='asdy'>
                              <h4 onClick={() => { handleClickopen3() }}>Add Vehicle</h4>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div> : ""}

                {popup3 ?
                  <div>
                    <div className='popup2'>
                      <div className='popup-inner'>
                        <lable className="zxc">Add Vehicle 3</lable>
                        <div className='ewq'>
                          <div className='qwe'>
                            <div className='asd'>
                              <button className='close-btn' onClick={closePopup5}>X</button>
                              <lable>Vehicle Cataegory</lable>
                              <select className='select' placeholder='Select Vecicle Catagory'
                                {...register("catagory", { required: '*Vehicle catagoty  is required' })}
                                name="catagory"
                                value={catagory}
                                onChange={e => setVehicleCategory(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Catagory</option>
                                <option>Select Vecicle Catagory 1</option>
                                <option>Select Vecicle Catagory 4</option>
                                <option>Select Vecicle Catagory 3</option>
                                <option>Select Vecicle Catagory 4</option>
                              </select>
                              {/* {catagory <= 0 && errors.catagory && <span className='validate_text'>{errors.catagory.message}</span>} */}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Name</lable>
                              <input name='vehicleName' type="text" value={vehicleName}
                                {...register("vehicleName", { required: true })}
                                placeholder='Enter Vehicle Name'
                                onChange={(e) => setvehicleName(e.target.value)} ></input>
                              {/* {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>} */}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Condition</lable>
                              <select className='select' value={conditionName} name='conditionName'

                                {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                onChange={e => setVehicleCondition(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                              </select>
                              {/* {conditionName <= 0 && errors.conditionName && <span className='validate_text'>{errors.conditionName.message}</span>} */}
                            </div>


                            <div className='asd'>
                              <lable>Plate Number</lable>
                              <input placeholder='Please Enter Plate Number'
                                value={plateNumber} name='conditionName'
                                {...register("plateNumber", { required: '*please choose service needed' })}
                                onChange={(e) => setPlateNumber(e.target.value)} >
                              </input>
                              {/* {plateNumber <= 0 && errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>} */}
                            </div>

                            <div className='asd'>
                              <lable>Manufacture Date</lable>
                              <input name='manufacture_date' type="date" value={manufactureDate}
                                {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                placeholder='Enter Manufactureing Date'
                                onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                              {/* {manufactureDate <= 0 && errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>} */}
                            </div>

                            <div className='asd'>
                              <lable>Device ID</lable>
                              <input name='deviceID' type="text" value={deviceID}
                                {...register("deviceID", { required: '*Device ID is required' })}
                                placeholder='Enter Device ID'
                                onChange={(e) => setdeviceId(e.target.value)} ></input>
                              {/* {deviceID <= 0 && errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>} */}
                            </div>
                            <div className='asdy'>
                              <h4 onClick={() => { handleClickopen3() }}>Back</h4>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => {
                                handleClickMessage()
                                closePopup5()
                              }}>Submit </button>
                            </div>
                            <div className='asdy'>
                              <h4 onClick={() => { handleClickopen4() }}>Add Vehicle</h4>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div> : ""}


                {popup4 ?
                  <div>
                    <div className='popup2'>
                      <div className='popup-inner'>
                        <lable className="zxc">Add Vehicle 4</lable>
                        <div className='ewq'>
                          <div className='qwe'>
                            <div className='asd'>
                              <button className='close-btn' onClick={closePopup5}>X</button>
                              <lable>Vehicle Cataegory</lable>
                              <select className='select' placeholder='Select Vecicle Catagory'
                                {...register("catagory", { required: '*Vehicle catagoty  is required' })}
                                name="catagory"
                                value={catagory}
                                onChange={e => setVehicleCategory(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Catagory</option>
                                <option>Select Vecicle Catagory 1</option>
                                <option>Select Vecicle Catagory 4</option>
                                <option>Select Vecicle Catagory 3</option>
                                <option>Select Vecicle Catagory 4</option>
                              </select>
                              {catagory <= 0 && errors.catagory && <span className='validate_text'>{errors.catagory.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Name</lable>
                              <input name='vehicleName' type="text" value={vehicleName}
                                {...register("vehicleName", { required: true })}
                                placeholder='Enter Vehicle Name'
                                onChange={(e) => setvehicleName(e.target.value)} ></input>
                              {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Condition</lable>
                              <select className='select' value={conditionName} name='conditionName'

                                {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                onChange={e => setVehicleCondition(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                              </select>
                              {conditionName <= 0 && errors.conditionName && <span className='validate_text'>{errors.conditionName.message}</span>}
                            </div>


                            <div className='asd'>
                              <lable>Plate Number</lable>
                              <input placeholder='Please Enter Plate Number'
                                value={plateNumber} name='conditionName'
                                {...register("plateNumber", { required: '*please choose service needed' })}
                                onChange={(e) => setPlateNumber(e.target.value)} >
                              </input>
                              {plateNumber <= 0 && errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Manufacture Date</lable>
                              <input name='manufacture_date' type="date" value={manufactureDate}
                                {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                placeholder='Enter Manufactureing Date'
                                onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                              {manufactureDate <= 0 && errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Device ID</lable>
                              <input name='deviceID' type="text" value={deviceID}
                                {...register("deviceID", { required: '*Device ID is required' })}
                                placeholder='Enter Device ID'
                                onChange={(e) => setdeviceId(e.target.value)} ></input>
                              {deviceID <= 0 && errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                            </div>
                            <div className='asdy'>
                              <h4 onClick={() => { handleClickopen4() }}>Back</h4>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => {
                                handleClickMessage()
                                closePopup5()
                              }}>Submit </button>
                            </div>
                            <div className='asdy'>
                              <h4 onClick={() => { handleClickopen5() }}>Add Vehicle</h4>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div> : ""}

                {popup5 ?
                  <div>
                    <div className='popup2'>
                      <div className='popup-inner'>
                        <lable className="zxc">Add Vehicle 5</lable>
                        <div className='ewq'>
                          <div className='qwe'>
                            <div className='asd'>
                              <button className='close-btn' onClick={closePopup5}>X</button>
                              <lable>Vehicle Cataegory</lable>
                              <select className='select' placeholder='Select Vecicle Catagory'
                                {...register("catagory", { required: '*Vehicle catagoty  is required' })}
                                name="catagory"
                                value={catagory}
                                onChange={e => setVehicleCategory(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Catagory</option>
                                <option>Select Vecicle Catagory 1</option>
                                <option>Select Vecicle Catagory 4</option>
                                <option>Select Vecicle Catagory 3</option>
                                <option>Select Vecicle Catagory 4</option>
                              </select>
                              {catagory <= 0 && errors.catagory && <span className='validate_text'>{errors.catagory.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Name</lable>
                              <input name='vehicleName' type="text" value={vehicleName}
                                {...register("vehicleName", { required: true })}
                                placeholder='Enter Vehicle Name'
                                onChange={(e) => setvehicleName(e.target.value)} ></input>
                              {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Condition</lable>
                              <select className='select' value={conditionName} name='conditionName'

                                {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                onChange={e => setVehicleCondition(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                              </select>
                              {conditionName <= 0 && errors.conditionName && <span className='validate_text'>{errors.conditionName.message}</span>}
                            </div>


                            <div className='asd'>
                              <lable>Plate Number</lable>
                              <input placeholder='Please Enter Plate Number'
                                value={plateNumber} name='conditionName'
                                {...register("plateNumber", { required: '*please choose service needed' })}
                                onChange={(e) => setPlateNumber(e.target.value)} >
                              </input>
                              {plateNumber <= 0 && errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Manufacture Date</lable>
                              <input name='manufacture_date' type="date" value={manufactureDate}
                                {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                placeholder='Enter Manufactureing Date'
                                onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                              {manufactureDate <= 0 && errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Device ID</lable>
                              <input name='deviceID' type="text" value={deviceID}
                                {...register("deviceID", { required: '*Device ID is required' })}
                                placeholder='Enter Device ID'
                                onChange={(e) => setdeviceId(e.target.value)} ></input>
                              {deviceID <= 0 && errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen5() }}>Back</button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => {
                                handleClickMessage()
                                closePopup5()
                              }}>Submit </button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen6() }}>Add Vehicle</button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div> : ""}

                {popup6 ?
                  <div>
                    <div className='popup2'>
                      <div className='popup-inner'>
                        <lable className="zxc">Add Vehicle 6</lable>
                        <div className='ewq'>
                          <div className='qwe'>
                            <div className='asd'>
                              <button className='close-btn' onClick={closePopup5}>X</button>
                              <lable>Vehicle Cataegory</lable>
                              <select className='select' placeholder='Select Vecicle Catagory'
                                {...register("catagory", { required: '*Vehicle catagoty  is required' })}
                                name="catagory"
                                value={catagory}
                                onChange={e => setVehicleCategory(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Catagory</option>
                                <option>Select Vecicle Catagory 1</option>
                                <option>Select Vecicle Catagory 4</option>
                                <option>Select Vecicle Catagory 3</option>
                                <option>Select Vecicle Catagory 4</option>
                              </select>
                              {catagory <= 0 && errors.catagory && <span className='validate_text'>{errors.catagory.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Name</lable>
                              <input name='vehicleName' type="text" value={vehicleName}
                                {...register("vehicleName", { required: true })}
                                placeholder='Enter Vehicle Name'
                                onChange={(e) => setvehicleName(e.target.value)} ></input>
                              {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Condition</lable>
                              <select className='select' value={conditionName} name='conditionName'

                                {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                onChange={e => setVehicleCondition(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                              </select>
                              {conditionName <= 0 && errors.conditionName && <span className='validate_text'>{errors.conditionName.message}</span>}
                            </div>


                            <div className='asd'>
                              <lable>Plate Number</lable>
                              <input placeholder='Please Enter Plate Number'
                                value={plateNumber} name='conditionName'
                                {...register("plateNumber", { required: '*please choose service needed' })}
                                onChange={(e) => setPlateNumber(e.target.value)} >
                              </input>
                              {plateNumber <= 0 && errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Manufacture Date</lable>
                              <input name='manufacture_date' type="date" value={manufactureDate}
                                {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                placeholder='Enter Manufactureing Date'
                                onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                              {manufactureDate <= 0 && errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Device ID</lable>
                              <input name='deviceID' type="text" value={deviceID}
                                {...register("deviceID", { required: '*Device ID is required' })}
                                placeholder='Enter Device ID'
                                onChange={(e) => setdeviceId(e.target.value)} ></input>
                              {deviceID <= 0 && errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen6() }}>Back</button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => {
                                handleClickMessage()
                                closePopup5()
                              }}>Submit </button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen7() }}>Add Vehicle</button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div> : ""}

                {popup7 ?
                  <div>
                    <div className='popup2'>
                      <div className='popup-inner'>
                        <lable className="zxc">Add Vehicle 7</lable>
                        <div className='ewq'>
                          <div className='qwe'>
                            <div className='asd'>
                              <button className='close-btn' onClick={closePopup5}>X</button>
                              <lable>Vehicle Cataegory</lable>
                              <select className='select' placeholder='Select Vecicle Catagory'
                                {...register("catagory", { required: '*Vehicle catagoty  is required' })}
                                name="catagory"
                                value={catagory}
                                onChange={e => setVehicleCategory(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Catagory</option>
                                <option>Select Vecicle Catagory 1</option>
                                <option>Select Vecicle Catagory 4</option>
                                <option>Select Vecicle Catagory 3</option>
                                <option>Select Vecicle Catagory 4</option>
                              </select>
                              {catagory <= 0 && errors.catagory && <span className='validate_text'>{errors.catagory.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Name</lable>
                              <input name='vehicleName' type="text" value={vehicleName}
                                {...register("vehicleName", { required: true })}
                                placeholder='Enter Vehicle Name'
                                onChange={(e) => setvehicleName(e.target.value)} ></input>
                              {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Condition</lable>
                              <select className='select' value={conditionName} name='conditionName'

                                {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                onChange={e => setVehicleCondition(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                              </select>
                              {conditionName <= 0 && errors.conditionName && <span className='validate_text'>{errors.conditionName.message}</span>}
                            </div>


                            <div className='asd'>
                              <lable>Plate Number</lable>
                              <input placeholder='Please Enter Plate Number'
                                value={plateNumber} name='conditionName'
                                {...register("plateNumber", { required: '*please choose service needed' })}
                                onChange={(e) => setPlateNumber(e.target.value)} >
                              </input>
                              {plateNumber <= 0 && errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Manufacture Date</lable>
                              <input name='manufacture_date' type="date" value={manufactureDate}
                                {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                placeholder='Enter Manufactureing Date'
                                onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                              {manufactureDate <= 0 && errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Device ID</lable>
                              <input name='deviceID' type="text" value={deviceID}
                                {...register("deviceID", { required: '*Device ID is required' })}
                                placeholder='Enter Device ID'
                                onChange={(e) => setdeviceId(e.target.value)} ></input>
                              {deviceID <= 0 && errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen7() }}>Back</button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => {
                                handleClickMessage()
                                closePopup5()
                              }}>Submit </button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen8() }}>Add Vehicle</button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div> : ""}

                {popup8 ?
                  <div>
                    <div className='popup2'>
                      <div className='popup-inner'>
                        <lable className="zxc">Add Vehicle 8</lable>
                        <div className='ewq'>
                          <div className='qwe'>
                            <div className='asd'>
                              <button className='close-btn' onClick={closePopup5}>X</button>
                              <lable>Vehicle Cataegory</lable>
                              <select className='select' placeholder='Select Vecicle Catagory'
                                {...register("catagory", { required: '*Vehicle catagoty  is required' })}
                                name="catagory"
                                value={catagory}
                                onChange={e => setVehicleCategory(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Catagory</option>
                                <option>Select Vecicle Catagory 1</option>
                                <option>Select Vecicle Catagory 4</option>
                                <option>Select Vecicle Catagory 3</option>
                                <option>Select Vecicle Catagory 4</option>
                              </select>
                              {catagory <= 0 && errors.catagory && <span className='validate_text'>{errors.catagory.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Name</lable>
                              <input name='vehicleName' type="text" value={vehicleName}
                                {...register("vehicleName", { required: true })}
                                placeholder='Enter Vehicle Name'
                                onChange={(e) => setvehicleName(e.target.value)} ></input>
                              {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Condition</lable>
                              <select className='select' value={conditionName} name='conditionName'

                                {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                onChange={e => setVehicleCondition(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                              </select>
                              {conditionName <= 0 && errors.conditionName && <span className='validate_text'>{errors.conditionName.message}</span>}
                            </div>


                            <div className='asd'>
                              <lable>Plate Number</lable>
                              <input placeholder='Please Enter Plate Number'
                                value={plateNumber} name='conditionName'
                                {...register("plateNumber", { required: '*please choose service needed' })}
                                onChange={(e) => setPlateNumber(e.target.value)} >
                              </input>
                              {plateNumber <= 0 && errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Manufacture Date</lable>
                              <input name='manufacture_date' type="date" value={manufactureDate}
                                {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                placeholder='Enter Manufactureing Date'
                                onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                              {manufactureDate <= 0 && errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Device ID</lable>
                              <input name='deviceID' type="text" value={deviceID}
                                {...register("deviceID", { required: '*Device ID is required' })}
                                placeholder='Enter Device ID'
                                onChange={(e) => setdeviceId(e.target.value)} ></input>
                              {deviceID <= 0 && errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen8() }}>Back</button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => {
                                handleClickMessage()
                                closePopup5()
                              }}>Submit </button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen9() }}>Add Vehicle</button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div> : ""}

                {popup9 ?
                  <div>
                    <div className='popup2'>
                      <div className='popup-inner'>
                        <lable className="zxc">Add Vehicle 9</lable>
                        <div className='ewq'>
                          <div className='qwe'>
                            <div className='asd'>
                              <button className='close-btn' onClick={closePopup5}>X</button>
                              <lable>Vehicle Cataegory</lable>
                              <select className='select' placeholder='Select Vecicle Catagory'
                                {...register("catagory", { required: '*Vehicle catagoty  is required' })}
                                name="catagory"
                                value={catagory}
                                onChange={e => setVehicleCategory(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Catagory</option>
                                <option>Select Vecicle Catagory 1</option>
                                <option>Select Vecicle Catagory 4</option>
                                <option>Select Vecicle Catagory 3</option>
                                <option>Select Vecicle Catagory 4</option>
                              </select>
                              {catagory <= 0 && errors.catagory && <span className='validate_text'>{errors.catagory.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Name</lable>
                              <input name='vehicleName' type="text" value={vehicleName}
                                {...register("vehicleName", { required: true })}
                                placeholder='Enter Vehicle Name'
                                onChange={(e) => setvehicleName(e.target.value)} ></input>
                              {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Condition</lable>
                              <select className='select' value={conditionName} name='conditionName'

                                {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                onChange={e => setVehicleCondition(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                              </select>
                              {conditionName <= 0 && errors.conditionName && <span className='validate_text'>{errors.conditionName.message}</span>}
                            </div>


                            <div className='asd'>
                              <lable>Plate Number</lable>
                              <input placeholder='Please Enter Plate Number'
                                value={plateNumber} name='conditionName'
                                {...register("plateNumber", { required: '*please choose service needed' })}
                                onChange={(e) => setPlateNumber(e.target.value)} >
                              </input>
                              {plateNumber <= 0 && errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Manufacture Date</lable>
                              <input name='manufacture_date' type="date" value={manufactureDate}
                                {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                placeholder='Enter Manufactureing Date'
                                onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                              {manufactureDate <= 0 && errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Device ID</lable>
                              <input name='deviceID' type="text" value={deviceID}
                                {...register("deviceID", { required: '*Device ID is required' })}
                                placeholder='Enter Device ID'
                                onChange={(e) => setdeviceId(e.target.value)} ></input>
                              {deviceID <= 0 && errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen9() }}>Back</button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => {
                                handleClickMessage()
                                closePopup5()
                              }}>Submit </button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen10() }}>Add Vehicle</button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div> : ""}

                {popup10 ?
                  <div>
                    <div className='popup2'>
                      <div className='popup-inner'>
                        <lable className="zxc">Add Vehicle 10</lable>
                        <div className='ewq'>
                          <div className='qwe'>
                            <div className='asd'>
                              <button className='close-btn' onClick={closePopup5}>X</button>
                              <lable>Vehicle Cataegory</lable>
                              <select className='select' placeholder='Select Vecicle Catagory'
                                {...register("catagory", { required: '*Vehicle catagoty  is required' })}
                                name="catagory"
                                value={catagory}
                                onChange={e => setVehicleCategory(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Catagory</option>
                                <option>Select Vecicle Catagory 1</option>
                                <option>Select Vecicle Catagory 4</option>
                                <option>Select Vecicle Catagory 3</option>
                                <option>Select Vecicle Catagory 4</option>
                              </select>
                              {catagory <= 0 && errors.catagory && <span className='validate_text'>{errors.catagory.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Name</lable>
                              <input name='vehicleName' type="text" value={vehicleName}
                                {...register("vehicleName", { required: true })}
                                placeholder='Enter Vehicle Name'
                                onChange={(e) => setvehicleName(e.target.value)} ></input>
                              {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                            </div>

                            <div className='asd'>
                              <lable>Vehicle Condition</lable>
                              <select className='select' value={conditionName} name='conditionName'

                                {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                onChange={e => setVehicleCondition(e.target.value)} >
                                <option selected disabled value="">Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                                <option>Select Vecicle Condition</option>
                              </select>
                              {conditionName <= 0 && errors.conditionName && <span className='validate_text'>{errors.conditionName.message}</span>}
                            </div>


                            <div className='asd'>
                              <lable>Plate Number</lable>
                              <input placeholder='Please Enter Plate Number'
                                value={plateNumber} name='conditionName'
                                {...register("plateNumber", { required: '*please choose service needed' })}
                                onChange={(e) => setPlateNumber(e.target.value)} >
                              </input>
                              {plateNumber <= 0 && errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Manufacture Date</lable>
                              <input name='manufacture_date' type="date" value={manufactureDate}
                                {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                placeholder='Enter Manufactureing Date'
                                onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                              {manufactureDate <= 0 && errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                            </div>

                            <div className='asd'>
                              <lable>Device ID</lable>
                              <input name='deviceID' type="text" value={deviceID}
                                {...register("deviceID", { required: '*Device ID is required' })}
                                placeholder='Enter Device ID'
                                onChange={(e) => setdeviceId(e.target.value)} ></input>
                              {deviceID <= 0 && errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                            </div>
                            <div className='asdy'>
                              <button onClick={() => { handleClickopen10() }}>Back</button>
                            </div>
                            <div className='asdy'>
                              <button onClick={() => {
                                handleClickMessage()
                                closePopup5()
                              }}>Submit </button>
                            </div>
                            <div className='asdy'>
                              {/* <button onClick={() => { handleClickopen3() }}>Add Vehicle</button> */}
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div> : ""}


              </form>



            </div>


          </div>

      }




    </>






  )
}