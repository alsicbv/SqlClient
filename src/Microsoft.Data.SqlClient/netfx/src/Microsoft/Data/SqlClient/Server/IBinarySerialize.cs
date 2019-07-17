﻿//------------------------------------------------------------------------------
//  <copyright file="IBinarySerialize.cs" company="Microsoft Corporation">
//     Copyright (c) Microsoft Corporation. All Rights Reserved.
//     Information Contained Herein is Proprietary and Confidential.
//  </copyright>
// <owner current="true" primary="true">alazela</owner>
// <owner current="true" primary="true">blained</owner>
// <owner current="true" primary="true">daltudov</owner>
// <owner current="true" primary="true">stevesta</owner>
// <owner current="true" primary="false">beysims</owner>
// <owner current="true" primary="false">laled</owner>
// <owner current="true" primary="false">vadimt</owner>
//------------------------------------------------------------------------------

using System.IO;

namespace Microsoft.Data.SqlClient.Server
{

    // This interface is used by types that want full control over the
    // binary serialization format.
    public interface IBinarySerialize
    {
        // Read from the specified binary reader.
        void Read(BinaryReader r);
        // Write to the specified binary writer.
        void Write(BinaryWriter w);
    }
}