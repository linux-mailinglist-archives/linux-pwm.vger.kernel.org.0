Return-Path: <linux-pwm+bounces-1905-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302B8A23A9
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Apr 2024 04:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6CB285C43
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Apr 2024 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9A8D299;
	Fri, 12 Apr 2024 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZxAKYJCq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC59ACA64
	for <linux-pwm@vger.kernel.org>; Fri, 12 Apr 2024 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887646; cv=none; b=hL7a1ggjyxwlFr5/GyLZ8o6hnTLLi/Zw9RsjfOV2O3YFbGFdjtlkhAkE69RyuINorm7wJYySxNoeluXuciiQ886L/M6N0DhjQBOfgvA+gFVA5nBTxY5lqTLP1j4SbcyTm0ACm752c3Jfjk7ndk/u4n/+qWkpHbY5MNnc/noh5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887646; c=relaxed/simple;
	bh=MelCsYWkdQ5EAsUBNYbNsTcwbc2X5i5zv+BYxjy46ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQTtTLcK6mW9ZrLyM5cfiCVk3djHncsWx5vtK++UEYBgs58XFpJl5b2kA0SNtEdprvRRlgSDfYgCCZtTx3ugMDIXK6dI0LbLvV+qAgfA2STXNAtJSa0y51uX0rZ9vQSfgXuVyEn1pXrnNlakUe5ufQsvYTLWR+CZcFt3Z1ag/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZxAKYJCq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6181237230dso4773097b3.2
        for <linux-pwm@vger.kernel.org>; Thu, 11 Apr 2024 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712887644; x=1713492444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQm9N6HlYQFv2uqQbKzOf53M4hr41FQjJSq0UsW2Bjw=;
        b=ZxAKYJCq50xUcKjq3UcT1V9eKrZbvF+i9yvDZRP0ddj9hOzcaHXxv67Ogr9pBUMXAx
         x8Cct3+o0gFhd02jhcGX/Er7wRZ2CJIQsCmzBxOjonI+YiHnoxQKRql35Jt9VLk8p2S5
         +4c6Etn7/u9QqZuIXpP4ldHKx7yCDYE5gLtBsltLiz55YAROuHmpU8PyGS4jvgv1GT/m
         BPuvKg26fWpt1EpnUNToMK5dKmq2m9wguHZ5E2kWbW2PhA/DdcSoXA+7S9klXr94XBFH
         Plj1HcK3ZuByQgo6i1J5jfnuMKqklvHiAWckJR+OlUDGdsyjovPcc3ID1X5T5nT030Iw
         /D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712887644; x=1713492444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQm9N6HlYQFv2uqQbKzOf53M4hr41FQjJSq0UsW2Bjw=;
        b=UYUWinqC1//Js2NviuwdPWbHgV1jALkyvQw+sCFwO9OaWQNc05lypqGLGQtZDN4+El
         R5neP92XhQnTeDrNLkP8zglUaB5rS6PLJ3+Zebw6QI3nJK4MOU7l6nvxq+oAQaiiFfFN
         i2R0rljo1ABKnYY3+N2Z2h0OgHaJgM61fWZphf8KVZw60nhZiS5Eq5PHaTICl5eYaYSp
         sQHZpgvXtKCfVygQ7rfL1EtI+hldZRSB1dLB4cFPbSpRlaGLjTL9tezJ0DcLE8IYkJo0
         +LJ8ZPigYu1utDc+iXuFJ6t6+ZILFvLf4N/yMpsuvMzDyhrv95MkyYIIADzZFdjEw93s
         46Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXdY37YE9awORK6XqMq14m38L1y75Gnl3uKboCFqvIFtVjD9jPDANs3jVyjSEe8TiS/NhBdLBUhvD6XvUHXUqA35MQ+792Eht8b
X-Gm-Message-State: AOJu0Ywx5T30xBJM16asSvrECQgL5zfl68TgqoB3sD36ULM0kDxvc7RG
	8/eC34RuY7D4JmJSlUNx4lLgx6k46byOq1J7KMe6tMEbJnWkZPRiERXhI+b8tKCx1wVHWu+nN0I
	gIeI0a6bvBBXZ4rSX1q2zJJ1jntJXnS6p/IfIuw==
