Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE1DB7C5
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391217AbfJQToG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 15:44:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34095 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfJQToG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 15:44:06 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iLBgr-0006ya-5S; Thu, 17 Oct 2019 21:44:05 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iLBgq-0003XT-95; Thu, 17 Oct 2019 21:44:04 +0200
Date:   Thu, 17 Oct 2019 21:44:04 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
Message-ID: <20191017194404.vvjfgt2wdrfoq7l2@pengutronix.de>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
 <20191017101116.3d5okxmto5coecad@pengutronix.de>
 <20191017111131.GB3122066@ulmo>
 <20191017120917.fcb7x4fq4tbl2iat@pengutronix.de>
 <20191017125932.GB3768303@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017125932.GB3768303@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Thu, Oct 17, 2019 at 02:59:32PM +0200, Thierry Reding wrote:
> On Thu, Oct 17, 2019 at 02:09:17PM +0200, Uwe Kleine-König wrote:
> > On Thu, Oct 17, 2019 at 01:11:31PM +0200, Thierry Reding wrote:
> > > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > > index ae11d8577f18..4113d5cd4c62 100644
> > > --- a/drivers/pwm/pwm-imx27.c
> > > +++ b/drivers/pwm/pwm-imx27.c
> > > [...]
> > 
> > I wonder if it would be more sensible to do this in the pwm core
> > instead. Currently there are two drivers known with this problem. I
> > wouldn't be surprised if there were more.
> 
> I've inspected all the drivers and didn't spot any beyond cros-ec and
> i.MX that have this problem.

I took a look, too, and I'd say pwm-atmel.c, pwm-imx-tpm.c, pwm-lpss.c,
pwm-meson.c, pwm-sifive.c, pwm-sprd.c and pwm-stm32-lp.c are affected.

> So the core would have to rely on state->duty_cycle that is passed in,
> but then the offending commit becomes useless because the whole point
> was to return the state as written to hardware (rather than the
> software state which was being returned before that patch).

I like allowing lowlevel drivers to implement the .enabled = false case
lazily as there is little value in calculating the needed register
values for a request like

	.duty_cycle = X, .period = Y, .enabled = false

even if the next request might be

	.duty_cycle = X, .period = Y, .enabled = true

because quite likely the same calculation is done for the second request
again and there is no benefit to save X and Y in the hardware (or the
driver if the hardware is incapable) apart from returning it to a
consumer who maybe even doesn't care because these values don't tell
anything at all about the implemented wave form and so it seems natural
to me that the lowlevel driver shouldn't care.

> > If we want to move clients to not rely on .period and .duty_cycle for a
> > disabled PWM (do we?) a single change in the core is also beneficial
> > compared to fixing several lowlevel drivers.
> 
> These are really two orthogonal problems. We don't currently consider
> enabled = 0 to be equivalent to duty_cycle = 0 at an API level. I'm not
> prepared to do that at this point in the release cycle either.

Yeah, I fully agree that we should not do that now. Given the number of
affected drivers I opt for reverting and retrying again more carefully
later.
 
> What this here has shown is that we have at least two drivers that don't
> behave the way they are supposed to according to the API and they break
> consumers. If they break for pwm-backlight, it's possible that they will
> break for other consumers as well. So the right thing to do is fix the
> two drivers that are broken.

In my eyes shifting the definition of "expected behaviour" and adapting
the core code accordingly to make this invisible to consumers is also a
viable option. Also shifting the definition and adapt all consumers not
to rely on the old behaviour is fine. But as above, this is not a good
idea at the current point in time.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
