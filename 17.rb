# Problem 17
# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

class Fixnum
  def to_english
    number = self
    negative = number < 0 
    number = number.abs
    
    return 'zero' if number == 0
    
    num_str = ''  
    ones = ['one',  'two',  'three', 'four', 'five', 'six',  'seven', 'eight',  'nine']
    tens = ['ten',  'twenty', 'thirty', 'forty',  'fifty', 'sixty','seventy','eighty','ninety']
    teens = ['eleven',  'twelve',    'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']
    
    exp_tens = [['b'],['tr'],['quadr'],['quint'],['sext'],
               ['sept'],['oct'],['non'],['dec'],['undec'],
               ['duodec'],['tredec'],['quattuordec'],['quindec'],
               ['sexdec'],['septendec'],
               ['octodec'],['novemdec'],['vigint']]
    
    exp = 9
    
    exp_tens.each do |exp_ten|
      exp_ten[0] = exp_ten[0] + 'illion';
      exp_ten.push(exp)
      exp = exp + 3
    end

    exp_tens = [ ['hundred', 2], ['thousand', 3], ['million', 6] ] + exp_tens
    exp_tens = exp_tens + [ ['googol', 100], ['centillion', 600] ]
    exp_tens.sort! { |x, y| x[1]<=>y[1] } 
    left  = number

    exp_tens.reverse.each do |exp_ten|
      value = 10**exp_ten[1]
      write = left/value
      left  = left - write*value

      if write > 0
        exps = write.to_english
        num_str = num_str + exps + ' ' + exp_ten[0]

        if left > 0
          if left < 100
            num_str = num_str + ' and '
          elsif
            num_str = num_str + ', '
          end
        end
      end

    end
    
    write = left/10          
    left  = left - write*10  
    
    if write > 0
      if ((write == 1) and (left > 0))
        num_str = num_str + teens[left-1]
        left = 0
      else
        num_str = num_str + tens[write-1]
      end
      
      if left > 0
        num_str = num_str + '-'
      end
    end
    
    write = left  
    left  = 0     

    if write > 0
      num_str = num_str + ones[write-1]
    end
    neg_string = negative ? '-' : ''
    neg_string + num_str
  end

end

puts (1..1000).map { |e| e.to_english }.join().scan(/[a-z]/i).count