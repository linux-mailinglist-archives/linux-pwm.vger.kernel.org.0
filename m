Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0576DECB7
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 14:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfJUMsF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 08:48:05 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51266 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfJUMsF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 08:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1571662082; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mqgyNMMMmE6bZdq8PkkYyKK6oc32QyDMFnXa9hmBclE=;
        b=WqcvXFIsFJy4rgOmsnbWPO9NaojWFJ2RGIkv7G3lIxPXCJfTIGUA3MhAdw0slagdewx3bv
        8vx1Fo798VfsODcUcxcsx5akkSN09Ibf2fGqSFjBBATHvKq4dWN/6o/4oW18097MqYL1UJ
        WEeoUjYCORGKXRQ/blVBb/05zducaR8=
Date:   Mon, 21 Oct 2019 14:47:57 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1571662077.3.1@crapouillou.net>
In-Reply-To: <20190814173218.zhg4se3pppano5m3@pengutronix.de>
References: <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
        <1565642590.2007.1@crapouillou.net>
        <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
        <1565648183.2007.3@crapouillou.net>
        <20190813052726.g37upws5rlvrszc4@pengutronix.de>
        <1565694066.1856.1@crapouillou.net>
        <20190813123331.m4ttfhcgt6wyrcfi@pengutronix.de>
        <1565700448.1856.2@crapouillou.net>
        <20190813140903.rdwy7p3mhwetmlnt@pengutronix.de>
        <1565799035.1984.0@crapouillou.net>
        <20190814173218.zhg4se3pppano5m3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,


