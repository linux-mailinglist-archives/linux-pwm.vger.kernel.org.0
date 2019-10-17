Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32EEDB833
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 22:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436862AbfJQUTn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 16:19:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38077 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQUTn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 16:19:43 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iLCFI-0001w9-W3; Thu, 17 Oct 2019 22:19:40 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iLCFG-0004sL-SK; Thu, 17 Oct 2019 22:19:38 +0200
Date:   Thu, 17 Oct 2019 22:19:38 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Adam Ford <aford173@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
Message-ID: <20191017201938.vhndval463ynmyfu@pengutronix.de>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
 <4f9594e5-f99b-f17d-531a-37d4c4161203@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f9594e5-f99b-f17d-531a-37d4c4161203@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 12:59:20PM +0200, Michal Vokáč wrote:
> On 17. 10. 19 11:48, Michal Vokáč wrote:
> > On 17. 10. 19 10:10, Uwe Kleine-König wrote:
> > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > > pwm_get_state() return the last implemented state")) changed the
> > > semantic of pwm_get_state() and disclosed an (as it seems) common
> > > problem in lowlevel PWM drivers. By not relying on the period and duty
> > > cycle being retrievable from a disabled PWM this type of problem is
> > > worked around.
> > > 
> > > Apart from this issue only calling the pwm_get_state/pwm_apply_state
> > > combo once is also more effective.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > > 
> > > There are now two reports about 01ccf903edd6 breaking a backlight. As
> > > far as I understand the problem this is a combination of the backend pwm
> > > driver yielding surprising results and the pwm-bl driver doing things
> > > more complicated than necessary.
> > > 
> > > So I guess this patch works around these problems. Still it would be
> > > interesting to find out the details in the imx driver that triggers the
> > > problem. So Adam, can you please instrument the pwm-imx27 driver to
> > > print *state at the beginning of pwm_imx27_apply() and the end of
> > > pwm_imx27_get_state() and provide the results?
> > > 
> > > Note I only compile tested this change.
> > 
> > Hi Uwe,
> > I was just about to respond to the "pwm_bl on i.MX6Q broken on 5.4-RC1+"
> > thread that I have a similar problem when you submitted this patch.
> > 
> > So here are my few cents:
> 
> Once again with updated and more detailed debug messages.
> 
> > My setup is as follows:
> >   - imx6dl-yapp4-draco with i.MX6Solo
> >   - backlight is controlled with inverted PWM signal
> >   - max brightness level = 32, default brightness level set to 32 in DT.
> > 
> > 1. Almost correct backlight behavior before 01ccf903edd6 ("pwm: Let
> >     pwm_get_state() return the last implemented state):
> > 
> >   - System boots to userspace and backlight is enabled all the time from
> >     power up.
> > 
>     -  $ dmesg | grep pwm_
>       [    1.761546] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
>       [    5.012352] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
>       [    5.021143] pwm_imx27_apply: period: 500000, duty: 500000, polarity: 1, enabled: 0
>       [    5.030182] pwm_imx27_apply: period: 500000, duty: 500000, polarity: 1, enabled: 1
> > 
> >   - $ cat brightness
> >     32
> > 
> >   - $ echo 32 > brightness # nothing happens, max. brightness
> > 
> >   - $ echo 1 > brightness # backlight goes down to lowest level
>       [   93.976354] pwm_imx27_apply: period: 500000, duty: 7843, polarity: 1, enabled: 1
> > 
> >   - $ echo 0 > brightness # backlight goes up to max. level, this is
> >                           # problem of the inverted PWM on i.MX we attempted
> >                           # to solve some time ago.
>       [  115.496350] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
> > 
> > 2. Backlight behavior on v5.4-rc3:
> > 
> >   - System boots to userspace and backlight is enabled all the time from
> >     power up.
> > 
>     - $ dmesg | grep pwm_
>       [    1.774071] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
>       [    5.003961] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
>       [    5.012649] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
>       [    5.021694] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 0
>       [    5.030732] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
>       [    5.039643] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 1
>       [    5.049605] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 1
> > 
> >   - $ cat brightness
> >     32
> > 
> >   - $ echo 32 > brightness # backlight goes down
>       [  707.946970] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 1
>       [  707.958551] pwm_imx27_get_state: period: 992970, duty: 992970, polarity: 0, enabled: 1
> > 
> >   - $ echo 1 > brightness # backlight goes up to high level
>       [  757.516845] pwm_imx27_apply: period: 992970, duty: 15576, polarity: 0, enabled: 1
>       [  757.528438] pwm_imx27_get_state: period: 992970, duty: 15576, polarity: 0, enabled: 1
> > 
> >   - $ echo 0 > brightness # backlight goes up to highest level
>       [  783.386838] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 0
>       [  783.398025] pwm_imx27_get_state: period: 496485, duty: 0, polarity: 0, enabled: 0
> > 
> > So the behavior is clearly inverted to how it worked prior to 01ccf903edd6
> > with the weird exception that the initial brightness level 32 is
> > not applied.
> > 
> > 3. Backlight behavior on v5.4-rc3 + this patch:
> > 
> >   - System boots with backlight enabled. In the middle of kernel boot
> >     backlight is disabled.
> > 
> >   - $ dmesg | grep state
>       [    1.773099] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
>       [    5.002532] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
>       [    5.011263] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0

Here is another corner case: pwm_imx27_apply doesn't even set polarity
in hardware if .enabled is false. This way .polarity is lost as
obviously the wrong setting is returned by pwm_get_state() later.

I didn't check in detail, but at least atmel, atmel-hlcdc, fsl-ftm,
stm32 and stm32-lp seem to suffer from the same problem.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
