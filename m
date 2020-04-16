Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9449A1ABBD8
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 10:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502995AbgDPI5A (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 04:57:00 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38605 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502875AbgDPI4D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 04:56:03 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E19F222F53;
        Thu, 16 Apr 2020 10:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1587027354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6knnTYd0SD0a2gjJU3xQbFJUgo1WzPpSFmhjfIQyUcY=;
        b=M9q2RMUFDQVW4SbouNkFNdJPzvQSvOQC+FhQtrDgr+5/mkydRI7TAhGXO0tbJzmPNNyyHX
        L7gLiTb5PDKWNrrSnrCdEZyt6jYVPk3HsLMtzmSAX0AXDADeVgSzEhGLRf7b5MFNZM8a6g
        TAZ0ODC6jxTAJEZd8Mh17RprqqBe0Lw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Apr 2020 10:55:46 +0200
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 11/16] gpio: add support for the sl28cpld GPIO
 controller
In-Reply-To: <CACRpkdbANL_W3gcTwue5VUCWT95boMXjFSqTeFDZvJ6iSeNpJg@mail.gmail.com>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-12-michael@walle.cc>
 <CACRpkdbANL_W3gcTwue5VUCWT95boMXjFSqTeFDZvJ6iSeNpJg@mail.gmail.com>
Message-ID: <46eb76699a76b3feedccc70f1d1da1de@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: E19F222F53
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         NEURAL_HAM(-0.00)[-0.402];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,baylibre.com,kernel.org,suse.com,roeck-us.net,linaro.org,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Linus,

Am 2020-04-16 10:34, schrieb Linus Walleij:
> Hi Michael,
> 
> this is looking good provided we can get the generic GPIO regmap
> helper reviewed and merged. Thanks!
> 
> On Thu, Apr 2, 2020 at 10:37 PM Michael Walle <michael@walle.cc> wrote:
> 
>> This adds support for the GPIO controller of the sl28 board management
>> controller. This driver is part of a multi-function device.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
>> +       depends on MFD_SL28CPLD
> 
> Apart from this depends it seems the patch is compile-time
> independent of the other patches

correct. There are no common mfd headers or something like that.

> so I'd suggest we just merge
> the generic regmap driver and this driver to the GPIO tree once
> we feel finished with them, optimistically assuming that the MFD
> driver will land and that we will not need any fundamental
> changes in the GPIO driver.
> 
> Worst case we have to revert the driver and that is no disaster.

Sure. One major thing I'm waiting for is the decision/new ideas on
how to handle the "register is not set or zero" problem, see the
other thread on the generic regmap gpio. Then I'd respin an update
of this whole series.

-michael
