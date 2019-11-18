Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABA1006B3
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 14:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKRNnF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 08:43:05 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50348 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfKRNnF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 08:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574084582; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nv4c7b/VT1Qmp5FKMYjEz/m1ECdlwRjOHA4Ocl+2ptw=;
        b=WMf0u/GQ3KniECf/8SwYXobL09aAfJoaNGi4OYbWXe/vrPT42kubSsezGh+M0hZRXUka+5
        O73hjeLP6vcZTlRrvkoAUjsCH6Gjd4tq5IGaxDdfvKbjvfVvydiE6p9/UArgakKOb9Vgj4
        hmW7ZEP4zCvjfksQ1JSzq4QudGieyrY=
Date:   Mon, 18 Nov 2019 14:42:54 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] pwm: jz4740: Use clocks from TCU driver
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>, kernel@pengutronix.de
Message-Id: <1574084574.3.1@crapouillou.net>
In-Reply-To: <20191118111933.vipfycc2j7j6esb7@pengutronix.de>
References: <20191116173613.72647-1-paul@crapouillou.net>
        <20191116173613.72647-2-paul@crapouillou.net>
        <20191117202028.4chgjv2kulyyq2eu@pengutronix.de>
        <1574031523.3.0@crapouillou.net>
        <20191118071538.46egokrswvjxdvfp@pengutronix.de>
        <1574074556.3.0@crapouillou.net>
        <20191118111933.vipfycc2j7j6esb7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,


Le lun., nov. 18, 2019 at 12:19, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> On Mon, Nov 18, 2019 at 11:55:56AM +0100, Paul Cercueil wrote:
>>  Le lun., nov. 18, 2019 at 08:15, Uwe Kleine-K=F6nig
>>  <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > On Sun, Nov 17, 2019 at 11:58:43PM +0100, Paul Cercueil wrote:
>>  > >  Le dim., nov. 17, 2019 at 21:20, Uwe Kleine-K=F6nig
>>  > >  <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > >  > On Sat, Nov 16, 2019 at 06:36:11PM +0100, Paul Cercueil=20
>> wrote:
>>  > >  > >   struct jz4740_pwm_chip {
>>  > >  > >   	struct pwm_chip chip;
>>  > >  > >  -	struct clk *clk;
>>  > >  >
>>  > >  > What is the motivation to go away from this approach to=20
>> store the
>>  > > clock?
>>  > >
>>  > >  It's actually not the same clock. Instead of obtaining "ext"=20
>> clock
>>  > > from the
>>  > >  probe, we obtain "timerX" clocks (X being the PWM channel)=20
>> from the
>>  > > request
>>  > >  callback.
>>  >
>>  > Before you used driver data and container_of to get it, now you=20
>> used
>>  > pwm_set_chip_data. I wondered why you changed the approach to=20
>> store
>>  > data. That the actual data is different now is another thing (and
>>  > obviously ok).
>>=20
>>  Thierry suggested it: https://lkml.org/lkml/2019/3/4/486
>=20
> If you motivate that in the commit log (preferably with a better
> rationale than "Thierry suggested it") that's fine for. (Do I claim=20
> now
> without having read the rationale :-)

I don't really have a better rationale. The alternative was to have a=20
"struct clk[NB_PWMS];" in the struct jz4740_pwm_chip, so this is=20
arguably better. I'm not sure it's worth mentioning in the commit=20
message, is it?


