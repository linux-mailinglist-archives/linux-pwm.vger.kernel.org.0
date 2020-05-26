Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652BB1E2659
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbgEZQDo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 12:03:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:3709 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgEZQDn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 26 May 2020 12:03:43 -0400
IronPort-SDR: mwE+zKzxthCAzlElbMsdbrEix9w1GWoocQYgYeopfTuaSTmuzg0Syqcx2OXBwNvNxuz96zdkbm
 W3eRM3qismhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 09:03:42 -0700
IronPort-SDR: 2xWlNCFO2LxbbSXeaNDSvwyvAro0gZEgkG/jybusID3x9qZ0i5pNXqeWg4zF5nMHdyMUhCGsL6
 GmBbwzkspemg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="255452739"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 26 May 2020 09:03:34 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdc3E-0091nj-Af; Tue, 26 May 2020 19:03:36 +0300
Date:   Tue, 26 May 2020 19:03:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/16] mfd: mfd-core: match device tree node against
 reg property
Message-ID: <20200526160336.GV1634618@smile.fi.intel.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
 <67e90dafd67c285158c2c6f67f92edb7@walle.cc>
 <20200515102848.GH271301@dell>
 <159e68b4ce53630ef906b2fcbca925bd@walle.cc>
 <20200526072427.GC3628@dell>
 <f5704ce5a3e280f63c81fe35efb08234@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5704ce5a3e280f63c81fe35efb08234@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, May 26, 2020 at 05:54:38PM +0200, Michael Walle wrote:
> Am 2020-05-26 09:24, schrieb Lee Jones:

...

> Like I said, in the long term I would like to have support for
> different versions of the board management controller

> without having to change the device tree and have device tree bindings for the
> subdevices at the same time.

But isn't device tree to describe *very specific platform* rather than *class
of platforms*?

> But it seems, that this is not possible
> and I guess I have to bite the bullet and may need to provide another
> device tree if the controller might be updated.

-- 
With Best Regards,
Andy Shevchenko


