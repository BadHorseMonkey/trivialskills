void main(int num_casts)
{
	int mana_total;
    boolean reset_outfit;
    mana_total = num_casts * 6;
    # Only do it if we have enough MP
    if(my_mp() >= mana_total) {
        # find and equip an April Shower Thoughts shield if you have one
        if ((equipped_item($slot[off-hand]) != $item[April Shower Thoughts shield]) && (item_amount($item[April Shower Thoughts shield]) > 0) && can_equip($item[April Shower Thoughts shield])) {
            # Save the current outfit
            cli_execute("outfit save Backup");
            equip($item[none], $slot[weapon]);
            equip($item[April Shower Thoughts shield]);
            reset_outfit = true;
        }
        else {
            reset_outfit = false;
        }
        use_skill(num_casts, $skill[Seal Clubbing Frenzy]);
        use_skill(num_casts, $skill[Patience of the Tortoise]);
        use_skill(num_casts, $skill[Manicotti Meditation]);
        use_skill(num_casts, $skill[Sauce Contemplation]);
        use_skill(num_casts, $skill[Disco Aerobics]);
        use_skill(num_casts, $skill[Moxie of the Mariachi]);
        print("Cast each trivial skill " + num_casts + " times, spending " + mana_total + " MP in the process.");
        if (reset_outfit) {
            cli_execute("outfit Backup");
        }
    }
    else {
        print("Current MP is " + my_mp() + ", which is too low to cast each trivial skill " + num_casts + " times. Aborting!");
    }
}
