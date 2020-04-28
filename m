Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E371BBE1F
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2020 14:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgD1Ms3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Apr 2020 08:48:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:16155 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgD1Ms3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Apr 2020 08:48:29 -0400
IronPort-SDR: frzY7PeL0lwc/Fy6ueZHWuZK4gGyeLdw6ZU51oVaOISklbKlQBRvo7YlnouO9HlM5lPPZgjOQp
 7T46iRqOpiqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 05:48:28 -0700
IronPort-SDR: Z6HWDOLjjHowLabIxkbwfY0Q9JgW7Nm7J2HaRF6lvI3Cx2TF1ufN6CXUvV7fWs7gyUl5moZXMA
 76qS05kQmiAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,327,1583222400"; 
   d="scan'208";a="257603079"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2020 05:48:23 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jTPez-003YmH-Dr; Tue, 28 Apr 2020 15:48:25 +0300
Date:   Tue, 28 Apr 2020 15:48:25 +0300
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
Message-ID: <20200428124825.GT185537@smile.fi.intel.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423174543.17161-5-michael@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 23, 2020 at 07:45:31PM +0200, Michael Walle wrote:
> This adds device tree bindings for the board management controller found
> on the Kontron SMARC-sAL28 board.

I think it should be independent patches (same way as you do for drivers).

>  .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  51 ++++++
>  .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 +++
>  .../bindings/mfd/kontron,sl28cpld.yaml        | 162 ++++++++++++++++++
>  .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++++
>  .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++++

-- 
With Best Regards,
Andy Shevchenko


