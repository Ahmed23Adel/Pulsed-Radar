clear all;close all;clc
%Task 1 Plot the transmitted pulse
fs= 60e6;%sampling frequency
ts=1/fs;%time sampling
t=-8e-7:ts:1.3e-5;% domain of time
amp=1e6;%calculatd from power
pulseWidth=3e-7;
transForumla=@(t) [((t>=0)&(t<3e-7)).*(amp) + ((t>=5e-6)&(t<5.3e-6)).*(amp)+ ((t>=1e-5)&(t<1.03e-5)).*(amp)];
transmittedSignal=transForumla(t);
figure('NumberTitle','Off','Name','Task 1');
plot(t,transmittedSignal);xlabel('Time(s)'); ylabel('Amplitude(V)');
title('baseband (Transmitted pulse)');
grid on;


%Task 3
figure('NumberTitle','Off','Name','Task 3');
%transmitted signal
subplot(2,1,1)
plot(t,transmittedSignal);xlabel('Time(s)'); ylabel('Amplitude(V)');title('baseband (Transmitted pulse)');
grid on
%recieved signal
subplot(2,1,2)
receievedSignal = awgn(transmittedSignal,20,'measured');
plot(t,receievedSignal);xlabel('Time(s)'); ylabel('Amplitude(V)');title('Received signal');
grid on

c=3e8;%speed of light
deltaT=4.20522e-7;%from graphs
RT3=3e8*deltaT/2;%R in task 3
disp("Task 3: The total time taken by pulse is"+deltaT+" sec, And the distance is: "+RT3);

%Task 4
figure('NumberTitle','Off','Name','Task 4');
tOnePulse=-8e-7:ts:5e-6;%time vector that will hold only one signal
%transmitted signal
xOnePulseFormula=@(t) [((t>=0)&(t<3e-7)).*(amp)];
xOnePulseTransmitted=xOnePulseFormula(tOnePulse);
subplot(3,1,1);
plot(tOnePulse,xOnePulseTransmitted);xlabel('Time(s)'); ylabel('Amplitude(V)');title('Transmitted pulse');
grid on
%Recieved signal
xOnePulseReceieved=awgn(xOnePulseFormula(tOnePulse-deltaT),5,'measured');
subplot(3,1,2);
plot(tOnePulse,xOnePulseReceieved);xlabel('Time(s)'); ylabel('Amplitude(V)');title('Received pulse');
grid on
%Correlation
[cor,lag]= xcorr(xOnePulseReceieved,xOnePulseTransmitted);
subplot(3,1,3);
plot(lag*ts, cor);xlabel('Time(s)'); ylabel('Amplitude(V)');title('Correlation');
grid on
%Calculations:
[valMax, inxMax]=max(cor);
deltaTT4 = lag(inxMax)*ts;
RT4=c*deltaT/2;%R in task 3
disp("Task 4: The total time taken by pulse is"+deltaTT4+" sec, And the distance is: "+RT4);


%Task 5
figure('NumberTitle','Off','Name','Task 5');
tMul=-8e-7:ts:2.5e-5;%time vector that will hold five pulses in task 5
xMulPulseFormula=@(t) [((t>=0)&(t<3e-7)).*(1.5e6) + ((t>=5e-6)&(t<5.3e-6)).*(1.5e6)  + ((t>=1e-5)&(t<1.03e-5)).*(1.5e6) + ((t>=1.5e-5)&(t<1.53e-5)).*(1.5e6)+ ((t>=2e-5)&(t<2.03e-5)).*(1.5e6) ];
xMulTransmitted=xMulPulseFormula(tMul);
xMulReceived=awgn(xMulPulseFormula(tMul-deltaT),5,'measured');
subplot(4,1,1);
plot(tMul,xMulTransmitted);xlabel('Time(s)'); ylabel('Amplitude(V)');title('Transmitted pulse');
grid on
%received
subplot(4,1,2);
plot(tMul,xMulReceived);xlabel('Time(s)'); ylabel('Amplitude(V)');title('Received pulse');
grid on
%correlation
[cor5,lag5]= xcorr(xMulReceived,xMulTransmitted);
subplot(4,1,3);
plot(lag5*ts, cor5);xlabel('Time(s)'); ylabel('Amplitude(V)');title('Correlation');
grid on
%average
repetitionFrequancy=0.2e6;
forinterval = fs/repetitionFrequancy;
interval1 = cor5(1 :forinterval+1);
interval2 = cor5(forinterval+1   :2*forinterval+1);
interval3 = cor5(2*forinterval+1 :3*forinterval+1);
interval4 = cor5(3*forinterval+1 :4*forinterval+1);
interval5 = cor5(4*forinterval+1 :5*forinterval+1);
interval6 = cor5(5*forinterval+1   :6*forinterval+1);
interval7 = cor5(6*forinterval+1 :7*forinterval+1);
interval8 = cor5(7*forinterval+1 :8*forinterval+1);
interval9 = cor5(8*forinterval+1 :9*forinterval+1);

time = 0: 1/fs : 1/repetitionFrequancy;
average = (interval1 +interval2 +interval3 +interval4 +interval5+interval6 +interval7 +interval8 +interval9 )./5;
subplot(4 ,1 ,4 );
plot(time,average);
grid on

[valueMax,indexMax]=max(cor5);
timeVector=lag5*ts;
diffTime=timeVector(indexMax);
RT5=c*diffTime/2;
disp("Task 5: The total time taken by pulse is"+diffTime+" sec, And the distance is: "+RT5);


%bonus
figure('NumberTitle','Off','Name','Bonus Task');
subplot(2,1,1);
grid on

L1=animatedline('Color','b');

subplot(2,1,2);

L2=animatedline('Color','b');

for k=1:length(t)

    addpoints(L1,t(k),transmittedSignal(k));
    drawnow

    addpoints(L2,t(k),receievedSignal(k))
    drawnow

end
