Return-Path: <linux-pwm+bounces-4484-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6E09FBA8B
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 09:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0940165BA7
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2CF189F56;
	Tue, 24 Dec 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJC+Q58M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDEB13D503;
	Tue, 24 Dec 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735029307; cv=none; b=HiD96moOUhgACUw03Xg2xrPiE35c3fz8vEdXzax+6BXlpyiJlHl13ZBRR/BwdIqOkSrDZr7GKKSHS+pzVUXG0Yv20nJWRf/QdAnJ4WpYIH1dN873T8GxBx+h+CoXvePPm0E2Xod2Z7Q7Ha1zc2NyXcXQapJuxqIKvzfYAJdNyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735029307; c=relaxed/simple;
	bh=LVK4FW2pIWOu8VxpMW2J0s2UCHgv4bTwZ5mPP0NHWTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiLOYLcmMw2tk4JaPfWdski1wtQWjBLpkg3dtxfZtLCmwHTWOFZUQx/UQVy2CVSHJ75PZG5kcRQbYv98O99eLVkkHiClwDa39X4mG3fg95EBqPownaRdhAXKV7gpvTsSSEAs+Jtf59Ncx8bPuyJuEfzul+GWJgWfKhwrQmid2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJC+Q58M; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e461015fbd4so3956575276.2;
        Tue, 24 Dec 2024 00:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735029304; x=1735634104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgCVgeN0wOheXPUe0p+npMyY7H/G+TEP8YjiV9rhOnQ=;
        b=HJC+Q58MfN1HxxWdxiPsr6zLcJCsP1Mqledf2foMdmIGJznCPTJAUEpOFAyIzxNz5C
         sqr8sjTt5EsJgWDmHerrdNZQTimByzcnOBOE7P1nOQRlSSiRJvl5ohJvtDJSRlMVi472
         Ys6IHw23l9JE7QAtWMrjj8Ly/0zDMzUx+OWCane1jGG6meA0SGTOilZ3FnOxXBvq2BjL
         On/6CqwwipExon2EEYc0V8yGal648IqCPckY5+WUKN6jfybapRdm99LTmQc44di7R/2i
         mukrul6mcVhgOqp5w0Y1Amc5wtu6YQ1MZLQ5a+ZdIWWXZf+bjNDWR9c2Vzg/FI0df+mp
         w/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735029304; x=1735634104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgCVgeN0wOheXPUe0p+npMyY7H/G+TEP8YjiV9rhOnQ=;
        b=iwXQ4FSyo/i83v1W/ZoBHyWV0FHVTEMTZEivtwBvN1GWvNWS0CZCnj4SQSFzX6OK4i
         heQwe3RCf2ZMzL6NiOt+8SwgLGo3vGWKvBg7SlIJk+G194SmXLDjf3BRdgD1o+yIOVCi
         KABR3ljifzptPY6Iq6IcvVNhApcvKF7qPGizPlxhTPK1NA3jUI91YRPWCwL1Pp98smyL
         wdAFIPrglumjHDk7GiJXp/jdVE9SFe+6OLVKORjZJkoynmKDK7/UoICFlcLU7jWkTiuY
         FqIx4rFgbBuQeYfdXFNoxHqOOrN4oAoOzwcTDqSFSR+UFsXcvwB3Rxi+uyChJG4MX4c4
         9KGg==
X-Forwarded-Encrypted: i=1; AJvYcCUpLdiEHk2X5a8xe7vj7sAbho51FEroRa/lQHw1huKzmeH2zaPK4G2f+eBgxhTz9GURzTK9yKeGPUxr@vger.kernel.org, AJvYcCVRoTp/V8Gam08WAIZKhXteXZEjs1Td9RzgNw6xzW3iWxExJGKt9iOQQo5lVT5TJHofF0K/gbQPC2ry@vger.kernel.org, AJvYcCVT5XLhr4hoLIIjgW1qPhoA7I9whsWshjKSPFsTVDb8/PFf9ab9NhyIQReyPpr0JtafUgkhUDHy2Qrx7pLS@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWCg098fFrGMvEMOhiMZHkmY5m/3ZKHSyeDMB3zQzE/05A8UQ
	k8LqAOOXl1yRAfmBWI1bIxT8qFfvHR3TjwIHF7/dcqaoPZ2JxCtZlw2hXZrkqeSko0eujXuQK9m
	R7J8EJkwdb7wpZC0yDsp+SaJJkx8=
X-Gm-Gg: ASbGncs7W0kL3Ghgbr011cKjDVj0hx163rKL64R4ho7INrK9i6KryFLQS0Q4oCuZyzz
	mhFQbpbyCeMNDm46R6up0b71QfMohRydM8/BOEjTo
