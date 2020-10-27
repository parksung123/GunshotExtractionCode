코드 실행 방법:

1. Auto, Single, 또는 Single 2 폴더에 있는 read_wave.m 파일을 열음.
2. MATLAB에 "현재 폴더"를 1번에 선택한 해당 폴더로 바꿈.
3. "명령 창"으로 다음과 같이 실행:

read_wave(PA, PLOT):
PA : 텍스트 파일을 다운받을 디렉토리 
PLOT == 1 : 출력된 데이터 플롯 
PLOT == 0 : 플롯 안함 

read_wave(PA, PLOT, ALG):
PLOT == 1 : 출력된 데이터 플롯 
PLOT == 0 : 플롯 안함 

ALG == 'xf' : xFinal 값 사용
ex) read_wave(PA, PLOT, 'xf', 3000, 30000)

ALG == 'cc' : cross-correlation 사용
ex) read_wave(PA, PLOT, 'cc')

ALG == 'check' : 사용자가 직접 추출 
1. read_wave(PA, PLOT, 'check', PEAK)

ex) read_wave(PA, PLOT, 'check', [1 2 3 4 5])
5개의 총성을 직접 추출

ex) read_wave(PA, PLOT, 'check', 1)
1번째 총성을 직접 추출

ex) read_wave(PA, PLOT, 'check', [1 3])
1번째와 3번째의 총성을 직접 추출

ex) read_wave(PA, PLOT, 'check', [1 5])
1번째와 5번째의 총성을 직접 추출