require 'uri'
require 'open-uri'
 
SERVER = "http://sent.ly/command/sendsms?"
USERNAME = "imranshaikh818@gmail.com"
PASSWORD = "program123"

class Sending_sms  

  def smsparams (to, text) 
    
    unless is_number_valid?(to)
      server_url = SERVER \
        + 'username=' + USERNAME \
        + '&password=' + PASSWORD \
        + '&to=' + to \
        + '&text=' + text
      
      server_url = URI.escape (server_url)
      open (server_url) {|result| 
        result.each_line {|line| 
          if line.match(/^Id:/)
            line.each_line(':') {|substr|
              if substr.match('Id')
                puts "Sms sent successfully"
              else  
                # Return ID alone.
                return Integer(substr)
              end
            }
          else
          # Error
            line.each_line(':') {|substr|
              if substr.match('Error')
                # Do nothing
              else
                case substr
                when "0"
                  puts "Authentication error"
                  return 0
                when "1"
                  puts "Malformed error"
                  return -1
                when "2"
                  puts "Reserved error"
                  return -2
                when "3"
                  puts  "No appropriate device error"
                when "4"
                  puts "Not enough credit error"
                else
                  puts "Unknown error"
                end
              end
            }
          end
        }
      }
    else
      puts "Oop! Number is invalid" 
    end


  end
  

  def is_number_valid?(number)
    number.length <= 4 && number[/^.\d+$/]
  end

  
end
