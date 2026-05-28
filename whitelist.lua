local function date(d, m, y)
    return os.time({day=d, month=m, year=y, hour=0, min=0, sec=0})
end

return {
    -- [[ OWNER / ADMIN ]]
    [5673689347] = math.huge, 
    [9690660225] = math.huge,
    [8274108424] = math.huge,
    [7376659191] = math.huge,
    [8277608643] = math.huge,
    [8270789374] = math.huge,

    -- [[ VIP PERMANENT ]]
    [9593359594] = math.huge, 
    [10365005803] = math.huge,
    [9352630223] = math.huge,
    [8278252628] = math.huge,
    [4045325529] = math.huge,
    [8698142467] = math.huge,
    [10494185985] = math.huge,
    [10832254242] = math.huge,
    [3189967384] = math.huge,
    [1375771009] = math.huge,

    -- [[ VIP 1 BULAN ]]
    -- Format: [ID] = date(Tanggal, Bulan, Tahun)
    [9056010980] = date(1, 6, 2026), 
    [9268364063] = date(1, 6, 2026), 
    [8153683757] = date(1, 6, 2026), 
    [8230713737] = date(1, 6, 2026), 
    [10646320247] = date(1, 6, 2026), 
    [341506349] = date(1, 6, 2026), 
    [7899843409] = date(1, 6, 2026), 
    [10414427205] = date(1, 6, 2026),
    [10512592607] = date(1, 6, 2026),
    [10486072042] = date(20, 6, 2060),
    [723167901] = date(25, 5, 2026),
    [3082022237] = date(24, 6, 2026),
    [2217350594] = date(25, 6, 2026),
    [10353949623] = date(25, 6, 2060),
    [10799347116] = date(25, 6, 2060),
    [9439769375] = date(25, 6, 2060),
    [7773544013] = date(25, 6, 2050),
    [10742494247] = date(28, 6, 2050),
}
