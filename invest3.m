clear all; clc; close all
addpath(genpath('D:\Escritorio\GEOFÍSICA\m_map'))
addpath 'D:\Escritorio\GEOFÍSICA\Geof_4to_año\Ondas en Fluidos Geofísicos\Trabajo01\cmocean'
%% DATOS GRILLADOS DE TMPERATURA MÁXIMA Y PRECIPITACIÓN MENSUAL 1979-2019
%% Preipitación
lat_p  = double(ncread('CR2MET_pr_v2.0_mon_1979_2019_005deg.nc','lat'));
lon_p  = double(ncread('CR2MET_pr_v2.0_mon_1979_2019_005deg.nc','lon'));
time_p = double(ncread('CR2MET_pr_v2.0_mon_1979_2019_005deg.nc','time'));
p_mm = double(ncread('CR2MET_pr_v2.0_mon_1979_2019_005deg.nc','pr',[100 460 1],[length(100:151) length(460:500) inf],[1 1 1]));
[~,idx_lat1] = min(abs(lat_p + 34)); % Posicion para 0N
[~,idx_lat2] = min(abs(lat_p + 32)); % Posicion para 30S
[~,idx_lon1] = min(abs(lon_p + 72)); % Posicion para 180E
[~,idx_lon2] = min(abs(lon_p + 69.5)); % Posicion para 280W
lat_p=lat_p(idx_lat1:idx_lat2); lon_p=lon_p(idx_lon1:idx_lon2);
[Lon_p,Lat_p]=meshgrid(double(lat_p),double(lon_p));
% VERANO (DICIEMBRE-ENERO-FEBRERO) 1980-2019
c = 1;
for i = 1:12:479
    p_ver(:,:,c) = sum(p_mm(:,:,[12 13 14] + i - 1),3);
    c = c + 1;
end
% OTOÑO (MARZO-ABRIL-MAYO) 1980-2019
c = 1;
for i = 1:12:479
    p_oto(:,:,c) = sum(p_mm(:,:,[15 16 17] + i - 1),3);
    c = c + 1;
end
% INVIERNO (JUNIO-JULIO-AGOSTO) 1980-2019
c = 1;
for i = 1:12:479
    p_inv(:,:,c) = sum(p_mm(:,:,[18 19 20] + i - 1),3);
    c = c + 1;
end
% PRIMAVERA(SEPTIEMBRE-OCTUBRE-NOVIEMBRE) 1980-2019
c = 1;
for i = 1:12:479
    p_pri(:,:,c) = sum(p_mm(:,:,[21 22 23] + i - 1),3);
    c = c + 1;
end 
anual_mm=(p_ver + p_inv + p_oto + p_pri);
%%
% VERANO (DICIEMBRE-ENERO-FEBRERO) 1980-2019
c = 1;
for i = 1:12:479
    prom_ver(:,:,c) = mean(p_mm(:,:,[12 13 14] + i - 1),3);
    c = c + 1;
end
% OTOÑO (MARZO-ABRIL-MAYO) 1980-2019
c = 1;
for i = 1:12:479
    prom_oto(:,:,c) = sum(p_mm(:,:,[15 16 17] + i - 1),3);
    c = c + 1;
end
% INVIERNO (JUNIO-JULIO-AGOSTO) 1980-2019
c = 1;
for i = 1:12:479
    prom_inv(:,:,c) = sum(p_mm(:,:,[18 19 20] + i - 1),3);
    c = c + 1;
end
% PRIMAVERA(SEPTIEMBRE-OCTUBRE-NOVIEMBRE) 1980-2019
c = 1;
for i = 1:12:479
    prom_pri(:,:,c) = sum(p_mm(:,:,[21 22 23] + i - 1),3);
    c = c + 1;
end 
%% ANALIZAMOS ENTRE LOS AÑOS 1980-2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% precipitación acumulada anual y por estación
%anual
prom_mma=mean(anual_mm(:,:,1:29),3);
%
figure()
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,prom_mma), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = '[mm]';
caxis([0 1500])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
title('Precipitación acumulada promedio (1980-2009)','FontSize',14)
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)

