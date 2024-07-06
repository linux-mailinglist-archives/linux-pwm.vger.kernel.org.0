Return-Path: <linux-pwm+bounces-2716-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7447B92948B
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jul 2024 17:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8588B20BAC
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jul 2024 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CAC13AD3F;
	Sat,  6 Jul 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zILM/dt9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544E24B5B
	for <linux-pwm@vger.kernel.org>; Sat,  6 Jul 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279512; cv=none; b=flTHRgZwz6PNlQpnU9jv9LVMdlid8SAfB2HQkxw7dCy9wZbnFr0RnUOGoTMhSPhK7rGaHP+1bZY0xxixdhEfF9vQ+8Rt998IakQsUmXoAmr3R4VznvMEwh+2mNacWOO9909E4Zk0oiDTtMeIz58CHN+GdOxux77Hvb2a7fXkhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279512; c=relaxed/simple;
	bh=MMjpgBOos9366GDTm1UOWVsWsj4zBPMgnBONKbFX28Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtDGZ4ctQcwgFgGVPEw2Vt/b+kqlLlSxYamGkl1AV71nZtzlzCePK/A9/+eFZLTknG2AElcx/vWEauXfJSQy7jjSON8/It1n6daTkQ4wrsnPe+2T+mK8I/CyqPx/F547b0KYXb80K7NbBlqCMp45k0IzJ3S35zuEWHvqrTnhBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zILM/dt9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso3056142a12.1
        for <linux-pwm@vger.kernel.org>; Sat, 06 Jul 2024 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720279508; x=1720884308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BK8LdtUzBaUosA9+7VEP7WADZJTDrOQiZ2DP4ZbEJEs=;
        b=zILM/dt9vNuui+bzAzN9w9GBV4xAYtq4W53kRJ09PuKEa8TURW1L/z5MjUik03V2x+
         g116ZjmRAYTur6v94hZBy4u43qQ6YtANW0cdAqhDhrkH1kFVXYQLJVEBmbOk6yLRIdRs
         Ar2p3JngYj1xamUnOemMAMwYKEJYty/ccPAslyf1I0x7L1jXCyflf+FaW7AmqjbNPdWb
         0QyBrUCmBlQgbYSH7P3FOmh8DOtsiy01o3E/K14NFq3ijcVQculGXDkXPrSwYAMvdLq/
         uH7COlH166NgEREtCXH2Ix4DnTkwkfTRa4Hl7plOLZM+D0c6CYd09GV+Z8Y1fKXhyT7p
         klwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720279508; x=1720884308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK8LdtUzBaUosA9+7VEP7WADZJTDrOQiZ2DP4ZbEJEs=;
        b=V+7HCdHFGmOsNQQYL6rKial5AbNTRTOnPwzCPssNw+3QZSTEz2vxjkXH3JN4OEPO03
         5TCudzsyL4DzATTuN/HDEwy9XH5oa8A30I7ywqG0qZ0XcCDYmqlezAjUBVZEDQDD6xPJ
         yQdc8mEwT0s3/FL+3nxoGMaH+dZYJax28a3pdZyCnsyFKcbw0zRL9+hfQ+tUuaO1uzH+
         /UdNYxd3nsauK+CieBYzOzJg/4S97/g6hrft/IPPC+y6cuFMKDrC1jtur4AB3O5B6MJt
         PWCBxU47qEcrHB8F2lS5MHQuImPjvRMrvlPCGSFcmNmvKNK0h6XIUixaHSPfs6y0FuSi
         ulfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYeC0Br13YpNessAS4a5ZYB6yi5SBVL9ZxLMvGO8WCvTLxsVb6fmIXwlVHskS6rB19Y9G8Oso+MpIWncOXg1FuZ+J+vkUxm5YQ
X-Gm-Message-State: AOJu0YxJVmkZM3Z8LXumBvxKVt3eFBewSeR4WKGxLlOlGGk4mSBPAXTZ
	iAHCLiSns5iG2VgXno8VwgJ16BBjXNG+YjAghsuE71AxrG/2n0Xg66AJM5DqMrs=
X-Google-Smtp-Source: AGHT+IEnWqknQxLnJEpexUB0z6PrbG+3ja7xvUWGsdML6+Dfe1thhIKgJ7dK9+/TLjN2rT5ex8eOVQ==
X-Received: by 2002:a05:6402:612:b0:58b:abc6:9cec with SMTP id 4fb4d7f45d1cf-58e5cd15312mr3739642a12.40.1720279507998;
        Sat, 06 Jul 2024 08:25:07 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324fe5dsm10895092a12.36.2024.07.06.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:25:07 -0700 (PDT)
