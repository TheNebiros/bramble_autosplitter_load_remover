state("Bramble_TMK-Win64-Shipping")
{
    byte Chapter : 0x4F1AC60, 0x180, 0x228, 0x38;
    string128 Map : 0x4F1AC60, 0x4A8, 0x2E;
    //bool IsPlaying : "Bramble_TMK-Win64-Shipping.exe", 0x4F1AC60, 0x118, 0x328, 0x28C;
    bool Credits : "Bramble_TMK-Win64-Shipping.exe", 0x4D42280, 0x10, 0xD0, 0x118, 0x3B8, 0x178, 0x70, 0x234;
    bool Loading : "Bramble_TMK-Win64-Shipping.exe", 0x4DCFE04;
}

startup
{
    vars.MAINMENU_MAP = "MainMenu/LV_MainMenu_DarkForest";
    vars.CHAPTER1_MAP = "LV01_Childroom/LV1_Childroom";
    vars.CHAPTER2_MAP = "LV02_NearbyForest/LV2_NearbyForest";
    vars.CHAPTER3_MAP = "LV03_BrambleForest/LV2_BrambleForest";
    vars.CHAPTER4_MAP = "LV_Dream/LV_Dream1";
    vars.CHAPTER5_MAP = "LV04_TrollForest/LV4_TrollForest";
    vars.CHAPTER6_MAP = "LV05_NeckensPond/LV5_NaeckensPond";
    //vars.CHAPTER7_MAP = "LV06_Tuva/LV6_Tuva";
    vars.CHAPTER8_MAP = "LV_Dream/LV_Dream2";
    vars.CHAPTER9_MAP = "LV06_Tuva/LV6_Tuva";
    vars.CHAPTER10_MAP = "LV07_Swamp/LV7_Swamp";
    vars.CHAPTER11_MAP = "LV08_Library/LV_Library";
    vars.CHAPTER12_MAP = "LV09_SkogsrasLabyrinth/LV9_SkogsrasLabyrinth";
    vars.CHAPTER13_MAP = "LV10_Pesta/LV10_Pesta_2";
    vars.CHAPTER14_MAP = "LV10_Pesta/LV_PestaBoss";
    vars.CHAPTER15_MAP = "LV_Dream/LV_Dream3";
    vars.CHAPTER16_MAP = "LV12_Halls/LV12_Halls";
    vars.CHAPTER17_MAP = "LV01_Childroom/LV13_Epilogue";

    settings.Add("chapters", true, "Split when completing a chapter:");
        //settings.Add("ch0", true, "Main menu -> Children's Room", "chapters");
        settings.Add("ch1", true, "Children's Room -> Nearby Forest", "chapters");
        settings.Add("ch2", true, "Nearby Forest -> Gnome Forest", "chapters");
        settings.Add("ch3", true, "Gnome Forest -> Summit Pt.1", "chapters");
        settings.Add("ch4", true, "Summit Pt.1 -> Troll Forest", "chapters");
        settings.Add("ch5", true, "Troll Forest -> Naecken's Pond", "chapters");
        settings.Add("ch6", true, "Naecken's Pond -> Tuva Pt.1", "chapters");
        settings.Add("ch7", false, "Tuva Pt.1 -> Summit Pt.2", "chapters");
        settings.Add("ch8", true, "Summit Pt.2 -> Tuva Pt.2", "chapters");
        settings.Add("ch9", true, "Tuva Pt.2 -> The Swamp", "chapters");
        settings.Add("ch10", true, "The Swamp -> The Library", "chapters");
        settings.Add("ch12", true, "The Library -> Skogra's Grove", "chapters");
        settings.Add("ch11", true, "Skogra's Grove -> Plague Village", "chapters");
        settings.Add("ch13", true, "Plague Village -> Pesta's Nightmare", "chapters");
        settings.Add("ch18", true, "Pesta's Nightmare -> The Summit Pt. 3", "chapters");
        settings.Add("ch14", true, "The Summit Pt. 3 -> Halls of the Mountain King", "chapters");
        settings.Add("ch15", true, "Halls of the Mountain King -> Epilogue", "chapters");
        settings.Add("credits", true, "Credits", "chapters");
    // ...

    vars.CompletedChapters = new HashSet<int>();

    vars.Correspondences = new Dictionary<int, int>();
    vars.Correspondences.Add(0, 1);
    vars.Correspondences.Add(1, 2);
    vars.Correspondences.Add(2, 3);
    vars.Correspondences.Add(3, 4);
    vars.Correspondences.Add(4, 5);
    vars.Correspondences.Add(5, 6);
    vars.Correspondences.Add(6, 7);
    vars.Correspondences.Add(7, 8);
    vars.Correspondences.Add(8, 9);
    vars.Correspondences.Add(9, 10);
    vars.Correspondences.Add(10, 12);
    vars.Correspondences.Add(12, 11);
    vars.Correspondences.Add(11, 13);
    vars.Correspondences.Add(13, 18);
    vars.Correspondences.Add(18, 14);
    vars.Correspondences.Add(14, 15);
    vars.Correspondences.Add(15, 16);
    vars.Correspondences.Add(16, 0);
}

onStart
{
    vars.CompletedChapters.Clear();
}

update
{
    if (string.IsNullOrEmpty(current.Map))
    current.Map = old.Map;
}

start
{
    return old.Map != current.Map && current.Map == vars.CHAPTER1_MAP;
}

reset
{
    //return old.Map != current.Map && current.Map == vars.MAINMENU_MAP;
}

split
{
    if(settings["credits"] && old.Credits != current.Credits && current.Credits == true) return true;
    
    return settings["ch" + old.Chapter] && vars.Correspondences[old.Chapter] == current.Chapter && !vars.CompletedChapters.Contains(old.Chapter) && vars.CompletedChapters.Add(old.Chapter);
}

isLoading
{
    return current.Loading;
}