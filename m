Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5143B1A89B1
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504056AbgDNSga (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 14:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730984AbgDNSg0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 14:36:26 -0400
X-Greylist: delayed 30551 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 11:36:25 PDT
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1035C061A0C;
        Tue, 14 Apr 2020 11:36:25 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 53BD023EC2;
        Tue, 14 Apr 2020 20:36:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1586889384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETg9DQrxdDCpr8jJWz38aDIweCD3QxDPHNHvzP2jUaI=;
        b=UCGbIx6BP4Q+IaZfvVxIu9QIHpybrXsMYlGwiW2F5q48TGdHlwBz9HWEvKi0jPP6M5pjd9
        Uw30KSd6GweHb9rvhRNdwXbJKNLmCajHFJWJw47XKaaa1+xYZhHnR2oC1BTv5WnO4w6CIb
        AVzpz/8vTxtmpQrjUjxSLzL8hoFsy5E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Apr 2020 20:36:23 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
In-Reply-To: <20200414172129.GJ5412@sirena.org.uk>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
 <20200414172129.GJ5412@sirena.org.uk>
Message-ID: <fa605af3aee48f0bc62133f398ed7c5d@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 53BD023EC2
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         NEURAL_HAM(-0.00)[-1.083];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[baylibre.com,vger.kernel.org,lists.infradead.org,linaro.org,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-04-14 19:21, schrieb Mark Brown:
> On Tue, Apr 14, 2020 at 12:07:01PM +0200, Michael Walle wrote:
>> Am 2020-04-14 11:50, schrieb Bartosz Golaszewski:
> 
>> > Maybe setting the pointer to ERR_PTR(-ENOENT) which will result in
>> > IS_ERR() returning true?
> 
>> Unfortunatly, its not a pointer, but only a regular unsigned int (ie
>> the type the regmap API has for its "reg" property). It could be a
>> pointer of course but then the user would have to allocate additional
>> memory.
> 
> You could define REGMAP_INVALID_ADDR to be (unsigned int)(-1) or some
> other suitably implausible address and use that as a value.  It's
> possible that there might be a collision with a real address on some
> device but it should be sufficiently unlikely to be useful, especially
> if it's not something regmap in general goes and evaluates.  For extra
> safety we could have an API for allowing users to query the register
> validity information regmap has (or can be given) and gpiolib could 
> then
> use that to figure out if the value was actually a dummy value but
> that's probably overdoing it.

If possible, I'd like to have the opposite logic. That is, if it is not
set it should be invalid. If we have a magic macro like
REGMAP_INVALID_ADDR, we must assign it to all the unused addresses. Thus
every driver would have to assign all addresses and if in the future
there will be some added, we'd have to touch all the drivers which use
gpio_regmap.

-michael
