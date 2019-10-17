Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38FDA99F
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfJQKLW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 06:11:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50449 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfJQKLW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 06:11:22 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iL2kY-0003Uf-Ew; Thu, 17 Oct 2019 12:11:18 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iL2kW-0001UO-UY; Thu, 17 Oct 2019 12:11:16 +0200
Date:   Thu, 17 Oct 2019 12:11:16 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Adam Ford <aford173@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
Message-ID: <20191017101116.3d5okxmto5coecad@pengutronix.de>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 11:48:08AM +0200, Michal Vokáč wrote:
> On 17. 10. 19 10:10, Uwe Kleine-König wrote:
> > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > pwm_get_state() return the last implemented state")) changed the
> > semantic of pwm_get_state() and disclosed an (as it seems) common
> > problem in lowlevel PWM drivers. By not relying on the period and duty
> > cycle being retrievable from a disabled PWM this type of problem is
> > worked around.
> > 
> > Apart from this issue only calling the pwm_get_state/pwm_apply_state
> > combo once is also more effective.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > There are now two reports about 01ccf903edd6 breaking a backlight. As
> > far as I understand the problem this is a combination of the backend pwm
> > driver yielding surprising results and the pwm-bl driver doing things
> > more complicated than necessary.
> > 
> > So I guess this patch works around these problems. Still it would be
> > interesting to find out the details in the imx driver that triggers the
> > problem. So Adam, can you please instrument the pwm-imx27 driver to
> > print *state at the beginning of pwm_imx27_apply() and the end of
> > pwm_imx27_get_state() and provide the results?
> > 
> > Note I only compile tested this change.
> 
> Hi Uwe,
> I was just about to respond to the "pwm_bl on i.MX6Q broken on 5.4-RC1+"
> thread that I have a similar problem when you submitted this patch.
> 
> So here are my few cents:
> 
> My setup is as follows:
>  - imx6dl-yapp4-draco with i.MX6Solo
>  - backlight is controlled with inverted PWM signal
>  - max brightness level = 32, default brightness level set to 32 in DT.
> 
> 1. Almost correct backlight behavior before 01ccf903edd6 ("pwm: Let
>    pwm_get_state() return the last implemented state):
> 
>  - System boots to userspace and backlight is enabled all the time from
>    power up.
> 
>    $ dmesg | grep state
>    [    1.763381] get state end: -1811360608, enabled: 0

What is -1811360608? When I wrote "print *state" above, I thought about
something like:

	pr_info("%s: period: %u, duty: %u, polarity: %d, enabled: %d",
		__func__, state->period, state->duty_cycle, state->polarity, state->enabled);

A quick look into drivers/pwm/pwm-imx27.c shows that this is another
driver that yields duty_cycle = 0 when the hardware is off.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
