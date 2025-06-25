Return-Path: <linux-pwm+bounces-6526-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7FAE787D
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 09:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA0F7A283D
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 07:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D090220CCE5;
	Wed, 25 Jun 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jduYaXVp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8A1FBE87;
	Wed, 25 Jun 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836276; cv=none; b=Zuad4as8I+alWFusRF/EyTQMGMbYvo9X1KelOLXxjGdFYPUaemf2ujnwp6dBvIxxov1OfzW5ZcZsykj7O1Wy5vzYkp6f8gaCE90cvHVmryU8QT00ESSDcuhNfoKzjE/AzJJC1MqYgHcgyf8+xG2jrr4gepb4I2I/WA4tC0Htbao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836276; c=relaxed/simple;
	bh=cn1hx+lAs/8KO5XyQct5juCcoosBjPJ4vuPg3voaHe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoyAmgaH0heTNCDrwiMc8nto36iMmvih7IWDGTmp3scUograAkpNl7qeJQs595e+lXGZzNaKPmYsUzsD9ieudEIQGea0IyvugxVXYDIDnxgzEN9+DYnUHw8QD9aQU373aMrovmCqD6n7DnJTgMFTLCIDmIFylrSzo89GXC9lqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jduYaXVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EC8C4CEF2;
	Wed, 25 Jun 2025 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750836276;
	bh=cn1hx+lAs/8KO5XyQct5juCcoosBjPJ4vuPg3voaHe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jduYaXVpI8xcYyVecWGw5k1QuYQxFK6AZRAjdHabn5GVZp3O3EPAPzSplFIq8KaF3
	 sReXOJW/cFwqRy417vdrWFvn0axUAr07o2WWJ8kam1w2RB7K1vjSH4NPMfE74tz0aR
	 LBYr3d6nFKwr8gDseMdbXdeGx3VM26elJzmDxN6brhJM1S8Bmcwh16lufXfWusTQZ/
	 Mbb61E0/9edxA1v8dYU59jPFo33qcxUIW7HP1k69DhrWb4aTkwBVJngbLR3VOFY4A8
	 /ZP26er4colFDHJPKtMxfHbZyRYFTMm218a9wx1Nhsw9RnLIGyo/4rgPefC7oJGWX7
	 n1okfwreggz2A==
Date: Wed, 25 Jun 2025 09:24:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v16 2/2] pwm: airoha: Add support for EN7581 SoC
Message-ID: <dehsalp2za4i6jgod6ej6gqhestljo7qost66jzmql52n2zecp@imtgipg24lv5>
References: <20250625000059.20040-1-ansuelsmth@gmail.com>
 <20250625000059.20040-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wnwqv3saq3luvxgw"
Content-Disposition: inline
In-Reply-To: <20250625000059.20040-2-ansuelsmth@gmail.com>


--wnwqv3saq3luvxgw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v16 2/2] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

On Wed, Jun 25, 2025 at 02:00:39AM +0200, Christian Marangi wrote:
> +	/*
> +	 * Period goes at 4ns step, normalize it to check if we can
> +	 * share a generator.
> +	 */
> +	period_ns = rounddown_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);

I don't understand why you need that. If you clamp to
AIROHA_PWM_PERIOD_MAX_NS first, you don't need the (expensive) 64-bit
operation. If you compare using ticks instead of ns you don't even need
to round down, but just do the division that you end up doing anyhow.

Best regards
Uwe

--wnwqv3saq3luvxgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhbpC4ACgkQj4D7WH0S
/k7mYAf8DVzvlNzcEQMaz3fU1ihq9Xiz3IGiZRYZWuzOteSsjK/BIoVrZiRW5zLO
hhookBo5cAVVaLT6eKte1aKOmwUz0A6vIQBJKidDJgrqF7OJLNrK+0M3Pll+WTWU
QXJNasyzl95Tor13v7Y8d5Kcd258fHguNU4IvDe2Pcl3JG8OxfQeqy/NF3iXG5hz
og7/crLt2ADAKq0y2kZf9J75Wg3tJVGKUGQXaQlZA9wCNb6o0eDEn93xapcAvmi2
xw1hSBo+3zLUIHpHauW76OGXv9Keshd1vwDAXJH60BfhK7YDboX/OHa2f0epui6C
nj5+8vQkHVFdjRKPpAvvY9y2AtxvyQ==
=hS9/
-----END PGP SIGNATURE-----

--wnwqv3saq3luvxgw--

