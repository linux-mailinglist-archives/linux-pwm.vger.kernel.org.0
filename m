Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A7F4AB94
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2019 22:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfFRUW6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jun 2019 16:22:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:12814 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730571AbfFRUW5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 18 Jun 2019 16:22:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 13:22:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,390,1557212400"; 
   d="asl'?hex'?scan'208";a="357972294"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2019 13:22:55 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Jun 2019 13:22:55 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.92]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.246]) with mapi id 14.03.0439.000;
 Tue, 18 Jun 2019 13:22:55 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Nikolaus Voss <nv@vosn.de>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
Thread-Topic: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
Thread-Index: AQHVIPn/qqDB5Bv4z0aSsleXlAnDw6abVhaAgAADpwD///G0sIAEkokAgACES6CAAT+dAIAANdnAgAALWnA=
Date:   Tue, 18 Jun 2019 20:22:54 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB066@ORSMSX110.amr.corp.intel.com>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
 <alpine.DEB.2.20.1906141114490.6579@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B95EFB26@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906170746150.12344@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B95F9EC6@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906181030240.24846@fox.voss.local> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWYzNDM4MzQtOGVmNS00ZTRiLWJkZTktZDExNTM1YTg5ZDk3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoialA3Y1d2Z3ZkMnZ2VUpzaXc3aDBTaWxGMFFmdEE4QUdvRCtYSHUrWWozN0g3cnRLckZMc1hwbEdXZkdmditHZiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: multipart/mixed;
        boundary="_004_94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB066ORSMSX110amrcor_"
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

--_004_94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB066ORSMSX110amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

It looks to me that the package objects are being initialized properly alre=
ady, unless I'm missing something. Please check the examples below and in t=
he attached files.

Attached is a small test case that dynamically loads an SSDT which contains=
 a package object which in turn contains references to other objects.


Main DSDT:
    Method (LD1)
    {
        Load (BUF1, HNDL)      // SSDT is in BUF1
        Store (HNDL, Debug)
        Return
    }  =20

Loaded table:
    External (DEV1, DeviceObj)
    Name (PKG1, Package() {
        1,2, DEV2, DEV1, 4})
    Device (DEV2) {}


AcpiExec Output:
- ev ld1
Evaluating \LD1
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0x00000000006DEEB8 000051 (v02 Intel  Load     00000001 INTL 201=
90509)
ACPI Exec: Table Event INSTALL, [SSDT] 006DEEB8
Table [SSDT: Load    ] (id 06) -    5 Objects with   1 Devices,   0 Regions=
,    1 Methods
ACPI Exec: Table Event LOAD, [SSDT] 006DEEB8
ACPI Debug:  Reference  [DdbHandle] Table Index 0x3
0x7 Outstanding allocations after evaluation of \LD1
Evaluation of \LD1 returned object 006D2FE8, external buffer length 18
  [Integer] =3D 0000000000000000

- ev pkg1
Evaluating \PKG1
Evaluation of \PKG1 returned object 006D2FE8, external buffer length 90
  [Package] Contains 5 Elements:
    [Integer] =3D 0000000000000001
    [Integer] =3D 0000000000000002
    [Object Reference] =3D 006DDF88 <Node>            Name DEV2 Device
    [Object Reference] =3D 006DD608 <Node>            Name DEV1 Device
    [Integer] =3D 0000000000000004


--_004_94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB066ORSMSX110amrcor_
Content-Type: application/octet-stream; name="loadedtable.asl"
Content-Description: loadedtable.asl
Content-Disposition: attachment; filename="loadedtable.asl"; size=337;
	creation-date="Tue, 18 Jun 2019 17:38:39 GMT";
	modification-date="Tue, 18 Jun 2019 20:17:09 GMT"
Content-Transfer-Encoding: base64

DQpEZWZpbml0aW9uQmxvY2soDQoJIiIsICAgICAgICAgLy8gT3V0cHV0IGZpbGVuYW1lDQoJIlNT
RFQiLCAgICAgLy8gU2lnbmF0dXJlDQoJMHgwMiwgICAgICAgLy8gRFNEVCBSZXZpc2lvbg0KCSJJ
bnRlbCIsICAgIC8vIE9FTUlEDQoJIkR5bmFtaWMiLCAgLy8gVEFCTEUgSUQNCgkweDAwMDAwMDAx
ICAvLyBPRU0gUmV2aXNpb24NCgkpDQp7DQogICAgRXh0ZXJuYWwgKERFVjEsIERldmljZU9iaikN
CiAgICBOYW1lIChMMDAxLCAxKQ0KDQogICAgTmFtZSAoUEtHMSwgUGFja2FnZSgpIHsNCiAgICAg
ICAgMSwyLCBERVYyLCBERVYxLCA0fSkNCg0KICAgIERldmljZSAoREVWMikge30NCn0NCg==

