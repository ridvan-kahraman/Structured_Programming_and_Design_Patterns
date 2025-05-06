FUNCTION_BLOCK FB_Debounce

// This function block filters unstable digital input transitions using a debounce logic.
// If the input changes, a timer is activated, and the output updates only if the input remains stable for the debounce period.

// Bu fonksiyon bloğu, kararsız dijital giriş geçişlerini bir debounce mantığı ile filtreler.
// Giriş değiştiğinde bir zamanlayıcı başlatılır ve giriş belirlenen süre boyunca kararlı kalırsa çıkış güncellenir.

VAR_INPUT
    InputToDebounce		: BOOL;	  					// Input Before Debounce - Filtreleme Öncesi Giriş
    DebounceTime		: INT;						// Debounce Time In Milliseconds - Filtreleme Süresi (Milisaniye)
    FB_Enable			: BOOL;						// Function Block Enable - Fonksiyon Bloğu Etkinleştirme
END_VAR

VAR_OUTPUT
    DebouncedInput		: BOOL;						// Input After Debounce - Filtreleme Sonrası Giriş
END_VAR

VAR
    DebounceTimer		: TON;	  					// Timer for Debouncing - Filtreleme için Zamanlayıcı
    LastState			: BOOL;						// Last Stable State - Son Kararlı Durum
    InputChanged		: BOOL;						// Flag for Change in Input - Giriş Değişim Bayrağı
END_VAR



// Last Stable State - Son Kararlı Durum
LastState := InputToDebounce;

// Start Debouncing If Enable is Active - Enable Girişi Aktifse Filtreleme İşlemine Başla

IF (FB_Enable) THEN
	
	// Check If Input Changed - Giriş Değişti Mi Kontrol Et
    InputChanged := (InputToDebounce <> LastState);
	
	// Timer Initialization	- Zamanlayıcının Başlatılması
    DebounceTimer(IN := InputChanged, PT := INT_TO_TIME(DebounceTime));

    // Update the Output If Input is Stable - Giriş Kararlıysa Çıkışı Güncelle
    IF DebounceTimer.Q THEN
        DebouncedInput := InputToDebounce;
        LastState := InputToDebounce;
		
	// Do Not Update the Output If Input is Unstable - Giriş Kararsızsa Çıkışı Güncelleme
    ELSE
        DebouncedInput := LastState;
    END_IF
	
// Do Nothing If Enable is Inactive - Enable Girişi Aktif Değilse Hiçbir Şey Yapma
ELSE
    // No Operation - Hiçbir İşlem Yapma
END_IF