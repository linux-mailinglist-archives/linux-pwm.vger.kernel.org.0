Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7112181EC
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2020 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgGHH4T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jul 2020 03:56:19 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53373 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHH4T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jul 2020 03:56:19 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3F86923078;
        Wed,  8 Jul 2020 09:56:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594194976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkAaApfhcYQrTtXHZ3DFw7xulIHI0rpYQDvfWCBnZm0=;
        b=biSWOVAjbZvthb+/2JqDpUf5TrG64sWC75SF1s1Z9kEyywzchrxU3Iqy6tXIkUZtVhIPg2
        abaMsAwWt4rVPYHYCytnRxorHIp1FA2W3FP3QKMrp3C5gwwGssdcUV38GWIS2O6vsBwp7x
        l58Gj90dSpH5zagXo6jLY7W8llV9JPY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Jul 2020 09:56:13 +0200
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 13/13] arm64: dts: freescale: sl28: enable fan support
In-Reply-To: <CACRpkdaPO7CGNrxmjL5QH1cxP5wqku1oMtQaQgJfeKiKqiGAOg@mail.gmail.com>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-14-michael@walle.cc>
 <CACRpkdaPO7CGNrxmjL5QH1cxP5wqku1oMtQaQgJfeKiKqiGAOg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <d9a53ed9254a136a7bc161c2a93045b0@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

Am 2020-07-08 09:39, schrieb Linus Walleij:
> just a drive-by-comment:
> 
> On Mon, Jul 6, 2020 at 7:57 PM Michael Walle <michael@walle.cc> wrote:
> 
>> Add a pwm-fan mapped to the PWM channel 0 which is connected to the
>> fan connector of the carrier.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> If you have a cooling device like this, do you also have a temperature
> sensor? In that case it makes sense to add a thermal zone and a
> policy, such as I did for a device in
> 6e97f0aaca4ca778905dd1dc667cbf379f4cae15

Yep, the CPU and DDR controller have temperatur sensors and there are
already thermal zones for them. We have the fan linked to the policies
in our vendor DTS overlay. For now I didn't want to include that here,
mainly because there are no labels in the fsl-ls1028a.dtsi for the
thermal zone/cooling maps/trips. But this is still on my TODO, when
this series finally make it into the kernel ;)

-michael
