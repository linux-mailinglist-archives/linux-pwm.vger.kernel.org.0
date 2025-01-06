Return-Path: <linux-pwm+bounces-4538-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF5DA0214C
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2025 10:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7738E1884A9C
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2025 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B39715EFA0;
	Mon,  6 Jan 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Sg9h7Mkj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD6C1D89EF
	for <linux-pwm@vger.kernel.org>; Mon,  6 Jan 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736154049; cv=none; b=mpwoY4YwnQXwk0zXeBezSS29XwkBKz3JGRJVy47yr6TVXMaLpxfZtVVBm6MjvTOTnMSiF+gwa8A0V+QakU0TrOHhJ32ATGx+Wo0NfK5DBxTLzkQMjM8L9hNDXRCVsOY6llt8t7WwacIcwK14TpTE8fATVoJm7yvc/h6HulhFEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736154049; c=relaxed/simple;
	bh=jYHqjhGgrgod3hvoUgAQYREZkyt42xAO1UJ6qmllf4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjwOStBPjAM5PlTcujGcSGZgxBDwcji1oqf9w6jlM2wtM9noTer7pqeIU+BCfZxEayWydWKDVkmMPwbuxzt4qYnf62jnUirnrTHOSioJf1m+BxkuiWQ+Vsf4qHiB0kiuYrAVPIV1hZ08gMome/8rR7lmkOckge8yXJlorwCw/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Sg9h7Mkj; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85c41442fdeso2515358241.1
        for <linux-pwm@vger.kernel.org>; Mon, 06 Jan 2025 01:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1736154044; x=1736758844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqWDvGHWrGvSzvZ+8ugo2KRnlDSxD8xXB96mXOU0lg4=;
        b=Sg9h7MkjrifGwOEbei6dnxio/0yhSy7AaJlXT4MDZW3lm97t2rB9SF2p4S03CYDv+5
         jYdxSKwrPXSYmELrInLXFnv0uyhEAoIoHua7Ly72xJIcGm553oYDY6leYbYdKnvpgLzD
         +r+M1ObMLEX7BZ/QikcGAzYgS1Ap2zX/FBDyGoSLSTZsoQ5SbMBY+UvJd+V0TGJvq2fU
         2OCfIjPy29nT36xgbRMlO/qGjICArbtoUoVVz3Ww4E5/AdtQzinZ3N3feJQgKwP6zX8M
         Ecml0gpoZMh3V9tGoyKtvT6EB8FUW42ZlDeuMVxiREK2q0LCI8/nSlcgne5SU9IGcgIX
         a30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736154044; x=1736758844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqWDvGHWrGvSzvZ+8ugo2KRnlDSxD8xXB96mXOU0lg4=;
        b=VyxOf9i5Bs1aI0tKcJq7KQyXvomdTguPOxnH05aCSe6ATI+KDbZmjhpz8OkDSAny3G
         vnebezq17QX1+EtUNyVNHRqKwdgO98PVh+/rLmpz/EyEemETcRIQHjEahqjwIwGbaODu
         +N76Dbx6vLTcPcYi0jv5JnH/eDzSLt44M4Ms0UhkuVrY0pBQux/eoQ2EzMFnmFN0VhmI
         4bUL7t7OAv3lo3DM3hSPTiq4rVJ20CV7DMxQ8aUYPbwvr0Qnwjq5IHFznoDlWap0yj3z
         Dnirfr+AhNUzyYj2/S/+Vlo5IMVfOeSv5cXUe8eeg10mEguUgFrRMP+fzNX9cudkZHS/
         EV+w==
X-Forwarded-Encrypted: i=1; AJvYcCVidaT+KOK/JHaksfFnemu5cFfrHh7kg2vcQLdJ4s3gRjHixWONO56OOGq4v7fjZ2xcxq6tH5PvRJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyktowJl1hXujKXxI4U2643G0GhkjJohhpOBB46dcVr7Y+GNrvy
	axlgPiFoz8cuMYEpLpz/+fGmJ0B4XvECG7VPmrEZkRpcdiCVmAN1mE7s8+YLEEJSvmSd6eEhj/6
	JpyafsOo3TD41tHhJ4jG6s7ZRed+LH2tuRYE2Rg==
X-Gm-Gg: ASbGncsnd+KbjjKUMtbkSNb5PrGZXt+nH3bDDWgp/aihS2JdHO7/hihMf7wiZ5/QpCc
	05ltFI0ne/0rY3UqPbYQI4yNt16a35/gaWbnRSLRv