X-Google-Smtp-Source: AGHT+IEyah2wqUDUWwo2dw/PFJAZ80ndyEe9wSUytDMdW7m4oK2cK2GqDd50cMMO1kXUDCo8ycdzX/F5kxc1yT2BDdc=
X-Received: by 2002:a0d:d614:0:b0:615:16a1:4a04 with SMTP id
 y20-20020a0dd614000000b0061516a14a04mr1202091ywd.31.1712887643882; Thu, 11
 Apr 2024 19:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081231.213406-1-nylon.chen@sifive.com>
 <20240222081231.213406-3-nylon.chen@sifive.com> <f5ukvah2ujko2iht3pd5jxq5kaukbs5z3pn5s7qwcnx4aqr3yv@mwtbwkcfa44a>
 <CAHh=Yk8MXy73d8M1J5bVu4spDMbjQDneVTqA=Ts=SGPDO7PXMQ@mail.gmail.com>
In-Reply-To: <CAHh=Yk8MXy73d8M1J5bVu4spDMbjQDneVTqA=Ts=SGPDO7PXMQ@mail.gmail.com>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Fri, 12 Apr 2024 10:07:12 +0800
Message-ID: <CAHh=Yk-WmzJe0vb+noX8Gb13BL2SOB=MwSB=F9nH_G-j9zi1Lw@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] pwm: sifive: change the PWM algorithm
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, conor@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, thierry.reding@gmail.com, 
	vincent.chen@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nylon Chen <nylon.chen@sifive.com> =E6=96=BC 2024=E5=B9=B44=E6=9C=882=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2024=E5=
=B9=B43=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:16=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > On Thu, Feb 22, 2024 at 04:12:30PM +0800, Nylon Chen wrote:
> > > The `frac` variable represents the pulse inactive time, and the resul=
t
> > > of this algorithm is the pulse active time.
> > > Therefore, we must reverse the result.
> > >
> > > The reference is SiFive FU740-C000 Manual[0]
> > >
> > > Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86=
ed8b16acba_fu740-c000-manual-v1p6.pdf [0]
> > >
> > > Co-developed-by: Zong Li <zong.li@sifive.com>
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > ---
> > >  drivers/pwm/pwm-sifive.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > index eabddb7c7820..a586cfe4191b 100644
> > > --- a/drivers/pwm/pwm-sifive.c
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -110,9 +110,10 @@ static int pwm_sifive_get_state(struct pwm_chip =
*chip, struct pwm_device *pwm,
> > >                               struct pwm_state *state)
> > >  {
> > >       struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_ddata(chi=
p);
> > > -     u32 duty, val;
> > > +     u32 duty, val, inactive;
> > >
> > > -     duty =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
> > > +     inactive =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm))=
;
> > > +     duty =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - inactive;
> > >
> > >       state->enabled =3D duty > 0;
> > >
> > > @@ -123,7 +124,7 @@ static int pwm_sifive_get_state(struct pwm_chip *=
chip, struct pwm_device *pwm,
> > >       state->period =3D ddata->real_period;
> > >       state->duty_cycle =3D
> > >               (u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
> > > -     state->polarity =3D PWM_POLARITY_INVERSED;
> > > +     state->polarity =3D PWM_POLARITY_NORMAL;
> > >
> > >       return 0;
> > >  }
> > > @@ -139,7 +140,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >       int ret =3D 0;
> > >       u32 frac;
> > >
> > > -     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > > +     if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > >               return -EINVAL;
> > >
> > >       cur_state =3D pwm->state;
> > > @@ -159,6 +160,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >       frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
Hi Uwe,
> > >       /* The hardware cannot generate a 100% duty cycle */
Do you mean that if the inference is correct, this comment should be modifi=
ed?
> >
> > Is this still true now that we know that PWM_SIFIVE_PWMCMP is the
> > inactive time in a period? If you fix that, the same claim in the heade=
r
> > of the driver needs adaption, too.
> I believe the statement is true, but I don't know which part the
> driver header file refers to.
> >
> > >       frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > +     frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> >
> > I like the additional variable in pwm_sifive_get_state(). Can you pleas=
e
> > add one here, too?
> got it
> >
> > >       mutex_lock(&ddata->lock);
> > >       if (state->period !=3D ddata->approx_period) {
> >
> Thank you for taking the time to help me review my implementation.
>
> Nylon
> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> > Industrial Linux Solutions                 | https://www.pengutronix.de=
/ |

