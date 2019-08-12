Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36A88AA61
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Aug 2019 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfHLWZp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 18:25:45 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41212 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHLWZp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 18:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565648742; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpvDPZt0n0JQQ2tsQ3wI+WD036Lk0j72y5P1ujGlN9w=;
        b=SwUBhl3E5SStXfHzOGTIsHJnklbSw/wakKSDm4rX7pNOn2NE9XHaLmizr1nm//qRnZCiNo
        PswTatfwpvXO5zgJoR4Ypd1XzG97jok8edh3xDk6nR9O2aBbQeK8CRXTF3Dk7VrmW/++lS
        MV9eYOuVoE9dslfCLDMJlWZrBdiolQE=
Date:   Tue, 13 Aug 2019 00:25:35 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1565648735.2007.4@crapouillou.net>
In-Reply-To: <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
        <20190809123031.24219-5-paul@crapouillou.net>
        <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
        <1565370885.2091.2@crapouillou.net>
        <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
        <1565642590.2007.1@crapouillou.net>
        <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

[Re-send my message in plain text, as it was bounced by the
lists - sorry about that]


Le lun. 12 ao=FBt 2019 =E0 23:48, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=
=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> On Mon, Aug 12, 2019 at 10:43:10PM +0200, Paul Cercueil wrote:
>>  Le lun. 12 ao=FBt 2019 =E0 8:15, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=
=3D
>>  <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > On Fri, Aug 09, 2019 at 07:14:45PM +0200, Paul Cercueil wrote:
>>  > >  Le ven. 9 ao=FBt 2019 =E0 19:05, Uwe=20
>> =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D
>>  > >  <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > >  > On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul Cercueil=20
>> wrote:
>>  > >  > > [...]
>>  > >  > >  +	/* Reset the clock to the maximum rate, and we'll=20
>> reduce it if needed */
>>  > >  > >  +	ret =3D clk_set_max_rate(clk, parent_rate);
>>  > >  >
>>  > >  > What is the purpose of this call? IIUC this limits the=20
>> allowed range of
>>  > >  > rates for clk. I assume the idea is to prevent other=20
>> consumers to change
>>  > >  > the rate in a way that makes it unsuitable for this pwm. But=20
>> this only
>>  > >  > makes sense if you had a notifier for clk changes, doesn't=20
>> it? I'm
>>  > >  > confused.
>>  > >
>>  > >  Nothing like that. The second call to clk_set_max_rate() might=20
>> have set
>>  > >  a maximum clock rate that's lower than the parent's rate, and=20
>> we want to
>>  > >  undo that.
>>  >
>>  > I still don't get the purpose of this call. Why do you limit the=20
>> clock
>>  > rate at all?
>>=20
>>  As it says below, we "limit the clock to a maximum rate that still=20
>> gives
>>  us a period value which fits in 16 bits". So that the computed=20
>> hardware
>>  values won't overflow.
>=20
> But why not just using clk_set_rate? You want to have the clock=20
> running
> at a certain rate, not any rate below that certain rate, don't you?

I'll let yourself answer yourself:
https://patchwork.ozlabs.org/patch/1018969/

It's enough to run it below a certain rate, yes. The actual rate doesn't
actually matter that much.


>=20
>>  E.g. if at a rate of 12 MHz your computed hardware value for the=20
>> period
>>  is 0xf000, then at a rate of 24 MHz it won't fit in 16 bits. So the=20
>> clock
>>  rate must be reduced to the highest possible that will still give=20
>> you a
>>  < 16-bit value.
>>=20
>>  We always want the highest possible clock rate that works, for the=20
>> sake of
>>  precision.
>=20
> This is dubious; but ok to keep the driver simple. (Consider a PWM=20
> that
> can run at i MHz for i in [1, .. 30]. If a period of 120 ns and a duty
> cycle of 40 ns is requested you can get an exact match with 25 MHz,=20
> but
> not with 30 MHz.)

The clock rate is actually (parent_rate >> (2 * x) )
for x =3D 0, 1, 2, ...

So if your parent_rate is 30 MHz the next valid one is 7.5 MHz, and the
next one is 1.875 MHz. It'd be very unlikely that you get a better=20
match at a
lower clock.


>>  > >  Basically, we start from the maximum clock rate we can get for=20
>> that PWM
>>  > >  - which is the rate of the parent clk - and from that compute=20
>> the maximum
>>  > >  clock rate that we can support that still gives us < 16-bits=20
>> hardware
>>  > >  values for the period and duty.
>>  > >
>>  > >  We then pass that computed maximum clock rate to=20
>> clk_set_max_rate(), which
>>  > >  may or may not update the current PWM clock's rate to match=20
>> the new limits.
>>  > >  Finally we read back the PWM clock's rate and compute the=20
>> period and duty
>>  > >  from that.
>>  >
>>  > If you change the clk rate, is this externally visible on the PWM
>>  > output? Does this affect other PWM instances?
>>=20
>>  The clock rate doesn't change the PWM output because the hardware=20
>> values for
>>  the period and duty are adapted accordingly to reflect the change.
>=20
> It doesn't change it in the end. But in the (short) time frame between
> the call to change the clock and the update of the PWM registers there
> is a glitch, right?

The PWM is disabled, so the line is in inactive state, and will be in=20
that state
until the PWM is enabled again. No glitch to fear.


> You didn't answer to the question about other PWM instances. Does that
> mean others are not affected?

Sorry. Yes, they are not affected - all PWM channels are independent.


> Best regards
> Uwe
>=20
> PS: It would be great if you could fix your mailer to not damage the
> quoted mail. Also it doesn't seem to understand how my name is encoded
> in the From line. I fixed up the quotes in my reply.

I guess I'll submit a bug report to Geary then.


>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |

=

