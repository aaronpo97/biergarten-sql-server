USE Biergarten;
GO

CREATE OR ALTER PROCEDURE dbo.USP_AddLocations
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;
    -- Countries (alpha-2)
    WITH
        Countries(CountryName, Alpha2)
        AS
        (
            SELECT 'Canada', 'CA' 
            UNION ALL 
            SELECT 'Mexico', 'MX'
            UNION ALL 
            SELECT 'United States', 'US'
        )
    INSERT INTO dbo.Country
        (CountryName, ISO3616_1)
    SELECT c.CountryName, c.Alpha2
    FROM Countries AS c
    WHERE NOT EXISTS (SELECT 1
        FROM dbo.Country AS x
        WHERE x.ISO3616_1 = c.Alpha2
    );

    WITH
        Regions(StateProvinceName, ISO2, CountryAlpha2)
        AS
        (
            -- United States (50 + DC + territories)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                SELECT 'Alabama', 'US-AL', 'US'
            UNION ALL
                SELECT 'Alaska', 'US-AK', 'US'
            UNION ALL
                SELECT 'Arizona', 'US-AZ', 'US'
            UNION ALL
                SELECT 'Arkansas', 'US-AR', 'US'
            UNION ALL
                SELECT 'California', 'US-CA', 'US'
            UNION ALL
                SELECT 'Colorado', 'US-CO', 'US'
            UNION ALL
                SELECT 'Connecticut', 'US-CT', 'US'
            UNION ALL
                SELECT 'Delaware', 'US-DE', 'US'
            UNION ALL
                SELECT 'Florida', 'US-FL', 'US'
            UNION ALL
                SELECT 'Georgia', 'US-GA', 'US'
            UNION ALL
                SELECT 'Hawaii', 'US-HI', 'US'
            UNION ALL
                SELECT 'Idaho', 'US-ID', 'US'
            UNION ALL
                SELECT 'Illinois', 'US-IL', 'US'
            UNION ALL
                SELECT 'Indiana', 'US-IN', 'US'
            UNION ALL
                SELECT 'Iowa', 'US-IA', 'US'
            UNION ALL
                SELECT 'Kansas', 'US-KS', 'US'
            UNION ALL
                SELECT 'Kentucky', 'US-KY', 'US'
            UNION ALL
                SELECT 'Louisiana', 'US-LA', 'US'
            UNION ALL
                SELECT 'Maine', 'US-ME', 'US'
            UNION ALL
                SELECT 'Maryland', 'US-MD', 'US'
            UNION ALL
                SELECT 'Massachusetts', 'US-MA', 'US'
            UNION ALL
                SELECT 'Michigan', 'US-MI', 'US'
            UNION ALL
                SELECT 'Minnesota', 'US-MN', 'US'
            UNION ALL
                SELECT 'Mississippi', 'US-MS', 'US'
            UNION ALL
                SELECT 'Missouri', 'US-MO', 'US'
            UNION ALL
                SELECT 'Montana', 'US-MT', 'US'
            UNION ALL
                SELECT 'Nebraska', 'US-NE', 'US'
            UNION ALL
                SELECT 'Nevada', 'US-NV', 'US'
            UNION ALL
                SELECT 'New Hampshire', 'US-NH', 'US'
            UNION ALL
                SELECT 'New Jersey', 'US-NJ', 'US'
            UNION ALL
                SELECT 'New Mexico', 'US-NM', 'US'
            UNION ALL
                SELECT 'New York', 'US-NY', 'US'
            UNION ALL
                SELECT 'North Carolina', 'US-NC', 'US'
            UNION ALL
                SELECT 'North Dakota', 'US-ND', 'US'
            UNION ALL
                SELECT 'Ohio', 'US-OH', 'US'
            UNION ALL
                SELECT 'Oklahoma', 'US-OK', 'US'
            UNION ALL
                SELECT 'Oregon', 'US-OR', 'US'
            UNION ALL
                SELECT 'Pennsylvania', 'US-PA', 'US'
            UNION ALL
                SELECT 'Rhode Island', 'US-RI', 'US'
            UNION ALL
                SELECT 'South Carolina', 'US-SC', 'US'
            UNION ALL
                SELECT 'South Dakota', 'US-SD', 'US'
            UNION ALL
                SELECT 'Tennessee', 'US-TN', 'US'
            UNION ALL
                SELECT 'Texas', 'US-TX', 'US'
            UNION ALL
                SELECT 'Utah', 'US-UT', 'US'
            UNION ALL
                SELECT 'Vermont', 'US-VT', 'US'
            UNION ALL
                SELECT 'Virginia', 'US-VA', 'US'
            UNION ALL
                SELECT 'Washington', 'US-WA', 'US'
            UNION ALL
                SELECT 'West Virginia', 'US-WV', 'US'
            UNION ALL
                SELECT 'Wisconsin', 'US-WI', 'US'
            UNION ALL
                SELECT 'Wyoming', 'US-WY', 'US'
            UNION ALL
                SELECT 'District of Columbia', 'US-DC', 'US'
            UNION ALL
                SELECT 'Puerto Rico', 'US-PR', 'US'
            UNION ALL
                SELECT 'U.S. Virgin Islands', 'US-VI', 'US'
            UNION ALL
                SELECT 'Guam', 'US-GU', 'US'
            UNION ALL
                SELECT 'Northern Mariana Islands', 'US-MP', 'US'
            UNION ALL
                SELECT 'American Samoa', 'US-AS', 'US'

            -- Canada (10 provinces + 3 territories)
            UNION ALL
                SELECT 'Ontario', 'CA-ON', 'CA'
            UNION ALL
                SELECT N'Québec', 'CA-QC', 'CA'
            UNION ALL
                SELECT 'Nova Scotia', 'CA-NS', 'CA'
            UNION ALL
                SELECT 'New Brunswick', 'CA-NB', 'CA'
            UNION ALL
                SELECT 'Manitoba', 'CA-MB', 'CA'
            UNION ALL
                SELECT 'British Columbia', 'CA-BC', 'CA'
            UNION ALL
                SELECT 'Prince Edward Island', 'CA-PE', 'CA'
            UNION ALL
                SELECT 'Saskatchewan', 'CA-SK', 'CA'
            UNION ALL
                SELECT 'Alberta', 'CA-AB', 'CA'
            UNION ALL
                SELECT 'Newfoundland and Labrador', 'CA-NL', 'CA'
            UNION ALL
                SELECT 'Northwest Territories', 'CA-NT', 'CA'
            UNION ALL
                SELECT 'Yukon', 'CA-YT', 'CA'
            UNION ALL
                SELECT 'Nunavut', 'CA-NU', 'CA'

            -- Mexico (32 states incl. CDMX)
            UNION ALL
                SELECT 'Aguascalientes', 'MX-AGU', 'MX'
            UNION ALL
                SELECT 'Baja California', 'MX-BCN', 'MX'
            UNION ALL
                SELECT 'Baja California Sur', 'MX-BCS', 'MX'
            UNION ALL
                SELECT 'Campeche', 'MX-CAM', 'MX'
            UNION ALL
                SELECT 'Chiapas', 'MX-CHP', 'MX'
            UNION ALL
                SELECT 'Chihuahua', 'MX-CHH', 'MX'
            UNION ALL
                SELECT 'Coahuila de Zaragoza', 'MX-COA', 'MX'
            UNION ALL
                SELECT 'Colima', 'MX-COL', 'MX'
            UNION ALL
                SELECT 'Durango', 'MX-DUR', 'MX'
            UNION ALL
                SELECT 'Guanajuato', 'MX-GUA', 'MX'
            UNION ALL
                SELECT 'Guerrero', 'MX-GRO', 'MX'
            UNION ALL
                SELECT 'Hidalgo', 'MX-HID', 'MX'
            UNION ALL
                SELECT 'Jalisco', 'MX-JAL', 'MX'
            UNION ALL
                SELECT N'México State', 'MX-MEX', 'MX'
            UNION ALL
                SELECT N'Michoacán de Ocampo', 'MX-MIC', 'MX'
            UNION ALL
                SELECT 'Morelos', 'MX-MOR', 'MX'
            UNION ALL
                SELECT 'Nayarit', 'MX-NAY', 'MX'
            UNION ALL
                SELECT N'Nuevo León', 'MX-NLE', 'MX'
            UNION ALL
                SELECT 'Oaxaca', 'MX-OAX', 'MX'
            UNION ALL
                SELECT 'Puebla', 'MX-PUE', 'MX'
            UNION ALL
                SELECT N'Querétaro', 'MX-QUE', 'MX'
            UNION ALL
                SELECT 'Quintana Roo', 'MX-ROO', 'MX'
            UNION ALL
                SELECT N'San Luis Potosí', 'MX-SLP', 'MX'
            UNION ALL
                SELECT 'Sinaloa', 'MX-SIN', 'MX'
            UNION ALL
                SELECT 'Sonora', 'MX-SON', 'MX'
            UNION ALL
                SELECT 'Tabasco', 'MX-TAB', 'MX'
            UNION ALL
                SELECT 'Tamaulipas', 'MX-TAM', 'MX'
            UNION ALL
                SELECT 'Tlaxcala', 'MX-TLA', 'MX'
            UNION ALL
                SELECT 'Veracruz de Ignacio de la Llave', 'MX-VER', 'MX'
            UNION ALL
                SELECT N'Yucatán', 'MX-YUC', 'MX'
            UNION ALL
                SELECT 'Zacatecas', 'MX-ZAC', 'MX'
            UNION ALL
                SELECT N'Ciudad de México', 'MX-CMX', 'MX'
        )
    INSERT INTO dbo.StateProvince
        (StateProvinceName, ISO3616_2, CountryID)
    SELECT
        r.StateProvinceName,
        r.ISO2,
        dbo.UDF_GetCountryIdByCode(r.CountryAlpha2)
    FROM Regions AS r
    WHERE NOT EXISTS (
        SELECT 1
    FROM dbo.StateProvince AS sp
    WHERE sp.ISO3616_2 = r.ISO2
    );

    WITH
        Cities(StateProvinceISO2, CityName)
        AS
        (
            -- USA
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                SELECT 'US-CA', 'Los Angeles'
            UNION ALL
                SELECT 'US-CA', 'San Diego'
            UNION ALL
                SELECT 'US-CA', 'San Francisco'
            UNION ALL
                SELECT 'US-CA', 'Sacramento'
            UNION ALL
                SELECT 'US-TX', 'Houston'
            UNION ALL
                SELECT 'US-TX', 'Dallas'
            UNION ALL
                SELECT 'US-TX', 'Austin'
            UNION ALL
                SELECT 'US-TX', 'San Antonio'
            UNION ALL
                SELECT 'US-FL', 'Miami'
            UNION ALL
                SELECT 'US-FL', 'Orlando'
            UNION ALL
                SELECT 'US-FL', 'Tampa'
            UNION ALL
                SELECT 'US-NY', 'New York'
            UNION ALL
                SELECT 'US-NY', 'Buffalo'
            UNION ALL
                SELECT 'US-NY', 'Rochester'
            UNION ALL
                SELECT 'US-IL', 'Chicago'
            UNION ALL
                SELECT 'US-IL', 'Springfield'
            UNION ALL
                SELECT 'US-PA', 'Philadelphia'
            UNION ALL
                SELECT 'US-PA', 'Pittsburgh'
            UNION ALL
                SELECT 'US-AZ', 'Phoenix'
            UNION ALL
                SELECT 'US-AZ', 'Tucson'
            UNION ALL
                SELECT 'US-CO', 'Denver'
            UNION ALL
                SELECT 'US-CO', 'Colorado Springs'
            UNION ALL
                SELECT 'US-MA', 'Boston'
            UNION ALL
                SELECT 'US-MA', 'Worcester'
            UNION ALL
                SELECT 'US-WA', 'Seattle'
            UNION ALL
                SELECT 'US-WA', 'Spokane'
            UNION ALL
                SELECT 'US-GA', 'Atlanta'
            UNION ALL
                SELECT 'US-GA', 'Savannah'
            UNION ALL
                SELECT 'US-NV', 'Las Vegas'
            UNION ALL
                SELECT 'US-NV', 'Reno'
            UNION ALL
                SELECT 'US-MI', 'Detroit'
            UNION ALL
                SELECT 'US-MI', 'Grand Rapids'
            UNION ALL
                SELECT 'US-MN', 'Minneapolis'
            UNION ALL
                SELECT 'US-MN', 'Saint Paul'
            UNION ALL
                SELECT 'US-OH', 'Columbus'
            UNION ALL
                SELECT 'US-OH', 'Cleveland'
            UNION ALL
                SELECT 'US-OR', 'Portland'
            UNION ALL
                SELECT 'US-OR', 'Salem'
            UNION ALL
                SELECT 'US-TN', 'Nashville'
            UNION ALL
                SELECT 'US-TN', 'Memphis'
            UNION ALL
                SELECT 'US-VA', 'Richmond'
            UNION ALL
                SELECT 'US-VA', 'Virginia Beach'
            UNION ALL
                SELECT 'US-MD', 'Baltimore'
            UNION ALL
                SELECT 'US-MD', 'Frederick'
            UNION ALL
                SELECT 'US-DC', 'Washington'
            UNION ALL
                SELECT 'US-UT', 'Salt Lake City'
            UNION ALL
                SELECT 'US-UT', 'Provo'
            UNION ALL
                SELECT 'US-LA', 'New Orleans'
            UNION ALL
                SELECT 'US-LA', 'Baton Rouge'
            UNION ALL
                SELECT 'US-KY', 'Louisville'
            UNION ALL
                SELECT 'US-KY', 'Lexington'
            UNION ALL
                SELECT 'US-IA', 'Des Moines'
            UNION ALL
                SELECT 'US-IA', 'Cedar Rapids'
            UNION ALL
                SELECT 'US-OK', 'Oklahoma City'
            UNION ALL
                SELECT 'US-OK', 'Tulsa'
            UNION ALL
                SELECT 'US-NE', 'Omaha'
            UNION ALL
                SELECT 'US-NE', 'Lincoln'
            UNION ALL
                SELECT 'US-MO', 'Kansas City'
            UNION ALL
                SELECT 'US-MO', 'St. Louis'
            UNION ALL
                SELECT 'US-NC', 'Charlotte'
            UNION ALL
                SELECT 'US-NC', 'Raleigh'
            UNION ALL
                SELECT 'US-SC', 'Columbia'
            UNION ALL
                SELECT 'US-SC', 'Charleston'
            UNION ALL
                SELECT 'US-WI', 'Milwaukee'
            UNION ALL
                SELECT 'US-WI', 'Madison'
            UNION ALL
                SELECT 'US-MN', 'Duluth'
            UNION ALL
                SELECT 'US-AK', 'Anchorage'
            UNION ALL
                SELECT 'US-HI', 'Honolulu'
            -- Canada
            UNION ALL
                SELECT 'CA-ON', 'Toronto'
            UNION ALL
                SELECT 'CA-ON', 'Ottawa'
            UNION ALL
                SELECT 'CA-QC', N'Montréal'
            UNION ALL
                SELECT 'CA-QC', N'Québec City'
            UNION ALL
                SELECT 'CA-BC', 'Vancouver'
            UNION ALL
                SELECT 'CA-BC', 'Victoria'
            UNION ALL
                SELECT 'CA-AB', 'Calgary'
            UNION ALL
                SELECT 'CA-AB', 'Edmonton'
            UNION ALL
                SELECT 'CA-MB', 'Winnipeg'
            UNION ALL
                SELECT 'CA-NS', 'Halifax'
            UNION ALL
                SELECT 'CA-SK', 'Saskatoon'
            UNION ALL
                SELECT 'CA-SK', 'Regina'
            UNION ALL
                SELECT 'CA-NB', 'Moncton'
            UNION ALL
                SELECT 'CA-NB', 'Saint John'
            UNION ALL
                SELECT 'CA-PE', 'Charlottetown'
            UNION ALL
                SELECT 'CA-NL', N'St. John''s'
            UNION ALL
                SELECT 'CA-ON', 'Hamilton'
            UNION ALL
                SELECT 'CA-ON', 'London'
            UNION ALL
                SELECT 'CA-QC', 'Gatineau'
            UNION ALL
                SELECT 'CA-QC', 'Laval'
            UNION ALL
                SELECT 'CA-BC', 'Kelowna'
            UNION ALL
                SELECT 'CA-AB', 'Red Deer'
            UNION ALL
                SELECT 'CA-MB', 'Brandon'
            -- MEXICO
            UNION ALL
                SELECT 'MX-CMX', N'Ciudad de México'
            UNION ALL
                SELECT 'MX-JAL', 'Guadalajara'
            UNION ALL
                SELECT 'MX-NLE', 'Monterrey'
            UNION ALL
                SELECT 'MX-PUE', 'Puebla'
            UNION ALL
                SELECT 'MX-ROO', N'Cancún'
            UNION ALL
                SELECT 'MX-GUA', 'Guanajuato'
            UNION ALL
                SELECT 'MX-MIC', 'Morelia'
            UNION ALL
                SELECT 'MX-BCN', 'Tijuana'
            UNION ALL
                SELECT 'MX-JAL', 'Zapopan'
            UNION ALL
                SELECT 'MX-NLE', N'San Nicolás'
            UNION ALL
                SELECT 'MX-CAM', 'Campeche'
            UNION ALL
                SELECT 'MX-TAB', 'Villahermosa'
            UNION ALL
                SELECT 'MX-VER', 'Veracruz'
            UNION ALL
                SELECT 'MX-OAX', 'Oaxaca'
            UNION ALL
                SELECT 'MX-SLP', N'San Luis Potosí'
            UNION ALL
                SELECT 'MX-CHH', 'Chihuahua'
            UNION ALL
                SELECT 'MX-AGU', 'Aguascalientes'
            UNION ALL
                SELECT 'MX-MEX', 'Toluca'
            UNION ALL
                SELECT 'MX-COA', 'Saltillo'
            UNION ALL
                SELECT 'MX-BCS', 'La Paz'
            UNION ALL
                SELECT 'MX-NAY', 'Tepic'
            UNION ALL
                SELECT 'MX-ZAC', 'Zacatecas'
        )
    INSERT INTO dbo.City
        (StateProvinceID, CityName)
    SELECT
        dbo.UDF_GetStateProvinceIdByCode(c.StateProvinceISO2),
        c.CityName
    FROM Cities AS c
    WHERE NOT EXISTS (
        SELECT 1
    FROM dbo.City AS ci
    WHERE ci.CityName = c.CityName
        AND ci.StateProvinceID = dbo.UDF_GetStateProvinceIdByCode(c.StateProvinceISO2)
    );


    COMMIT TRANSACTION;
END;
GO
