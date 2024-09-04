Return-Path: <linux-pwm+bounces-3091-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6BF96C4DC
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2024 19:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A9E1F227A6
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2024 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4541DA31D;
	Wed,  4 Sep 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1OU3SPLZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253BA43152
	for <linux-pwm@vger.kernel.org>; Wed,  4 Sep 2024 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469529; cv=none; b=kJT/pFf03YSu/dwPOUVKrdL77BlvU/pw/UhvD1M9CUn/OXPnfHkYsD4t5sO3aum0D+SlCYHA3ijugtK9f7dywPFIQvvWnh2QE+MkFatl4x/ofvwON731KtyHJvAVW1LTFLgmc0YAHm89ndOBcb1fghDiTUjbqLsTrgMY97FAXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469529; c=relaxed/simple;
	bh=0Hq9dizH83vS4znrymzYAB7bQ7PnqyC9VbTZuVB5+Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7bcB0QCXS5R3dvftfrP0G7cnkIqjULjCYTv+QdUev4/Adkb8eTmxASiw9hFhYZ8RNu/J4dOOnUBE+K+gEoUloge3xAm0LJlS655D0uSaDB2um4uBC9my5eSvNMgLbreVVxWdPZ32wwYYUAR4E8lpF0XTCmp/FPlPT5HR3vbyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1OU3SPLZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a81bd549eso638389966b.3
        for <linux-pwm@vger.kernel.org>; Wed, 04 Sep 2024 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725469524; x=1726074324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxXuLysi6zz+I5M8mPOGoQ0hAmAHwgPJncxxEP7nPHk=;
        b=1OU3SPLZvyMLFzZ2M6EdO0dzzoySnelGjUK0ScN4c5LJNshWO2EsXIiskROlotSjLX
         WSGElmnJIpNPlKfmeLYYqMzR+d6oSPCz6NPR9tGjjY5zVGta5ButXqfNEdCWlcdcRcke
         5BgMNYt6bkUyCQxI59ErfwMmke0lEie9tgweaJgK8cEbcJjxXcp+6HGMcmQm99bBBohn
         ZN7ZC/ap2UQfLbPlZFwo2SVYpwZoM7TovAytOmbcjpWQZ6rLQbIuLQAhLTnXjqVkbrII
         RU7MCyrB5BuRRmH8zLRo+58sGweTc4s0CidZfhaLA8XRu21AgZ/zRGHEVacWrct7U9vR
         Vgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469524; x=1726074324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxXuLysi6zz+I5M8mPOGoQ0hAmAHwgPJncxxEP7nPHk=;
        b=X2WLrlOClX4V0X2XmsR9ZWxCcdagKt1sKDxg70xsks7sZd0mtcBuJHIaPiXkUhUQAL
         TkwJzb18OuZabOnMglL21fZ1P1GG3xa6/dzbhwHDjtEEUCX9QOsj+vZ6d2Y8zeeA0eJL
         1qrIB2RRdFYjLE/5P/Hm2jWzZ9ckdHzoDb0/sVgXbbXiKVW5hLWqUMBWATPefcrgp4Z8
         MnEZYrFxpmP7dngHOG8cMk7sDARlQ96JTszpSnZJZjvFIrYb6OMAPD+4Ia/OuG/ipPAR
         lYm1RAsiZX9FKtGIzfVpqBeaaUJsTrWg4as6Q+1+LntgyK/smv6JM5XqWzKHLUpr3Z3G
         kQJQ==
X-Gm-Message-State: AOJu0Ywb5G0WfXEQwzH66UzY9croO8uEqh2aWuxHDMlzAT1ghd+vh13H
	sdL+31n6SwgAp8NC9n8KaBZOaPHHYkrSSSninidVAYRz2IgDfQ/InaqQP2ORNVo=
X-Google-Smtp-Source: AGHT+IFMseDQF5UPnOh8PA4y/y8Nr9TRKquBerSHczMHl+FVUsVLaE/xMknCLEcoQh9UincHEuOf7A==
X-Received: by 2002:a17:907:7290:b0:a86:ac86:1e17 with SMTP id a640c23a62f3a-a8a1d4c3496mr575073066b.54.1725469524287;
        Wed, 04 Sep 2024 10:05:24 -0700 (PDT)