>>  > >  > >   static void jz4740_pwm_free(struct pwm_chip *chip,=20
>> struct pwm_device *pwm)
>>  > >  > >   {
>>  > >  > >  +	struct clk *clk =3D pwm_get_chip_data(pwm);
>>  > >  > >  +
>>  > >  > >   	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
>>  > >  >
>>  > >  > What is the purpose of this call? I would have expected that=20
>> all these
>>  > >  > would go away when converting to the clk stuff?!
>>  > >
>>  > >  Some go away in patch [1/3] as they are clock-related, this=20
>> one will go away
>>  > >  in patch [2/3] when the driver is converted to use regmap.
>>  >
>>  > I'd like to understand what it does. Judging from the name I=20
>> expect this
>>  > is somehow related to the clock stuff and so I wonder if the=20
>> conversion
>>  > to the clk API is as complete as it should be.
>>=20
>>  It clears the PWM channel's CTRL register. That's the register used=20
>> for
>>  instance to enable the PWM function of a TCU channel.
>=20
> OK, so this is a register in a different register range than the PWM
> related registers to set duty and period, right? Looking at the code,
> this register has a bit to enable PWM mode and other than that bit
> fields to tune the clock feeding the PWM counters, right?

They are actually all in the same register range. Each channel has 4=20
32-bit registers, the first one is the CTRL (aka. TCSR) register which=20
is written to here. The following two configure the duty/period values,=20
the last one is the counter. The 'timer enable' bit is however in the=20
global TCU registers area.

The clock bits of the TCSRs registers (including the TCSR registers of=20
the watchdog and 64-bit OS timer) are controlled by the clocks driver.=20
All register accesses are properly handled thanks to regmap, that we=20
add in patch [2/3].


> This probably explains my resistance because such a setup if really=20
> hard
> to map to nice code. At least the "PWM enable" bit doesn't fit the clk
> abstraction, no good idea here. Maybe it's easier and more straight
> forward to not wrap that register in a clock driver and only use a clk
> for the parent? What is the motivation to convert this piece of=20
> hardware
> to a clk driver? Or abstract it as a proper clk and provide a function
> to enable PWM mode for channel X?

The motivation behind converting it to a clocks driver, is that it's=20
not only used for PWM, but for system timers, the watchdog, and the=20
64-bit OS timer.

There is some overview of the TCU hardware here:=20
linux/Documentation/mips/ingenic-tcu.rst (and yes, that hardware is a=20
mess).

All the bits have been merged or accepted upstream minus the OST driver=20
which is still under review, and this patchset.


>>  > >  > >  -	jz4740_timer_stop(pwm->hwpwm);
>>  > >  > >  +	clk_disable_unprepare(clk);
>>  > >  > >  +	clk_put(clk);
>>  > >  > >   }
>>  > >  > >
>>  > >  > >   static int jz4740_pwm_enable(struct pwm_chip *chip,=20
>> struct
>>  > > pwm_device *pwm)
>>  > >  > >  @@ -91,17 +110,21 @@ static int jz4740_pwm_apply(struct
>>  > > pwm_chip *chip, struct pwm_device *pwm,
>>  > >  > >   			    const struct pwm_state *state)
>>  > >  > >   {
>>  > >  > >   	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>  > >  > >  +	struct clk *clk =3D pwm_get_chip_data(pwm),
>>  > >  > >  +		   *parent_clk =3D clk_get_parent(clk);
>>  > >  > >  +	unsigned long rate, period, duty;
>>  > >  > >   	unsigned long long tmp;
>>  > >  > >  -	unsigned long period, duty;
>>  > >  > >   	unsigned int prescaler =3D 0;
>>  > >  > >   	uint16_t ctrl;
>>  > >  > >
>>  > >  > >  -	tmp =3D (unsigned long long)clk_get_rate(jz4740->clk) *
>>  > > state->period;
>>  > >  > >  +	rate =3D clk_get_rate(parent_clk);
>>  > >  >
>>  > >  > Why is it the parent's rate that is relevant here?
>>  > >
>>  > >  We calculate the divider to be used for the "timerX" clock, so=20
>> we
>>  > > need to
>>  > >  know the parent clock.
>>  >
>>  > Then the approach here is wrong. You should not assume anything=20
>> about
>>  > the internal details of the clock, that's the task of the clock=20
>> driver.
>>  > As a consumer of the clock just request a rate (or use=20
>> clk_round_rate to
>>  > find a good setting first) and use that.
>>=20
>>  Totally agreed. I wanted to do that, but you were fighting tooth=20
>> and nails
>>  against my patch "Improve algorithm of clock calculation", remember?
>=20
> No, I don't, but I looked that up :-) And I fighted because I thought
> the clk API isn't used properly (and I think your problem is that the
> clk API as is today doesn't give you what you want, so there is more
> work to do on the clk side of the problem).

That's a question of point of view, really. I need to specify the=20
maximum clock rate that still gives me a valid value, the clk API gives=20
me clk_set_max_rate(). Doesn't look like I'm doing something out of=20
bounds.

> The conceptual problem I see is that currently the code uses some
> internal knowledge about how this timer clock works but as soon as you
> use the clk abstraction it's wrong to use such internal knowledge.

Well, this patch is still a step in the right direction. I too would=20
like to see a better solution, but I don't want to hold it until we fix=20
the problem mentioned above. Right now jz4740-pwm is broken upstream=20
(incompatible with the documented DT bindings) and that's something I=20
want fixed ASAP, hence this reduced patchset.

Best regards,
-Paul

=

