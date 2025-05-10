FUNCTION FN_ADC : BOOL

(*
	This function converts an analog input value to a digital (BOOL) output based on a threshold level.
	IF the input exceeds the defined threshold, the output is TRUE; otherwise, it is FALSE.
	Additionally, variable "ActiveSide" allows reversing the output logic.
	
	Bu fonksiyon, analog giriş değerini belirlenen eşik seviyesine göre dijital (BOOL) çıktıya çevirir.
	Eğer giriş değeri belirlenen sınırı aşarsa TRUE, aşmazsa FALSE olarak döner.
	Ayrıca "ActiveSide" değişkeni, çıkışı tersine çevirmek için kullanılır.
*)

VAR_INPUT
    AnalogInput			: WORD;				// Analog Input Value - Analog Giriş Değeri
    ActiveSide			: BOOL;				// Reverse Output Logic Control - Çıkışı Tersine Çevirme Kontrolü
	Threshold			: WORD;				// Digital Threshold Value - Dijital Eşik Değeri
END_VAR

VAR  
END_VAR



// If Analog Input Exceeds the Threshold TRUE otherwise FALSE - Analog Giriş Eşik Değerini Geçiyorsa TRUE, Geçmiyorsa FALSE

IF (AnalogInput > Threshold) THEN
    FN_ADC := TRUE;
ELSE
    FN_ADC := FALSE;
END_IF

// Adjust Output Based On ActiveSide Condition - ActiveSide Durumuna Göre Çıkışı Ayarla
IF (ActiveSide = FALSE) THEN
	FN_ADC := NOT FN_ADC;
END_IF