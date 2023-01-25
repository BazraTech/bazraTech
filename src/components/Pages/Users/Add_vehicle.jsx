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
import { FaStarOfLife } from 'react-icons/fa';
import { useForm } from 'react-hook-form';
import { Link } from 'react-router-dom';
import { HiMenuAlt1 } from "react-icons/hi";
import Header from '../../Header/Header';

export default function() {


    {/*------------------ Validation for company registration ----------------- */ }

    {/*---------------- handle events ----------------- */ }
    const { register, handleSubmit, watch, formState: { errors } } = useForm();

    {/*---------------- handle submit values ----------------- */ }
    const onSubmit = data => console.log(data);

    return (
        <div className="company_container">

            {/*--------------- Company Container ---------------*/}

            <div className="company_navigation">
                <ul>
                    <li>
                        <Link to="/dashboard">
                            <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='white'></FaHome><p></p></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Total_number_of_vehicle">
                            <p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='#00cc44'></AiFillCar></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/tracking">
                            <p class="hovertext" data-hover="Tracking"><RiGpsFill size="2rem" color='white'></RiGpsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="#">
                            <p class="hovertext" data-hover="Monitor Vehicles"><MdMonitor size="2rem" color='white'></MdMonitor></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/users">
                            <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='white'></FaUsers></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/accident">
                            <p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='white'></HiBellAlert></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/report">
                            <p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Company_registration">
                            <p class="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" color='white'></FaRegIdCard></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/message_overview">
                            <p class="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="#">
                            <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/settings">
                            <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                        </Link>
                    </li>
                </ul>
            </div>


            {/* --------------- Company header --------------- */}

            <Header title="Add Vehicle"></Header>

            {/* --------------- Registration- -------------- */}

            <section className='company_register'>
                <form className='form' onSubmit={handleSubmit(onSubmit)}>

                    <div className='second_div'>
                        <div className='registerd_vehicle'><h1>Vehicle Information</h1> <div className='Vehicle_number'><h1>Registerd Vehicle</h1><h1 className='number' >10</h1></div></div>
                        <div className='vehicle_information'>
                            <div>
                                <p>Vehicle Catagory <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select className='select' {...register("vehicleCatagory", { required: '*Vehicle catagoty  is required' })}>
                                    <option value='' selected disabled>Select Vecicle Catagory</option>
                                    <option value=''>Select Vecicle Catagory</option>
                                    <option value=''>Select Vecicle Catagory</option>
                                    <option value=''>Select Vecicle Catagory</option>
                                    <option value=''>Select Vecicle Catagory</option>
                                </select>
                                {errors.vehicleCatagory && <span className='validate_text'>{errors.vehicleCatagory.message}</span>}
                            </div>
                            <div>
                                <p>Vehicle Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("vehicleName", { required: true })} placeholder='Enter Vehicle Name'></input>
                                {errors.organizationName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                            </div>
                            <div>
                                <p>Vehicle Condition <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select className='select' {...register("vehicleCondition", { required: '*Vecicle Condition is required' })}>
                                    <option value=''>Select Vecicle Condition</option>
                                    <option>Select Vecicle Condition</option>
                                    <option>Select Vecicle Condition</option>
                                    <option>Select Vecicle Condition</option>
                                    <option>Select Vecicle Condition</option>
                                </select>
                                {errors.vehicleCondition && <span className='validate_text'>{errors.vehicleCondition.message}</span>}
                            </div>
                            <div>
                                <p>Plate Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <div className='plate_number'>
                                    <select className='select' {...register("plateNumber", { required: '*plate number is required' })}>
                                        <option value=''>AD</option>
                                        <option>ET</option>
                                        <option>ORO</option> 
                                        <option>AM</option>
                                        <option>TG</option>
                                    </select>
                                    <input type="number" {...register("code")} placeholder='4'></input>
                                    <input type="number" {...register("idd")} placeholder='00034'></input>
                                    {errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                                </div>
                            </div>

                            <div> 
                                <p>Manufacture Date <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="date" {...register("manufactureDate", { required: '*Manufacture date is required' })} placeholder='Enter Manufactureing Date'></input>
                                {errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                            </div>
                            <div>
                                <p>Device ID <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("deviceID", { required: '*Device ID is required' })} placeholder='Enter Device ID'></input>
                                {errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                            </div>
                        </div>
                    </div>
                    <div className='company_button'>
                        <button className='add'>Save</button>
                        <button className='add'>Add Another</button>
                    </div>

                </form>

            </section>


            {/* ---------------end Registaration--------------- */}
        </div>
    )
}
