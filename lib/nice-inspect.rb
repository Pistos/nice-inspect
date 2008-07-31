class Object
  def outer_indentation( indentation_level )
    "  " * indentation_level
  end
  def inner_indentation( indentation_level )
    "  " * ( indentation_level + 1 )
  end
  
  def nice_inspect( join_string = ",\n", indentation = 0 )
    if instance_variables.empty?
      inspect
    else
      
      var_str = instance_variables.map { |var|
        val = instance_variable_get( var )
        "#{inner_indentation(indentation)}#{var}=" + (
          val.respond_to?( :nice_inspect ) ?
          val.nice_inspect( join_string, indentation + 1 ) :
          val.inspect
        )
      }.join( join_string )
      outer_indentation(indentation) + "#<#{self.class}\n" + var_str + "\n>"
    end
  end
end

class BigDecimal
    def nice_inspect( x1 = nil, x2 = nil )
        "%.2f" % [ self ]
    end
end

class Array
    def nice_inspect( join_string = ",\n", indentation = 0 )
        outer_indentation(indentation) +
        "[\n" +
            collect { |e|
                "    " * indentation +
                (
                    e.respond_to?( :nice_inspect ) ?
                    e.nice_inspect( join_string, indentation + 1 ) :
                    e.inspect
                )
            }.join( join_string ) +
        "\n" +
        outer_indentation(indentation) +
        "]"
    end
end

class Date
    def nice_inspect( join_string = ",\n", indentation = 0 )
        "'#{to_s}'"
    end
end

class Hash
    def nice_inspect( join_string = ",\n", indentation = 0 )
        outer_indentation(indentation) +
        "{\n" +
            keys.sort_by { |k|
                k.respond_to?( :<=> ) ? k : k.to_s
            }.collect { |k|
                v = self[ k ]
                inner_indentation(indentation) +
                k.inspect + " => " + (
                    v.respond_to?( :nice_inspect ) ?
                    v.nice_inspect( join_string, indentation + 1 ) :
                    v.inspect
                )
            }.join( join_string ) +
        "\n" +
        outer_indentation(indentation) +
        "}"
    end
end

class String
    def nice_inspect( *args )
      inspect
    end
end
