FROM ubuntu

LABEL Jordan Urias

WORKDIR /root

RUN  apt-get -y update && \
     apt-get install -yq curl unzip git

RUN pip install csvkit pandas matplotlib

RUN  curl -L -O https://datosabiertos.salud.gob.mx/gobmx/salud/datos_abiertos/historicos/2022/01/datos_abiertos_covid19_01.01.2022.zip &&\
     unzip datos_abiertos_covid19_01.01.2022.zip &&\
     csvcut -c SEXO,TIPO_PACIENTE,ENTIDAD_RES,MUNICIPIO_RES,DIABETES,HIPERTENSION,CARDIOVASCULAR,OBESIDAD,RENAL_CRONICA,CLASIFICACION_FINAL 220101COVID19MEXICO.csv | \
     csvgrep -c ENTIDAD_RES -m "26" | csvcut -c SEXO,TIPO_PACIENTE,MUNICIPIO_RES,DIABETES,HIPERTENSION,CARDIOVASCULAR,OBESIDAD,RENAL_CRONICA,CLASIFICACION_FINAL | \
     csvgrep -c CLASIFICACION_FINAL -r "[37]"  > casos_y_salud_municipios_sonora.csv &&\
     mv casos_y_salud_municipios_sonora.csv /tunnel/ &&\
     rm datos_abiertos_covid19_01.01.2022.zip &&\
     rm 220101COVID19MEXICO.csv

CMD ["bash"]
