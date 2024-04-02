Return-Path: <linux-pwm+bounces-1842-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93F894921
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 04:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7DAB22D47
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 02:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A6BD53C;
	Tue,  2 Apr 2024 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SI2j69fH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50667D51D
	for <linux-pwm@vger.kernel.org>; Tue,  2 Apr 2024 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023702; cv=none; b=LBnYerACuhVUQT/oeCsZBFNpAPY8guuwp2culUH88TqhS6VpdUsASXhfKVTsO4BqJNNfbBjoVeYwQtxugdWfkPxcv9GOT9J/LjW5RFKs+BAU6hAM5X5j8Y5CLijHM2ncPHsjvmWw/YoanuZ4Zz63ezY/GVDUZ99iDpgAwx5bWvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023702; c=relaxed/simple;
	bh=PrlGp1dxOAI91R3aGTmxXIR4ZfxIcjbvIEqWZhUIigs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDpYjJJhIQYEngEXu/95JjNykJTOMItEqNBVo8byCqScrnVKr1idsujsgVRTMKDu4h1VhsachsYNcDG9Qx4xbtwkU2XDWc3G0bxYQ02r0PyVOHHagHCLPQDGEuaKapOYmzRUoYXki/A6z/2o2UnH6044xm+/owkzNi5KdhEoXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SI2j69fH; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-615019cd427so8125407b3.3
        for <linux-pwm@vger.kernel.org>; Mon, 01 Apr 2024 19:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712023699; x=1712628499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO2nKjxSM3VMmgCum0y14ZLXUnNoa4kf/yRJ6eyJhQc=;
        b=SI2j69fHr04DKp0u1mvSX/TxpKTZhuEBPVvkuZtYQyxPTS8mgIgok9VPgoXbZ51WJV
         ynoR9UtKfGf/nh29WcZ2Lrdc2iblrDppKQbdVSrPIYmf+D7kZ65Qof97M2EROqeYqDte
         6VShohu5/Pi4enBFf35Mfn0CcpNujdAm/l7s4ystncgmJqcnX5XgectMRYfYHjL0JPMF
         OUZc1nmDvJ2pDTCe7kriOmtdi6mmKhjmLc/ViMpJcThygUqJIUkdnkNV6Xv2A+k+hXaR
         xywKUt21dCDOWxS/vPyDvKM1vM5RI4f/nPVSJZlqAMrM2u4nsmw4FOtzI+pGrSeUH4bM
         PF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712023699; x=1712628499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aO2nKjxSM3VMmgCum0y14ZLXUnNoa4kf/yRJ6eyJhQc=;
        b=aW2cckMR1/WPMZApAmmoXsntiNNaYLV72quLNhSdU6LCEWE/CNNGfKtzulmIwdfMrq
         xjooqlcO0YYRsFfXlkQN82nkXU+ekyRqvd6JvBibPjqJZF5eF/CBPRpiWMT+moEK2zv7
         Tzqcd0wosaLSjLyYnk6x3nUhS5GfQLel4Pkc2Pv7/KmSbVffjORGEZRUk9L5PwR+jNO1
         i9lvap4v4I0y7/JfVoHZRuQmVT34JhkUwDjWScnJIl4HG4unZUyq5cbcT2bEh8PrrFDe
         nZox25fRomfmhJ1fJMXs9C2K0LETBgm7nUdvGonC7GWIhHiQ02zQkKmxFiCkTzI99KDJ
         G6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWV1/d2yAh0XchQnPgf5UloJWc1cUJ9fNeWLYfqnkCdrd5IGHwT+NgVc+1AiaL/65r3zNnzLC1KNON64Ed4PFLUBTVT3wSvAIY6
