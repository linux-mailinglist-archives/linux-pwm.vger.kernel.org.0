Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA7D462F5
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2019 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfFNPfk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 14 Jun 2019 11:35:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:34880 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNPfj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 14 Jun 2019 11:35:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 08:35:38 -0700
X-ExtLoop1: 1
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2019 08:35:38 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 14 Jun 2019 08:35:38 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.60]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.166]) with mapi id 14.03.0415.000;
 Fri, 14 Jun 2019 08:35:37 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Nikolaus Voss <nv@vosn.de>, "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
Thread-Topic: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
Thread-Index: AQHVIPn/qqDB5Bv4z0aSsleXlAnDw6abVhaAgAADpwD///G0sA==
Date:   Fri, 14 Jun 2019 15:35:36 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95EFB26@ORSMSX110.amr.corp.intel.com>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
 <alpine.DEB.2.20.1906141114490.6579@fox.voss.local>
In-Reply-To: <alpine.DEB.2.20.1906141114490.6579@fox.voss.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjNjOGUyNzEtODllMy00MDgxLWE0MmYtZTE5ZDRlOTBjZDFmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieHMzbXMwTW5xdTg0dUJueHJ5aWNNR0dQTDNaSWk1T0FNYlRldUk0TW0wMUlzWnp6cFwvN0dqNlAraXlyaTVweG0ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



-----Original Message-----
From: Nikolaus Voss [mailto:nv@vosn.de] 
Sent: Friday, June 14, 2019 2:26 AM
To: Rafael J. Wysocki <rafael@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; Thierry Reding <thierry.reding@gmail.com>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE (ACPICA) <devel@acpica.org>; linux-leds@vger.kernel.org; Linux PWM List <linux-pwm@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table loads

Hi Rafael,

On Fri, 14 Jun 2019, Rafael J. Wysocki wrote:
> On Wed, Jun 12, 2019 at 10:36 AM Nikolaus Voss 
> <nikolaus.voss@loewensteinmedical.de> wrote:
>>
>> If an ACPI SSDT overlay is loaded after built-in tables have been 
>> loaded e.g. via configfs or efivar_ssdt_load() it is necessary to 
>> rewalk the namespace to resolve references. Without this, relative 
>> and absolute paths like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved 
>> correctly.
>>
>> Make configfs load use the same method as efivar_ssdt_load().
>>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>
> This is fine by me, so
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Or if you want me to take this patch (without the other two in the 
> series), please let me know.

thanks. I think it would be the best if you take up this patch as it is an independent topic. In retrospect it wasn't a good idea to put it into this series.

Kind regards,
Niko

I would have to ask, why is additional code needed for package initialization/resolution? It already happens elsewhere in acpica.
Bob

[...]
