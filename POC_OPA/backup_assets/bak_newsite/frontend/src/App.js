import React, { useState, useEffect } from "react";

function App() {
  const [cities, setCities] = useState([]);

  useEffect(() => {
    fetch("http://backend-service.frontback.svc.cluster.local/cities")
      .then((response) => response.json())
      .then((data) => setCities(Object.values(data)))
      .catch((error) => console.error("Error fetching cities:", error));
  }, []);

  return (
    <div>
      <h1>Bienvenue sur le site des villes</h1>
      {cities.map((city, index) => (
        <div key={index}>
          <h2>{city.name}</h2>
          <img src={`http://backend-service.frontback.svc.cluster.local${city.image}`} alt={city.name} width="400px" />
        </div>
      ))}
    </div>
  );
}

export default App;
