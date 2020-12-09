Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67B2D4763
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Dec 2020 18:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgLIRDC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Dec 2020 12:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730993AbgLIRDC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Dec 2020 12:03:02 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C311C0613CF;
        Wed,  9 Dec 2020 09:02:21 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a16so3154795ejj.5;
        Wed, 09 Dec 2020 09:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+BAYkDIc2f5fQOiat/eOSg4PwBisnOFtz7SzWykOlWw=;
        b=eL0cMj4vc8cPeKvVhn08wc1wa10kU31qD8Ygf4WpJkyGTxaiBZJadWeWMhsv/QY29y
         WioT+lmnL0UDq+Jvvaxm/DN9oxHavQh7zOxFbOhiAqDHiEQzQf5MTI/QdgtnE8rEn3nQ
         DdK7MzmOrA14yKd498cn6G2DRosR5TJezywYK9GFVSr7wQ567Uy9Z5UBl5HAW9HhPlo2
         51qZaTVe/ZEetBM8rBsNL16hOvm6P9wb/Jj6eg9YXUJ205RzFcz4unEATnze2jsyqhBe
         zr2Igs1zTRWOzRSC8yT2K2BnD/BTCLOyDYdFKwl4ffFucruVVByg6L/0oVIxtikkfgGP
         ohBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+BAYkDIc2f5fQOiat/eOSg4PwBisnOFtz7SzWykOlWw=;
        b=AvO5JzVbu3CVVUOoc8HmS1MhQvxiaAQDsfMgEmA3uUmYQ9XFsh6zsF1gm8ovYz9OlY
         mBEZWCYbJX2NWfLSTSdZywUbdrW7ddCG3pN5nYRR4QO5ko9m1dofJGnnWUCLoPZc+DhA
         zAsEsOwn82rnUDKTgnzRBEMmL8R3SlTZCzJSRbxr9JGcQi7IsBTCg4uvv+DlB8qP4XI2
         0oMfBdbta6ziHVhOh+JTeokAYRRzSJPrd2yIzGTDRGHLPFZTEPi8u1G3yuiJBun4sNQ2
         asmqdd5d69nEHe+MuRWemTkG99vIzg6kISRvESK09XhcUhUzHXiQiuBnfhnjc5V6dEGX
         1MqA==
X-Gm-Message-State: AOAM531SoYinL3ONog7ITXz1MR9mepzRMtH2GC9kFMAX10/0EuVTztcr
        lDwFlzCiNKCi8J/DXgyMLBg=
X-Google-Smtp-Source: ABdhPJxBFnMu1WEo8E985mJB9/rl+N89qHRLSY7U8UFvxLuP+vmn5uiDo0QHTb88szMDhpU+7t8hAQ==
X-Received: by 2002:a17:906:c790:: with SMTP id cw16mr2919433ejb.344.1607533340207;
        Wed, 09 Dec 2020 09:02:20 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c25sm2041881ejx.39.2020.12.09.09.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 09:02:18 -0800 (PST)
Date:   Wed, 9 Dec 2020 18:02:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X9EDGHySNYb7CxcW@ulmo>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j2kUEb1PsaEbDZG0"
Content-Disposition: inline
In-Reply-To: <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--j2kUEb1PsaEbDZG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 07:26:37PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry, hello Sven,
>=20
> On Tue, Dec 08, 2020 at 05:57:12PM +0100, Thierry Reding wrote:
> > On Tue, Dec 08, 2020 at 09:44:42AM -0500, Sven Van Asbroeck wrote:
> > > On Tue, Dec 8, 2020 at 4:10 AM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > If this is already in the old code, this probably warrants a separa=
te
> > > > fix, and yes, I consider this a severe bug. (Consider one channel
> > > > driving a motor and reconfiguring an LED modifies the motor's speed=
=2E)
> > > >
> > >=20
> > > I think you are 100% correct, this would be a severe bug. I have only=
 used
> > > this chip to drive LEDs, where the actual period is not that importan=
t. But
> > > for motor control, it's a different story.
> > >=20
> > > Basically you are suggesting: the period (prescaler) can only be chan=
ged iff
> > > its use-count is 1.
> > >=20
> > > This however brings up a whole load of additional questions: consider=
 the case
> > > where the chip outputs are also used in gpio mode. the gpio functiona=
lity
> > > only sets "full on" and "full off" bits. On a scope, a gpio output wi=
ll look
> > > identical, no matter the value of the period. So when a gpio output i=
s in use,
> > > does it increment the prescaler use-count ?
> > >=20
> > > Example:
> > > 1. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=
=3D1/200Hz)
> > > 2. output 2: set led mode (full-on bit set)
> > > 3. output 1: change period(enabled=3Dtrue, duty_cycle=3D50%, period=
=3D1/100Hz)
> > >=20
> > > Do we have to make (3) fail? I would say no: although output 2 is in =
use,
> > > it's not actually using the prescaler. Changing prescale won't modify
> > > output 2 in any way.
> > >=20
> > > Which brings us to an even trickier question: what happens if a pwm o=
utput
> > > is set to 0% or 100% duty cycle? In that case, it'll behave like a gp=
io output.
> > > So when it's enabled, it does not use the prescaler.
> > > But! what happens if we now set that output to a different duty cycle?
> > >=20
> > > Example:
> > > 1. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  period=
=3D1/200Hz)
> > > 2. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, period=
=3D1/400Hz)
> > >   fail? no, because it's not actually using the period (it's full on)
> > > 3. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, period=
=3D1/200Hz)
> > >   fail? no, because it's not actually using the period (it's full on)
> > > 4. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  period=
=3D1/400Hz)
> > >   fail? no, because only output 1 is using the prescaler
> > > 5. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=
=3D1/400Hz)
> > >   fail? no, because output 2 is not changing the prescaler
> > > 6. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=
=3D1/200Hz)
> > >   fail? yes, because output 2 is changing prescaler and it's already =
in use
> > >=20
> > > IMHO all this can get very complicated and tricky.
> >=20
> > Is this really that complicated?
>=20
> I think it is.

