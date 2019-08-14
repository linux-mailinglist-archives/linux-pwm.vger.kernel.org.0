Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785DD8D7BD
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 18:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfHNQKo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 12:10:44 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58380 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNQKo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 12:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565799040; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z6XGkAyuz2IYD/cLPxT6DMfaDIVK2qPCXAJ9/DkSgXQ=;
        b=uaMyXyE8le8mG32h/sNFAvtSRr3rGH2Lx8tZ3T/ioAD2XfUfEBSrT71eV21g1P1c1CnGk9
        j8dDP07ijakohN4PNS8fkJtC4feYenr/ItGMoSABPjITaUnwyhzi4eoOcNa4oJySQx4MgG
        YjsDwfPt8KsPoM1jsf3iXqDV4Dvvu2I=
Date:   Wed, 14 Aug 2019 18:10:35 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1565799035.1984.0@crapouillou.net>
In-Reply-To: <20190813140903.rdwy7p3mhwetmlnt@pengutronix.de>
References: <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
        <1565370885.2091.2@crapouillou.net>
        <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
        <1565642590.2007.1@crapouillou.net>
        <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
        <1565648183.2007.3@crapouillou.net>
        <20190813052726.g37upws5rlvrszc4@pengutronix.de>
        <1565694066.1856.1@crapouillou.net>
        <20190813123331.m4ttfhcgt6wyrcfi@pengutronix.de>
        <1565700448.1856.2@crapouillou.net>
        <20190813140903.rdwy7p3mhwetmlnt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,


Le mar. 13 ao=FBt 2019 =E0 16:09, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=
=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> On Tue, Aug 13, 2019 at 02:47:28PM +0200, Paul Cercueil wrote:
>>  Le mar. 13 ao=FBt 2019 =E0 14:33, Uwe Kleine-K=F6nig a =E9crit :
>>  > On Tue, Aug 13, 2019 at 01:01:06PM +0200, Paul Cercueil wrote:
>>  > > Well, you said that I shouln't rely on the fact that=20
>> clk_round_rate() will
>>  > > round down. That completely defeats the previous algorithm. So=20
>> please tell
>>  > > me how to use it correctly, because I don't see it.
>>  >
>>  > Using clk_round_rate correctly without additional knowledge is=20
>> hard. If
>>  > you assume at least some sane behaviour you'd still have to call=20
>> it
>>  > multiple times. Assuming maxrate is the maximal rate you can=20
>> handle
>>  > without overflowing your PWM registers you have to do:
>>  >
>>  > 	rate =3D maxrate;
>>  > 	rounded_rate =3D clk_round_rate(clk, rate);
>>  > 	while (rounded_rate > rate) {
>>  > 		if (rate < rounded_rate - rate) {
>>  > 			/*
>>  > 			 * clk doesn't support a rate smaller than
>>  > 			 * maxrate (or the round_rate callback doesn't
>>  > 			 * round consistently).
>>  > 			 */
>>  > 			 return -ESOMETHING;
>>  > 		}
>>  > 		rate =3D rate - (rounded_rate - rate)
>>  > 		rounded_rate =3D clk_round_rate(clk, rate);
>>  > 	}
>>  >
>>  > 	return rate;
>>  >
>>  > Probably it would be sensible to put that in a function provided=20
>> by the
>>  > clk framework (maybe call it clk_round_rate_down and maybe with
>>  > additional checks).
>>=20
>>  clk_round_rate_down() has been refused multiple times in the past=20
>> for
>>  reasons that Stephen can explain.
>=20
> I'd be really interested in these reasons as I think the clk framework
> should make it easy to solve common tasks related to clocks. And=20
> finding
> out the biggest supported rate not bigger than a given maxrate is
> something I consider such a common task.
>=20
> The first hit I found when searching was
> https://lkml.org/lkml/2010/7/14/260 . In there Stephen suggested that
> clk_round_rate with the current semantic is hardly useful and=20
> suggested
> clk_round_rate_up() and clk_round_rate_down() himself.

That's from 2010, though.

I agree that clk_round_rate_up() and clk_round_rate_down() should=20
exist. Even if they return -ENOSYS if it's not implemented for a given=20
clock controller.

