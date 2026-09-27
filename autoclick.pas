{$reference 'System.Windows.Forms.dll'}
program autoclick;
uses System.Windows.Forms,crt;

const
  MOUSEEVENTF_LEFTDOWN = $0002;
  MOUSEEVENTF_LEFTUP   = $0004;
  MOUSEEVENTF_RIGHTDOWN = $0008;
  MOUSEEVENTF_RIGHTUP   = $0010;

var mouseorkeyboard, numberletter, numbermouse, buttonmouse, numberwait: integer; letter, united: string; incycle: boolean;
 

procedure mouse_event(dwFlags, dx, dy, dwData, dwExtraInfo: integer); 
  external 'user32.dll' name 'mouse_event';


begin
  writeln('autoclicker, ver. 0.1');
  if (incycle = false) then repeat 
    incycle := true;
  writeln('Mouse or keyboard? If mouse - 0, keyboard - 1');
  try readln(mouseorkeyboard);
  except on System.FormatException do begin 
    writeln('Recieved incorrect input. The program will be now restarted.');
    continue;
    end;
    end; 
    
  if mouseorkeyboard = 1 then begin
    writeln('What key/combination of keys? To send the Enter key write a backslash, to send the ESC key write a ]. NOT SUPPORTED KEYS: Non-number and non-letter keys except for Enter and ESC (for example: "Alt" is not supported');
    readln(letter); //TODO add space key support
    writeln('How many times do you need keys to be pressed?');
    try readln(numberletter);
    except on System.FormatException do begin 
    writeln('Recieved incorrect input. The program will be now restarted.');
    continue;
    end;
    end;
    writeln('How long do you need the delay between pressing keys to be?');
    try readln(numberwait)
    except on System.FormatException do begin 
    writeln('Recieved incorrect input. The program will be now restarted.');
    continue;
    end;
    end;
    writeln('You have 5 seconds to alt+tab to the window you need the keys sent into');
    sleep(5000);
    
    
    loop numberletter do begin //sending
      for i: integer := 1 to letter.Length do begin
        if letter[i] = '\' then begin 
        united := ('{' + 'ENTER ' + '1' + '}');
        sleep(numberwait);
        sendkeys.Sendwait(united);  
        end
        else if letter[i] = ']' then begin 
        united := ('{' + 'ESCAPE ' + '1' + '}');
        sleep(numberwait);
        sendkeys.Sendwait(united); 
        end
        else
        begin
        united := ('{' + letter[i] + ' ' + '1' + '}');
        sleep(numberwait);
        sendkeys.Sendwait(united);
        application.doevents();
        end;
        end
        end;
  end
  
  
  else if mouseorkeyboard = 0 then begin
    writeln('RMB or LMB? If 0 - RMB, 1 - LMB ');
    try begin readln(buttonmouse); 
    if (buttonmouse <> 0) and (buttonmouse <> 1) then begin
    writeln('Recieved incorrect input. The program will be now restarted.');
    continue;  
    end;
    end
    except on System.FormatException do begin 
    writeln('Recieved incorrect input. The program will be now restarted.');
    continue;
    end;
    end;
      writeln('How many times do you need the mouse button to be pressed?');
      try readln(numbermouse)
      except on System.FormatException do begin 
    writeln('Recieved incorrect input. The program will be now restarted.');
    continue;
    end;
    end;
      writeln('Delay time in ms? If not needed - 0');
      try readln(numberwait);
      except on System.FormatException do begin 
    writeln('Recieved incorrect input. The program will be now restarted.');
    continue;
    end;
    end;
      writeln('You have 5 seconds to alt+tab to the window you need the keys sent into');
      sleep(5000);
      
      
    loop numbermouse do begin //sending
     if (buttonmouse = 0) then begin
     mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
     mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
     end
     else if (buttonmouse = 1) then begin
     mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
     mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
     end;
     sleep(numberwait);
     end;
     incycle := false;
  end
  else begin
   writeln('Recieved incorrect input. The program will be now restarted.');
   continue;
  end;
  until 1<0;
end. 