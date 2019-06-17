Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4DBA4946B
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jun 2019 23:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfFQVS4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 17 Jun 2019 17:18:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:43004 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfFQVS4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 17 Jun 2019 17:18:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 14:18:55 -0700
X-ExtLoop1: 1
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2019 14:18:55 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 17 Jun 2019 14:18:54 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.92]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.41]) with mapi id 14.03.0439.000;
 Mon, 17 Jun 2019 14:18:54 -0700
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
Thread-Index: AQHVIPn/qqDB5Bv4z0aSsleXlAnDw6abVhaAgAADpwD///G0sIAEkokAgACES6A=
Date:   Mon, 17 Jun 2019 21:18:53 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95F9EC6@ORSMSX110.amr.corp.intel.com>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
 <alpine.DEB.2.20.1906141114490.6579@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B95EFB26@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906170746150.12344@fox.voss.local>
In-Reply-To: <alpine.DEB.2.20.1906170746150.12344@fox.voss.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWYzNGU5MjEtOTVmYS00NTIwLWEwNDAtZjVjY2FhNDMyMzcyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ0VVTTM4NGZoQm5MNFFFeDI2dUhmcEE1SnNzcXNjWDZUVElBdVwvOWdkdkhyN3pBXC95cVpcLzNkY0tkRk1SbFc2MiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



> -----Original Message-----
> From: Nikolaus Voss [mailto:nv@vosn.de]
> Sent: Sunday, June 16, 2019 11:24 PM
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
> Bob,
> 
> On Fri, 14 Jun 2019, Moore, Robert wrote:
> >
> >
> > -----Original Message-----
> > From: Nikolaus Voss [mailto:nv@vosn.de]
> > Sent: Friday, June 14, 2019 2:26 AM
> > To: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown
> > <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com>; Schmauss,
> > Erik <erik.schmauss@intel.com>; Jacek Anaszewski
> > <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
> > <dmurphy@ti.com>; Thierry Reding <thierry.reding@gmail.com>; ACPI
> > Devel Maling List <linux-acpi@vger.kernel.org>; open list:ACPI
> > COMPONENT ARCHITECTURE (ACPICA) <devel@acpica.org>;
> > linux-leds@vger.kernel.org; Linux PWM List
> > <linux-pwm@vger.kernel.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
> > table loads
> >
> > Hi Rafael,
> >
> > On Fri, 14 Jun 2019, Rafael J. Wysocki wrote:
> >> On Wed, Jun 12, 2019 at 10:36 AM Nikolaus Voss
> >> <nikolaus.voss@loewensteinmedical.de> wrote:
> >>>
> >>> If an ACPI SSDT overlay is loaded after built-in tables have been
> >>> loaded e.g. via configfs or efivar_ssdt_load() it is necessary to
> >>> rewalk the namespace to resolve references. Without this, relative
> >>> and absolute paths like ^PCI0.SBUS or \_SB.PCI0.SBUS are not
> >>> resolved correctly.
> >>>
> >>> Make configfs load use the same method as efivar_ssdt_load().
> >>>
> >>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> >>
> >> This is fine by me, so
> >>
> >> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Or if you want me to take this patch (without the other two in the
> >> series), please let me know.
> >
> > thanks. I think it would be the best if you take up this patch as it
> > is an independent topic. In retrospect it wasn't a good idea to put it
> > into this series.
> >
> > Kind regards,
> > Niko
> >
> > I would have to ask, why is additional code needed for package
> > initialization/resolution? It already happens elsewhere in acpica. Bob
> 
> for built-in tables loaded via acpi_ex_load_table_op() everything is
> fine, because after acpi_tb_load_table() acpi_ns_walk_namespace() is
> called to resolve references.
> 
> My fix only affects tables loaded dynamically via either acpi_configfs
> driver (for debugging purposes) or efivar_ssdt_load() (to specify a
> table on the kernel's command line). They use acpi_load_table() to load
> the table from a caller-owned buffer. To resolve the references, it is
> again necessary to rewalk the namespace, which was simply missing in
> acpi_load_table().
> 
[Moore, Robert] 

Perhaps you should call AcpiInitializeObjects after the call to AcpiLoadTable, but I will check.

> Niko
