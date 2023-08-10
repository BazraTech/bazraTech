import React from 'react'
import { FaHome } from 'react-icons/fa';
import styles from './markating.module.css';
import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { Pagination } from 'antd';
import beep from './beep.mp3'
import swal from "sweetalert";

export default function () {
 
  const [popup, setPop1] = useState(false);
  const handleClickopen = () => {
    setPop1(!popup);
  }
const [error,setError]=useState('')
  const playBeep = () => {
    const audio = new Audio(beep); 
    audio.play();
    console.log('beep')
  };
  const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

  const options = {

    headers: {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": `Bearer ${jwt}`
    },

  };
  const [reloadKey, setReloadKey] = useState(0);

  const handleReload = () => {
  setReloadKey((prevKey) => prevKey + 1);
  };
  const [NewMarket,setNewMarkets]=useState(0)
  const [Loading, setLoading] = useState([])
  const [totalPages, setTotalPage] = useState(1);
  const url2 = "http://164.90.174.113:9090/Api/Admin/All/Cargos";
  const [dataSource2, setDataSource2] = useState([])
  useEffect(() => {
    setLoading(true);
    fetch(url2, options)
      .then(respnse => respnse.json())
      .then(response => {
                localStorage.setItem("message", JSON.stringify(response["message"])); 
                const mess = localStorage.getItem("message");
                console.log(response.status)
              if (response.status == 500) {
              throw new Error('Failed to get the drivers');
              }else{
                setDataSource2(response.cargos.filter(item => item.status != 'FINISHED'))
                setNewMarkets(response.cargos.filter(item => item.status === 'NEW'))
                setTotalPage(response.cargos); 
                setLoading(false);
              }
              })
              .catch(error => {

              setError(error.message);
              swal(`Failed ${error}`, "Error", "error");
              }
              );
  }, [reloadKey])

console.log(dataSource2)
  const [page, setCurentPage] = useState(1);
  const [postPerPage, setpostPerPage] = useState(7);

  const indexOfLastPage = page * postPerPage;
  const indexOfFirstPage = indexOfLastPage - postPerPage;

  const onShowSizeChange = (current, pageSize) => {
    setpostPerPage(pageSize);
  }
  const [color, setColor] = useState("green");
  const [margin, setMargin] = useState("");

  const [filteredRows, setFilteredRows] = useState(dataSource2);
  const [searchValue, setSearchValue] = useState('');


  const handleSearch = (e) => {
      const value = e.target.value;
      setSearchValue(value);
   
      const filteredData = dataSource2.filter((item) => {
        // Customize the conditions as per your search requirements
        return (
          item.cargoOwner.toLowerCase().includes(value.toLowerCase()) ||
          item.packaging.toLowerCase().includes(value.toLowerCase()) ||
          item.weight.toString().toLowerCase().includes(value.toLowerCase())||
          item.status.toLowerCase().includes(value.toLowerCase())||
          item.pickUp.toLowerCase().includes(value.toLowerCase())||
          item.dropOff.toLowerCase().includes(value.toLowerCase())
          
        );
      });

      setFilteredRows(filteredData);
    };
    const currentPage = (searchValue === '' ? dataSource2 : filteredRows).slice(indexOfFirstPage, indexOfLastPage);

  const searchResult = currentPage



  return (
    <>


    <div className="company_container">

{/*--------------- Company Container ---------------*/}
<Navigation path="/marketing" title="marketing"></Navigation>

{/* --------------- Registration- -------------- */}

<section className={styles.main_content}>

    <div className={styles.company_individual_header} onClick={()=>handleReload()}>
        <p ><Link style={{ textDecoration: 'none' }} to="#"><h1 className={styles.companyHeader}>Available Works</h1></Link></p>
        <p><Link style={{ textDecoration: 'none' }} to="/FinishedWorks"><h1>Finished Works</h1></Link></p>
    </div>
    <div className={styles.allDiv}>

    <div className={styles.search}>
            
            
            
              <input type="text" id="myInput" onChange={handleSearch}  placeholder="Search . . ."></input>
              <button>Search</button>
           
            </div>

            {/*---------------- table ------------------- */}

            <div className={styles.outer_vehicle_table} id='myTable'>
             <div style={{display:'flex'}}> <p>Available  markate</p> 
             {NewMarket.length > 0 &&  <span onClick={handleReload}className={styles.glow_box}>{NewMarket.length} New Markets</span>}
             </div>
              <table className={styles.vehicle_table} id="myTable">
                                            <thead>
                                                <tr>
                                                    <th>Name</th>
                                                    <th>packaging</th>
                                                    <th>Trips from to</th>
                                                    <th>weight</th>
                                                    <th>Status</th>
                                                    <th>Detail/progress</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {searchResult && searchResult.map(item => (
                                                    <tr className={styles.active_row} key = {item.id}>
                                                        <td>{item.cargoOwner}</td>
                                                        <td>{item.packaging}</td>
                                                        <td>{item.pickUp +' => '+ item.dropOff }</td>
                                                        <td>{item.weight}</td>
                                                        <td style={{color:item.status === 'NEW' ? 'fbff00': ''}}>{item.status}</td>
                                                       {/* <td><Link to={`/cargo/${item.id}`}>
                                                            <button>Detail</button></Link>
                                                            </td> */}
                                                         <td>{item.status != 'NEW' ?<Link to={`/Market_Progress/${item.id}`}><button>Progress</button></Link>:
                                                         <Link to={`/Post_market/${item.id}`}><button>Detail</button></Link>}</td>
                                                        
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
                total={totalPages.length}
              showQuickJumper
              showSizeChanger
              onShowSizeChange={onShowSizeChange}
              />
            </div>

          </div>
    
    </section>
  </div>

</>
  )
}