X-Google-Smtp-Source: AGHT+IEi3ZBafEZiHUD7dXioBMaLkm1e2JoCKXblv3XIfUY1bATE2OhPY0NnTbQT5snAk04oeSJgkfFVx4e/nsM3hb0=
X-Received: by 2002:a05:6102:2914:b0:4b2:cbe4:5999 with SMTP id
 ada2fe7eead31-4b2cc493769mr42332843137.23.1736154044154; Mon, 06 Jan 2025
 01:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081231.213406-1-nylon.chen@sifive.com>
 <20240222081231.213406-4-nylon.chen@sifive.com> <jvwgsszvs4jtcytcphsdjulzgqfqzdp4sisu236ddwsqgmvriw@ngi4ljgh5b74>
 <CAHh=Yk92=hp+kaTJWL13_jwJ5gzAAi8gbRF=Ns9=yq2trRUQEg@mail.gmail.com>
 <xf6ympnaljfjztptb5w5qdpuluckptozdz5a7gtuycsev32ngr@x2ovibqv6evr>
 <CAGKtFavQAZOof5QSTFCEaRJEPETm5aBqzkV4g24n3ioiBAOgDA@mail.gmail.com> <p6rqpx3yrn2ib4ulmby7tbnpbg4bjyt4dt6snrmhuyw6hx6izl@lywssban54et>
In-Reply-To: <p6rqpx3yrn2ib4ulmby7tbnpbg4bjyt4dt6snrmhuyw6hx6izl@lywssban54et>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Mon, 6 Jan 2025 17:00:32 +0800
Message-ID: <CAHh=Yk-iFGULUQc-U-PNjx-st7d5KER3J+t54SNERVaNr++qoQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] pwm: sifive: Fix the error in the idempotent test
 within the pwm_apply_state_debug function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Nylon Chen <nylon7717@gmail.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, conor@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, thierry.reding@gmail.com, 
	vincent.chen@sifive.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =E6=96=BC 2024=E5=B9=
=B412=E6=9C=8827=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:39=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> On Tue, Dec 24, 2024 at 04:34:53PM +0800, Nylon Chen wrote:
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2024=
=E5=B9=B44=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:05=E5=
=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Apr 02, 2024 at 10:01:39AM +0800, Nylon Chen wrote:
> > > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 20=
24=E5=B9=B43=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:17=
=E5=AF=AB=E9=81=93=EF=BC=9A
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Thu, Feb 22, 2024 at 04:12:31PM +0800, Nylon Chen wrote:
> > > > > > Round the result to the nearest whole number. This ensures that
> > > > > > real_period is always a reasonable integer that is not lower th=
an the
> > > > > > actual value.
> > > > > >
> > > > > > e.g.
> > > > > > $ echo 110 > /sys/devices/platform/led-controller-1/leds/d12/br=
ightness
> > > > > > $ .apply is not idempotent (ena=3D1 pol=3D0 1739692/4032985) ->=
 (ena=3D1 pol=3D0 1739630/4032985)
> > > > > >
> > > > > > Co-developed-by: Zong Li <zong.li@sifive.com>
> > > > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > > > > ---
> > > > > >  drivers/pwm/pwm-sifive.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.=
c
> > > > > > index a586cfe4191b..bebcbebacccd 100644
> > > > > > --- a/drivers/pwm/pwm-sifive.c
> > > > > > +++ b/drivers/pwm/pwm-sifive.c
> > > > > > @@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct =
pwm_sifive_ddata *ddata,
> > > > > >
> > > > > >       /* As scale <=3D 15 the shift operation cannot overflow. =
*/
> > > > > >       num =3D (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_C=
MPWIDTH + scale);
> > > > > > -     ddata->real_period =3D div64_ul(num, rate);
> > > > > > +     ddata->real_period =3D DIV_ROUND_UP_ULL(num, rate);
> > > > > >       dev_dbg(ddata->chip.dev,
> > > > > >               "New real_period =3D %u ns\n", ddata->real_period=
);
> > > > > >  }
> > > > Hi Uwe
> > > > >
> > > > > pwm_sifive_apply has a DIV64_U64_ROUND_CLOSEST(). I wonder if tha=
t needs
> > > > > adaption, too?!
> > > > According to my experiments, no adjustment is necessary.
> > >
> > > Did you enable PWM_DEBUG and tested with something like:
> > >
> > >         seq 5000 100000 | while read p; do echo p > /sys/class/pwm/pw=
mchipX/pwmY/period; done
> > >
> > Hi Uwe,
> > I apologize for the significant delay in responding to your query,
> > I've now completed a thorough verification of the PWM_DEBUG
> > functionality.
> >
> > The Period Testing:
> > seq 5000 5000 100000 | while read p; do echo $p >
> > /sys/class/pwm/pwmchip0/pwm0/period echo "Testing period: $p" done
> >
> > The Duty Cycle Testing:
> > for percent in 0 25 50 75 100; do duty=3D$((100000 * percent / 100))
> > echo $duty > /sys/class/pwm/pwmchip0/pwm0/duty_cycle done
>
> This is unlikely to find the issues that I have in mind. If doing ~100k
> assignments is too much, please keep the +1 step but restrict the
> interval.
Hi Uwe, I have made the following adjustments based on your
requirements. Does this align with what you had in mind?
- period
seq 5000 1 15000 | while read p; do echo $p >
/sys/class/pwm/pwmchip0/pwm0/period echo "Testing period: $p" done

- duty cycle
for duty in $(seq 0 1 10000); do echo $duty >
/sys/class/pwm/pwmchip0/pwm0/duty_cycle echo "Testing duty cycle:
$duty" done
>
> Best regards
> Uwe

