Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D265A39A1
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Aug 2019 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfH3Oxx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Aug 2019 10:53:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:55256 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfH3Oxx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 30 Aug 2019 10:53:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 07:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="198051411"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2019 07:53:49 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i3iHc-0008QV-0c; Fri, 30 Aug 2019 17:53:48 +0300
Date:   Fri, 30 Aug 2019 17:53:48 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        nikolaus.voss@loewensteinmedical.de
Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
Message-ID: <20190830145348.GM2680@smile.fi.intel.com>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <20190814185055.GZ30120@smile.fi.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C61A211@ORSMSX122.amr.corp.intel.com>
 <alpine.DEB.2.20.1908161345590.41303@fox.voss.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1908161345590.41303@fox.voss.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 16, 2019 at 01:57:26PM +0200, Nikolaus Voss wrote:
> On Wed, 14 Aug 2019, Schmauss, Erik wrote:
> > > -----Original Message-----
> > > From: Shevchenko, Andriy
> > > Sent: Wednesday, August 14, 2019 11:51 AM
> > > To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
> > > Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
> > > <erik.schmauss@intel.com>; Jacek Anaszewski <jacek.anaszewski@gmail.com>;
> > > Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; Thierry
> > > Reding <thierry.reding@gmail.com>; linux-acpi@vger.kernel.org;
> > > devel@acpica.org; linux-leds@vger.kernel.org; linux-pwm@vger.kernel.org
> > > Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
> > > 
> > > On Wed, May 29, 2019 at 02:18:20PM +0200, Nikolaus Voss wrote:
> > > > If an ACPI SSDT overlay is loaded after built-in tables have been
> > > > loaded e.g. via configfs or efivar_ssdt_load() it is necessary to
> > > > rewalk the namespace to resolve references. Without this, relative and
> > > > absolute paths like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved
> > > > correctly.
> > > > 
> > > > Make configfs load use the same method as efivar_ssdt_load().
> > > 
> > > This patch brought a regression (bisect log below).
> > > Now I'm unable to unload the table which was working before.
> > > 
> > > Reverting (manual, due to ACPICA changes) helps.
> > > 
> > > Please, consider to revert for this cycle, or fix. I will be glad to test any
> > > proposed fix.
> > 
> > We submitted a patch (d1fb5b2f623b1af5a0d2a83d205df1b61f430dc6)
> > in response to this suggestion and I was not aware that this had been applied.
> > 
> > Rafael, please revert at least the ACPICA portion of this patch.
> 
> As I see it, my ACPICA change is not part of 5.3-rc1 any more. Reverting my
> fix is part of the patch above (d1fb5b2f623b1af5a0d2a83d205df1b61f430dc6)
> which is already applied.
> 
> Nevertheless, what is new, is that acpi_ns_initialize_objects() is called in
> acpi_load_table(). This is necessary to resolve the references in the newly
> loaded table. Maybe this prevents the table from being unloaded?

So, can we do something about it? It's a regression.

Rafael, Nikolaus?

-- 
With Best Regards,
Andy Shevchenko


