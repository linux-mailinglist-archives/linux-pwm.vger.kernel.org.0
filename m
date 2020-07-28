Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4302306B6
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 11:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgG1Jjd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 05:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgG1Jjc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 05:39:32 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6AAC061794;
        Tue, 28 Jul 2020 02:39:32 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 54F7722FEB;
        Tue, 28 Jul 2020 11:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595929170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64gdmRmPNUAWxLuPtaHOnsTHn2FxnHw9JZXkDuXvtZc=;
        b=o8YM+mX42C2t3je/oH3/fZv44ZYDoiucvXv3qUg5hvBntlN/+8aWdGh0ld+f0XgZcL0dMn
        HI3VlmaE9HskRrEarnJ18TJsbPuIbhv12jccoIuPt4mtL+9vtkuRSD7nJ0+zSZ8X928a24
        /nmJJUx4WDgLDFPyJkWZ6i1nNmFYbwY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jul 2020 11:39:30 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
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
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 02/13] dt-bindings: mfd: Add bindings for sl28cpld
In-Reply-To: <20200728092016.GE2419169@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-3-michael@walle.cc> <20200728072422.GF1850026@dell>
 <1065b0107ce6fd88b2bdd704bf45346b@walle.cc> <20200728082707.GB2419169@dell>
 <a47993ca4c77ab1ee92f6693debb3c87@walle.cc> <20200728085616.GD2419169@dell>
 <2fd3b880e36aa65e880b801092b51945@walle.cc> <20200728092016.GE2419169@dell>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <7aebbd1986d1a0e57fd34c2ccf5e03e3@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-07-28 11:20, schrieb Lee Jones:
>> What sounds bogus? That we name the implementation sl28cpld?
>> How is that different to like adt7411? Its just a name made up by
>> the vendor. So if there is a new version of the adt7411 the vendor
>> might name it adt7412.
> 
> Using an arbitrary string as a compatible would be bogus.
> 
> So here 'sl28cpld' is the device name, so it's not actually
> arbitrary.  That's a good start.
> 
>> We name it sl28cpld-r2. So what is the problem here?
> 
> Do you though?  So 'sl28cpld-r1' is the name of the device?  The name
> that is quoted from the (private) datasheet?  Because looking at the
> implementation and going by the conversation, it sounds as though
> you-re only adding the '-r1' piece to the compatible string for
> revision identification.  Which if true, is not usually allowed and
> warrants intervention by Rob.

Revisions would imply backwards compatibility, correct? I'm not
aming for that. Yes, I appended that "-r1" (in the lack of any
better suffix) because I didn't want to tie the base name to the
simple MFD, just in case. And isn't that the whole purpose of
the compatible string? To connect a driver to a piece of
hardware?

But even here, I don't care anymore. I strip it again. So future
incarnations which aren't compatible with simple mfd will need
another name. So what.

-michael