>=20
>>  > >  I came up with a much smarter alternative, that doesn't rely=20
>> on the rounding
>>  > >  method of clk_round_rate, and which is better overall (no loop=20
>> needed). It
>>  > >  sounds to me like you're bashing the code without making the=20
>> effort to
>>  > >  understand what it does.
>>  > >
>>  > >  Thierry called it a "neat trick"
>>  > >  (https://patchwork.kernel.org/patch/10836879/) so it cannot be=20
>> as bad as you
>>  > >  say.
>>  >
>>  > Either that or Thierry failed to see the downside. The obvious=20
>> downside
>>  > is that once you set the period to something long (and so the clk=20
>> was
>>  > limited to a small frequency) you never make the clock any faster
>>  > afterwards.
>>=20
>>  Read the algorithm again.
>=20
> I indeed missed a call to clk_set_rate(clk, parent_rate). I thought I
> grepped for clk_set_rate before claiming the code was broken. Sorry.
>=20
> So I think the code works indeed, but it feels like abusing
> clk_set_max_rate. So I'd like to see some words from Stephen about=20
> this
> procedure.
>=20
> Also I think this is kind of inelegant to set the maximal rate twice.=20
> At
> least call clk_set_max_rate only once please.

Ok. I can do that.

>=20
>>  > > > > > >  E.g. if at a rate of 12 MHz your computed hardware=20
>> value for the period
>>  > > > > > >  is 0xf000, then at a rate of 24 MHz it won't fit in 16=20
>> bits. So the clock
>>  > > > > > >  rate must be reduced to the highest possible that will=20
>> still give you a
>>  > > > > > >  < 16-bit value.
>>  > > > > > >
>>  > > > > > >  We always want the highest possible clock rate that=20
>> works, for the sake of
>>  > > > > > >  precision.
>>  > > > > >
>>  > > > > > This is dubious; but ok to keep the driver simple.=20
>> (Consider a PWM that
>>  > > > > > can run at i MHz for i in [1, .. 30]. If a period of 120=20
>> ns and a duty
>>  > > > > > cycle of 40 ns is requested you can get an exact match=20
>> with 25 MHz, but
>>  > > > > > not with 30 MHz.)
>>  > > > >
>>  > > > > The clock rate is actually (parent_rate >> (2 * x) )
>>  > > > > for x =3D 0, 1, 2, ...
>>  > > > >
>>  > > > > So if your parent_rate is 30 MHz the next valid one is 7.5=20
>> MHz, and the
>>  > > > > next one is 1.875 MHz. It'd be very unlikely that you get a=20
>> better match at
>>  > > > > a lower clock.
>>  > > >
>>  > > > If the smaller freqs are all dividers of the fastest that's=20
>> fine. Please
>>  > > > note in a code comment that you're assuming this.
>>  > >
>>  > >  No, I am not assuming this. The current driver just picks the=20
>> highest clock
>>  > >  rate that works. We're not changing the behaviour here.
>>  >
>>  > But you hide it behind clk API functions that don't guarantee this
>>  > behaviour. And even if it works for you it might not for the next=20
>> person
>>  > who copies your code to support another hardware.
>>=20
>>  Again, I'm not *trying* to guarantee this behaviour.
>=20
> I didn't request you should guarantee this behaviour. I want you to=20
> make
> it obvious for readers of your code that you rely on something that
> isn't guaranteed. That your code works today isn't a good enough=20
> excuse.
> There are various examples like these. If you want a few:
>=20
>  - printf("string: %s\n", NULL); works fine with glibc, but segfaults=20
> on
>    other libcs.
>  - setenv("MYVAR", NULL) used to work (and was equivalent to
>    setenv("MYVAR", "")) but that was never guaranteed. Then at some
>    point of time it started to segfault.
>  - Look into commits like a4435febd4c0f14b25159dca249ecf91301c7c76.=20
> This
>    used to work fine until compilers were changed to optimize more
>    aggressively.
>=20
> Now if you use a clk and know that all rates smaller than the=20
> requested
> one are divisors of the fast one and your code only works (here: is
> optimal) when this condition is given, you're walking on thin ice just
> because this fact it's not guaranteed.
> The least you can do is to add a code comment to make people aware who
> debug the breakage or copy your code.

If I was assuming something, it's not that the requested clock rates=20
are always integer dividers of the parent rate - but rather that the=20
difference in precision between two possible clock rates (even=20
non-integer-dividers) is so tiny that we just don't care.

>=20
> I admit this wasn't optimal already before, but at least the logic was
> in the same code and not hidden behind the clk API.
>=20
> Please do people who review or copy your code the favour to document=20
> the
> assumptions you're relying on. And if it's only to save some time for
> someone who stumbles over your code who knows the clk API and starts
> thinking about improving the driver.

Ok. I can add a comment.

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

