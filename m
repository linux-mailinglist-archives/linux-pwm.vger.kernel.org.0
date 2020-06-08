Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AFA1F1BF4
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 17:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgFHPVb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgFHPVb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 11:21:31 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBFAC08C5C2;
        Mon,  8 Jun 2020 08:21:31 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D311822EDB;
        Mon,  8 Jun 2020 17:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591629687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5/wFYr0WrHR2BGw4sUPuRmTmyyZEDrBDXp7xE6Rcqs=;
        b=Wg5tn5H1faOtr0XnIGPDSGd5kyucCSnasem9z0pro05j+LKp9YmcltmJYSntceVYHtAZHW
        CWFWp/mjoJ2xvRoKRmfTvpANiM8L6SG62R4HTUanniYR0aE0wa6xqFpGLIlU1qOlaKndyr
        yx9pmn5kqLEjpxuBMngTNYuCFJX99fM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Jun 2020 17:21:20 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/16] mfd: mfd-core: match device tree node against
 reg property
In-Reply-To: <20200608142413.GA4106@dell>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
 <67e90dafd67c285158c2c6f67f92edb7@walle.cc> <20200515102848.GH271301@dell>
 <159e68b4ce53630ef906b2fcbca925bd@walle.cc> <20200608142413.GA4106@dell>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <7566ef30fea9740f427f392aabde0eac@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-06-08 16:24, schrieb Lee Jones:
> On Mon, 25 May 2020, Michael Walle wrote:
>> Am 2020-05-15 12:28, schrieb Lee Jones:
>> > On Thu, 30 Apr 2020, Michael Walle wrote:
>> >
>> > > Hi Lee,
>> > >
>> > > Am 2020-04-23 19:45, schrieb Michael Walle:
>> > > > There might be multiple children with the device tree compatible, for
>> > > > example if a MFD has multiple instances of the same function. In this
>> > > > case only the first is matched and the other children get a wrong
>> > > > of_node reference.
>> > > > Add a new option to match also against the unit address of the child
>> > > > node. Additonally, a new helper OF_MFD_CELL_REG is added.
> 
> [...]
> 
>> > > > diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
>> > > > index d01d1299e49d..c2c0ad6b14f3 100644
>> > > > --- a/include/linux/mfd/core.h
>> > > > +++ b/include/linux/mfd/core.h
>> > > > @@ -13,8 +13,11 @@
>> > > >  #include <linux/platform_device.h>
>> > > >
>> > > >  #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
>> > > > +#define MFD_OF_REG_VALID	BIT(31)
>> >
>> > What about 64bit platforms?
>> 
>> The idea was to have this as a logical number. I.e. for now you may 
>> only
>> have one subdevice per unique compatible string. In fact, if you have 
>> a
>> look at the ab8500.c, there are multiple "stericsson,ab8500-pwm"
>> subdevices. But there is only one DT node for all three of it. I guess
>> this works as long as you don't use phandles to reference the pwm node
>> in the device tree. Or you don't want to use device tree properties
>> per subdevice (for example the "timeout-sec" of a watchdog device).
> 
> This is not a good example, as the "stericsson,ab8500-pwm" is
> legitimate.  Here we are registering 3 potential devices, but only
> instantiating 1 of them.

Mh?

static const struct mfd_cell ab8500_devs[] = {
..
        OF_MFD_CELL("ab8500-pwm",
                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
         OF_MFD_CELL("ab8500-pwm",
                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
         OF_MFD_CELL("ab8500-pwm",
                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
..
}

And in pwm-ab8500.c there are three offsets based on the pdev->id.

Am I missing something here?

-- 
-michael
