Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD991EF9FB
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFEOJO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 10:09:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:45252 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbgFEOJO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 5 Jun 2020 10:09:14 -0400
IronPort-SDR: 3GpFEgJh1E1/pkYsMX2LrazmJIRlAesPx29CBXWo3aDZQfDWDvly76YlZBbxYTbQt+cz9zChzU
 AG1/Ks9NdSeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 07:09:14 -0700
IronPort-SDR: STm5cJBEx3cZwh5EDl1WI2zIniez547qsBBHLm0a+PZkJql6UaV6R0I9F6DqWusAPQO2MUnztk
 j822dzBvILJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="471924635"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2020 07:09:09 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jhD1z-00B2nb-Cy; Fri, 05 Jun 2020 17:09:11 +0300
Date:   Fri, 5 Jun 2020 17:09:11 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
Message-ID: <20200605140911.GO2428291@smile.fi.intel.com>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
 <8f042c2442852c29519c381833f3d289@walle.cc>
 <CAHp75VfY0BD4CFu6Thx1wE-U0Zt1q8uTOLxkWTMdFk0MBuhYFQ@mail.gmail.com>
 <871a4990-5b94-3a17-01d4-74998375f08b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871a4990-5b94-3a17-01d4-74998375f08b@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 05, 2020 at 06:52:00AM -0700, Guenter Roeck wrote:
> On 6/5/20 3:50 AM, Andy Shevchenko wrote:
> > On Fri, Jun 5, 2020 at 1:24 PM Michael Walle <michael@walle.cc> wrote:
> >> Am 2020-06-05 10:14, schrieb Andy Shevchenko:
> >>> On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:

...

> >>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
> >>>> +module_param(nowayout, bool, 0);
> >>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
> >>>> (default="
> >>>> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT)
> >>>> ")");
> >>>> +
> >>>> +static int timeout;
> >>>> +module_param(timeout, int, 0);
> >>>> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> >>>
> >>> Guenter ACKed this, but I'm wondering why we still need module
> >>> parameters...
> >>
> >> How would a user change the nowayout or the timeout? For the latter
> >> there is
> >> a device tree entry, but thats not easy changable by the user.
> > 
> > Yes, it's more question to VIm and Guenter than to you.
> > 
> 
> Has support for providing module parameters with the kernel command line
> been discontinued/deprecated, or did it run out of favor ? Sorry if I
> missed that.

Latter according to Greg KH. One of the (plenty) examples [1].

[1]: https://www.mail-archive.com/driverdev-devel@linuxdriverproject.org/msg96495.html

> nowayout has a configuration default. A module parameter is sometimes
> provided by drivers to be able to override it. The timeout provided
> via devicetree or on the command line is only the initial/default
> timeout, and the watchdog daemon can change it after opening the
> watchdog device as it sees fit.

Thanks for explanation.

-- 
With Best Regards,
Andy Shevchenko


