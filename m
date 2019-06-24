Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4800517FF
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2019 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfFXQGS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 12:06:18 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36426 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFXQGS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 12:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561392374; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MzBEvnVeaj/Jo8SGi3r3KmrrKH3BJWvGTw8dpWQZ7I=;
        b=CokspySgvH/Rs9efc9znexgsx2vE4giXXTNqSeRtIMIAgdrl7mBlEpPLVzOGbYVc2F8SeQ
        P+5ZDlxeYykmlwJYrVn2cEsqPsgUedQI0hOGoKBwUZSICBSHwK79+DNOqcluFikLLhQ5zI
        GIuSQc7E0wU/dW2WgJUwAAoVvCOGy50=
Date:   Mon, 24 Jun 2019 18:06:07 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1561392367.20436.2@crapouillou.net>
In-Reply-To: <20190624154628.rq7ykltms7ovhawx@holly.lan>
References: <20190522163428.7078-1-paul@crapouillou.net>
        <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
        <20190621135608.GB11839@ulmo> <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
        <1561386717.20436.0@crapouillou.net>
        <20190624154628.rq7ykltms7ovhawx@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le lun. 24 juin 2019 =E0 17:46, Daniel Thompson=20
<daniel.thompson@linaro.org> a =E9crit :
> On Mon, Jun 24, 2019 at 04:31:57PM +0200, Paul Cercueil wrote:
>>=20
>>=20
>>  Le lun. 24 juin 2019 =E0 13:28, Daniel Thompson=20
>> <daniel.thompson@linaro.org> a
>>  =E9crit :
>>  > On Fri, Jun 21, 2019 at 03:56:08PM +0200, Thierry Reding wrote:
>>  > >  On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson=20
>> wrote:
>>  > >  > On 22/05/2019 17:34, Paul Cercueil wrote:
>>  > >  > > When the driver probes, the PWM pin is automatically=20
>> configured
>>  > > to its
>>  > >  > > default state, which should be the "pwm" function.
>>  > >  >
>>  > >  > At which point in the probe... and by who?
>>  > >
>>  > >  The driver core will select the "default" state of a device=20
>> right
>>  > > before
>>  > >  calling the driver's probe, see:
>>  > >
>>  > >  	drivers/base/pinctrl.c: pinctrl_bind_pins()
>>  > >
>>  > >  which is called from:
>>  > >
>>  > >  	drivers/base/dd.c: really_probe()
>>  > >
>>  >
>>  > Thanks. I assumed it would be something like that... although=20
>> given
>>  > pwm-backlight is essentially a wrapper driver round a PWM I=20
>> wondered why
>>  > the pinctrl was on the backlight node (rather than the PWM node).
>>  >
>>  > Looking at the DTs in the upstream kernel it looks like ~20% of=20
>> the
>>  > backlight drivers have pinctrl on the backlight node. Others=20
>> presumable
>>  > have none or have it on the PWM node (and it looks like support=20
>> for
>>  > sleeping the pins is *very* rare amoung the PWM drivers).
>>=20
>>  If your PWM driver has more than one channel and has the pinctrl=20
>> node, you
>>  cannot fine-tune the state of individual pins. They all share the=20
>> same
>>  state.
>=20
> Good point. Thanks.
>=20
>=20
>>  > >  > > However, at this
>>  > >  > > point we don't know the actual level of the pin, which may=20
>> be
>>  > > active or
>>  > >  > > inactive. As a result, if the driver probes without=20
>> enabling the
>>  > >  > > backlight, the PWM pin might be active, and the backlight=20
>> would
>>  > > be
>>  > >  > > lit way before being officially enabled.
>>  > >  > >
>>  > >  > > To work around this, if the probe function doesn't enable=20
>> the
>>  > > backlight,
>>  > >  > > the pin is set to its sleep state instead of the default=20
>> one,
>>  > > until the
>>  > >  > > backlight is enabled. Whenk the backlight is disabled, the=20
>> pin
>>  > > is reset
>>  > >  > > to its sleep state.
>>  > >  > Doesn't this workaround result in a backlight flash between
>>  > > whatever enables
>>  > >  > it and the new code turning it off again?
>>  > >
>>  > >  Yeah, I think it would. I guess if you're very careful on how=20
>> you
>>  > > set up
>>  > >  the device tree you might be able to work around it. Besides=20
>> the
>>  > > default
>>  > >  and idle standard pinctrl states, there's also the "init"=20
>> state. The
>>  > >  core will select that instead of the default state if=20
>> available.
>>  > > However
>>  > >  there's also pinctrl_init_done() which will try again to=20
>> switch to
>>  > > the
>>  > >  default state after probe has finished and the driver didn't=20
>> switch
>>  > > away
>>  > >  from the init state.
>>  > >
>>  > >  So you could presumably set up the device tree such that you=20
>> have
>>  > > three
>>  > >  states defined: "default" would be the one where the PWM pin is
>>  > > active,
>>  > >  "idle" would be used when backlight is off (PWM pin inactive)=20
>> and
>>  > > then
>>  > >  another "init" state that would be the same as "idle" to be=20
>> used
>>  > > during
>>  > >  probe. During probe the driver could then switch to the "idle"
>>  > > state so
>>  > >  that the pin shouldn't glitch.
>>  > >
>>  > >  I'm not sure this would actually work because I think the way=20
>> that
>>  > >  pinctrl handles states both "init" and "idle" would be the same
>>  > > pointer
>>  > >  values and therefore pinctrl_init_done() would think the driver
>>  > > didn't
>>  > >  change away from the "init" state because it is the same=20
>> pointer
>>  > > value
>>  > >  as the "idle" state that the driver selected. One way to work=20
>> around
>>  > >  that would be to duplicate the "idle" state definition and
>>  > > associate one
>>  > >  instance of it with the "idle" state and the other with the=20
>> "init"
>>  > >  state. At that point both states should be different (different
>>  > > pointer
>>  > >  values) and we'd get the init state selected automatically=20
>> before
>>  > > probe,
>>  > >  select "idle" during probe and then the core will leave it=20
>> alone.
>>  > > That's
>>  > >  of course ugly because we duplicate the pinctrl state in DT,=20
>> but
>>  > > perhaps
>>  > >  it's the least ugly solution.
>>  > >  Adding Linus for visibility. Perhaps he can share some insight.
>>  >
>>  > To be honest I'm happy to summarize in my head as "if it flashes=20
>> then
>>  > it's not
>>  > a pwm_bl.c's problem" ;-).
>>=20
>>  It does not flash. But the backlight lits way too early, so we have=20
>> a 1-2
>>  seconds
>>  of "white screen" before the panel driver starts.
>=20
> That's the current behaviour.
>=20
> What I original asked about is whether a panel that was dark before=20
> the
> driver probes could end up flashing after the patch because it is
> activated pre-probe and only goes to sleep afterwards.
>=20
> Anyhow I got an answer; if it flashes after the patch then the problem
> does not originate in pwm_bl.c and is likely a problem with the=20
> handling
> of the pinctrl idel state (i.e. probably DT misconfiguration)
>=20
> So I think that just leaves my comment about the spurious sleep in the
> probe function.

The probe function calls backlight_update_status(), which then calls
pwm_backlight_power_off(), which returns early as pb->enabled is false.
So the pins are still in "default" (or "init") state after the call
to backlight_update_status().

-Paul

=