Le mer., ao=FBt 14, 2019 at 19:32, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> On Wed, Aug 14, 2019 at 06:10:35PM +0200, Paul Cercueil wrote:
>>  Le mar. 13 ao=FBt 2019 =E0 16:09, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig=
?=3D=20
>> a =E9crit :
>>  > On Tue, Aug 13, 2019 at 02:47:28PM +0200, Paul Cercueil wrote:
>>  > > Le mar. 13 ao=FBt 2019 =E0 14:33, Uwe Kleine-K=F6nig a =E9crit :
>>  > > > On Tue, Aug 13, 2019 at 01:01:06PM +0200, Paul Cercueil wrote:
>>  > > > > Well, you said that I shouln't rely on the fact that=20
>> clk_round_rate() will
>>  > > > > round down. That completely defeats the previous algorithm.=20
>> So please tell
>>  > > > > me how to use it correctly, because I don't see it.
>>  > > >
>>  > > > Using clk_round_rate correctly without additional knowledge=20
>> is hard. If
>>  > > > you assume at least some sane behaviour you'd still have to=20
>> call it
>>  > > > multiple times. Assuming maxrate is the maximal rate you can=20
>> handle
>>  > > > without overflowing your PWM registers you have to do:
>>  > > >
>>  > > > 	rate =3D maxrate;
>>  > > > 	rounded_rate =3D clk_round_rate(clk, rate);
>>  > > > 	while (rounded_rate > rate) {
>>  > > > 		if (rate < rounded_rate - rate) {
>>  > > > 			/*
>>  > > > 			 * clk doesn't support a rate smaller than
>>  > > > 			 * maxrate (or the round_rate callback doesn't
>>  > > > 			 * round consistently).
>>  > > > 			 */
>>  > > > 			 return -ESOMETHING;
>>  > > > 		}
>>  > > > 		rate =3D rate - (rounded_rate - rate)
>>  > > > 		rounded_rate =3D clk_round_rate(clk, rate);
>>  > > > 	}
>>  > > >
>>  > > > 	return rate;
>>  > > >
>>  > > > Probably it would be sensible to put that in a function=20
>> provided by the
>>  > > > clk framework (maybe call it clk_round_rate_down and maybe=20
>> with
>>  > > > additional checks).
>>  > >
>>  > >  clk_round_rate_down() has been refused multiple times in the=20
>> past for
>>  > >  reasons that Stephen can explain.
>>  >
>>  > I'd be really interested in these reasons as I think the clk=20
>> framework
>>  > should make it easy to solve common tasks related to clocks. And=20
>> finding
>>  > out the biggest supported rate not bigger than a given maxrate is
>>  > something I consider such a common task.
>>  >
>>  > The first hit I found when searching was
>>  > https://lkml.org/lkml/2010/7/14/260 . In there Stephen suggested=20
>> that
>>  > clk_round_rate with the current semantic is hardly useful and=20
>> suggested
>>  > clk_round_rate_up() and clk_round_rate_down() himself.
>>=20
>>  That's from 2010, though.
>=20
> If you have a better link please tell me.
>=20
>>  I agree that clk_round_rate_up() and clk_round_rate_down() should=20
>> exist.
>>  Even if they return -ENOSYS if it's not implemented for a given=20
>> clock
>>  controller.
>=20
> ack.
>=20
>>  > > > > I came up with a much smarter alternative, that doesn't=20
>> rely on the rounding
>>  > > > > method of clk_round_rate, and which is better overall (no=20
>> loop needed). It
>>  > > > > sounds to me like you're bashing the code without making=20
>> the effort to
>>  > > > > understand what it does.
>>  > > > >
>>  > > > > Thierry called it a "neat trick"
>>  > > > > (https://patchwork.kernel.org/patch/10836879/) so it cannot=20
>> be as bad as you
>>  > > > > say.
>>  > > >
>>  > > > Either that or Thierry failed to see the downside. The=20
>> obvious downside
>>  > > > is that once you set the period to something long (and so the=20
>> clk was
>>  > > > limited to a small frequency) you never make the clock any=20
>> faster
>>  > > > afterwards.
>>  > >
>>  > >  Read the algorithm again.
>>  >
>>  > I indeed missed a call to clk_set_rate(clk, parent_rate). I=20
>> thought I
>>  > grepped for clk_set_rate before claiming the code was broken.=20
>> Sorry.
>>  >
>>  > So I think the code works indeed, but it feels like abusing
>>  > clk_set_max_rate. So I'd like to see some words from Stephen=20
>> about this
>>  > procedure.
>>  >
>>  > Also I think this is kind of inelegant to set the maximal rate=20
>> twice. At
>>  > least call clk_set_max_rate only once please.
>>=20
>>  Ok. I can do that.
>=20
> I would still prefer to hear from Stephen about this approach. It=20
> seems
> wrong to have two different ways to achieve the same goal and my
> impression is that clk_round_rate is the function designed for this=20
> use
> case.

Stephen, any feedback?
I'm still stuck here.


>>  > > > > > > > > E.g. if at a rate of 12 MHz your computed hardware=20
>> value for the period
>>  > > > > > > > > is 0xf000, then at a rate of 24 MHz it won't fit in=20
>> 16 bits. So the clock
>>  > > > > > > > > rate must be reduced to the highest possible that=20
>> will still give you a
>>  > > > > > > > > < 16-bit value.
>>  > > > > > > > >
>>  > > > > > > > > We always want the highest possible clock rate that=20
>> works, for the sake of
>>  > > > > > > > > precision.
>>  > > > > > > >
>>  > > > > > > > This is dubious; but ok to keep the driver simple.>=20
>> (Consider a PWM that
>>  > > > > > > > can run at i MHz for i in [1, .. 30]. If a period of=20
>> 120 ns and a duty
>>  > > > > > > > cycle of 40 ns is requested you can get an exact=20
>> match with 25 MHz, but
>>  > > > > > > > not with 30 MHz.)
>>  > > > > > >
>>  > > > > > > The clock rate is actually (parent_rate >> (2 * x) )
>>  > > > > > > for x =3D 0, 1, 2, ...
>>  > > > > > >
>>  > > > > > > So if your parent_rate is 30 MHz the next valid one is=20
>> 7.5 MHz, and the
>>  > > > > > > next one is 1.875 MHz. It'd be very unlikely that you=20
>> get a better match at
>>  > > > > > > a lower clock.
>>  > > > > >
>>  > > > > > If the smaller freqs are all dividers of the fastest=20
>> that's fine. Please
>>  > > > > > note in a code comment that you're assuming this.
>>  > > > >
>>  > > > >  No, I am not assuming this. The current driver just picks=20
>> the highest clock
>>  > > > >  rate that works. We're not changing the behaviour here.
>>  > > >
>>  > > > But you hide it behind clk API functions that don't guarantee=20
>> this
>>  > > > behaviour. And even if it works for you it might not for the=20
>> next person
>>  > > > who copies your code to support another hardware.
>>  > >
>>  > >  Again, I'm not *trying* to guarantee this behaviour.
>>  >
>>  > I didn't request you should guarantee this behaviour. I want you=20
>> to make
>>  > it obvious for readers of your code that you rely on something=20
>> that
>>  > isn't guaranteed. That your code works today isn't a good enough=20
>> excuse.
>>  > There are various examples like these. If you want a few:
>>  >
>>  >  - printf("string: %s\n", NULL); works fine with glibc, but=20
>> segfaults on
>>  >    other libcs.
>>  >  - setenv("MYVAR", NULL) used to work (and was equivalent to
>>  >    setenv("MYVAR", "")) but that was never guaranteed. Then at=20
>> some
>>  >    point of time it started to segfault.
>>  >  - Look into commits like=20
>> a4435febd4c0f14b25159dca249ecf91301c7c76. This
>>  >    used to work fine until compilers were changed to optimize more
>>  >    aggressively.
>>  >
>>  > Now if you use a clk and know that all rates smaller than the=20
>> requested
>>  > one are divisors of the fast one and your code only works (here:=20
>> is
>>  > optimal) when this condition is given, you're walking on thin ice=20
>> just
>>  > because this fact it's not guaranteed.
>>  > The least you can do is to add a code comment to make people=20
>> aware who
>>  > debug the breakage or copy your code.
>>=20
>>  If I was assuming something, it's not that the requested clock=20
>> rates are
>>  always integer dividers of the parent rate - but rather that the=20
>> difference
>>  in precision between two possible clock rates (even=20
>> non-integer-dividers) is
>>  so tiny that we just don't care.
>=20
> I'm more exacting here. If you are asked for X and can provide X - 2=20
> you
> shouldn't provide X - 12. Depending on the use case the consumer is=20
> happy
> about every bit of accuracy they can get. So if you deliberately=20
> provide
> X - 12 because it is easier to do and good enough for you, at least
> document this laziness to not waste other people's time more than
> necessary.
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