Date: Sat, 6 Jul 2024 17:25:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 2/2] pwm: Add Loongson PWM controller support
Message-ID: <2mrfd5qe742zxz4mxd64jiwiebuvqnlxo5ezbikk77f6eh6rnw@ebc3uxneij5m>
References: <cover.1716795485.git.zhoubinbin@loongson.cn>
 <23d08fa45237efd83cb9dd51a259e2c980f01b3f.1716795485.git.zhoubinbin@loongson.cn>
 <b2lyte7dtrdxxoj4rwwrxbt5myc3td7v3psus7h36qc7dp3thh@czfp25bferl4>
 <CAMpQs4Lo55VhFCNKFxjdA2zMt8GdMTo4sn4BXdy8Nr+kq2OfvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6grgdfuogy5smzhk"
Content-Disposition: inline
In-Reply-To: <CAMpQs4Lo55VhFCNKFxjdA2zMt8GdMTo4sn4BXdy8Nr+kq2OfvQ@mail.gmail.com>


--6grgdfuogy5smzhk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Binbin,

On Sat, Jul 06, 2024 at 03:08:30PM +0600, Binbin Zhou wrote:
> Hi Uwe:
>=20
> Thanks for your reply.
>=20
> On Sat, Jul 6, 2024 at 5:26=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Hello,
> >
> > On Mon, May 27, 2024 at 03:51:12PM +0800, Binbin Zhou wrote:
> > > +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> > > +                           const struct pwm_state *state)
> > > +{
> > > +     int ret;
> > > +     u64 period, duty_cycle;
> > > +     bool enabled =3D pwm->state.enabled;
> > > +
> > > +     period =3D min(state->period, NANOHZ_PER_HZ);
> > > +     duty_cycle =3D min(state->duty_cycle, NANOHZ_PER_HZ);
> > > +
> > > +     if (state->polarity !=3D pwm->state.polarity) {
> > > +             if (enabled) {
> > > +                     pwm_loongson_disable(chip, pwm);
> > > +                     enabled =3D false;
> > > +             }
> > > +
> > > +             ret =3D pwm_loongson_set_polarity(chip, pwm, state->pol=
arity);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     if (!state->enabled) {
> > > +             if (enabled)
> > > +                     pwm_loongson_disable(chip, pwm);
> > > +             return 0;
> > > +     }
> >
> > Given that the configured polarity isn't relevant for a disabled PWM, I
> > suggest to swap these two if blocks. However then you have to be a bit
> > more careful for the polarity check because otherwise the following
> > series of commands yields wrong results:
> >
> >         pwm_apply_might_sleep(pwm, {.duty_cycle =3D D, .period =3D P, .=
polarity =3D PWM_POLARITY_NORMAL, .enabled =3D true});
> >         pwm_apply_might_sleep(pwm, {.duty_cycle =3D D, .period =3D P, .=
polarity =3D PWM_POLARITY_INVERSED, .enabled =3D false});
> >         pwm_apply_might_sleep(pwm, {.duty_cycle =3D D, .period =3D P, .=
polarity =3D PWM_POLARITY_INVERSED, .enabled =3D true});
> >
>=20
> Yes, we'd better make sure pwm is enabled first.
> I will swap the two if blocks.
>=20
> > > +     ret =3D pwm_loongson_config(chip, pwm, duty_cycle, period);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (!enabled)
> > > +             ret =3D pwm_loongson_enable(chip, pwm);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_=
device *pwm,
> > > +                               struct pwm_state *state)
> > > +{
> > > +     u32 duty, period, ctrl;
> > > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip=
);
> > > +
> > > +     /* duty_cycle =3D ddata->duty * NSEC_PER_SEC / ddata->clk_rate =
*/
> > > +     duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
> > > +     state->duty_cycle =3D mul_u64_u64_div_u64(duty, NSEC_PER_SEC, d=
data->clk_rate);
> > > +
> > > +     /* period =3D ddata->period * NSEC_PER_SEC / ddata->clk_rate */
> > > +     period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
> > > +     state->period =3D mul_u64_u64_div_u64(period, NSEC_PER_SEC, dda=
ta->clk_rate);
> > > +
> > > +     ctrl =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> > > +     state->polarity =3D (ctrl & LOONGSON_PWM_CTRL_INVERT) ? PWM_POL=
ARITY_INVERSED :
> > > +                       PWM_POLARITY_NORMAL;
> > > +     state->enabled =3D (ctrl & LOONGSON_PWM_CTRL_EN) ? true : false;
> > > +
> > > +     return 0;
> >
> > You didn't test extensively with PWM_DEBUG enabled, right? You need to
> > round up the divisions here otherwise you get strange rounding results:
> >
> > Consider ddata->clk_rate =3D 1594323. When a state with .period =3D 200=
00 is
> > applied, LOONGSON_PWM_REG_PERIOD is assigned 31.
> > Calling .get_state() in this situation gives .period =3D 19443. Reapply=
ing
> > .period =3D 19443 results in LOONGSON_PWM_REG_PERIOD :=3D 30. Iterating=
 this
> > further yields:
> >
> >  - .period =3D 18816
> >  - LOONGSON_PWM_REG_PERIOD :=3D 29
> >  - .period =3D 18189
> >  - LOONGSON_PWM_REG_PERIOD :=3D 28
> >  - ...
> >
> Yes, I'm very sorry I didn't do extensive testing with PWM_DEBUG enabled.
> Here I do need to use DIV64_U64_ROUND_UP().
>=20
> Below:
>=20
>         /* duty_cycle =3D ddata->duty * NSEC_PER_SEC / ddata->clk_rate */
>         duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
>         state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)duty *
> NSEC_PER_SEC, ddata->clk_rate);
>=20
>         /* period =3D ddata->period * NSEC_PER_SEC / ddata->clk_rate */
>         period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
>         state->period =3D DIV64_U64_ROUND_UP((u64)period * NSEC_PER_SEC,
> ddata->clk_rate);
>=20
>=20
> I'd also like to ask which tests I still need to do to make sure the
> driver is more complete?

