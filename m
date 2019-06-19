Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF394BD64
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFSP7g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 19 Jun 2019 11:59:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:46099 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfFSP7g (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 19 Jun 2019 11:59:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 08:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="181662641"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2019 08:59:34 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Jun 2019 08:59:34 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.92]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.41]) with mapi id 14.03.0439.000;
 Wed, 19 Jun 2019 08:59:34 -0700
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "nikolaus.voss@loewensteinmedical.de" 
        <nikolaus.voss@loewensteinmedical.de>
Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
Thread-Topic: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
Thread-Index: AQHVIPn/qqDB5Bv4z0aSsleXlAnDw6abVhaAgAADpwD///G0sIAEkokAgACES6CAAT+dAIAANdnAgAALWnCAAAJ3oIAAAgmggAFPOoD///bKAA==
Date:   Wed, 19 Jun 2019 15:59:33 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FC28D@ORSMSX110.amr.corp.intel.com>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
 <alpine.DEB.2.20.1906141114490.6579@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B95EFB26@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906170746150.12344@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B95F9EC6@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906181030240.24846@fox.voss.local>
    <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB0BA@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906191123400.34742@fox.voss.local>
In-Reply-To: <alpine.DEB.2.20.1906191123400.34742@fox.voss.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2MwMjlmZjgtMjNkYi00N2ZjLTlmMmQtNjNlYmY1OTMyOWFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZVBaZGNrSVo0dnZpczNyWHlzc01mTWJMNUtVRDd2b24yMnJxQkNPb25xcjhrM1ZoQjZEb0t4QWR5YUNISFZjOCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



> -----Original Message-----
> From: Nikolaus Voss [mailto:nv@vosn.de]
> Sent: Wednesday, June 19, 2019 2:31 AM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Schmauss, Erik
> <erik.schmauss@intel.com>; Jacek Anaszewski
> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
> <dmurphy@ti.com>; Thierry Reding <thierry.reding@gmail.com>; ACPI Devel
> Maling List <linux-acpi@vger.kernel.org>; open list:ACPI COMPONENT
> ARCHITECTURE (ACPICA) <devel@acpica.org>; linux-leds@vger.kernel.org;
> Linux PWM List <linux-pwm@vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; nikolaus.voss@loewensteinmedical.de
> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
> loads
> 
> Hi Bob,
> 
> On Tue, 18 Jun 2019, Moore, Robert wrote:
> >
> >
> >> -----Original Message-----
> >> From: Moore, Robert
> >> Sent: Tuesday, June 18, 2019 1:25 PM
> >> To: 'Nikolaus Voss' <nv@vosn.de>
> >> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
> >> <rjw@rjwysocki.net>; 'Len Brown' <lenb@kernel.org>; Schmauss, Erik
> >> <erik.schmauss@intel.com>; 'Jacek Anaszewski'
> >> <jacek.anaszewski@gmail.com>; 'Pavel Machek' <pavel@ucw.cz>; 'Dan
> >> Murphy' <dmurphy@ti.com>; 'Thierry Reding'
> >> <thierry.reding@gmail.com>; 'ACPI Devel Maling List'
> >> <linux-acpi@vger.kernel.org>; 'open list:ACPI COMPONENT ARCHITECTURE
> >> (ACPICA)' <devel@acpica.org>; 'linux- leds@vger.kernel.org' <linux-
> leds@vger.kernel.org>; 'Linux PWM List'
> >> <linux-pwm@vger.kernel.org>; 'Linux Kernel Mailing List' <linux-
> >> kernel@vger.kernel.org>
> >> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
> >> table loads
> >>
> >> If it is in fact the AcpiLoadTable interface that is incorrect, that
> >> of course is different. I'll check that out next.
> >>
> > [Moore, Robert]
> >
> > Yes, this is the issue, not specifically the Load() operator, but the
> > AcpiLoadTable interface only.
> 
> thanks for checking this out. So what is the conclusion? Is my fix of
> AcpiLoadTable() sufficient or do we need a different solution?
> 
> Niko
> 


Your change is in the correct area. We want to do something like this, however:

diff --git a/source/components/executer/exconfig.c b/source/components/executer/exconfig.c
index 84a058ada..eba1a6d28 100644
--- a/source/components/executer/exconfig.c
+++ b/source/components/executer/exconfig.c
@@ -342,10 +342,9 @@ AcpiExLoadTableOp (
         return_ACPI_STATUS (Status);
     }
 
-    /* Complete the initialization/resolution of package objects */
+    /* Complete the initialization/resolution of new objects */
 
-    Status = AcpiNsWalkNamespace (ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
-        ACPI_UINT32_MAX, 0, AcpiNsInitOnePackage, NULL, NULL, NULL);
+    AcpiNsInitializeObjects ();
 
     /* Parameter Data (optional) */
 
@@ -620,10 +619,11 @@ AcpiExLoadOp (
         return_ACPI_STATUS (Status);
     }
 
-    /* Complete the initialization/resolution of package objects */
+    /* Complete the initialization/resolution of new objects */
 
-    Status = AcpiNsWalkNamespace (ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
-        ACPI_UINT32_MAX, 0, AcpiNsInitOnePackage, NULL, NULL, NULL);
+    AcpiExExitInterpreter ();
+    AcpiNsInitializeObjects ();
+    AcpiExEnterInterpreter ();
 
     /* Store the DdbHandle into the Target operand */
 
diff --git a/source/components/tables/tbxfload.c b/source/components/tables/tbxfload.c
index 217d54bf0..1e17db6c8 100644
--- a/source/components/tables/tbxfload.c
+++ b/source/components/tables/tbxfload.c
@@ -479,6 +479,13 @@ AcpiLoadTable (
     ACPI_INFO (("Host-directed Dynamic ACPI Table Load:"));
     Status = AcpiTbInstallAndLoadTable (ACPI_PTR_TO_PHYSADDR (Table),
         ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE, &TableIndex);
+    if (ACPI_SUCCESS (Status))
+    {
+        /* Complete the initialization/resolution of new objects */
+
+        AcpiNsInitializeObjects ();
+    }
+
     return_ACPI_STATUS (Status);
 }



> [...]
