Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7193B1BABDE
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2020 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgD0SBR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Apr 2020 14:01:17 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:58681 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgD0SBR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Apr 2020 14:01:17 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6B45823060;
        Mon, 27 Apr 2020 20:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1588010474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VgZY7A1YcWL+FUikv6WQsHGx/g/bx2ZDb/8Q06Sb0cg=;
        b=IwcZkG2ZaZ6kJ4ww3jxV05EBcMLx7lugU1iUUJK/aNzSzAGEpQYhe16q5/ZkjEBSngqk7C
        yG/267Xo4LJWOBoGv3ePYiXJlgmb42AZAtStyAeQzexqDTq4Bcm4iIhHdG8y+C/DunmQ+f
        L3Htu5r2vUx6nHwuitymbBSeJZzItug=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Apr 2020 20:01:14 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
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
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 06/16] irqchip: add sl28cpld interrupt controller
 support
In-Reply-To: <20200427174427.GE4383@sirena.org.uk>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-7-michael@walle.cc>
 <87pnbtqhr1.fsf@nanos.tec.linutronix.de>
 <87f141bce0a4fda04b550647306be296@walle.cc>
 <20200427174427.GE4383@sirena.org.uk>
Message-ID: <5d63026fc7c8700c2c7fb15267a9e441@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 6B45823060
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         NEURAL_HAM(-0.00)[-0.827];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linutronix.de,linux.intel.com,vger.kernel.org,lists.infradead.org,linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-04-27 19:44, schrieb Mark Brown:
> On Mon, Apr 27, 2020 at 07:40:11PM +0200, Michael Walle wrote:
> 
>> IRQF_ONESHOT, because its is a threaded interrupt with no primary
>> handler. But I just noticed, that regmap-irq will also set the
>> IRQF_ONESHOT. But that the commit 09cadf6e088b ("regmap-irq:
>> set IRQF_ONESHOT flag to ensure IRQ request") reads like it is
>> just there to be sure. So I don't know if it should also be set
>> here.
> 
> Looking at the changelog there the "we can't be sure" bit is that
> coccinelle couldn't follow the flags through from the caller to make
> sure that IRQF_ONESHOT is set so we're just oring it in 
> unconditionally.

So it is correct that IRQF_ONESHOT is also set in the driver which is
using regmap_add_irq_chip(), right?

-michael