--_004_94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB066ORSMSX110amrcor_
Content-Type: application/octet-stream; name="tableinit.asl"
Content-Description: tableinit.asl
Content-Disposition: attachment; filename="tableinit.asl"; size=1296;
	creation-date="Tue, 18 Jun 2019 17:38:39 GMT";
	modification-date="Tue, 18 Jun 2019 20:13:38 GMT"
Content-Transfer-Encoding: base64

DQpEZWZpbml0aW9uQmxvY2soDQoJIiIsICAgICAgICAgLy8gT3V0cHV0IGZpbGVuYW1lDQoJIkRT
RFQiLCAgICAgLy8gU2lnbmF0dXJlDQoJMHgwMiwgICAgICAgLy8gRFNEVCBSZXZpc2lvbg0KCSJJ
bnRlbCIsICAgIC8vIE9FTUlEDQoJIkxvYWRUZXN0IiwgLy8gVEFCTEUgSUQNCgkweDAwMDAwMDAx
ICAvLyBPRU0gUmV2aXNpb24NCgkpDQp7DQoNCiAgICBOYW1lIChBRERSLCAwKQ0KICAgIE5hbWUg
KEhOREwsIDApDQogICAgRGV2aWNlIChERVYxKSB7fQ0KDQogICAgTmFtZSAoQlVGMSwgQnVmZmVy
KCkNCiAgICB7DQogICAgICAgIDB4NTMsMHg1MywweDQ0LDB4NTQsMHg1MSwweDAwLDB4MDAsMHgw
MCwgIC8qIDAwMDAwMDAwICAgICJTU0RUUS4uLiIgKi8NCiAgICAgICAgMHgwMiwweEE4LDB4NDks
MHg2RSwweDc0LDB4NjUsMHg2QywweDAwLCAgLyogMDAwMDAwMDggICAgIi4uSW50ZWwuIiAqLw0K
ICAgICAgICAweDQ0LDB4NzksMHg2RSwweDYxLDB4NkQsMHg2OSwweDYzLDB4MDAsICAvKiAwMDAw
MDAxMCAgICAiRHluYW1pYy4iICovDQogICAgICAgIDB4MDEsMHgwMCwweDAwLDB4MDAsMHg0OSww
eDRFLDB4NTQsMHg0QywgIC8qIDAwMDAwMDE4ICAgICIuLi4uSU5UTCIgKi8NCiAgICAgICAgMHgw
OSwweDA1LDB4MTksMHgyMCwweEEwLDB4MEEsMHgwMCwweDE1LCAgLyogMDAwMDAwMjAgICAgIi4u
LiAuLi4uIiAqLw0KICAgICAgICAweDVDLDB4NDQsMHg0NSwweDU2LDB4MzEsMHgwNiwweDAwLDB4
MDgsICAvKiAwMDAwMDAyOCAgICAiXERFVjEuLi4iICovDQogICAgICAgIDB4NEMsMHgzMCwweDMw
LDB4MzEsMHgwMSwweDA4LDB4NTAsMHg0QiwgIC8qIDAwMDAwMDMwICAgICJMMDAxLi5QSyIgKi8N
CiAgICAgICAgMHg0NywweDMxLDB4MTIsMHgwRiwweDA1LDB4MDEsMHgwQSwweDAyLCAgLyogMDAw
MDAwMzggICAgIkcxLi4uLi4uIiAqLw0KICAgICAgICAweDQ0LDB4NDUsMHg1NiwweDMyLDB4NDQs
MHg0NSwweDU2LDB4MzEsICAvKiAwMDAwMDA0MCAgICAiREVWMkRFVjEiICovDQogICAgICAgIDB4
MEEsMHgwNCwweDVCLDB4ODIsMHgwNSwweDQ0LDB4NDUsMHg1NiwgIC8qIDAwMDAwMDQ4ICAgICIu
LlsuLkRFViIgKi8NCiAgICAgICAgMHgzMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLyogMDAwMDAwNTAgICAgIjIiICAgICAgICAqLw0KICAgIH0pDQoNCiAgICBNZXRob2Qg
KExEMSkNCiAgICB7DQogICAgICAgIExvYWQgKEJVRjEsIEhOREwpDQogICAgICAgIFN0b3JlIChI
TkRMLCBEZWJ1ZykNCiAgICAgICAgUmV0dXJuDQogICAgfSAgIA0KfQ0K