% por estación
m_ver_a=mean(p_ver(:,:,1:29),3);m_inv_a=mean(p_inv(:,:,1:29),3);
m_oto_a=mean(p_oto(:,:,1:29),3);m_pri_a=mean(p_pri(:,:,1:29),3);
%
figure()
subplot(2,2,1)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,m_ver_a), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = '[mm]';
caxis([0 850])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Precipitación acumulada promedio en Verano (1980-2009)','FontSize',12)
subplot(2,2,2)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,m_oto_a), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = '[mm]';
caxis([0 850])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Precipitación acumulada promedio en Otoño (1980-2009)','FontSize',12)
subplot(2,2,3)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,m_inv_a), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = '[mm]';
caxis([0 850])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Precipitación acumulada promedio en Invierno (1980-2009)','FontSize',12)
subplot(2,2,4)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,m_pri_a), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = '[mm]';
caxis([0 850])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Precipitación acumulada promedio en Primavera (1980-2009)','FontSize',12)

%% PROMEDIO CLIMATOLÓGICO 1980-2009 
VERa=mean(prom_ver(:,:,1:29),3); INVa=mean(prom_inv(:,:,1:29),3);
OTOa=mean(prom_oto(:,:,1:29),3); PRIa=mean(prom_pri(:,:,1:29),3);
TOTa=(VERa + INVa + OTOa + PRIa);
%% calculamos y ploteamos la contribución entre 1980-2009
ver_ac=(VERa./TOTa)*100; inv_ac=(INVa./TOTa)*100;
oto_ac=(OTOa./TOTa)*100; pri_ac=(PRIa./TOTa)*100;
%
figure()
subplot(2,2,1)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,ver_ac), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('thermal'))
cc.Label.String = '[%]';
caxis([0 80])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Contribución de Verano al promedio (1980-2009)','FontSize',14)
subplot(2,2,2)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,oto_ac), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('thermal'))
cc.Label.String = '[%]';
caxis([0 80])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Contribución de Otoño al promedio (1980-2009)','FontSize',14)
subplot(2,2,3)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,inv_ac), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('thermal'))
cc.Label.String = '[%]';
caxis([0 80])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Contribución de Invierno al promedio (1980-2009)','FontSize',14)
subplot(2,2,4)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,pri_ac), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('thermal'))
cc.Label.String = '[%]';
caxis([0 80])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Contribución de Primavera al promedio (1980-2009)','FontSize',14)

%% ANALIZAMOS ENTRE LOS AÑOS 2010 - 2019
%% precipitación acumulada anual y por estación
%anual
prom_mms=mean(anual_mm(:,:,30:end),3);
%
figure()
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,prom_mms), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = '[mm]';
caxis([0 1500])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Precipitación acumulada promedio (2010-2019)','FontSize',12)
% por estación
m_ver_s=mean(p_ver(:,:,30:end),3);m_inv_s=mean(p_inv(:,:,30:end),3);
m_oto_s=mean(p_oto(:,:,30:end),3);m_pri_s=mean(p_pri(:,:,30:end),3);
%
figure()
subplot(2,2,1)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,m_ver_s), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = '[mm]';
caxis([0 850])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Precipitación acumulada promedio en Verano (2010-2019)','FontSize',12)
subplot(2,2,2)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,m_oto_s), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = '[mm]';
caxis([0 850])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Precipitación acumulada promedio en Otoño (2010-2019)','FontSize',12)
subplot(2,2,3)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,m_inv_s), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = '[mm]';
caxis([0 850])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Precipitación acumulada promedio en Invierno (2010-2019)','FontSize',12)
subplot(2,2,4)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,m_pri_s), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = '[mm]';
caxis([0 850])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Precipitación acumulada promedio en Primavera (2010-2019)','FontSize',12)
%% PROMEDIO CLIMATOLÓGICO 2010-2019
VERs=mean(prom_ver(:,:,30:end),3); INVs=mean(prom_inv(:,:,30:end),3);
OTOs=mean(prom_oto(:,:,30:end),3); PRIs=mean(prom_pri(:,:,30:end),3);
TOTs=(VERs + INVs + OTOs + PRIs);
%% calculamos y ploteamos la contribución entre 1980-2009
ver_sc=(VERs./TOTs)*100; inv_sc=(INVs./TOTs)*100;
oto_sc=(OTOs./TOTs)*100; pri_sc=(PRIs./TOTs)*100;
%
figure()
subplot(2,2,1)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,ver_sc), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('thermal'))
cc.Label.String = '[%]';
caxis([0 80])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Contribución de Verano al promedio (2010-2019)','FontSize',14)
subplot(2,2,2)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,oto_sc), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('thermal'))
cc.Label.String = '[%]';
caxis([0 80])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Contribución de Otoño al promedio (2010-2019)','FontSize',14)
subplot(2,2,3)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,inv_sc), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('thermal'))
cc.Label.String = '[%]';
caxis([0 80])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Contribución de Invierno al promedio (2010-2019)','FontSize',14)
subplot(2,2,4)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,pri_sc), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('thermal'))
cc.Label.String = '[%]';
caxis([0 80])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Contribución de Primavera al promedio (2010-2019)','FontSize',14)




