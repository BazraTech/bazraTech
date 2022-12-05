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
import './company_registration.css';
import { useForm } from 'react-hook-form';
import { Link } from 'react-router-dom';

export default function Both() {

    {/*------------------Validation for company registration----------------- */ }

    {/*----------------handle events----------------- */ }
    const { register, handleSubmit, watch, formState: { errors } } = useForm();

    {/*----------------handle submit values----------------- */ }
    const onSubmit = data => console.log(data);

    return (
        <div className="company_container">

            {/*---------------navigation---------------*/}

            <div className="company_navigation">
                <ul>
                    <li>
                        <Link to="/dashboard"> <p><FaHome size="2rem" color='white'></FaHome></p></Link>
                    </li>
                    <li>
                        <Link to="/Vehicle_reg"><p><AiFillCar className='sty' size="2rem" color='white'></AiFillCar></p></Link>
                    </li>
                    <li>
                        <p><RiGpsFill size="2rem" color='white'></RiGpsFill></p>
                    </li>
                    <li>
                        <p><MdMonitor size="2rem" color='white'></MdMonitor></p>
                    </li>
                    <li>
                        <Link to="/users">  <p><FaUsers size="2rem" color='white'></FaUsers></p></Link>
                    </li>
                    <li>
                        <p><HiBellAlert size="2rem" color='white'></HiBellAlert></p>
                    </li>
                    <li>
                        <p><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p>
                    </li>
                    <li>
                        <Link to="/Company_registration"> <p><FaRegIdCard size="1.8rem" color='#00cc44'></FaRegIdCard></p></Link>
                    </li>
                    <li>
                        <p><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p>
                    </li>
                    <li>
                        <p><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                    </li>
                    <li>
                        <p><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                    </li>
                </ul>
            </div>

            {/* ---------------end navigation--------------- */}


            {/* ---------------header--------------- */}

            <div className="company_header">
                <h2>Bazra Moters</h2>
                <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
            </div>
            {/* ---------------end header--------------- */}


            {/* ---------------Registration--------------- */}

            <section className='company_register'>

                <form className='form' onSubmit={handleSubmit(onSubmit)}>

                    {/* ---------------Company Information--------------- */}

                    <div className='input-box'>
                        <h1 >Company Information</h1>
                        <p>Company Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                        <input className='title' type="text" {...register("organizationName", { required: true })} placeholder='Enter organization name'></input>
                        {errors.organizationName?.type === "required" && <span className='validate_text'>*please enter the organization name</span>}

                    </div>

                    <div className='sector_tyoe'>
                        <div className='input-box'>
                            <p>Company Sector <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                            <select className='select' {...register("sectorType", { required: '*Company sector is required' })}>
                                <option value=''>Select company sector</option>
                                <option value='plc'>Public Llimited Company</option>
                                <option value='plc'>Government</option>
                                <option value='plc'>Public Llimited Company</option>
                                <option value='plc'>Public Llimited Company</option>
                            </select>
                            {errors.sectorType && <span className='validate_text'>{errors.sectorType.message}</span>}
                        </div>
                        <div className='input-box'>
                            <p>Company Type <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                            <input type="text" {...register("companyType", { required: true })} placeholder='Enter organization name'></input>
                            {errors.companyType?.type === "required" && <span className='validate_text'>*please enter the company type</span>}
                        </div>
                    </div>

                    {/* ---------------Company Address--------------- */}

                    <div className='input-box'>
                        <h1>Company Address</h1>
                    </div>

                    <div className='company_address'>

                        <div className='address'>
                            <div className='input-box'>
                                <p>Region <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select className='select' {...register("region", { required: '*please fill your region' })}>
                                    <option value=''>Select company sector</option>
                                    <option value='plc'>Public Llimited Company</option>
                                    <option value='plc'>Public Llimited Company</option>
                                    <option >Public Llimited Company</option>
                                    <option >Public Llimited Company</option>
                                </select>
                                {errors.region && <span className='validate_text'>{errors.region.message}</span>}
                            </div>

                            <div className='input-box'>
                                <p>City <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select className='select' {...register("city", { required: '*please fill your city' })}>
                                    <option value=''>Select company sector</option>
                                    <option value='plc'>Public Llimited Company</option>
                                    <option value='plc'>Public Llimited Company</option>
                                    <option >Public Llimited Company</option>
                                    <option >Public Llimited Company</option>
                                </select>
                                {errors.city && <span className='validate_text'>{errors.city.message}</span>}
                            </div>

                        </div>

                        <div className='address'>
                            <div className='input-box'>
                                <p>Sub City <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select className='select'{...register("subCity", { required: '*please fill your Sub-city' })}>
                                    <option value=''>Select company sector</option>
                                    <option value='plc'>Public Llimited Company</option>
                                    <option value='plc'>Public Llimited Company</option>
                                    <option >Public Llimited Company</option>
                                    <option >Public Llimited Company</option>
                                </select>
                                {errors.subCity && <span className='validate_text'>{errors.subCity.message}</span>}
                            </div>

                            <div className='input-box'>
                                <p>Woreda </p>
                                <input type="text" {...register("werda", { pattern: { value: /^[0-9]+[0-9]*$/, message: 'please enter a vaild number' } })} placeholder='Enter Woreda'></input>
                                {errors.werda && <span className='validate_text'>{errors.werda.message}</span>}
                            </div>

                        </div>

                        <div className='address'>
                            <div className='input-box'>
                                <p>Specfic Location </p>
                                <input type="text" {...register("specificLocation")} placeholder='Enter Specfic Location'></input>
                            </div>

                            <div className='input-box'>
                                <p>House Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" className="enter-otp" {...register("houseNumber", { required: "*please fill your house nuber", pattern: { value: /^[0-9]+[0-9]*$/, message: 'please enter a vaild number' } })} placeholder='Enter House Number'></input>
                                {errors.houseNumber && <span className='validate_text'>{errors.houseNumber.message}</span>}
                            </div>


                        </div>
                        <div className='address'>
                            <div className='input-box'>
                                <p>Phone Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("officeNumber", { required: "*please fill your company number" })} placeholder='Enter Phone Number'></input>
                                {errors.officeNumber && <span className='validate_text'>{errors.officeNumber.message}</span>}
                            </div>

                        </div>

                    </div>

                    <div className='input-box'>
                        <h1>Owner Information</h1>
                    </div>

                    <div className='owner_information'>
                        <div className='input-box'>
                            <p>First Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                            <input type="text" {...register("firstName", { required: true })} placeholder='Enter Your first name'></input>
                            {errors.firstName?.type === "required" && <span className='validate_text'>*please enter your name</span>}
                        </div>
                        <div className='input-box'>
                            <p>Last Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                            <input type="text" {...register("lastName", { required: true })} placeholder='Enter Your last name'></input>
                            {errors.lastName?.type === "required" && <span className='validate_text'>*please enter your last name</span>}
                        </div>
                        <div className='input-box'>
                            <p>Phone Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                            <input type="text" {...register("customerNumber", { required: "*please fill your mobile nuber" })} placeholder='Enter Phone Number'></input>
                            {errors.customerNumber && <span className='validate_text'>{errors.customerNumber.message}</span>}
                        </div>
                        <div className='input-box'>
                            <p>Email <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                            <input type="email" {...register("emailAddress", { required: "please enter a valid email", pattern: { value: /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/, message: 'please fill a valid message' } })} placeholder='Enter your Email'></input>
                            {errors.emailAddress && <span className='validate_text'>{errors.emailAddress.message}</span>}
                        </div>
                    </div>

                    <div className='input-box'>
                        <h1>Additional Information</h1>
                    </div>
                    <div className='addition_information'>
                        <div className='input-box'>
                            <p>Notification Preference <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                            <select className='select' {...register("notificationPreference", { required: '*please choose your notification preference' })}>
                                <option value=''>Select company sector</option>
                                <option value='plc'>Public Llimited Company</option>
                                <option value='plc'>Public Llimited Company</option>
                                <option>Public Llimited Company</option>
                                <option>Public Llimited Company</option>
                            </select>
                            {errors.notificationPreference && <span className='validate_text'>{errors.notificationPreference.message}</span>}
                        </div>
                        <div className='input-box'>
                            <p>Service Neded <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                            <select className='select' {...register("serviceNeeded", { required: '**please choose service needed' })}>
                                <option value=''>Select company sector</option>
                                <option value='plc'>Public Llimited Company</option>
                                <option value='plc'>Public Llimited Company</option>
                                <option>Public Llimited Company</option>
                                <option>Public Llimited Company</option>
                            </select>
                            {errors.serviceNeeded && <span className='validate_text'>{errors.serviceNeeded.message}</span>}
                        </div>


                    </div>
                    <div className='button'>
                        <button className='edit'>Save and Continue</button>
                    </div>







                    <div className='input-box'>
            <h1>Vehicle Information</h1>
          </div>
          <div className='vehicle_information'>

            <div className='address'>
              <div className='input-box'>
                <p>Vehicle Catagory <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                <select className='select'>
                  <option selected disabled>Select company sector</option>
                  <option>Public Llimited Company</option>
                  <option>Public Llimited Company</option>
                  <option>Public Llimited Company</option>
                  <option>Public Llimited Company</option>
                </select>
              </div>
            </div>

            <div className='address'>
              <div className='input-box'>
                <p>Vehicle Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                <input type="text" placeholder='Enter Vehicle Name'></input>
              </div>

            </div>
            <div className='address'>
              <div className='input-box'>
                <p>Vehicle Condition <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                <select className='select'>
                  <option selected disabled>Select company sector</option>
                  <option>Public Llimited Company</option>
                  <option>Public Llimited Company</option>
                  <option>Public Llimited Company</option>
                  <option>Public Llimited Company</option>
                </select>
              </div>

            </div>
            <div className='address'>
              <div className='input-box'>
                <p>Plate Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                <input type="text" placeholder='Enter Plate Number'></input>
              </div>
            </div>

            <div className='address'>
              <div className='input-box'>
                <p>--<FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                <input type="number" placeholder='4'></input>
              </div>

            </div>
            <div className='address'>
              <div className='input-box'>
                <p>--<FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                <input type="number" placeholder='00034'></input>
              </div>

            </div>
          </div>

          <div className='vehicle_info'>
            <div className='input-box'>
              <p>Manufactureing Date<FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
              <input type="date" placeholder='Enter Manufactureing Date'></input>
            </div>
            <div className='input-box'>
              <p>Device ID <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
              <input type="text" placeholder='Enter Device ID'></input>
            </div>
          </div>


          <div className='button'>
          <button className='edit'>Add Vehicle</button>
          </div>





                </form>

            </section>


            {/* ---------------end Registaration--------------- */}
        </div>
    )
}
