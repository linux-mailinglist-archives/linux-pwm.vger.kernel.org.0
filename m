Return-Path: <linux-pwm+bounces-7702-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0F1C887E4
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Nov 2025 08:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAEF3351ECB
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Nov 2025 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624F246BB6;
	Wed, 26 Nov 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH8R5eIR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C932800;
	Wed, 26 Nov 2025 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143307; cv=none; b=KXfhhVQMk9FHtMHa39/I1vm6h5wQt6O1nYJLCqUWNgLc0eHDTDIZnB/4zGUaEFOowfTdi376A2bkG8jbNBTT3czYTUOQX/my+WW3RlHFcjmbD38ZzhyrGSOxAFsWftNPZs9f+lD2h3iRh4T9UpGROmyxAwdjm+J3ilL+rPqq+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143307; c=relaxed/simple;
	bh=lXGDzoS914E9vLp+zp5RzGovGQB+FX27i5N1U4yV0c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHB8CDOgH8I1Tp3i34tn9IIwgNJaf8X9xFsY/rT4y/CMz64vrUE2dmdFXnGYrqZ52lbiOTm/6UUZNGja6PmXoJNy2CtgZKasIakUr+S/79OwUhzIyJQm2Ssqw8E4/KlG7p9kH3J2cGx0SfUpfPpWhyw0GAvdPnL4l88ZHkOEjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH8R5eIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532D0C113D0;
	Wed, 26 Nov 2025 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764143306;
	bh=lXGDzoS914E9vLp+zp5RzGovGQB+FX27i5N1U4yV0c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZH8R5eIRF9BBpYF854w5yaZTwd/cGBkPtmmr5lBWpnmN0iYzfrfoH16StJ0Wvezzs
	 MVWa3S0Q6Dksoumm3Zeags2W5NlbIMgeyAn7hl3mUC91kHRBzYYiiPezHrlOGiMVXQ
	 PZvx4XjeU1GF6OC2GWbDDCEEbMS+1XNTJ6Er/kB391md+ICmL+hUrxAUsYngxksFkX
	 0xYwB7zFa8a0bpzgoJf27oltHjTRUOrZPNnh3jxloO/elsf6SrcIJLyIjoQwSaxwIw
	 45w5Zz94h+GS3t8nfxlOttw08Zw1HwyCSQ4I9DM7OfV9uRw0SxvGAD43Ok5tFGHNi+
	 Ej2Pm1mH/7x0g==
Date: Wed, 26 Nov 2025 08:48:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 4/6] pwm: tiehrpwm: implement .get_state callback
Message-ID: <icnzqynjxkvbxz7wm6ibkpeqgnxsgijulasoh62arbq2oemdib@u2lphznhtmit>
References: <b2uf4jtvavhnktunabpufq7vyqiqrrwkcf7u6t7ffj3ll2ktmh@4w4myyquf26q>
 <20251125203919.1136-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m2ll5u7qy362yn47"
Content-Disposition: inline
In-Reply-To: <20251125203919.1136-1-rafael.v.volkmer@gmail.com>


--m2ll5u7qy362yn47
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 4/6] pwm: tiehrpwm: implement .get_state callback
MIME-Version: 1.0

Hello Rafael,

On Tue, Nov 25, 2025 at 05:39:19PM -0300, Rafael V. Volkmer wrote:
> ok, I=E2=80=99ll do that then and rework the series to adapt tiehrpwm
> directly to the waveform callbacks, dropping the legacy
> apply/get_state ones. I=E2=80=99ll try to get to this and have a new
> version ready sometime next week.
>=20
> Before I respin the whole series, would you mind having a quick
> look at patch 5/6 (the one handling already-running channels at probe)?
> If that direction looks fine to you, I can fold any comments into it
> and then send everything again as a single updated series.

Conceptually patch #5 is right. After a very quick glance I wonder if

+       if (enabled_ch[PWM_CHA] || enabled_ch[PWM_CHB]) {
+               ret =3D clk_enable(pc->tbclk);

is wrong and you need to clk_enable() twice if both enabled_ch[PWM_CHA]
and enabled_ch[PWM_CHB] are true.

Can you please use `git send-email --no-chain-reply-to` for future
submissions? While this sometimes results in having the patches not in
their apply order, it reduces the nesting which helps me and also it the
more common setting.

Best regards
Uwe

--m2ll5u7qy362yn47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkmsMUACgkQj4D7WH0S
/k5ubwf+KwKA378rCG5I2SKKnCn006301Rkp9/5+VWNvbc8L3eEcbiBVIfLes5IB
is/C5udo/bgRXuBa23TPLZrSzWwDcvH92LYwJhP2nxxvkgHF9DP/bor0Z90qSViJ
h4paG6rwe00lD9Vl615h/yEo6oT/qkLsbu4+fRZ9Kq+scA4CbLaXQW7OFNbu4pz7
t0Vsr44wyaHeAWpdZEELqhayd5f8Pp4QO1HX7xagqNWG9f7Ukd/sSNqfuVN23wla
i16eospRugmu0a1qqSIX40mfl3KokSB+OlsPUptHHPvmcRxv0aqFxdkagS6DMPcE
V5aW3m8+c4jFIoyD4l3PD3coge2uCg==
=JbLd
-----END PGP SIGNATURE-----

--m2ll5u7qy362yn47--

