Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DFA1BC1CA
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2020 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgD1OuE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Apr 2020 10:50:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:62133 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgD1OuD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Apr 2020 10:50:03 -0400
IronPort-SDR: PR1dPZPySpVR2UiMRdyxMDS84NGYYsCxM1YD0cWj/jJG5dbDURJvGlN9g49tzp9R9uYMhYT1v5
 pv2Wcq0c2iDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 07:50:02 -0700
IronPort-SDR: TIm9BnP5eTWiaT9SoCeMc1+yPT6amVcHlv8tmFBZ2L8njNT66dS/UjZGIRiR3nyY1Lyov1WfuY
 QLWN1Mr2JzFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="292873815"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 28 Apr 2020 07:49:56 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jTRYc-003Zjk-TU; Tue, 28 Apr 2020 17:49:58 +0300
Date:   Tue, 28 Apr 2020 17:49:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
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
Subject: Re: [PATCH v3 05/16] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200428144958.GZ185537@smile.fi.intel.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-6-michael@walle.cc>
 <20200428125049.GU185537@smile.fi.intel.com>
 <5e2d486077f9e2ce8bd9b171cf806fd9@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e2d486077f9e2ce8bd9b171cf806fd9@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Apr 28, 2020 at 04:43:24PM +0200, Michael Walle wrote:
> Am 2020-04-28 14:50, schrieb Andy Shevchenko:
> > On Thu, Apr 23, 2020 at 07:45:32PM +0200, Michael Walle wrote:
> > > This patch adds core support for the board management controller found
> > > on the SMARC-sAL28 board. It consists of the following functions:
> > >  - watchdog
> > >  - GPIO controller
> > >  - PWM controller
> > >  - fan sensor
> > >  - interrupt controller
> > 
> > ...
> > 
> > >  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> > > 
> > >  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> > > +
> > > +obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
> > 
> > Perhaps keep an order?
> 
> I don't see any order in that makefile. Looked to me like every new
> file was added at the end.

Okay, just didn't note from above context.

-- 
With Best Regards,
Andy Shevchenko


