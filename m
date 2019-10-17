Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE3DABDC
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405681AbfJQMTt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 08:19:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60153 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731634AbfJQMTt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 08:19:49 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iL4ks-00087g-Np; Thu, 17 Oct 2019 14:19:46 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iL4kr-0005Yu-SV; Thu, 17 Oct 2019 14:19:45 +0200
Date:   Thu, 17 Oct 2019 14:19:45 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Adam Ford <aford173@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
Message-ID: <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <20191017114727.fy5tg2kgi6mr2sei@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017114727.fy5tg2kgi6mr2sei@holly.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 12:47:27PM +0100, Daniel Thompson wrote:
> On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-König wrote:
> > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > pwm_get_state() return the last implemented state")) changed the
> > semantic of pwm_get_state() and disclosed an (as it seems) common
> > problem in lowlevel PWM drivers. By not relying on the period and duty
> > cycle being retrievable from a disabled PWM this type of problem is
> > worked around.
> > 
> > Apart from this issue only calling the pwm_get_state/pwm_apply_state
> > combo once is also more effective.
> 
> I'm only interested in the second paragraph here.
> 
> There seems to be a reasonable consensus that the i.MX27 and cros-ec
> PWM drivers should be fixed for the benefit of other PWM clients.
> So we make this change because it makes the pwm-bl better... not to
> work around bugs ;-).

That's fine, still I think it's fair to explain the motivation of
creating this patch.

> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index 746eebc411df..ddebd62b3978 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
> >  
> >  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> >  {
> > -	struct pwm_state state;
> > -
> > -	pwm_get_state(pb->pwm, &state);
> > -	if (!pb->enabled)
> > -		return;
> > -
> 
> Why remove the pb->enabled check? I thought that was there to ensure we
> don't mess up the regular reference counts.

I havn't looked yet, but I guess I have to respin. Expect a v2 later
today.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