Received: from localhost (p200300f65f0046006ae56225a49a5edb.dip0.t-ipconnect.de. [2003:f6:5f00:4600:6ae5:6225:a49a:5edb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a620840b6sm15222866b.92.2024.09.04.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 10:05:23 -0700 (PDT)
Date: Wed, 4 Sep 2024 19:05:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-pwm@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v3 8/8] pwm: stm32: Implementation of the waveform
 callbacks
Message-ID: <yg654oehmaqjx5fbnoungvrbbx3pnnvhyo7mct2tk334tgadpk@4qz5n6wkrwgy>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
 <b193c8d4bc8e188ad6b4b4ddb6f730308d7f1099.1722261050.git.u.kleine-koenig@baylibre.com>
 <3515a8f3-436e-4d14-9bac-dfe6aa869819@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w2wbk3r2n5m3efs5"
Content-Disposition: inline
In-Reply-To: <3515a8f3-436e-4d14-9bac-dfe6aa869819@foss.st.com>


--w2wbk3r2n5m3efs5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fabrice,

On Tue, Aug 20, 2024 at 06:09:59PM +0200, Fabrice Gasnier wrote:
> On 7/29/24 16:34, Uwe Kleine-K=F6nig wrote:
> > Convert the stm32 pwm driver to use the new callbacks for hardware
> > programming.
>=20
> Sorry it took me some time to start to have a look. I only had an
> overview on the series, and this patch. I'd have some overall question
> on the waveform support (on the delay offset).

No need to be sorry, I very appreciate you looking into my patch set.

> > +	wfhw->ccer =3D TIM_CCER_CCxE(ch + 1);
> > +	if (priv->have_complementary_output)
> > +		wfhw->ccer =3D TIM_CCER_CCxNE(ch);
>=20
> Need to use (ch + 1 here), and avoid overriding ccer when
> have_complementary_output is true, e.g.
>=20
> 	if (priv->have_complementary_output)
> 		wfhw->ccer |=3D TIM_CCER_CCxNE(ch + 1);

Huh, indeed. Thanks.

> > +	rate =3D clk_get_rate(priv->clk);
> > +
> > +	if (active_channels(priv) & ~(1 << ch * 4)) {
> > +		u64 arr;
> > +
> > +		/*
> > +		 * Other channels are already enabled, so the configured PSC and
> > +		 * ARR must be used for this channel, too.
> > +		 */
> > +		ret =3D regmap_read(priv->regmap, TIM_PSC, &wfhw->psc);
> > +		if (ret)
> > +			goto out;
> > +
> > +		ret =3D regmap_read(priv->regmap, TIM_ARR, &wfhw->arr);
> > +		if (ret)
> > +			goto out;
> > +
> > +		/*
> > +		 * calculate the best value for ARR for the given PSC, refuse if
> > +		 * the resulting period gets bigger than the requested one.
> > +		 */
> > +		arr =3D mul_u64_u64_div_u64(wf->period_length_ns, rate,
> > +					  (u64)NSEC_PER_SEC * (wfhw->psc + 1));
> > +		if (arr <=3D wfhw->arr) {
> > +			/*
> > +			 * requested period is small than the currently
> > +			 * configured and unchangable period, report back the smallest
> > +			 * possible period, i.e. the current state; Initialize
> > +			 * ccr to anything valid.
> > +			 */
> > +			wfhw->ccr =3D 0;
> > +			ret =3D 1;
>=20
> I'm suprised, I'm more used to return negative error codes. This may
> cascade up to the sysfs interface. Is there some possible side effect ?

I'm not entirely happy with that 1, too, but I didn't want to use an
existing error code, because I wanted to catch exactly the condition
that no valid rounding exists and so having a dedicated value for it
looks right to me. Then I didn't want to use a negative value to be sure
to not interpret it as an errno value.

This shouldn't propagate to the sysfs interface (or even __pwm_apply()).
I need to fix that.

> I could see in your commit message in "pwm: New abstraction for PWM
> waveforms" that "... this fact is signaled by a return value of 1".
>=20
> Perhaps some define could be used, to better point that ?

I shortly considered that while implementing, but decided against it
because I didn't wanted to clobber the fact, that it's a positive value.
Reading your suggestion I'll think about it again.

> > +	if (wf->duty_length_ns && wf->duty_offset_ns &&
> > +	    wf->duty_length_ns + wf->duty_offset_ns >=3D wf->period_length_ns=
) {
>=20
> The condition here (mixing && + >=3D) is rather hard to read, could it be
> more readable ?
>=20
> It's more clear when reading pwm_wf2state() and pwm_state2wf() the
> condition for normal/inversed polarity rather looks like:
>=20
> if (wf->period_length_ns) {
> 	if (wf->duty_length_ns + wf->duty_offset_ns < wf->period_length_ns)
> 	/* normal */
> 	else
> 	/* inversed */
>=20
> BTW I notice small difference here: (wf->duty_length_ns &&
> wf->duty_offset_ns)
>=20
> Suggestion: could use some (new) helper function or macro from the pwm
> core ? e.g. rather than implementing in the driver ?

Hmm, this will indeed be useful for all drivers that have no way to
configure the offset in a more flexible way than inverting the polarity
(which I'd guess are most of them). I'll try an implementation to judge
if I like it.
=20
> > +		wfhw->ccer |=3D TIM_CCER_CCxP(ch + 1);
> > +		if (priv->have_complementary_output)
> > +			wfhw->ccer |=3D TIM_CCER_CCxNP(ch + 1);
> > +
> > +		ccr =3D wfhw->arr + 1 - duty;
> > +	} else {
> > +		ccr =3D duty;
> > +	}
> > +
> > +	wfhw->ccr =3D min_t(u64, ccr, wfhw->arr + 1);
> > +
> > +	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> CCER: %08x, PS=
C: %08x, ARR: %08x, CCR: %08x\n",
> > +		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offse=
t_ns,
> > +		rate, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr);
> > +
> > +out:
> > +	clk_disable(priv->clk);
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * This should be moved to lib/math/div64.c. Currently there are some =
changes
> > + * pending to mul_u64_u64_div_u64. Uwe will care for that when the dus=
t settles.
> > + */
> > +static u64 stm32_pwm_mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c)
> > +{
> > +	u64 res =3D mul_u64_u64_div_u64(a, b, c);
> > +	/* Those multiplications might overflow but it doesn't matter */
> > +	u64 rem =3D a * b - c * res;
> > +
> > +	if (rem)
> > +		res +=3D 1;
> > +
> > +	return res;
> > +}
> > +
> > +static int stm32_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> > +					   struct pwm_device *pwm,
> > +					   const void *_wfhw,
> > +					   struct pwm_waveform *wf)
> > +{
> > +	const struct stm32_pwm_waveform *wfhw =3D _wfhw;
> > +	struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> > +	unsigned int ch =3D pwm->hwpwm;
> > +
> > +	if (wfhw->ccer & TIM_CCER_CCxE(ch + 1)) {
> > +		unsigned long rate =3D clk_get_rate(priv->clk);
> > +		u64 ccr_ns;
> > +
> > +		/* The result doesn't overflow for rate >=3D 15259 */
> > +		wf->period_length_ns =3D stm32_pwm_mul_u64_u64_div_u64_roundup(((u64=
)wfhw->psc + 1) * (wfhw->arr + 1),
> > +									     NSEC_PER_SEC, rate);
> > +
> > +		ccr_ns =3D stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1=
) * wfhw->ccr,
> > +							       NSEC_PER_SEC, rate);
> > +
> > +		if (wfhw->ccer & TIM_CCER_CCxP(ch + 1)) {
> > +			wf->duty_length_ns =3D
> > +				stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw=
->arr + 1 - wfhw->ccr),
> > +								      NSEC_PER_SEC, rate);
> > +
> > +			wf->duty_offset_ns =3D ccr_ns;
> > +		} else {
> > +			wf->duty_length_ns =3D ccr_ns;
> > +			wf->duty_offset_ns =3D 0;
> > +		}
>=20
> Well, my main confusion is around duty_offset_ns. Indeed, it's right
> here, that with PWM mode 1 (CCMR bit 5 and 6 set later on), only
> possibilty is to have either 0, or the period - duty cycle as delay when
> polarity is inversed.
>=20
> I gave it a try (basic testing), but user doesn't get information when
> setting a waveform (with a valid duty_offset_ns), but the hardware
> doesn't necessarily apply it when writing the waveform ? What's your
> advise / opinion ?

