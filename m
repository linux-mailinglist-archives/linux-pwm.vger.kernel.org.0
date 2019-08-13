Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11108B612
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Aug 2019 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfHMLBO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Aug 2019 07:01:14 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51944 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfHMLBN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Aug 2019 07:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565694071; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyTl/h1jR+R1IfXTdZ80fJwRqvaC6+t87MXI23waFY4=;
        b=I1j/bK/1NZGDyxwQGSpwkhJXDaiis2eN3zMtmPrIHRGXO+gevu6RlBUoxjQ1rN3Bj7nT1R
        WpCKA8WBtscPG964M3qrCCtj8fHgrbjGpxwyArHzg1m9zB1cZ0AwGbAUwNul9zgG2o16AX
        is0esKM7MGk7dAJpTY5MJxEnhS5+ubI=
Date:   Tue, 13 Aug 2019 13:01:06 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Stephen Boyd <sboyd@kernel.org>
Message-Id: <1565694066.1856.1@crapouillou.net>
In-Reply-To: <20190813052726.g37upws5rlvrszc4@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
        <20190809123031.24219-5-paul@crapouillou.net>
        <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
        <1565370885.2091.2@crapouillou.net>
        <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
        <1565642590.2007.1@crapouillou.net>
        <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
        <1565648183.2007.3@crapouillou.net>
        <20190813052726.g37upws5rlvrszc4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le mar. 13 ao=FBt 2019 =E0 7:27, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> [adding Stephen Boyd to Cc]
>=20
> On Tue, Aug 13, 2019 at 12:16:23AM +0200, Paul Cercueil wrote:
>>  Le lun. 12 ao=FBt 2019 =E0 23:48, Uwe Kleine-K=F6nig a =E9crit :
>>  > On Mon, Aug 12, 2019 at 10:43:10PM +0200, Paul Cercueil wrote:
>>  > > Le lun. 12 ao=FBt 2019 =E0 8:15, Uwe Kleine-K=F6nig a =E9crit :
>>  > > > On Fri, Aug 09, 2019 at 07:14:45PM +0200, Paul Cercueil wrote:
>>  > > > > Le ven. 9 ao=FBt 2019 =E0 19:05, Uwe Kleine-K=F6nig a =E9crit :
>>  > > > > > On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul Cercueil=20
>> wrote:
>>  > > > > > > [...]
>>  > > > > > >  +	/* Reset the clock to the maximum rate, and we'll=20
>> reduce it if needed */
>>  > > > > > >  +	ret =3D clk_set_max_rate(clk, parent_rate);
>>  > > > > >
>>  > > > > > What is the purpose of this call? IIUC this limits the=20
>> allowed range of
>>  > > > > > rates for clk. I assume the idea is to prevent other=20
>> consumers to change
>>  > > > > > the rate in a way that makes it unsuitable for this pwm.=20
>> But this only
>>  > > > > > makes sense if you had a notifier for clk changes,=20
>> doesn't it? I'm
>>  > > > > > confused.
>>  > > > >
>>  > > > > Nothing like that. The second call to clk_set_max_rate()=20
>> might have set
>>  > > > > a maximum clock rate that's lower than the parent's rate,=20
>> and we want to
>>  > > > > undo that.
>>  > > >
>>  > > > I still don't get the purpose of this call. Why do you limit=20
>> the clock
>>  > > > rate at all?
>>  > >
>>  > > As it says below, we "limit the clock to a maximum rate that=20
>> still gives
>>  > > us a period value which fits in 16 bits". So that the computed=20
>> hardware
>>  > > values won't overflow.
>>  >
>>  > But why not just using clk_set_rate? You want to have the clock=20
>> running
>>  > at a certain rate, not any rate below that certain rate, don't=20
>> you?
>>=20
>>  I'll let yourself answer yourself:
>>  https://patchwork.ozlabs.org/patch/1018969/
>=20
> In that thread I claimed that you used clk_round_rate wrongly, not=20
> that
> you should use clk_set_max_rate(). (The claim was somewhat weakend by
> Stephen, but still I think that clk_round_rate is the right approach.)

Well, you said that I shouln't rely on the fact that clk_round_rate()=20
will round down. That completely defeats the previous algorithm. So=20
please tell me how to use it correctly, because I don't see it.

I came up with a much smarter alternative, that doesn't rely on the=20
rounding method of clk_round_rate, and which is better overall (no loop=20
needed). It sounds to me like you're bashing the code without making=20
the effort to understand what it does.

