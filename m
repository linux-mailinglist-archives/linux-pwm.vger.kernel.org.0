Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAED1A75F1
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2019 23:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfICVHn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Sep 2019 17:07:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46163 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICVHn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Sep 2019 17:07:43 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i5G1e-00029a-0Q; Tue, 03 Sep 2019 23:07:42 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i5G1c-0002Wp-HX; Tue, 03 Sep 2019 23:07:40 +0200
Date:   Tue, 3 Sep 2019 23:07:40 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     linux-pwm <linux-pwm@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v3 5/6] pwm: fsl-ftm: Don't update the state for the
 caller of pwm_apply_state()
Message-ID: <20190903210740.qgyvxxmsdg5dzaby@pengutronix.de>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
 <20190824153707.13746-6-uwe@kleine-koenig.org>
 <CAD=FV=X8kVU_zr69aKe-+GkAQh-tDwVf8tFogKve3s5O5ndF-g@mail.gmail.com>
 <20190902142709.wxrjsfzorozgeiuh@pengutronix.de>
 <CAD=FV=XFTuixKL-VBv-QObiO=Jg43i6W0enprLgXQ0U8=9C49A@mail.gmail.com>
 <20190903184800.2fmmvwyzbwbsaf6y@pengutronix.de>
 <CAD=FV=XOyayzv6N9Ky8m2ffXe4UzUijzrL8JCMZC3K+MEzaRFw@mail.gmail.com>
 <20190903201550.gxcyed5svtq33ev2@pengutronix.de>
 <CAD=FV=WjRiaNLJQJ25OeNSpY455H-ev8g3iZN24UXQtk3uXhtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WjRiaNLJQJ25OeNSpY455H-ev8g3iZN24UXQtk3uXhtA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Sep 03, 2019 at 01:50:27PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 3, 2019 at 1:15 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Tue, Sep 03, 2019 at 12:35:25PM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Tue, Sep 3, 2019 at 11:48 AM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Tue, Sep 03, 2019 at 09:54:37AM -0700, Doug Anderson wrote:
> > > > > On Mon, Sep 2, 2019 at 7:27 AM Uwe Kleine-König
> > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > On Fri, Aug 30, 2019 at 10:39:16AM -0700, Doug Anderson wrote:
> > > > > > > On Sat, Aug 24, 2019 at 8:37 AM Uwe Kleine-König <uwe@kleine-koenig.org> wrote:
> > > > > > > >
> > > > > > > > The pwm-fsl-ftm driver is one of only three PWM drivers which updates
> > > > > > > > the state for the caller of pwm_apply_state(). This might have
> > > > > > > > surprising results if the caller reuses the values expecting them to
> > > > > > > > still represent the same state.
> > > > > > > >
> > > > > > > > Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> > > > > > > > ---
> > > > > > > >  drivers/pwm/pwm-fsl-ftm.c | 4 ----
> > > > > > > >  1 file changed, 4 deletions(-)
> > > > > > >
> > > > > > > Presumably this patch could break something since the pwm-fsl-ftm
> > > > > > > driver doesn't appear to implement the get_state() function.  ...or
> > > > > > > did I miss it?
> > > > > >
> > > > > > I don't expect breakage. We have more than 50 pwm drivers and only three
> > > > > > of them made use of adapting the passed state. So unless you do
> > > > > > something special with the PWM (i.e. more than backlight, LED or fan
> > > > > > control) I don't think a consumer might care. But it might well be that
> > > > > > I miss something so feel free to prove me wrong.
> > > > >
> > > > > I don't have this hardware so I can't prove you wrong.  ...but
> > > > > presumably someone added the code to return the state on purpose?
> > > > >
> > > > > Maybe you could implement get_state() for this driver in your series?
> > > >
> > > > Sure, I could. But I don't have hardware either and so I'm not in a
> > > > better position than anybody else on this list.
> > > >
> > > > I suggest to apply as is during the merge window, and let affected
> > > > user report problems (or patches) if there really is an issue.
> > > > Guessing what people might suffer from and trying to cure this with
> > > > untested patches won't help I think.
> > >
> > > I suppose it's not up to me, but I would rather have a patch that
> > > attempts to keep things working like they did before rather than one
> > > that is known to change behavior.  Even worse is that your patch
> > > description doesn't mention this functionality change at all.
> >
> > I suggest to add
> >
> >         As the driver doesn't provide a .get_state() callback it is
> >         expected that this changes behaviour slightly as pwm_get_state()
> >         will yield the last set instead of the last implemented setting.
> >
> > to the commit log to fix this.
> >
> > > I will also note that not everyone does a deep test of all
> > > functionality during every kernel merge window.  ...so your change in
> > > functionality certain has a pretty high chance of remaining broken for
> > > a while.
> >
> > I don't expect any real breakage. The changed behaviour only affects
> > users of pwm_get_state() that is called after pwm_apply_state().
> >
> > > In addition if a PWM is used for something like a PWM
> > > regulator then subtle changes can cause totally non-obvious breakages,
> > > maybe adjusting regulators by a very small percentage.
> >
> > So for drivers/regulator/pwm-regulator.c this affects the .get_voltage()
> > call only. Note that .set_voltage() does call pwm_get_state() but
> > doesn't use the result. I don't see how my change would affect the
> > configuration written to the PWM registers when the PWM regulator driver
> > is its user. So if you want to convince me that the PWM regulator is one
> > of the potentially affected consumers, you have to work a bit harder.
> > :-)
> 
> Prior to your patch, pwm_apply_state() would call the ->apply()
> function, right?  That would modify the state.  Then pwm_apply_state()
> would store the state (after it had been modified) into pwm->state.
> All future calls to pwm_get_state() would return the modified state.
> 
> ...this means that the call to pwm_get_state() in
> pwm_regulator_get_voltage() would return the actual hardware state.
> 
> After your patch series pwm_get_state() will not return the actual
> hardware state for "pwm-fsl-ftm.c", it will return the state that was
> programmed.
> 
> While pwm_set_voltage() will not necessarily be affected, future calls
> to pwm_regulator_get_voltage() could be affected.  Unless you are
> asserting that 100% of the calls to pwm_get_voltage() cosmetic.
>
> 
> Please correct anything I got wrong there.

I think this is all true. The key question here is then: Who calls the
.get_voltage() callback and cares about the result? Yes, it changes a
few files in sysfs but apart from that?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
