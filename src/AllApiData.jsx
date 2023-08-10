import { useEffect, useState } from "react";
import React  from 'react'

export default function AllApiData()
{
const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api
    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
    };

    const url1 = "http://164.90.174.113:9090/Api/Admin/All/Vehicles";
    const [allvehicles, setAllvehicles] = useState([])
    useEffect(() => {
        fetch(url1, options)
            .then(respnse => respnse.json())
            .then(data => {
                setAllvehicles(data.totalVehicles)

            })
    }, [allvehicles])

    const url2 = "http://164.90.174.113:9090/Api/Admin/All/Drivers";
    const [allDrivers, setAllDrivers] = useState([])
    useEffect(() => {
        fetch(url2, options) 
            .then(respnse => respnse.json())
            .then(data => {
                setAllDrivers(data.totalDrivers)

            })
    }, [allDrivers])

    const url = "http://164.90.174.113:9090/Api/Admin/All/VehicleOwners/";
    const [allVehiclwOwner, setAllVehiclwOwner] = useState([])
    useEffect(() => {
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setAllVehiclwOwner(data.totalusers) 
            

            })
    }, [])
    const [individualVOwner, setindividualVOwner] = useState([])
    const urin = "http://164.90.174.113:9090/Api/Admin/All/VehicleOwners/Role/individual";
    useEffect(() => {
        fetch(urin, options)
            .then(respnse => respnse.json())
            .then(data => {
                setindividualVOwner(data.totalusers)
               
            })
    }, [individualVOwner])
    const cargourl = "http://164.90.174.113:9090/Api/Admin/All/CargoOwners";
    const [allCargoOwner, setallCargoOwner] = useState(0)
    useEffect(() => {
        fetch(cargourl, options)
            .then(respnse => respnse.json())
            .then(response => {
                localStorage.setItem("message", JSON.stringify(response["message"])); 
                const mess = localStorage.getItem("message");
                console.log(response.status)
          if (!response.ok) {
            setallCargoOwner('!')
            throw new Error('Failed to get cargo owners');
            
          }else{
            setallCargoOwner(response.cargoOwners.length )
        }})
    }, [])
  
    const url3 = "http://164.90.174.113:9090/Api/Admin/Alerts/OFFROAD";
    const [alertOffroad, setalertOffroad] = useState([])
    useEffect(() => {
        fetch(url3, options)
            .then(respnse => respnse.json())
            .then(data => {
                setalertOffroad(data && data.activeAlerts.length)
              
            })
    }, [])

    const url4 = "http://164.90.174.113:9090/Api/Message/All";
    const [allMessage, setallMessage] = useState([])
    useEffect(() => {
        fetch(url4, options)
            .then(respnse => respnse.json())
            .then(data => {
                setallMessage(data && data.messages.length)
               
            })
    }, [])
    const url5 = "http://164.90.174.113:9090/Api/Admin/All/Cargos";
    const [allMarket, setallMarket] = useState([])
    useEffect(() => {
        fetch(url5, options)
            .then(respnse => respnse.json())
            .then(data => {
                setallMarket(data && data.cargos.length)
            
            })
    }, [])




/**************Vihichels********************* */

const onRouteUrl = "http://164.90.174.113:9090/Api/Admin/All/Vehicles/Status/ONROUTE";
    const [onRoute, setonRoute] = useState([])
    useEffect(() => {
        fetch(onRouteUrl, options)
            .then(respnse => respnse.json())
            .then(data => {
                setonRoute(data.inRouteVehicles)
            })
    }, [onRoute])

    const inStockUrl = "http://164.90.174.113:9090/Api/Admin/All/Vehicles/Status/INSTOCK";
    const [inStock, setinStock] = useState([])
    useEffect(() => {
        fetch(inStockUrl, options)
            .then(respnse => respnse.json())
            .then(data => {
                setinStock(data.stockedVehicles)
               
            })
    }, [inStock])

    const parkedUrl = "http://164.90.174.113:9090/Api/Admin/All/Vehicles/Status/PARKED";
    const [parked, setparked] = useState([])
    useEffect(() => {
        fetch(parkedUrl, options)
            .then(respnse => respnse.json())
            .then(data => {
                setparked(data.parkedVehicles)

            })
    }, [parked])

    const MaintainigUrl = "http://164.90.174.113:9090/Api/Admin/All/Vehicles/Status/MAINTAINING";
    const [Maintaining, setMaintainig] = useState([])
    useEffect(() => {
        fetch(MaintainigUrl, options)
            .then(respnse => respnse.json()) 
            .then(data => {
                setMaintainig(data.maintainingVehicles)
                
            })
    }, [Maintaining])
/***************************Users ******************/
const VehicleOwnersUrl = "http://164.90.174.113:9090/Api/Admin/All/VehicleOwners";
const [VehicleOwners,setVehicleOwners]= useState([])
useEffect(() => {
    fetch(VehicleOwnersUrl, options)
        .then(respnse => respnse.json())
        .then(data => {
            setVehicleOwners(data.totalusers)        })
}, [])
const CompanyUrl = "http://164.90.174.113:9090/Api/Admin/All/VehicleOwners/Role/owner";
const [CompanyOwner, setCompanyOwner] = useState([])
useEffect(() => {
    fetch(CompanyUrl, options)
        .then(respnse => respnse.json())
        .then(data => {
            setCompanyOwner(data.totalusers)
        })
}, [])
const IndividualUrl = "http://164.90.174.113:9090/Api/Admin/All/VehicleOwners/Role/individual";
const [IndividualOwner, setIndividual] = useState([])
    useEffect(() => {
        fetch(IndividualUrl, options)
            .then(respnse => respnse.json())
            .then(data => {
                setIndividual(data.totalusers)
            })
    }, [])


    localStorage.setItem("ApiData", JSON.stringify({"allvehicles":allvehicles,
    "allDrivers":allDrivers,
    'allVehiclwOwner':allVehiclwOwner,
    "individualVOwner":individualVOwner,
    "allCargoOwner":allCargoOwner,
    "alertOffroad":alertOffroad,
    "allMessage":allMessage,
    "allMarket":allMarket,
    "onRoute":onRoute,
    "inStock":inStock,
    "parked":parked,
    "Maintaining":Maintaining,
    "VehicleOwners":VehicleOwners,
    "CompanyOwner":CompanyOwner,
    "IndividualOwner":IndividualOwner,
    "CargoOwner":allCargoOwner
}))
return(
    <></>
)

}