Thierry called it a "neat trick"=20
(https://patchwork.kernel.org/patch/10836879/) so it cannot be as bad=20
as you say.


>=20
> The upside of clk_round_rate is that it allows you to test for the
> capabilities of the clock without actually changing it before you=20
> found
> a setting you consider to be good.

I know what clk_round_rate() is for. But here we don't do=20
trial-and-error to find the first highest clock rate that works, we=20
compute the maximum clock we can use and limit the clock rate to that.


>=20
>>  It's enough to run it below a certain rate, yes. The actual rate=20
>> doesn't
>>  actually matter that much.
>=20
> 1 Hz would be fine? I doubt it.

We use the highest possible clock rate. We wouldn't use 1 Hz unless=20
it's the highest clock rate available.


>=20
>>  > >  E.g. if at a rate of 12 MHz your computed hardware value for=20
>> the period
>>  > >  is 0xf000, then at a rate of 24 MHz it won't fit in 16 bits.=20
>> So the clock
>>  > >  rate must be reduced to the highest possible that will still=20
>> give you a
>>  > >  < 16-bit value.
>>  > >
>>  > >  We always want the highest possible clock rate that works, for=20
>> the sake of
>>  > >  precision.
>>  >
>>  > This is dubious; but ok to keep the driver simple. (Consider a=20
>> PWM that
>>  > can run at i MHz for i in [1, .. 30]. If a period of 120 ns and a=20
>> duty
>>  > cycle of 40 ns is requested you can get an exact match with 25=20
>> MHz, but
>>  > not with 30 MHz.)
>>=20
>>  The clock rate is actually (parent_rate >> (2 * x) )
>>  for x =3D 0, 1, 2, ...
>>=20
>>  So if your parent_rate is 30 MHz the next valid one is 7.5 MHz, and=20
>> the
>>  next one is 1.875 MHz. It'd be very unlikely that you get a better=20
>> match at
>>  a lower clock.
>=20
> If the smaller freqs are all dividers of the fastest that's fine.=20
> Please
> note in a code comment that you're assuming this.

No, I am not assuming this. The current driver just picks the highest=20
clock rate that works. We're not changing the behaviour here.


>=20
>>  > >  > >  Basically, we start from the maximum clock rate we can=20
>> get for that PWM
>>  > >  > >  - which is the rate of the parent clk - and from that=20
>> compute the maximum
>>  > >  > >  clock rate that we can support that still gives us <=20
>> 16-bits hardware
>>  > >  > >  values for the period and duty.
>>  > >  > >
>>  > >  > >  We then pass that computed maximum clock rate to=20
>> clk_set_max_rate(), which
>>  > >  > >  may or may not update the current PWM clock's rate to=20
>> match the new limits.
>>  > >  > >  Finally we read back the PWM clock's rate and compute the=20
>> period and duty
>>  > >  > >  from that.
>>  > >  >
>>  > >  > If you change the clk rate, is this externally visible on=20
>> the PWM
>>  > >  > output? Does this affect other PWM instances?
>>  > >
>>  > >  The clock rate doesn't change the PWM output because the=20
>> hardware values for
>>  > >  the period and duty are adapted accordingly to reflect the=20
>> change.
>>  >
>>  > It doesn't change it in the end. But in the (short) time frame=20
>> between
>>  > the call to change the clock and the update of the PWM registers=20
>> there
>>  > is a glitch, right?
>>=20
>>  The PWM is disabled, so the line is in inactive state, and will be=20
>> in that state
>>  until the PWM is enabled again. No glitch to fear.
>=20
> ok, please note in the commit log that the reordering doesn't affect=20
> the
> output because the PWM is off and are done to make it more obvious=20
> what
> happens.
>=20
>>  > You didn't answer to the question about other PWM instances. Does=20
>> that
>>  > mean others are not affected?
>>=20
>>  Sorry. Yes, they are not affected - all PWM channels are=20
>> independent.
>=20
> ok.
>=20
>>  > PS: It would be great if you could fix your mailer to not damage=20
>> the
>>  > quoted mail. Also it doesn't seem to understand how my name is=20
>> encoded
>>  > in the From line. I fixed up the quotes in my reply.
>>=20
>>  I switched Geary to "rich text". Is that better?
>=20
> No. It looks exactly like the copy you bounced to the list. See
> https://patchwork.ozlabs.org/comment/2236355/ for how it looks.
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