X-Gm-Message-State: AOJu0YwMNu4z2X2dpqVMeA3C78VRPS2tQegq/frEpd1oPUee+oUW0YEn
	OQ17mb4U+fHKJ+ow1e5eq2PO/GIJsV6+/c/gsH6RMpyXcUay0ULigl9zELxaAFiot/q9kLVOzIh
	hnhlCeK87Dl5PgvmvRNv+Y8i7LlZGac5WV1zPjA==
X-Google-Smtp-Source: AGHT+IH3DILv5+78c1GHhnyaPQm/r0jIaMiTrNrIh4LNwLDk/VMmQxGRZ3ndmVTuyIWK1baCoGbKbbm8kZWFSv0sI0s=
X-Received: by 2002:a81:7788:0:b0:610:973f:3877 with SMTP id
 s130-20020a817788000000b00610973f3877mr9996133ywc.35.1712023699215; Mon, 01
 Apr 2024 19:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081231.213406-1-nylon.chen@sifive.com>
 <20240222081231.213406-3-nylon.chen@sifive.com> <f5ukvah2ujko2iht3pd5jxq5kaukbs5z3pn5s7qwcnx4aqr3yv@mwtbwkcfa44a>
In-Reply-To: <f5ukvah2ujko2iht3pd5jxq5kaukbs5z3pn5s7qwcnx4aqr3yv@mwtbwkcfa44a>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Tue, 2 Apr 2024 10:08:08 +0800
Message-ID: <CAHh=Yk8MXy73d8M1J5bVu4spDMbjQDneVTqA=Ts=SGPDO7PXMQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] pwm: sifive: change the PWM algorithm
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, conor@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, thierry.reding@gmail.com, 
	vincent.chen@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2024=E5=B9=
=B43=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:16=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Thu, Feb 22, 2024 at 04:12:30PM +0800, Nylon Chen wrote:
> > The `frac` variable represents the pulse inactive time, and the result
> > of this algorithm is the pulse active time.
> > Therefore, we must reverse the result.
> >
> > The reference is SiFive FU740-C000 Manual[0]
> >
> > Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed=
8b16acba_fu740-c000-manual-v1p6.pdf [0]
> >
> > Co-developed-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > ---
> >  drivers/pwm/pwm-sifive.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > index eabddb7c7820..a586cfe4191b 100644
> > --- a/drivers/pwm/pwm-sifive.c
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -110,9 +110,10 @@ static int pwm_sifive_get_state(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> >                               struct pwm_state *state)
> >  {
> >       struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_ddata(chip)=
;
> > -     u32 duty, val;
> > +     u32 duty, val, inactive;
> >
> > -     duty =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
> > +     inactive =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
> > +     duty =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - inactive;
> >
> >       state->enabled =3D duty > 0;
> >
> > @@ -123,7 +124,7 @@ static int pwm_sifive_get_state(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> >       state->period =3D ddata->real_period;
> >       state->duty_cycle =3D
> >               (u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
> > -     state->polarity =3D PWM_POLARITY_INVERSED;
> > +     state->polarity =3D PWM_POLARITY_NORMAL;
> >
> >       return 0;
> >  }
> > @@ -139,7 +140,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >       int ret =3D 0;
> >       u32 frac;
> >
> > -     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > +     if (state->polarity !=3D PWM_POLARITY_NORMAL)
> >               return -EINVAL;
> >
> >       cur_state =3D pwm->state;
> > @@ -159,6 +160,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >       frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> >       /* The hardware cannot generate a 100% duty cycle */
>
> Is this still true now that we know that PWM_SIFIVE_PWMCMP is the
> inactive time in a period? If you fix that, the same claim in the header
> of the driver needs adaption, too.
I believe the statement is true, but I don't know which part the
driver header file refers to.
>
> >       frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > +     frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
>
> I like the additional variable in pwm_sifive_get_state(). Can you please
> add one here, too?
got it
>
> >       mutex_lock(&ddata->lock);
> >       if (state->period !=3D ddata->approx_period) {
>
Thank you for taking the time to help me review my implementation.

Nylon
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

