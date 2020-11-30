Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B5E2C8603
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 14:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgK3N4L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 30 Nov 2020 08:56:11 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:46469 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgK3N4K (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Nov 2020 08:56:10 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 637D9440A96;
        Mon, 30 Nov 2020 15:55:28 +0200 (IST)
References: <c27a61d66a9ec4e52e0d1820ce9528ffa18ca539.1606743203.git.baruch@tkos.co.il>
 <20201130135130.rynozhii4yfxtmdh@pengutronix.de>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] gpio: mvebu: fix potential user-after-free on probe
In-reply-to: <20201130135130.rynozhii4yfxtmdh@pengutronix.de>
Date:   Mon, 30 Nov 2020 15:55:28 +0200
Message-ID: <87blffdk4v.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Nov 30 2020, Uwe Kleine-König wrote:
> On Mon, Nov 30, 2020 at 03:33:23PM +0200, Baruch Siach wrote:
>> When mvebu_pwm_probe() fails IRQ domain is not released. Move
>> mvebu_pwm_probe() before IRQ domain registration.
>
> And now if something with IRQ domain registration fails the pwm stuff
> isn't freed?

As far as I can see mvebu_pwm_probe() uses devres exclusively to
allocate resources.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
