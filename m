Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35C8F422D
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 09:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfKHIej (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 03:34:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38509 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfKHIej (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Nov 2019 03:34:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so5276029wmk.3;
        Fri, 08 Nov 2019 00:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VkI4cvX4wkJb9cEinKhbBlP59eTt5rxMwM6muY3FHmk=;
        b=XYDgk1cdeJqtjFrCaSfVAgN96MN8Wbcax5Ms1Zmp3POWOH5hCw5s3PzxCbXFlQXi5g
         VIj6YS+7ahGPRoYeYJVzmrrso7zR6fsGoivRWpxRazhvttcgSYZ2KPKyRZ03wLOgc7Ro
         MCZ0+7QWURO9Q3NUIAhWIKVnhdctT9HQOJSZ6g2uS7WixsIYGNUGlxij3St1kqcdyOqW
         o32ylKXs7abPggaMHFdEltPD1VLuEoEQ8dtKc9OiZms/xdTvYqJjlFHkRlhlF9qr1fYz
         vJT6Fj+DkECLmOqOggYzC1J4wxAp/KKUDCF+7DqOFlWmolcSNaY79j6r4WLCrHLr2L7u
         l2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VkI4cvX4wkJb9cEinKhbBlP59eTt5rxMwM6muY3FHmk=;
        b=ER0gdoYW71mu6e/TqbmCminsoLcVQq9R4031jrxTX/hKbl9oL5g49YfR5mBr5OF8t9
         MuOxiOXpE72feJPRcu6TqZxu3q1pq0aI2BZokldGG6D6AaF4k6A1Haz7SA5qaWOVBYOB
         yByFA5H0Igfc0amCP65Ev3Uw65OL8J8lGtjduKuM6Az5JaV8jtM6USdj3oclICQSlJu6
         35aMt8TjVPslOwCH+JRSN2MyjGLbHaIblhF8JbfsVyjMk7TnR/l1Sfh1NS+T8wan27sV
         rp4x7eEqqRWh2kRQVyL37hMPynKBL7EorzuZqbwgnHtl69elty3yL9BSR4cKvzACz+Pq
         q3qg==
X-Gm-Message-State: APjAAAUMf+PTWtqjSHVIzU+j+1LnDhy46AhCx61EDD3BYJcetsvPEq3N
        wO+gjXGuXX0cAD9YdT4TKvL0Stzt2suygEBpPS0=
X-Google-Smtp-Source: APXvYqwO5LNjRjZqBsLm0rx2ZVFBShCv1CuuOkko/vXZhWR0gKobSrxO8D2AYRmTGsvhPEQK7KDzYl1RD1/Hmamx/oc=
X-Received: by 2002:a1c:a512:: with SMTP id o18mr6701777wme.4.1573202075843;
 Fri, 08 Nov 2019 00:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20191105131456.32400-1-peron.clem@gmail.com> <20191105131456.32400-5-peron.clem@gmail.com>
 <20191105145659.ffezqntodsys4phn@pengutronix.de> <CAJiuCcdXr3y0oe19ZNaiQoN7Y39p54p8LjQjXfjHbTH8tbnrpw@mail.gmail.com>
 <20191107065118.j4s5cghj4ark7sql@pengutronix.de>
In-Reply-To: <20191107065118.j4s5cghj4ark7sql@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 8 Nov 2019 09:34:24 +0100
Message-ID: <CAJiuCcd3qAP=xODJWcvay6q-MbLeBvX5tAtuUj7dFcp8biXzOw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] pwm: sun4i: Add support to output source clock directly
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, 7 Nov 2019 at 07:51, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Cl=C3=A9ment,
>
> On Wed, Nov 06, 2019 at 10:24:39PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Tue, 5 Nov 2019 at 15:57, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Tue, Nov 05, 2019 at 02:14:53PM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > +     bypass =3D state->enabled &&
> > > > +              (state->period * clk_rate >=3D NSEC_PER_SEC) &&
> > >
> > > This is too coarse. With state->period =3D 1000000 this is fulfilled
> > > (unless the multiplication overflows).
> >
> > Sorry, misunderstood the previous mail
> >
> > What about something like this ?
> > ((state->period - 1) * clk_rate <=3D NSEC_PER_SEC) &&
> > ((state->period + 1) * clk_rate >=3D NSEC_PER_SEC) &&
> >  ((state->duty_cycle - 1) * 2 <=3D state->period) &&
> >  ((state->duty_cycle + 1) * 2 >=3D state->period);
> >
> > We are sure that the user is looking for a PWM around the OSC with a
> > 50% duty cycle ?
>
> This again is too strict. The general policy to fulfill a request is:
>
>  1) provide the longest possible period not bigger than requested
>  2) provide the longest possible duty cycle not bigger than requested
>  3) if possible complete the currently running period before switching
>     and don't return to the user before the new setting is active.
>     Document the behaviour prominently because the code (usually)
>     doesn't allow to understand the hardware's features here.
>  4) A disabled PWM should output the inactive level

Thanks for the explanation

>
> And then there is a corner case: If the user requests .duty_cycle =3D 0,
> .enabled =3D 1 it is ok to provide .enabled =3D 0 iff otherwise 0% isn't
> possible.
>
> So the right check for bypass is:
>
>   state->period * clk_rate >=3D NSEC_PER_SEC &&
>   state->period * clk_rate < whatevercanbereachedwithoutbypass &&
>   state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_SEC

The shortest PWM ratio which is not a constant output is 12MHz.
(Prescal 1, 2 entire cycle and 1 active cycle)

So something like this :
state->period * clk_rate >=3D NSEC_PER_SEC &&
state->period * clk_rate < 2 * NSEC_PER_SEC &&
state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_SEC

I will send a v4,
Thanks for the help
Regards,
Cl=C3=A9ment

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
