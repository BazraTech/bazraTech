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
import './Vehicle_registration.css';
import { Link } from 'react-router-dom';

export default function Vehicle_Registration() {
  return (
    <div className="containerr">

      {/*---------------navigation---------------*/}

      <div className="navigation">
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

      <div className="header">
        <h2>Bazra Moters</h2>
        <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
      </div>
      {/* ---------------end header--------------- */}


      {/* ---------------Registration--------------- */}

      <section className='register'>
        <form className='form'>
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
          <Link to="/both"><button className='edit'>Add Vehicle</button></Link>
          </div>



        </form>

      </section>


      {/* ---------------end Registaration--------------- */}
    </div>
  )
}
