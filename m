Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 759DB8B905
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Aug 2019 14:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfHMMrq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Aug 2019 08:47:46 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56672 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHMMrp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Aug 2019 08:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565700463; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lx31O8tJ3MpsZnkr36QsYoIlok1hh9lfS2ERrFOI00A=;
        b=et0ve3fI65fxbRAI0VgSizAYH98o1W8FcsdDdyRu5Do23bYeEw0CAzDDmJZb8/a59DYPCF
        UsNPA1rqwtQx0SeKGlKsN0oA11K0BOf7OZUhhgUmXXE9sXeWmnE+5KHP4FDrzXysbYpBB7
        WvCbEAssjilU4P1QCxIMDM9U6V7ukvQ=
Date:   Tue, 13 Aug 2019 14:47:28 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Stephen Boyd <sboyd@kernel.org>
Message-Id: <1565700448.1856.2@crapouillou.net>
In-Reply-To: <20190813123331.m4ttfhcgt6wyrcfi@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
        <20190809123031.24219-5-paul@crapouillou.net>
        <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
        <1565370885.2091.2@crapouillou.net>
        <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
        <1565642590.2007.1@crapouillou.net>
        <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
        <1565648183.2007.3@crapouillou.net>
        <20190813052726.g37upws5rlvrszc4@pengutronix.de>
        <1565694066.1856.1@crapouillou.net>
        <20190813123331.m4ttfhcgt6wyrcfi@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le mar. 13 ao=FBt 2019 =E0 14:33, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=
=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> On Tue, Aug 13, 2019 at 01:01:06PM +0200, Paul Cercueil wrote:
>>  Le mar. 13 ao=FBt 2019 =E0 7:27, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=
=3D
>>  <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > [adding Stephen Boyd to Cc]
>>  >
>>  > On Tue, Aug 13, 2019 at 12:16:23AM +0200, Paul Cercueil wrote:
>>  > > Le lun. 12 ao=FBt 2019 =E0 23:48, Uwe Kleine-K=F6nig a =E9crit :
>>  > > > On Mon, Aug 12, 2019 at 10:43:10PM +0200, Paul Cercueil wrote:
>>  > > > > Le lun. 12 ao=FBt 2019 =E0 8:15, Uwe Kleine-K=F6nig a =E9crit :
>>  > > > > > On Fri, Aug 09, 2019 at 07:14:45PM +0200, Paul Cercueil=20
>> wrote:
>>  > > > > > > Le ven. 9 ao=FBt 2019 =E0 19:05, Uwe Kleine-K=F6nig a=20
>> =E9crit :
>>  > > > > > > > On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul=20
>> Cercueil wrote:
>>  > > > > > > > > [...]
>>  > > > > > > > >  +	/* Reset the clock to the maximum rate, and=20
>> we'll reduce it if needed */
>>  > > > > > > > >  +	ret =3D clk_set_max_rate(clk, parent_rate);
>>  > > > > > > >
>>  > > > > > > > What is the purpose of this call? IIUC this limits=20
>> the allowed range of
>>  > > > > > > > rates for clk. I assume the idea is to prevent other=20
>> consumers to change
>>  > > > > > > > the rate in a way that makes it unsuitable for this=20
>> pwm. But this only
>>  > > > > > > > makes sense if you had a notifier for clk changes,=20
>> doesn't it? I'm
>>  > > > > > > > confused.
>>  > > > > > >
>>  > > > > > > Nothing like that. The second call to=20
>> clk_set_max_rate() might have set
>>  > > > > > > a maximum clock rate that's lower than the parent's=20
>> rate, and we want to
>>  > > > > > > undo that.
>>  > > > > >
>>  > > > > > I still don't get the purpose of this call. Why do you=20
>> limit the clock
>>  > > > > > rate at all?
>>  > > > >
>>  > > > > As it says below, we "limit the clock to a maximum rate=20
>> that still gives
>>  > > > > us a period value which fits in 16 bits". So that the=20
>> computed hardware
>>  > > > > values won't overflow.
>>  > > >
>>  > > > But why not just using clk_set_rate? You want to have the=20
>> clock running
>>  > > > at a certain rate, not any rate below that certain rate,=20
>> don't you?
>>  > >
>>  > >  I'll let yourself answer yourself:
>>  > >  https://patchwork.ozlabs.org/patch/1018969/
>>  >
>>  > In that thread I claimed that you used clk_round_rate wrongly,=20
>> not that
>>  > you should use clk_set_max_rate(). (The claim was somewhat=20
>> weakend by
>>  > Stephen, but still I think that clk_round_rate is the right=20
>> approach.)
>>=20
>>  Well, you said that I shouln't rely on the fact that=20
>> clk_round_rate() will
>>  round down. That completely defeats the previous algorithm. So=20
>> please tell
>>  me how to use it correctly, because I don't see it.
>=20
> Using clk_round_rate correctly without additional knowledge is hard.=20
> If
> you assume at least some sane behaviour you'd still have to call it
> multiple times. Assuming maxrate is the maximal rate you can handle
> without overflowing your PWM registers you have to do:
>=20
> 	rate =3D maxrate;
> 	rounded_rate =3D clk_round_rate(clk, rate);
> 	while (rounded_rate > rate) {
> 		if (rate < rounded_rate - rate) {
> 			/*
> 			 * clk doesn't support a rate smaller than
> 			 * maxrate (or the round_rate callback doesn't
> 			 * round consistently).
> 			 */
> 			 return -ESOMETHING;
> 		}
> 		rate =3D rate - (rounded_rate - rate)
> 		rounded_rate =3D clk_round_rate(clk, rate);
> 	}
>=20
> 	return rate;
>=20
> Probably it would be sensible to put that in a function provided by=20
> the
> clk framework (maybe call it clk_round_rate_down and maybe with
> additional checks).