X-Google-Smtp-Source: AGHT+IHi7ZkSCFx2vwI8ZF7AXi5AHBQsK++ke2rv1PF8DQ0znblHAfcvl+lWC3uBrJAstXD0hu8gA2de7Y4XVRLgaZI=
X-Received: by 2002:a05:6902:240e:b0:e38:a081:f533 with SMTP id
 3f1490d57ef6-e538c20dfc4mr10174313276.7.1735029304401; Tue, 24 Dec 2024
 00:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081231.213406-1-nylon.chen@sifive.com>
 <20240222081231.213406-4-nylon.chen@sifive.com> <jvwgsszvs4jtcytcphsdjulzgqfqzdp4sisu236ddwsqgmvriw@ngi4ljgh5b74>
 <CAHh=Yk92=hp+kaTJWL13_jwJ5gzAAi8gbRF=Ns9=yq2trRUQEg@mail.gmail.com> <xf6ympnaljfjztptb5w5qdpuluckptozdz5a7gtuycsev32ngr@x2ovibqv6evr>
In-Reply-To: <xf6ympnaljfjztptb5w5qdpuluckptozdz5a7gtuycsev32ngr@x2ovibqv6evr>
From: Nylon Chen <nylon7717@gmail.com>
Date: Tue, 24 Dec 2024 16:34:53 +0800
Message-ID: <CAGKtFavQAZOof5QSTFCEaRJEPETm5aBqzkV4g24n3ioiBAOgDA@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] pwm: sifive: Fix the error in the idempotent test
 within the pwm_apply_state_debug function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nylon Chen <nylon.chen@sifive.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, conor@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, thierry.reding@gmail.com, 
	vincent.chen@sifive.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2024=E5=B9=
=B44=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:05=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Tue, Apr 02, 2024 at 10:01:39AM +0800, Nylon Chen wrote:
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2024=
=E5=B9=B43=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:17=E5=
=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > Hello,
> > >
> > > On Thu, Feb 22, 2024 at 04:12:31PM +0800, Nylon Chen wrote:
> > > > Round the result to the nearest whole number. This ensures that
> > > > real_period is always a reasonable integer that is not lower than t=
he
> > > > actual value.
> > > >
> > > > e.g.
> > > > $ echo 110 > /sys/devices/platform/led-controller-1/leds/d12/bright=
ness
> > > > $ .apply is not idempotent (ena=3D1 pol=3D0 1739692/4032985) -> (en=
a=3D1 pol=3D0 1739630/4032985)
> > > >
> > > > Co-developed-by: Zong Li <zong.li@sifive.com>
> > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > > ---
> > > >  drivers/pwm/pwm-sifive.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > > index a586cfe4191b..bebcbebacccd 100644
> > > > --- a/drivers/pwm/pwm-sifive.c
> > > > +++ b/drivers/pwm/pwm-sifive.c
> > > > @@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_=
sifive_ddata *ddata,
> > > >
> > > >       /* As scale <=3D 15 the shift operation cannot overflow. */
> > > >       num =3D (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWI=
DTH + scale);
> > > > -     ddata->real_period =3D div64_ul(num, rate);
> > > > +     ddata->real_period =3D DIV_ROUND_UP_ULL(num, rate);
> > > >       dev_dbg(ddata->chip.dev,
> > > >               "New real_period =3D %u ns\n", ddata->real_period);
> > > >  }
> > Hi Uwe
> > >
> > > pwm_sifive_apply has a DIV64_U64_ROUND_CLOSEST(). I wonder if that ne=
eds
> > > adaption, too?!
> > According to my experiments, no adjustment is necessary.
>
> Did you enable PWM_DEBUG and tested with something like:
>
>         seq 5000 100000 | while read p; do echo p > /sys/class/pwm/pwmchi=
pX/pwmY/period; done
>
Hi Uwe,
I apologize for the significant delay in responding to your query,
I've now completed a thorough verification of the PWM_DEBUG
functionality.

The Period Testing:
seq 5000 5000 100000 | while read p; do echo $p >
/sys/class/pwm/pwmchip0/pwm0/period echo "Testing period: $p" done

The Duty Cycle Testing:
for percent in 0 25 50 75 100; do duty=3D$((100000 * percent / 100))
echo $duty > /sys/class/pwm/pwmchip0/pwm0/duty_cycle done

- All period values from 5000ns to 100000ns were applied successfully
- Various duty cycle ratios were tested without issues
- Monitored dmesg output during tests - no kernel messages about wrong
settings were observed

Let me know if you need any additional test data or have other
parameters you'd like me to verify.

> and then verified that this test didn't result in kernel messages about
> wrong settings?
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

--=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
sifive system software  team =E9=99=B3=E4=BC=AF=E7=B6=B8

Cell phone:  0989057854
E-mail: nylon7717@gmail.com
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