%% VEAMOS LAS DIFERENCIAS RESTANDO EL CAMPO DE (2010-2019) A (1980-2009)
d_ver=(ver_sc-ver_ac); di_ver=(ver_sc-ver_ac); % hacemos 2 para poder comparar después
d_oto=(oto_sc-oto_ac); di_oto=(oto_sc-oto_ac);
d_inv=(inv_sc-inv_ac); di_inv=(inv_sc-inv_ac);
d_pri=(pri_sc-pri_ac); di_pri=(pri_sc-pri_ac);
figure()
subplot(2,2,1)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,ver_sc-ver_ac), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('balance'))
cc.Label.String = '[%]';
caxis([-30 30])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Diferencias de contribución en Verano (2010-2019) - (1980-2009)','FontSize',14)
subplot(2,2,2)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,oto_sc-oto_ac), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('balance'))
cc.Label.String = '[%]';
caxis([-30 30])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Diferencias de contribución en Otoño (2010-2019) - (1980-2009)','FontSize',14)
subplot(2,2,3)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,inv_sc-inv_ac), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('balance'))
cc.Label.String = '[%]';
caxis([-30 30])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Diferencias de contribución en Invierno (2010-2019) - (1980-2009)  ','FontSize',14)
subplot(2,2,4)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,pri_sc-pri_ac), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('balance'))
cc.Label.String = '[%]';
caxis([-30 30])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Diferencias de contribución en Primavera (2010-2019) - (1980-2009)','FontSize',14)


%% Test de Monte Carlo para ver la significancia de esta diferencia
%antes ese mean(fechas(1:29))
%depues esmean(fechas(30:40));
% calculaste los promedios, las contribuciones)
% difO=contriMS-contriAntes;
fechas=1:40;
 for m=1:2000
            fechasM=remuestreo(fechas);
            %antes
            antes_ver = mean(prom_ver(:,:,fechasM(1:29)),3);
            antes_oto = mean(prom_oto(:,:,fechasM(1:29)),3);
            antes_inv = mean(prom_inv(:,:,fechasM(1:29)),3);
            antes_pri = mean(prom_pri(:,:,fechasM(1:29)),3);
            antes_anual = (antes_ver+antes_oto+antes_inv+antes_pri);
            % contribuciones antes
            antes_ver_c = (antes_ver./antes_anual)*100;
            antes_oto_c = (antes_oto./antes_anual)*100;
            antes_inv_c = (antes_inv./antes_anual)*100;
            antes_pri_c = (antes_pri./antes_anual)*100;
            %después
            deps_ver = mean(prom_ver(:,:,fechasM(30:40)),3);
            deps_oto = mean(prom_oto(:,:,fechasM(30:40)),3);
            deps_inv = mean(prom_inv(:,:,fechasM(30:40)),3);
            deps_pri = mean(prom_pri(:,:,fechasM(30:40)),3);
            deps_anual = (deps_ver+deps_oto+deps_inv+deps_pri);
            %contribuciones después
            deps_ver_c = (deps_ver./deps_anual)*100;
            deps_oto_c = (deps_oto./deps_anual)*100;
            deps_inv_c = (deps_inv./deps_anual)*100;
            deps_pri_c = (deps_pri./deps_anual)*100;
            % diferencia entre contribuciones 
             dif_ver(:,:,m) = deps_ver_c-antes_ver_c;
             dif_oto(:,:,m) = deps_oto_c-antes_oto_c;
             dif_inv(:,:,m) = deps_inv_c-antes_inv_c;     
             dif_pri(:,:,m) = deps_pri_c-antes_pri_c;     
 end

 
