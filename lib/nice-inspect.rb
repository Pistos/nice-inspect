class Object
  def outer_indentation( indentation_level )
    "  " * indentation_level
  end
  def inner_indentation( indentation_level )
    "  " * ( indentation_level + 1 )
  end

  def nice_inspect( join_string = ",\n", indentation = 0, visited = Hash.new )
    return "#<#{self.class}>" if visited[ self ]
    visited[ self ] = true
    ivars = instance_variables
    if ivars.empty?
      inspect
    else
      var_str = ivars.map { |var|
        val = instance_variable_get( var )
        "#{inner_indentation(indentation)}#{var} = " + val.nice_inspect( join_string, indentation + 1, visited ).strip
      }.join( join_string )
      "#<#{self.class}\n" + var_str + "\n>"
    end
  end
end

class Array
  def nice_inspect( join_string = ",\n", indentation = 0, visited = Hash.new )
    return "#<#{self.class}>" if visited[ self ]
    visited[ self ] = true
    "[\n" +
      collect { |e|
        "    " * indentation + e.nice_inspect( join_string, indentation + 1, visited ).strip
      }.join( join_string ) +
      "\n" +
      outer_indentation(indentation) +
    "]"
  end
end

class Hash
  def nice_inspect( join_string = ",\n", indentation = 0, visited = Hash.new )
    return "#<#{self.class}>" if visited[ self ]
    visited[ self ] = true
    "{\n" +
      keys.sort_by { |k|
        k.respond_to?( :<=> ) ? k : k.to_s
      }.collect { |k|
        v = self[ k ]
        inner_indentation(indentation) +
        k.inspect + " => " + v.nice_inspect( join_string, indentation + 1, visited ).strip
      }.join( join_string ) +
      "\n" +
      outer_indentation(indentation) +
    "}"
  end
end

class Date
  def nice_inspect( join_string = ",\n", indentation = 0 )
    "'#{to_s}'"
  end
end

class BigDecimal
  def nice_inspect( x1 = nil, x2 = nil )
    "%.2f" % [ self ]
  end
end

