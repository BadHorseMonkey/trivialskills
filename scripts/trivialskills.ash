void main(string number_of_casts)
{
  int mana_total;
  int skill_count = 0 ;
  int num_casts;
  boolean reset_outfit;
  string use_error;


  skill [int] trivial_skills = {
    $skill[Seal Clubbing Frenzy],
    $skill[Patience of the Tortoise],
    $skill[Manicotti Meditation],
    $skill[Sauce Contemplation],
    $skill[Disco Aerobics],
    $skill[Moxie of the Mariachi]
    };

  if ( ! is_integer(number_of_casts)) {
    print("Executes all six of the class primitive skills, putting on the April Shower Thoughts Shield if available.  Enter the number of times to cast as the parameter of the script");
    print("Usage: trivialskills 10 (where 10 is the number of times for each skill)");
  else
  {
  foreach key in trivial_skills {
    skill_count = skill_count + to_int(have_skill(trivial_skills[key])) + 1;
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

        print("Cast each available trivial skill " + num_casts + " times, spending " + mana_total + " MP in the process.");
        int mp_use = 0;
        foreach key in trivial_skills {
         use_error = catch use_skill(num_casts, trivial_skills[key]);
         //print("error: " + use_error);
         if (length(use_error) == 0 )
            mp_use = mp_use + num_casts;
      }
      print("Actual MP use was " + mp_use);

    # cleanup
    cli_execute("outfit checkpoint");
    cli_execute("checkpoint clear");

    }
  }
}
}

