// This file is part of hdf5_handler a HDF5 file handler for the OPeNDAP
// data server.

// Author: Hyo-Kyung Lee <hyoklee@hdfgroup.org> and Muqun Yang
// <myang6@hdfgroup.org> 

// Copyright (c) 2009 The HDF Group, Inc. and OPeNDAP, Inc.
//
// This is free software; you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free
// Software Foundation; either version 2.1 of the License, or (at your
// option) any later version.
//
// This software is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
// or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
// License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//
// You can contact OPeNDAP, Inc. at PO Box 112, Saunderstown, RI. 02874-0112.
// You can contact The HDF Group, Inc. at 1901 South First Street,
// Suite C-2, Champaign, IL 61820  

#ifndef _HE5ShortName_H
#define _HE5ShortName_H

#include "config_hdf5.h"

#include <map>
#include <sstream>
#include <string>
#include <vector>
#include <debug.h>

using namespace std;

/// A class for keeping track of short names.
///
/// This class contains functions that generate a shortened variable names
/// to help visualization clients like GrADS. The "sdfopen" command in
/// GrADS expects that all variables are less than 15 characters long.
/// Otherwise, you need to use "xdfopen" command in GrADS which requires
/// additional definition file that maps long name to short one.
/// 
///
/// @author Hyo-Kyung Lee <hyoklee@hdfgroup.org>
///
/// Copyright (c) 2009 The HDF Group
///
/// All rights reserved.
class HE5ShortName {
  
public:
    /// This variable is incremented to generate unique id that will be
    // appended to "A" character.
    int index;
    /// Remembers the long name to short name mapping.
    map < string, string > long_to_short;
    
    /// Remembers the short name to long name mapping.
    map < string, string > short_to_long;	
  
    HE5ShortName();

    /// Drops the group path name from \a a_name and returns the dataset name
    /// only by searching for the last instance of '/' character.
    /// 
    /// \param a_name  HDF-EOS5 dataset name
    /// \see HE5CF.cc
    /// \see H5EOS.cc
    /// \return substring 
    string cut_long_name(string a_name);

    /// Generates a unique name from \a a_name
    ///
    /// This function generates  a new name that starts with "A" and a unique
    /// id number that starts from 0. It cuts the \a a_name to make the final
    /// string shorter than 15 characters long.
    /// 
    /// \param a_name  HDF-EOS5 dataset name
    /// \see HE5CF.cc
    /// \see H5EOS.cc
    /// \return a new, 15-character long string.
    string generate_short_name(string a_name);

    /// Retrieves a long name from \a a_short_name
    ///
    /// \param a_short_name generated by CF option
    ///
    /// \return a string that is the original full-path dataset name.
    string get_long_name(string a_short_name);

    /// Retrieves a short name from \a a_long_name
    ///
    /// \param a_long_name a full-path dataset name.
    ///
    /// \return a shortened string generated by CF option
    string get_short_name(string a_long_name);

    ///  Clears all internal map variables and makes index 0.
    void reset();
};

#endif
