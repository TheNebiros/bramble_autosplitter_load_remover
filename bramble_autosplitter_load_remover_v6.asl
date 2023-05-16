state("Bramble_TMK-Win64-Shipping")
{
    byte Chapter : 0x4F1AC60, 0x180, 0x228, 0x38;
    string128 Map : 0x4F1AC60, 0x4A8, 0x2E;
    bool Loading : 0x4DCFE04;
}

startup
{
    vars.MAINMENU_MAP = "MainMenu/LV_MainMenu_DarkForest";
    vars.CHAPTER1_MAP = "LV01_Childroom/LV1_Childroom";

    settings.Add("chapters", true, "Split when completing a chapter:");
        settings.Add("ch01->02", true, "Children's Room -> Nearby Forest", "chapters");
        settings.Add("ch02->03", true, "Nearby Forest -> Gnome Forest", "chapters");
        settings.Add("ch03->04", true, "Gnome Forest -> Summit Pt.1", "chapters");
        settings.Add("ch04->05", true, "Summit Pt.1 -> Troll Forest", "chapters");
        settings.Add("ch05->06", true, "Troll Forest -> Naecken's Pond", "chapters");
        settings.Add("ch06->07", true, "Naecken's Pond -> Tuva Pt.1", "chapters");
        settings.Add("ch07->08", false, "Tuva Pt.1 -> Summit Pt.2", "chapters");
        settings.Add("ch08->09", true, "Summit Pt.2 -> Tuva Pt.2", "chapters");
        settings.Add("ch09->10", true, "Tuva Pt.2 -> The Swamp", "chapters");
        settings.Add("ch10->12", true, "The Swamp -> The Library", "chapters");
        settings.Add("ch12->11", true, "The Library -> Skogra's Grove", "chapters");
        settings.Add("ch11->13", true, "Skogra's Grove -> Plague Village", "chapters");
        settings.Add("ch13->18", true, "Plague Village -> Pesta's Nightmare", "chapters");
        settings.Add("ch18->14", true, "Pesta's Nightmare -> The Summit Pt. 3", "chapters");
        settings.Add("ch14->15", true, "The Summit Pt. 3 -> Halls of the Mountain King", "chapters");
        settings.Add("ch15->16", true, "Halls of the Mountain King -> End", "chapters");
    // ...

    vars.CompletedChapters = new HashSet<string>();
}

onStart
{
    vars.CompletedChapters.Clear();

    vars.RunFinished = false;
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

split
{
    string id = string.Format("ch{0:00}->{1:00}", old.Chapter, current.Chapter);
    if (settings[id] && vars.CompletedChapters.Add(id))
        return true;

    if(vars.CompletedChapters.Contains("ch15->16"))
        vars.RunFinished = true;
}

reset
{
    return old.Map != current.Map && current.Map == vars.MAINMENU_MAP && vars.RunFinished == false;
}

isLoading
{
    return current.Loading;
}
