# sta4R
 

## Description

### R Client for OGC SensorThings API (STA)

#### Easing the management of and access to environmental time series data from an OGC SensorThings API (STA)

sta4R is a package for R.  The user can also use it to query data from any standard STA instance using R functions, providing R users a convenient way to integrate data from STA servers into analysis workflows. This functionality is inspired by the 52 North package [sos4R](https://github.com/52North/sos4R), which provides similar capabilities for the OGC Sensor Observation Service (SOS) standard. 

In addition, the user can use ```sta4R``` functions to import data from tabular data sources into a STA instance, mirroring the capabilities of importer tools such as the [52 North SOS importer](https://wiki.52north.org/SensorWeb/SosImporter) for the SOS.

#### Key Technologies

- R Programming Language
- OGC SensorThings API v1.0 and v1.1
- OGC Operations and Measurements 2.0

#### Key Use Cases

- Ease data import into STA instances 
- Automatic generation of STA API requests
- STA API response handling and parsing into R data objects


## SensorThings API and R

There are two families of functions that need to be created:

1. Functions replicating SensorThings API calls. These can be built with:
  - ```httr``` package request framework 
  - solid understanding of the SensorThings Data Model (see [description](https://ogc-iot.github.io/ogc-iot-api/datamodel.html) and/or [video](https://youtu.be/eWsT_4SlcBM))
  - solid understanding of SensorThings API request patterns (see SensorUp [API Docs](https://developers.sensorup.com/docs/) and [Tutorials](https://developers.sensorup.com/examples/)
  
2. Functions parsing SensorThings responses into R data objects, including:
  - ```data.frame``` / ```tibbles```
  - ```sf``` objects

### Playground

a playground sta to read data from and write data to is at https://sta-demo.internetofwater.dev/api/v1.1 (or 1.1)

