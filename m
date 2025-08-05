Return-Path: <linux-pwm+bounces-6959-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD0B1B4E2
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 15:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A27189B7D2
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970D274B40;
	Tue,  5 Aug 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH/jGQYw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA41400C;
	Tue,  5 Aug 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400467; cv=none; b=C9jczas1nirB2sLSCiXFzBykZdTiu3uLzJErAuFcSVnMev1Tp1WB/tIpqlF9KNLe7lQpsa2ffl4+hrWLgfblOaInpWH6wjfA5oehJGv5C8qAe31v4mzJr8LhAw9JJ7YhPy9EfWFAAMjX39go0xdxRfWT76bo8McpCBWHI45+xRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400467; c=relaxed/simple;
	bh=8rLlAX3+dqUHfqBBIfUFx5jRN9zh7Gy3FuWRWSIWhIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNBe9eWaHifF3CAMyiSaVfooqiuwBoGXY+316NgQAxCZSGx21PJHhsTnpwBT4Kw2VecOjs4Ugte3QDIgK6aGH9/cXHN+wM45riIZZcDkC8oMUyhFcszPJ1eZlNcuWzlKpjpeEaUgmjOwGQyDJxtF3lGA+nJNAyDXHyfQcfVLLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH/jGQYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C499DC4CEF0;
	Tue,  5 Aug 2025 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754400467;
	bh=8rLlAX3+dqUHfqBBIfUFx5jRN9zh7Gy3FuWRWSIWhIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BH/jGQYwfVH1MhDTMAS/PFuRvDFrcAQQDxafjmkHd/y5RFK5AT+aNz/BT3b2RLtW1
	 tHCAq4Gknck/q+5R4pdb7adeW5duDY4nak1zi4Pa93EvRqNt22K3feh/05hgN0u2bZ
	 T4Z/UOnlrcwVUgBVkKFLEINlhSrzacX88wIBjYcJJoaP+z5btueIC/2xk1pwU4Fjzx
	 N80fx+t7WuHOrpO8SlNsOG5T5SDCAIaw8YT/+yMc5CZqcponH2VdfY2/9i+owqm/o4
	 5Cu+Wv/NfnrVRvPq3jo70g03rwDbvfIcy/s84eZN2mhXWnt96RemQhPkOyhC4PBkaL
	 YL5aLTTIG5nFQ==
Date: Tue, 5 Aug 2025 15:27:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pwm: rzg2l-gpt: Implementation of the waveform callbacks
Message-ID: <2knipwg44si6rajfcg7e2wxfcjxo625yswkh5v4tsbc4eyvp7r@lhfqj2ngb4rd>
References: <20250805065032.193766-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mheqiwwcjq62v4lb"
Content-Disposition: inline
In-Reply-To: <20250805065032.193766-1-biju.das.jz@bp.renesas.com>


--mheqiwwcjq62v4lb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: rzg2l-gpt: Implementation of the waveform callbacks
MIME-Version: 1.0

Hello Biju,

On Tue, Aug 05, 2025 at 07:50:23AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Convert the rzg2l-gpt driver to use the new callbacks for hardware
> programming.

You picked a great project!

> +static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const struct pwm_waveform *wf,
> +					 void *_wfhw)
> +
>  {
>  	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> -	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
>  	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
>  	u64 period_ticks, duty_ticks;
>  	unsigned long pv, dc;
> -	u8 prescale;
> +
> +	guard(mutex)(&rzg2l_gpt->lock);
> +	if (wf->period_length_ns =3D=3D 0) {
> +		*wfhw =3D (struct rzg2l_gpt_waveform){
> +			.gtpr =3D 0,
> +			.gtccr =3D 0,
> +		};
> +
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm))
> +			rzg2l_gpt_disable(rzg2l_gpt, pwm);

This is wrong. the .round_waveform_tohw() callback isn't supposed to
modify hardware. It's only supposed to tell the caller about the
current possibilities of the corresponding device.

> +		return 0;
> +	}
> =20
>  	/* Limit period/duty cycle to max value supported by the HW */
> -	period_ticks =3D mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_khz=
, USEC_PER_SEC);
> +	period_ticks =3D mul_u64_u64_div_u64(wf->period_length_ns, rzg2l_gpt->r=
ate_khz, USEC_PER_SEC);
>  	if (period_ticks > RZG2L_MAX_TICKS)
>  		period_ticks =3D RZG2L_MAX_TICKS;
>  	/*

Otherwise it looks good from a quick glance.

Best regards
Uwe

--mheqiwwcjq62v4lb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiSBs0ACgkQj4D7WH0S
/k65Pwf+PyxwEQzqfZ4Q2g5Emh3KI9l1ja+YlGawQ14Xg99MDVzMjAgTnTJtl2Oi
X0HtuDy89GOCsOHeNKZcA4rUOG9wKkd/VilwGdjWfDCf4B4f/JfjNgGpX28bJIkW
yXOQ27WuXhc9ABW9dqy8554GksP7Y8Mt9tKTe32RtArrfuNooRf7F0xX2k8FFV4G
LiADjMU+OzRBqEpOiGfHn9CYQneaMItzLYwE30mvKtmJaKQln/2NmiNJw/+492lq
8UBGV9laxy87BCXAho+r7xip2QU6Fb6V+zrZME6ZHYPxGExdyF5uz9Jvp4YW0Am6
dRl8ekUT0iPDQpbSATSQHbfS80FuCg==
=D4pO
-----END PGP SIGNATURE-----

--mheqiwwcjq62v4lb--

