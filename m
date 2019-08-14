Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C145C8DEC8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 22:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfHNU1h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 14 Aug 2019 16:27:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:10731 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbfHNU1h (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 14 Aug 2019 16:27:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 13:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="352025015"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga005.jf.intel.com with ESMTP; 14 Aug 2019 13:27:35 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.68]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.52]) with mapi id 14.03.0439.000;
 Wed, 14 Aug 2019 13:27:35 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
Thread-Topic: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
Thread-Index: AQHVUtE53Fq1kC1ZJkuyhDPpGVYpeqb7Fn5Q
Date:   Wed, 14 Aug 2019 20:27:35 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C61A211@ORSMSX122.amr.corp.intel.com>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <20190814185055.GZ30120@smile.fi.intel.com>
In-Reply-To: <20190814185055.GZ30120@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTFjMDk5MDQtNzdmYi00MGQ4LThhMDktZDgyODNhZDI1NGFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSXNhQUZDbkhUWEhMYktrRkw3SzlDbldiNGRzUDRoQ3BER3c2OTBpSTBEcWY5SFwvVnVENlhqWm9ZZmtnTzdMQ24ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



> -----Original Message-----
> From: Shevchenko, Andriy
> Sent: Wednesday, August 14, 2019 11:51 AM
> To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
> Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
> <erik.schmauss@intel.com>; Jacek Anaszewski <jacek.anaszewski@gmail.com>;
> Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; Thierry
> Reding <thierry.reding@gmail.com>; linux-acpi@vger.kernel.org;
> devel@acpica.org; linux-leds@vger.kernel.org; linux-pwm@vger.kernel.org
> Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
> 
> On Wed, May 29, 2019 at 02:18:20PM +0200, Nikolaus Voss wrote:
> > If an ACPI SSDT overlay is loaded after built-in tables have been
> > loaded e.g. via configfs or efivar_ssdt_load() it is necessary to
> > rewalk the namespace to resolve references. Without this, relative and
> > absolute paths like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved
> > correctly.
> >
> > Make configfs load use the same method as efivar_ssdt_load().
> 
> This patch brought a regression (bisect log below).
> Now I'm unable to unload the table which was working before.
> 
> Reverting (manual, due to ACPICA changes) helps.
> 
> Please, consider to revert for this cycle, or fix. I will be glad to test any
> proposed fix.

We submitted a patch (d1fb5b2f623b1af5a0d2a83d205df1b61f430dc6)
in response to this suggestion and I was not aware that this had been applied.

Rafael, please revert at least the ACPICA portion of this patch.

Thanks,
Erik
> 
> 
> git bisect start
> # good: [0ecfebd2b52404ae0c54a878c872bb93363ada36] Linux 5.2 git bisect
> good 0ecfebd2b52404ae0c54a878c872bb93363ada36
> # bad: [5f9e832c137075045d15cd6899ab0505cfb2ca4b] Linus 5.3-rc1 git
> bisect bad 5f9e832c137075045d15cd6899ab0505cfb2ca4b
> # bad: [e786741ff1b52769b044b7f4407f39cd13ee5d2d] Merge tag 'staging-
> 5.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect bad e786741ff1b52769b044b7f4407f39cd13ee5d2d
> # bad: [8f6ccf6159aed1f04c6d179f61f6fb2691261e84] Merge tag 'clone3-v5.3'
> of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
> git bisect bad 8f6ccf6159aed1f04c6d179f61f6fb2691261e84
> # good: [ed63b9c873601ca113da5c7b1745e3946493e9f3] Merge tag
> 'media/v5.3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-
> media
> git bisect good ed63b9c873601ca113da5c7b1745e3946493e9f3
> # bad: [4b4704520d97b74e045154fc3b844b73ae4e7ebd] Merge tag 'acpi-5.3-
> rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect bad 4b4704520d97b74e045154fc3b844b73ae4e7ebd
> # good: [e3303268f9cfa4eb7c2217df471417d4327109fd] ASoC: soc-core: don't
> use soc_find_component() at snd_soc_find_dai() git bisect good
> e3303268f9cfa4eb7c2217df471417d4327109fd
> # good: [3c53c6255d598db7084c5c3d7553d7200e857818] Merge tag 'asoc-
> v5.3' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-
> linus git bisect good 3c53c6255d598db7084c5c3d7553d7200e857818
> # good: [4cdd5f9186bbe80306e76f11da7ecb0b9720433c] Merge tag 'sound-
> 5.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect good 4cdd5f9186bbe80306e76f11da7ecb0b9720433c
> # good: [13b06b78c772d64e2207e4a5a5329856fe2bf241] Merge branches
> 'pm-opp', 'pm-misc', 'pm-avs' and 'pm-tools'
> git bisect good 13b06b78c772d64e2207e4a5a5329856fe2bf241
> # good: [cf2d213e49fdf47e4c10dc629a3659e0026a54b8] Merge tag 'pm-5.3-
> rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good cf2d213e49fdf47e4c10dc629a3659e0026a54b8
> # bad: [02a93f35f57fe5d4d1bac0ac8496884235e2fd2e] ACPICA: Update
> version to 20190703 git bisect bad
> 02a93f35f57fe5d4d1bac0ac8496884235e2fd2e
> # bad: [d4ca763eed3bcc227f220beb11ff4eb2fa548755] Merge ACPI tables
> handling changes for v5.3.
> git bisect bad d4ca763eed3bcc227f220beb11ff4eb2fa548755
> # bad: [d06c47e3dd07fdf3f07e8fc45f2ce655e9b295c5] ACPI: configfs: Resolve
> objects on host-directed table loads git bisect bad
> d06c47e3dd07fdf3f07e8fc45f2ce655e9b295c5
> # good: [c78fea61f0c1f8568fbbb36ac3d1e1c85a903ae4] ACPI: tables: Allow
> BGRT to be overridden git bisect good
> c78fea61f0c1f8568fbbb36ac3d1e1c85a903ae4
> # first bad commit: [d06c47e3dd07fdf3f07e8fc45f2ce655e9b295c5] ACPI:
> configfs: Resolve objects on host-directed table loads
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