clk_round_rate_down() has been refused multiple times in the past for=20
reasons that Stephen can explain.


>=20
>>  I came up with a much smarter alternative, that doesn't rely on the=20
>> rounding
>>  method of clk_round_rate, and which is better overall (no loop=20
>> needed). It
>>  sounds to me like you're bashing the code without making the effort=20
>> to
>>  understand what it does.
>>=20
>>  Thierry called it a "neat trick"
>>  (https://patchwork.kernel.org/patch/10836879/) so it cannot be as=20
>> bad as you
>>  say.
>=20
> Either that or Thierry failed to see the downside. The obvious=20
> downside
> is that once you set the period to something long (and so the clk was
> limited to a small frequency) you never make the clock any faster
> afterwards.

Read the algorithm again.


>=20
> Also I wonder how clk_set_max_rate() is supposed to be used like that=20
> or
> if instead some work should be invested to make it easier for clk
> consumers to use clk_round_rate() (e.g. by providing helper functions
> like the above). Stephen, can you shed some light into this?
>=20
>>  > The upside of clk_round_rate is that it allows you to test for the
>>  > capabilities of the clock without actually changing it before you=20
>> found
>>  > a setting you consider to be good.
>>=20
>>  I know what clk_round_rate() is for. But here we don't do=20
>> trial-and-error to
>>  find the first highest clock rate that works, we compute the=20
>> maximum clock
>>  we can use and limit the clock rate to that.
>>=20
>>  >
>>  > >  It's enough to run it below a certain rate, yes. The actual=20
>> rate
>>  > > doesn't
>>  > >  actually matter that much.
>>  >
>>  > 1 Hz would be fine? I doubt it.
>>=20
>>  We use the highest possible clock rate. We wouldn't use 1 Hz unless=20
>> it's the
>>  highest clock rate available.
>=20
> That's wrong. If the clk already runs at 1 Hz and you call
> clk_set_max_rate(rate, somethingincrediblehigh); it still runs at 1 Hz
> afterwards. (Unless I missed something.)

You missed something. I reset the max rate to the parent clock's rate=20
at the beginning of the algorithm. It works just fine.


>=20
>>  > > > >  E.g. if at a rate of 12 MHz your computed hardware value=20
>> for the period
>>  > > > >  is 0xf000, then at a rate of 24 MHz it won't fit in 16=20
>> bits. So the clock
>>  > > > >  rate must be reduced to the highest possible that will=20
>> still give you a
>>  > > > >  < 16-bit value.
>>  > > > >
>>  > > > >  We always want the highest possible clock rate that works,=20
>> for the sake of
>>  > > > >  precision.
>>  > > >
>>  > > > This is dubious; but ok to keep the driver simple. (Consider=20
>> a PWM that
>>  > > > can run at i MHz for i in [1, .. 30]. If a period of 120 ns=20
>> and a duty
>>  > > > cycle of 40 ns is requested you can get an exact match with=20
>> 25 MHz, but
>>  > > > not with 30 MHz.)
>>  > >
>>  > > The clock rate is actually (parent_rate >> (2 * x) )
>>  > > for x =3D 0, 1, 2, ...
>>  > >
>>  > > So if your parent_rate is 30 MHz the next valid one is 7.5 MHz,=20
>> and the
>>  > > next one is 1.875 MHz. It'd be very unlikely that you get a=20
>> better match at
>>  > > a lower clock.
>>  >
>>  > If the smaller freqs are all dividers of the fastest that's fine.=20
>> Please
>>  > note in a code comment that you're assuming this.
>>=20
>>  No, I am not assuming this. The current driver just picks the=20
>> highest clock
>>  rate that works. We're not changing the behaviour here.
>=20
> But you hide it behind clk API functions that don't guarantee this
> behaviour. And even if it works for you it might not for the next=20
> person
> who copies your code to support another hardware.

Again, I'm not *trying* to guarantee this behaviour.


>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |

=

