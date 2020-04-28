Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4A1BC1AE
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2020 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgD1OtY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Apr 2020 10:49:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:44321 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgD1OtX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Apr 2020 10:49:23 -0400
IronPort-SDR: M3/Xyic/5VujCElqY7alBgdPsNTdir4yfb6nDoNiZpXT+E/oAmiAYl+JnmDRaOsL6piQC0Umky
 ZcwH0rCPLpEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 07:49:23 -0700
IronPort-SDR: M7Q2JOL2/2WVi2KG81PKTMYYXt/g2OLOYqwoQAXN4maj5NEy50tqiPlW0IWJuQk3HXmy2PCj+g
 JaFrFUEwuzTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="404712385"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 28 Apr 2020 07:49:17 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jTRXz-003ZjC-A2; Tue, 28 Apr 2020 17:49:19 +0300
Date:   Tue, 28 Apr 2020 17:49:19 +0300
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
Subject: Re: [PATCH v3 04/16] dt-bindings: mfd: Add bindings for sl28cpld
Message-ID: <20200428144919.GY185537@smile.fi.intel.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-5-michael@walle.cc>
 <20200428124825.GT185537@smile.fi.intel.com>
 <8cc4a2bd3fcaf836d7f393ce2425c872@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc4a2bd3fcaf836d7f393ce2425c872@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Apr 28, 2020 at 04:39:44PM +0200, Michael Walle wrote:
> Am 2020-04-28 14:48, schrieb Andy Shevchenko:
> > On Thu, Apr 23, 2020 at 07:45:31PM +0200, Michael Walle wrote:
> > > This adds device tree bindings for the board management controller
> > > found
> > > on the Kontron SMARC-sAL28 board.
> > 
> > I think it should be independent patches (same way as you do for
> > drivers).
> 
> It used to be several patches but Rob suggested to put it into one:
> https://lore.kernel.org/linux-devicetree/20200330223535.GA31402@bogus/

Ah, okay.

-- 
With Best Regards,
Andy Shevchenko


