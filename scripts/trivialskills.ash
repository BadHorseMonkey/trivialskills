void main(int num_casts)
{
  int mana_total;
  int skill_count = 0 ;
  boolean reset_outfit;

  string [int] trivial_skills = {
    "Seal Clubbing Frenzy",
    "Patience of the Tortoise",
    "Manicotti Meditation",
    "Sauce Contemplation",
    "Disco Aerobics",
    "Moxie of the Mariachi"
    };
    foreach trivial_skill in trivial_skills {
       skill_count = skill_count + to_int(have_skill($skill[trivial_skill]))
    }
  if (skill_count < 1) {
    print ("No trivial skills available.");
    }
    else
    {
    mana_total = skill_count * num_casts;
    # Only do it if we have enough MP
    if(my_mp() < mana_total) {
      print("Current MP is " + my_mp() + ", which is too low to cast each trivial skill " + num_casts + " times. Aborting!");
    }
    else {
      # find and equip an April Shower Thoughts shield if you have one
      cli_execute("checkpoint");
      if ((equipped_item($slot[off-hand]) != $item[April Shower Thoughts shield]) && (item_amount($item[April Shower Thoughts shield]) > 0) && can_equip($item[April Shower Thoughts shield])) {
      # Save the current outfit
      equip($item[none], $slot[weapon]);
      equip($item[April Shower Thoughts shield]);
      }
      try {
        // so we can be sure to restore our stuff at the end...
        print("Cast each available trivial skill " + num_casts + " times, spending " + mana_total + " MP in the process.");
        foreach trivial_skill in trivial_skills {
        try {
          use_skill(num_casts, $skill[trivial_skill]);
          }
      }
    };
    # cleanup
    cli_execute("outfit checkpoint");
    cli_execute("checkpoint clear");

    }
  }
}
