FUNCTION_BLOCK FB_Ramp

(*
	Ramp FB smoothly limits changes between current and target.
	Rampa FB mevcut ile hedef arasındaki değişimi yumuşatır.
*)

VAR_INPUT
	i_Target	: REAL;		// Target Value – Hedef Değer
	i_RampUp	: REAL;		// Increase Ramp – Artış Rampası
	i_RampDown	: REAL;		// Decrease Ramp – Azalış Rampası
END_VAR

VAR_OUTPUT
	q_Value		: REAL;		// Ramp Output – Rampa Çıktısı
END_VAR

VAR
	l_Diff      : REAL;		// Difference – Fark
	l_Step      : REAL;		// Step to Apply – Uygulanacak Adım
END_VAR



// Directional Ramp Calculation – Yönlü Rampa Hesaplaması
IF q_Value < i_Target THEN
	
	l_Diff := i_Target - q_Value;
	
    // Limits the RampUp Value - RampUp Değerini Sınırlar
	IF l_Diff > i_RampUp THEN
		l_Step := i_RampUp;
	ELSE
		l_Step := l_Diff;
	END_IF
	
    // Converges the Target Value - İstenen Değere Yaklaşır
	q_Value := q_Value + l_Step;
	
ELSIF q_Value > i_Target THEN
	
	l_Diff := q_Value - i_Target;
	

    // Limits the RampDown Value - RampDown Değerini Sınırlar
	IF l_Diff > i_RampDown THEN
		l_Step := i_RampDown;
	ELSE
		l_Step := l_Diff;
	END_IF

	// Converges the Target Value - İstenen Değere Yaklaşır
	q_Value := q_Value - l_Step;
	
ELSE
	// Reached the Target Value - İstene Değere Ulaşıldı
	q_Value := i_Target;
	
END_IF