--_004_94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB066ORSMSX110amrcor_
Content-Type: application/octet-stream; name="loadedtable.hex"
Content-Description: loadedtable.hex
Content-Disposition: attachment; filename="loadedtable.hex"; size=1241;
	creation-date="Tue, 18 Jun 2019 19:39:26 GMT";
	modification-date="Tue, 18 Jun 2019 20:12:53 GMT"
Content-Transfer-Encoding: base64

LyoNCiAqIA0KICogSW50ZWwgQUNQSSBDb21wb25lbnQgQXJjaGl0ZWN0dXJlDQogKiBBU0wrIE9w
dGltaXppbmcgQ29tcGlsZXIvRGlzYXNzZW1ibGVyIHZlcnNpb24gMjAxOTA1MDkgKDMyLWJpdCB2
ZXJzaW9uKQ0KICogQ29weXJpZ2h0IChjKSAyMDAwIC0gMjAxOSBJbnRlbCBDb3Jwb3JhdGlvbg0K
ICogDQogKiBDb21waWxhdGlvbiBvZiAibG9hZGVkdGFibGUuYXNsIiAtIFR1ZSBKdW4gMTggMTM6
MTI6NTMgMjAxOQ0KICogDQogKiBBU0wgc291cmNlIGNvZGUgb3V0cHV0DQogKiBBTUwgY29kZSBi
bG9jayBjb250YWlucyAweDUxIGJ5dGVzDQogKg0KICovDQogICAgTmFtZSAoQlVGMSwgQnVmZmVy
KCkNCiAgICB7DQogICAgICAgIDB4NTMsMHg1MywweDQ0LDB4NTQsMHg1MSwweDAwLDB4MDAsMHgw
MCwgIC8qIDAwMDAwMDAwICAgICJTU0RUUS4uLiIgKi8NCiAgICAgICAgMHgwMiwweEE4LDB4NDks
MHg2RSwweDc0LDB4NjUsMHg2QywweDAwLCAgLyogMDAwMDAwMDggICAgIi4uSW50ZWwuIiAqLw0K
ICAgICAgICAweDQ0LDB4NzksMHg2RSwweDYxLDB4NkQsMHg2OSwweDYzLDB4MDAsICAvKiAwMDAw
MDAxMCAgICAiRHluYW1pYy4iICovDQogICAgICAgIDB4MDEsMHgwMCwweDAwLDB4MDAsMHg0OSww
eDRFLDB4NTQsMHg0QywgIC8qIDAwMDAwMDE4ICAgICIuLi4uSU5UTCIgKi8NCiAgICAgICAgMHgw
OSwweDA1LDB4MTksMHgyMCwweEEwLDB4MEEsMHgwMCwweDE1LCAgLyogMDAwMDAwMjAgICAgIi4u
LiAuLi4uIiAqLw0KICAgICAgICAweDVDLDB4NDQsMHg0NSwweDU2LDB4MzEsMHgwNiwweDAwLDB4
MDgsICAvKiAwMDAwMDAyOCAgICAiXERFVjEuLi4iICovDQogICAgICAgIDB4NEMsMHgzMCwweDMw
LDB4MzEsMHgwMSwweDA4LDB4NTAsMHg0QiwgIC8qIDAwMDAwMDMwICAgICJMMDAxLi5QSyIgKi8N
CiAgICAgICAgMHg0NywweDMxLDB4MTIsMHgwRiwweDA1LDB4MDEsMHgwQSwweDAyLCAgLyogMDAw
MDAwMzggICAgIkcxLi4uLi4uIiAqLw0KICAgICAgICAweDQ0LDB4NDUsMHg1NiwweDMyLDB4NDQs
MHg0NSwweDU2LDB4MzEsICAvKiAwMDAwMDA0MCAgICAiREVWMkRFVjEiICovDQogICAgICAgIDB4
MEEsMHgwNCwweDVCLDB4ODIsMHgwNSwweDQ0LDB4NDUsMHg1NiwgIC8qIDAwMDAwMDQ4ICAgICIu
LlsuLkRFViIgKi8NCiAgICAgICAgMHgzMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLyogMDAwMDAwNTAgICAgIjIiICAgICAgICAqLw0KICAgIH0pDQo=

--_004_94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB066ORSMSX110amrcor_--
