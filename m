Return-Path: <linux-pwm+bounces-7857-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC83CF80E5
	for <lists+linux-pwm@lfdr.de>; Tue, 06 Jan 2026 12:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092BA303E667
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jan 2026 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE252F360A;
	Tue,  6 Jan 2026 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mizbAzOs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-106105.protonmail.ch (mail-106105.protonmail.ch [79.135.106.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A313B293
	for <linux-pwm@vger.kernel.org>; Tue,  6 Jan 2026 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699051; cv=none; b=kYzHYY77DpcUSM4P91jk9bnSA34HUq1nr+5nMg0QNp4usnPasWPWzi54QqIBkPWJ/fpU5P5uZCNm74v0DUx0xsuMCW7Hj9/7wBAQ/ZbGQ+FM20YVdM3JlJTLPa6auhgUQla4QDl0G+pLdvqLxfwsDizCcpMxNQteHkrXX6XLUbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699051; c=relaxed/simple;
	bh=zeytZDKo2QT/k8ZiKMfO0addLULG9aTa2dZdhOVy/Pg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEnyBHQ2Hkjg+aiLtmgJx/Ffs/PW8zl7cEKWTcWZDylXFMI28YwDTNcs5//XunVwUmD+5NVOUT5iFz1n+Qp3Inwj6i+/2+0d3IVeum7YH/nHTKNkRaQaUSFg9P1gXpukzc9QWdVN/Y0pv6aheeaF/nle4w2614ZGBR+2GihtJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mizbAzOs; arc=none smtp.client-ip=79.135.106.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1767699039; x=1767958239;
	bh=mpZ9a6BXZLK2t8VLw/I32vovbpQXSb2aQUMDb54O4es=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mizbAzOsLh3qycHcIAVYKJQ+eFrxAa5/EfrTxq2h4TvFlUp/ck2DJTtSh2jyedtyw
	 yiusH5ZdqIV3dYLmdc6cxVeixwBM/XaaBCuQDukVVfs4BhJe5sy2seNLHdLR9nf27q
	 yKrmMQn/Nni3gDKD7oqyRu8LRNsJDPa5rvLyXTnTnjn4sOhlQiYxhykXPi1JSIL14r
	 +bbvi+DifomcYj4aIIfg23ECZKtNfcgQBFu8LKWZX3288fYl+3J27ES1Wj3D1gKfxj
	 oXmGa9gponyar1Y9QpPU58qCLEIJlaUGEMXD78WJVPOxEuRYrgPiKQZpI5sb7Da3Fu
	 +ugk9btn6901A==
Date: Tue, 06 Jan 2026 11:30:34 +0000
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
Message-ID: <2e2iahbzcepbzwgk7xeta2afxmycfjgv2zofzngqjvp4on46r2@mzpi4bz4uqie>
In-Reply-To: <kemjjoyrhqglqq4p2j6kygspevq2mdbiujtnksw4rkdapoqcfy@zte2c7fhqvn3>
References: <20260106-stm32-pwm-v1-1-33e9e8a9fc33@geanix.com> <kemjjoyrhqglqq4p2j6kygspevq2mdbiujtnksw4rkdapoqcfy@zte2c7fhqvn3>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 2e006c92e9af34182a73b56e93f3230599eee605
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Tue, Jan 06, 2026 at 11:22:57AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Sean,
>=20
> On Tue, Jan 06, 2026 at 08:01:57AM +0100, Sean Nyekjaer wrote:
> > After commit 7346e7a058a2 ("pwm: stm32: Always do lazy disabling"),
> > polarity changes are ignored. Updates to the TIMx_CCER CCxP bits are
> > ignored by the hardware when the master output is enabled via the
> > TIMx_BDTR MOE bit.
> >=20
> > Handle polarity changes by temporarily disabling the PWM when required,
> > in line with apply() implementations used by other PWM drivers.
> >=20
> > Fixes: 7346e7a058a2 ("pwm: stm32: Always do lazy disabling")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > This patch is only applicable for stable tree's <=3D 6.12
> > How to explicitly state that and what is the procedure?
>=20
> I haven't checked in detail yet but I wonder if the problem also exists
> in newer kernels. Also I think that changing the polarity with the
> hardware on happend before 7346e7a058a2; in that case you blamed the
> wrong commit.

For your reference i bisected to that commit.

>=20
> So even if we decide to apply a small targetted fix for the issue you
> report to stable without an equivalent commit in mainline (due to the
> rework the driver saw in v6.13-rc1~157^2~9^2~3 ("pwm: stm32:
> Implementation of the waveform callbacks")), I refuse to do that if the
> problem still exists in mainline.
>=20

I have tried to boot stable/master 6.19.0-rc4, my backlight is on!
In stm32_pwm_write_waveform() TIMx_CCER is set before MOE is set.

> > ---
> >  drivers/pwm/pwm-stm32.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index eb24054f9729734da21eb96f2e37af03339e3440..d5f79e87a0653e1710d46e6=
bf9268a59638943fe 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -452,15 +452,23 @@ static int stm32_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> > =20
> >  =09enabled =3D pwm->state.enabled;
> > =20
> > +=09if (state->polarity !=3D pwm->state.polarity) {
> > +=09=09if (enabled) {
> > +=09=09=09stm32_pwm_disable(priv, pwm->hwpwm);
> > +=09=09=09enabled =3D false;
> > +=09=09}
> > +
> > +=09=09ret =3D stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity=
);
> > +=09=09if (ret)
> > +=09=09=09return ret;
> > +=09}
> > +
> >  =09if (!state->enabled) {
> >  =09=09if (enabled)
> >  =09=09=09stm32_pwm_disable(priv, pwm->hwpwm);
> >  =09=09return 0;
> >  =09}
> > =20
> > -=09if (state->polarity !=3D pwm->state.polarity)
> > -=09=09stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
> > -
> >  =09ret =3D stm32_pwm_config(priv, pwm->hwpwm,
> >  =09=09=09       state->duty_cycle, state->period);
> >  =09if (ret)
>=20
> I would prefer the following change:
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index eb24054f9729..5f118c20f1ca 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -452,12 +452,16 @@ static int stm32_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> =20
>  =09enabled =3D pwm->state.enabled;
> =20
> -=09if (!state->enabled) {
> +=09/* The hardware must be disabled to honor polarity changes. */
> +=09if (!state->enabled || state->polarity !=3D pwm->state.polarity) {
>  =09=09if (enabled)
>  =09=09=09stm32_pwm_disable(priv, pwm->hwpwm);
> -=09=09return 0;
> +=09=09enabled =3D false;
>  =09}
> =20
> +=09if (!state->enabled)
> +=09=09return 0;
> +
>  =09if (state->polarity !=3D pwm->state.polarity)
>  =09=09stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
> =20
> Maybe it's just me, but I think the resulting code is simpler with this
> hunk.

Fine with me, I just looked at the other PWM drivers and copy/pasted
from them :)

>=20
> I have hardware using this driver, will set it up later this week for
> testing.

Very cool, looking forward to hear if you can re-produce.

>=20
> Best regards
> Uwe

/Sean