There is no official lower limit on tests. But the goal is that your
driver behaves correctly and some of the typical errors can be catched
by enabling PWM_DEBUG and then doing the following tests for sensible
values of A and B:

	# Sequence of increasing periods
	for period in A ... B:
		configure 0/period

	# Sequence of decreasing periods
	for period in A ... B:
		configure 0/(B + A - period)

	for period in some set:
		# Sequence of increasing duty length
		for duty_cycle in 0 ... period:
			configure duty_cycle/period

		# Sequence of decreasing duty length
		for duty_cycle in 0 ... period:
			configure (period - duty_cycle)/period

That should give you a good coverage.

The idea of extensive testing on your side is also: Review capacities
are a scarce resource and you suffer from that because it takes some
patience between you sending a patch and a maintainer coming around to
review it. If your code is well tested, there is less for the
maintainers to find and so I save time because there are less revisions
and they mature quicker. The direct consequence for you and the others
waiting for my attention should be obvious. (This also means: If you
look into other's patch submissions and point out the things you already
learned to them, you also save maintainer time and so might get their
attention earlier yourself.)

I'm working on a bigger change for the pwm subsystem. One of the results
will be a new userspace API. I intend to create a test program that does
the above tests, so in the foreseeable future testing should get easier.
(In return writing a lowlevel driver will become a bit harder, as the
requirements for precision increase.)

Best regards
Uwe

--6grgdfuogy5smzhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaJYc4ACgkQj4D7WH0S
/k5GjAf/T5cnZCbZWPmsKHJi6Yk0Kx4vG6/4qPLHyqW6p9SD659LCAGHwkP9cVPc
rf5WvR5J0ZNwt0JHR+6C3QSp29HYmzCOTPWMVKK3E/bSUGygVqHtQGFkRa8I8g3F
XqKAJD96fUMGzE+lPA8L0XxLez0Bez8rKpwjm70CkIw1fAeSZvS7sDj9xT8qTQAF
qnTRQZNRdUvNhesBxRnEO279ER8wO78FMlo31LTWWoP3aBMVGnjdy/l3xqUUQIbC
Z83cnxp4Zmor8vTCsscHs9v6Xm5mG5q3yLZYRQNxOyvZ98eJ83rFoZXyHscLJb5v
2YZztNZrch2uKGnT1AMimKotTYoJAA==
=JU6c
-----END PGP SIGNATURE-----

--6grgdfuogy5smzhk--

