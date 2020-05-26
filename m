Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F501E261B
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 17:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgEZPyu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 11:54:50 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:44023 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgEZPyt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 11:54:49 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 25A9823E2C;
        Tue, 26 May 2020 17:54:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1590508485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fea62NxmJK3eV7EnGjkH2PK8+sAxiTRywctVj4jahAw=;
        b=p/H6CoByMx+/VRkUqo+zYBHQEDnzKf87T6UB5OckeCGd559i5IIHZzp0KffewoWwrz88Ae
        h4yBFkejNH9BHFDcaRt1kgJ81Y0dFZk9I17TNByb0x/PZd+5Ojh4zOlgnTuQUvHMWc5GBK
        mSDPNjq9ejnJ/5I3fr34XdPofcyMOs0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 May 2020 17:54:38 +0200
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
In-Reply-To: <20200526072427.GC3628@dell>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
 <67e90dafd67c285158c2c6f67f92edb7@walle.cc> <20200515102848.GH271301@dell>
 <159e68b4ce53630ef906b2fcbca925bd@walle.cc> <20200526072427.GC3628@dell>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <f5704ce5a3e280f63c81fe35efb08234@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-05-26 09:24, schrieb Lee Jones:
> On Mon, 25 May 2020, Michael Walle wrote:
> 
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
>> > >
>> > >
>> > > Do you think this is feasible? I guess this is the biggest uncertainty
>> > > for me at the moment in this patch series.
>> >
>> > I think it sounds fine in principle.  So long as it doesn't change the
>> > existing behaviour when of_reg isn't set.
>> >
>> > > > Signed-off-by: Michael Walle <michael@walle.cc>
>> > > > ---
>> > > >  drivers/mfd/mfd-core.c   | 29 ++++++++++++++++++++---------
>> > > >  include/linux/mfd/core.h | 26 ++++++++++++++++++++------
>> > > >  2 files changed, 40 insertions(+), 15 deletions(-)
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
>> 
>> So to circumvent this, I thought of having the unit-address (and thus
>> the "reg" property) to differentiate between multiple subdevices. Now
>> there is one special case for me: this board management controller
>> might be upgradable and it might change internally. Thus I came up
>> with that logical numbering of subdevices. Rob doesn't seem to be a
>> fan of that, though. Therefore, having bit 31 as a valid indicator
>> leaves you with 2^31 logical devices, which should be enough ;)
>> 
>> Rob proposed to have the internal offset as the unit-address. But
>> in that case I can also use devm_of_platform_populate() and don't
>> need the OF_MFD_CELL_REG; I'd just parse the reg offset in each
>> individual subdevice driver. But like I said, I wanted to keep the
>> internal offsets out of the device tree.
> 
> Oh, I see what you're doing.
> 
> So you're adding an arbitrary ID to the device's reg property in DT?

Yes.

> How is this not a hack?

Well IMHO this is not more or less a hack as the current of_node
handling of MFD devices, which happens to work only because there
is only one device per compatible string (or it doesn't really work,
like in the stericsson,ab8500-pwm case). The of_node is assigned
according to the compatible string, just like in my case, only that
I have two subdevices with the same compatible string.

> Why don't you use the full address for identification?

Like I said, in the long term I would like to have support for
different versions of the board management controller without having
to change the device tree and have device tree bindings for the
subdevices at the same time. But it seems, that this is not possible
and I guess I have to bite the bullet and may need to provide another
device tree if the controller might be updated.

-michael
