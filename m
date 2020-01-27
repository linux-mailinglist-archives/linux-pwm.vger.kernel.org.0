Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024F2149F4B
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2020 08:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgA0Hl3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jan 2020 02:41:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34275 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgA0Hl3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jan 2020 02:41:29 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ivz1O-0006lk-Dr; Mon, 27 Jan 2020 08:41:22 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ivz1N-0002Se-EY; Mon, 27 Jan 2020 08:41:21 +0100
Date:   Mon, 27 Jan 2020 08:41:21 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 3/3] leds: pwm: don't set the brightness during .probe
Message-ID: <20200127074121.n2qawknactfjqvkr@pengutronix.de>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
 <20200124165409.12422-4-uwe@kleine-koenig.org>
 <20200126194236.GC2569@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200126194236.GC2569@labundy.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Jeff,

On Sun, Jan 26, 2020 at 07:42:39PM +0000, Jeff LaBundy wrote:
> My only concern here is whether or not there happen to be some hardware
> out in the world whose PWM-related registers power on to a random state
> and unknowingly depended on brightness being forced to zero.

This might happen, and is (AFAIK) the same for other LED drivers.

> The other folks on the thread probably have some better view into this,
> but I wonder if the safest option would be to adopt the "default-state"
> property from leds/common.txt, and only forgo the call to led_pwm_set()
> if the property is set to "keep".

I think it would be sane to add support for parsing the default-state
property to the LED core. I was surprised to learn that this for now is
only implemented in a few LED drivers.

> I did test this and can confirm that the LED's state prior to the driver
> being loaded is preserved. However as you've warned, the brightness read
> back from user space is zero and does not match the actual brightness of
> the LED.

That is something that the core should handle, too. If there is no
.get_brightness callback and 0 is assumed, calling .set_brightness to 0
to ensure a right assumption sounds like the right thing to me.
 
> Understanding that it's more work, I wonder if this patch is not safe if
> we don't also add a brightness_get callback in case there were any cases
> where user space makes some decisions based on brightness == 0?
> 
> At any rate this patch does what is advertised, and so:
> 
> Tested-by: Jeff LaBundy <jeff@labundy.com>

Thanks for your feedback.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
