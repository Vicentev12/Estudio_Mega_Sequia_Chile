clear all; clc; close all
addpath(genpath('D:\Escritorio\GEOFÍSICA\m_map'))
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
%%
% VERANO (DICIEMBRE-ENERO-FEBRERO) 1980-2019
c = 1;
for i = 1:12:479
    ver(:,:,c) = sum(p_mm(:,:,[12 13 14] + i - 1),3);
    c = c + 1;
end
% OTOÑO (MARZO-ABRIL-MAYO) 1980-2019
c = 1;
for i = 1:12:479
    oto(:,:,c) = sum(p_mm(:,:,[15 16 17] + i - 1),3);
    c = c + 1;
end
% INVIERNO (JUNIO-JULIO-AGOSTO) 1980-2019
c = 1;
for i = 1:12:479
    inv(:,:,c) = sum(p_mm(:,:,[18 19 20] + i - 1),3);
    c = c + 1;
end
% PRIMAVERA(SEPTIEMBRE-OCTUBRE-NOVIEMBRE) 1980-2019
c = 1;
for i = 1:12:479
    pri(:,:,c) = sum(p_mm(:,:,[21 22 23] + i - 1),3);
    c = c + 1;
end 
anual = (ver + inv + oto + pri);
%%
c=0;
for i=1:40
    a(:,1)=reshape(squeeze(ver(:,:,i)),41*52,1);
    a(:,2)=reshape(squeeze(oto(:,:,i)),41*52,1);
    a(:,3)=reshape(squeeze(inv(:,:,i)),41*52,1);
    a(:,4)=reshape(squeeze(pri(:,:,i)),41*52,1);
    tt=reshape(squeeze(anual(:,:,i)),41*52,1);
    for j=1:4
        c=c+1;
        P(:,c)=a(:,j)./tt*100;% contribuciones de estacion al año
    end
end
b(:,1)=mean(P(:,1:4:end)')';
b(:,2)=mean(P(:,2:4:end)')';
b(:,3)=mean(P(:,3:4:end)')';
b(:,4)=mean(P(:,4:4:end)')';
c=0;
%% matriz F
for i=1:40
    for j=1:4
        c=c+1;
        F(:,c)=P(:,c)-b(:,j);
    end
end
[L,E,A,error]=EOF(F');

invierno=reshape(F(:,3:4:end),52,41,40);  


for x = 1:52
    for y = 1:41
        corr_invierno(x,y) = corr(A(3:4:end,1)/std(A(3:4:end,1)),squeeze(invierno(x,y,:)));
    end
end



figure()
m_proj('mercator','lon',[min(lon_p(:)) max(lon_p(:))],'lat',[min(lat_p(:)) max(lat_p(:))])
m_pcolor(Lat_p,Lon_p,corr_invierno*-1), shading interp
cc=colorbar(gca,'Location','EastOutside');
colormap(gca, jet)
cc.Label.String = 'Correlación';
caxis([0 1])
hold on
m_grid('Box','Fancy','LineStyle','none','FontSize',14);
m_gshhs_i('Color','w');
m_contour(Lat_p,Lon_p,corr_invierno*-1,'-k','ShowText','on','LineWidth',1)
hold off
xlabel('Longitud','FontSize',14)
ylabel('Latitud','FontSize',14)
title('Correlación Contribución y Componente Principal (74.6%) en Invierno (1980-2019)','FontSize',12)



figure()
subplot(2,1,1)
plot(F(1000,:),'b','LineWidth',2)
xlabel('Estaciones (1980-2010)','FontSize',14)
ylabel('Anomalías','FontSize',14)
title('Campo de Anomalías Estacionales (1980-2019)','FontSize',14)
grid minor
subplot(2,1,2)
plot(1980:2019,P(1000,1:4:160),'r','LineWidth',1.5)
hold on
plot(1980:2019,P(1000,2:4:160),'k','LineWidth',1.5)
plot(1980:2019,P(1000,3:4:160),'b','LineWidth',1.5)
plot(1980:2019,P(1000,4:4:160),'g','LineWidth',1.5)
legend('Verano','Otoño','Invierno','Primavera')
xlabel('Años','FontSize',14)
ylabel('Porcentaje [%]','FontSize',14)
title('Porcentaje de contribución de estaciones por año (1980-2019)','FontSize',14)
grid minor


figure()
plot(1980:2019,(A(3:4:end,1)./std(A(3:4:end,1)))*-1,'k','LineWidth',1.5)
hold on
line([1980 2019],[0 0],'Color','r','LineWidth',2)
line([2010 2010],[-3 2],'Color','g','LineWidth',1.5,'LineStyle','--')
title('Componente principal normalizada en Invierno (1980-2019) (74.6%)','FontSize',16)
xlabel('Años','FontSize',14)
grid minor