The intended behaviour is that if you pass a duty_offset_ns >=3D period -
duty_cycle_ns (together with duty_offset > 0), you get inversed polarity.
This isn't signaled indeed. But the same holds true for other hardware
specific adaptions (e.g. when you pass period =3D 12345 and that's rounded
down to 12300 because of input clock constraints). If a consumer cares
about that, there is the possiblity to use .round_waveform_tohw() +
=2Eround_waveform_fromhw() to know beforehand.

> > +	} else {
> > +		*wf =3D (struct pwm_waveform){
> > +			.period_length_ns =3D 0,
> > +		};
> > +	}
>=20
> Would be nice to add similar dev_dbg() as in
> stm32_pwm_round_waveform_tohw().

Ack.

Thanks for your two good catches and your opion on my design,
Uwe

--w2wbk3r2n5m3efs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbYk08ACgkQj4D7WH0S
/k55qwf9EgN+NhhEi+Yq9bVFPXawoBgYgXhtz15b9/HdHx//aXePBZbaePmT0mL6
tk2ffKE45l/RVEWmLv4Ju3egAyi0FEB8Nib28BqRHHx6ogLAGYlYSXLKF1pPpIGG
MS5Xs/V6VQ/QHqgOgGiDHsr5vO05QsYX3/8xG3if4V28kV/5UIdtu8bzI8Zez/RY
BB9RLIqGTKqzzC1OVqNQXkKFlbuU2eFTgLnwACPrUCwKsa4agF60ERmgVmic5Z8l
fzzCE1cNmgWCkfMfNMqic+OunA4X9hKBsFRtwiqEZFc31BovQBkKnitlGmXGbM35
X2kQr2UTr/RKXZTsZqTfoMhwxYO06Q==
=x3Fw
-----END PGP SIGNATURE-----

--w2wbk3r2n5m3efs5--