Care to specify what exactly is complicated about it? You're just saying
that you don't like the restrictions that this implements, but there's
really nothing we can do about that because the hardware just doesn't
give you that flexibility.

> > I sounds to me like the only thing that you need is to have some sort
> > of usage count for the prescaler. Whenever you want to use the
> > prescaler you check that usage count. If it is zero, then you can just
> > set it to whatever you need. If it isn't zero, that means somebody
> > else is already using it and you can't change it, which means you have
> > to check if you're trying to request the value that's already set. If
> > so, you can succeed, but otherwise you'll have to fail.
>=20
> With this abstraction Sven's questions are changed to:
>=20
> Does a PWM that runs at 0% or 100% use the prescaler?
>=20
> If yes, you limit the possibilities of the brother channels. And if not,
> it will not be possible to go to a 50% relative duty cycle while
> retaining the period. Both sounds not optimal.

Again, this is a restriction imposed by the hardware design and there's
nothing in software that we can do about that. The only thing I proposed
was a simple way to detect the circumstances and make sure we can deal
with it.

And that's obviously subject to the kind of policy we want to implement.
I don't think it's necessarily a bad thing to give people the most
flexibility. If they know that one PWM channel is only ever going to be
full-on/full-off, then they can still use that other channel in whatever
way they want. If, on the other hand, we assume that the prescaler is
always going to be used we limit the flexibility even if we don't
necessarily have to.

Obviously if you want to use both channels at partial duty-cycles there
isn't much you can do and you really have to make sure they both run at
the same frequency/period. But that's usually something that you can
deal with by just choosing a period that works for both.

And if that's not possible, well, then you better just use a different
PWM controller to begin with, because you just can't make it work.

> > > We can of course make this much simpler by assumung that gpio or on/o=
ff pwms
> > > are actually using the prescaler. But then we'd be limiting this chip=
's
> > > functionality.
> >=20
> > Yeah, this is obviously much simpler, but the cost is a bit high, in my
> > opinion. I'm fine with this alternative if there aren't any use-cases
> > where multiple outputs are actually used.
>=20
> This metric is wishy-washy; of course you can construct a use-case. I'd
> still go for this simpler option and assume the prescaler used if the
> PWM runs at 0% or 100%, but not when it is a GPIO.

I don't understand what you're saying here. On one hand you seem to
object to what I was saying, but then you agree with it?

And I'm not asking anyone to make up any artificial use-case. What I'm
saying is that if there aren't any existing use-cases that would break
if we assume a pre-scaler is used for full-on/full-off, then I'm okay
with making that assumption and simplifying the driver. If there were
use-cases, then that assumption would break existing users and that's
not something I'm willing to accept.

Anything wrong with that metric in your opinion?

Thierry

--j2kUEb1PsaEbDZG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/RAxYACgkQ3SOs138+
s6GZ3A//YcMRJSOG38TvSgd06WzYkAcGUpsWsieinSRTJx7C87ZEnapVO50WV+uT
hJCAMWz9pwz6ZEFSf3a0It9Gy2QAqNF+o1cDFqfSi427+ySg2xU2MYSSD/MTDbbm
vJB7clBKJD2fr/D6ZSpp2Cw1uHxWJx1uVwg6kcXLFPB8R5Xm6Neh4jt85JRQkVQ7
XKx5Dx/shikFmaQP/IdaAC/U4soWgAtax/8vUjlQa4n4ftaIpJJiYhg2gO11enNm
jk37gacEWsGVSFpIjbWlrqGPh3ri3Zon3s+SFL3GfhKZsj2DfT7L+CY8sEdvwzWt
Z0a2ys9yeqrEgBQSclmK1U27X+0V6KqGDcKuh5/VvLhZLFgzqnoZiaWG9RSLByMX
4p55D/bboD5hNQbr0MHvHxWsGdi3CuqQVkd1GA5JwFtLA+bDobC0vJlQlWpNdZlH
SWayd2Yihst8pK01kYWJOaGFQ8jX67utY0BjdJt10/+i3PTJ8vpKISPRix0SFvc0
9nCmyDeJKCzhRK82bkGErTqPPFwZ4zy/3kQrdncNoSddT1vWJ3mqhAweKjc3BGvd
iDIK0nA4eCHi0aR3DhZ8bW4Ch/NQizXy9xkhBzbsO4ZOGjY0cAsEEChgZYoMznmb
eO5cuV9RAypUQM2ERspLUVHHX5GDaVhCbVQyQK2FDEkiQLBMSd8=
=vN/4
-----END PGP SIGNATURE-----

--j2kUEb1PsaEbDZG0--