% Calculamos los intervalos de confianza bajo un 95%
for x = 1:52
    for y = 1:41
        % verano
        ic_sup_ver(x,y) = prctile(squeeze(dif_ver(x,y,:)),97.5);
        ic_inf_ver(x,y) = prctile(squeeze(dif_ver(x,y,:)),2.5);
        %otoño
        ic_sup_oto(x,y) = prctile(squeeze(dif_oto(x,y,:)),97.5);
        ic_inf_oto(x,y) = prctile(squeeze(dif_oto(x,y,:)),2.5);
        %invierno
        ic_sup_inv(x,y) = prctile(squeeze(dif_inv(x,y,:)),97.5);
        ic_inf_inv(x,y) = prctile(squeeze(dif_inv(x,y,:)),2.5);
        %primavera
        ic_sup_pri(x,y) = prctile(squeeze(dif_pri(x,y,:)),97.5);
        ic_inf_pri(x,y) = prctile(squeeze(dif_pri(x,y,:)),2.5);
    end
end
% Definimos si es significativo o no utilizando un IF
% verano
for x = 1:52
    for y = 1:41
        
        if ic_inf_ver(x,y) < d_ver(x,y) && d_ver(x,y) < ic_sup_ver(x,y)
            d_ver(x,y) = NaN;
        else
        end
    end
end
% otoño
for x = 1:52
    for y = 1:41
        
        if ic_inf_oto(x,y) < d_oto(x,y) && d_oto(x,y) < ic_sup_oto(x,y)
            d_oto(x,y) = NaN;
        else
        end
    end
end
% invierno
for x = 1:52
    for y = 1:41
        
        if ic_inf_inv(x,y) < d_inv(x,y) && d_inv(x,y) < ic_sup_inv(x,y)
            d_inv(x,y) = NaN;
        else
        end
    end
end
% primavera
for x = 1:52
    for y = 1:41
        
        if ic_inf_pri(x,y) < d_pri(x,y) && d_pri(x,y) < ic_sup_pri(x,y)
            d_pri(x,y) = NaN;
        else
        end
    end
end
% Visualizamos el nuevo mapa 
figure()
subplot(2,2,1)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,di_ver), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('curl'))
cc.Label.String = '[%]';
caxis([-30 30])
hold on
m_contour(Lat_p,Lon_p,d_ver,':k','LineWidth',3)% sombreado de zona significativa
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Diferencias y Significancia en Verano' ,'FontSize',14)
subplot(2,2,2)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,di_oto), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('curl'))
cc.Label.String = '[%]';
caxis([-30 30])
hold on
m_contour(Lat_p,Lon_p,d_oto,':k','LineWidth',3)
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Diferencia y Significancia en Otoño','FontSize',14)
subplot(2,2,3)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,di_inv), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('curl'))
cc.Label.String = '[%]';
caxis([-30 30])
hold on
m_contour(Lat_p,Lon_p,d_inv,':k','LineWidth',3)
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Diferencia y Significancia en Invierno','FontSize',14)
subplot(2,2,4)
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,di_pri), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, cmocean('curl'))
cc.Label.String = '[%]';
caxis([-30 30])
hold on
m_contour(Lat_p,Lon_p,d_pri,':k','LineWidth',3)
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Diferencia y Significancia en Primavera','FontSize',14)
