Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677D31F068C
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jun 2020 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgFFMpu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 6 Jun 2020 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgFFMpt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 6 Jun 2020 08:45:49 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF62C03E96A;
        Sat,  6 Jun 2020 05:45:49 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 999A322EE3;
        Sat,  6 Jun 2020 14:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591447546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gM7IewjQCAkSDvRzyGMjXyQ6q6nkyRovpb2OhFZgErU=;
        b=KuYGZZ03XJdDL/35fA1elmt+MIj+rU+0eKSys+0i1Gm2egVv5RXaD3aFB3MbhRgnovcamY
        4aT7AEghDPLkUWLir3HVwjqlo7DG4MYmumZOnXR3FIRnd/DzSgbqimwkYeeY+6keWPjTC2
        uwzuGiRic8TGrOkkEq19V8gU90hnB3Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 06 Jun 2020 14:45:38 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management
 controller
In-Reply-To: <20200606114645.GB2055@sirena.org.uk>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc> <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-06-06 13:46, schrieb Mark Brown:
> On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
>> Am 2020-06-05 12:50, schrieb Mark Brown:
> 
>> > I have no idea what you are thinking of when you say "simple-regmap" so
>> > it is difficult to comment.
> 
>> I guess, Lee is suggesting to be able to create a regmap instance via
>> device tree (and populate its child nodes?). Like
>>   compatible = "syscon", "simple-mfd";
>> but for any regmap, not just MMIO.
> 
> I don't understand why this would be anything separate to
> simple-mfd.

Don't just simple-mfd tells the of core, to probe the children this
node? Where does the regmap then come from?

> 
>> But, there is more in my driver:
>>  (1) there is a version check
>>  (2) there is another function for which there is no suitable linux
>>      subsystem I'm aware of and thus which I'd like to us sysfs
>>      attributes for: This controller supports 16 non-volatile
>>      configuration bits. (this is still TBD)
> 
> TBH I'd also say that the enumeration of the subdevices for this
> device should be in the device rather than the DT, they don't
> seem to be things that exist outside of this one device.

We're going circles here, formerly they were enumerated in the MFD.
Yes, they are devices which aren't likely be used outside a
"sl28cpld", but there might there might be other versions of the
sl28cpld with other components on different base addresses. I
don't care if they are enumerated in DT or MFD, actually, I'd
prefer the latter. _But_ I would like to have the device tree
properties for its subdevices, e.g. the ones for the watchdog or
whatever components there might be in the future. MFD core can
match a device tree node today; but only one per unique compatible
string. So what should I use to differentiate the different
subdevices? Rob suggested the internal offset, which I did here.
But then, there is less use in duplicating the offsets in the MFD
just to have the MFD enumerate the subdevices and then match
the device tree nodes against it. I can just use
of_platform_populate() to enumerate the children and I won't
have to duplicate the base addresses.

So here we are, any ideas appreciated.

-michael
