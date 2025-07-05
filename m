Return-Path: <linux-pwm+bounces-6736-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE83AF9F38
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 10:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD870189D464
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E9018A6DF;
	Sat,  5 Jul 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M85+Dxes"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDB1E4AE;
	Sat,  5 Jul 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751705260; cv=none; b=juaB8pyRgvdQCvSB3hOMSAkqTWkjwcB0chkngfwyr/Y9tQiBxrZvhcOGTb+LfBeGJ56pb+VrpCxGKcxkHQ5DJ/cIanCR10+DDjRFXl8dkC+dSeoL1eRBnOt6KRAuRiS70ZBmQWhtXteTicG0LvfjejPBInmpZXDFEmSTg/rP18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751705260; c=relaxed/simple;
	bh=DnqbnnDHg1upjVY5MTyVILFvGLNXotvjCe9FK8zS0u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI68Ze61nLVSVzEclz+01GpQelP8EJw7t8W4+vxxTORzDrNlx06K4MMQMDs0XcucvP8jfI+Z0+1egFvLpQMSV9IubD0YQYIwgp6K7kUfS/OslIphLDFy8i7ogW7vs6Tt5lm/tcrba9A6se35TJjCnRoD1sDff4u5qSKrubT3Bsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M85+Dxes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBF2C4CEE7;
	Sat,  5 Jul 2025 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751705260;
	bh=DnqbnnDHg1upjVY5MTyVILFvGLNXotvjCe9FK8zS0u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M85+DxespTTJWlhf2Vg4UeZrfeImaNmBqioInsTpAkK1fgQo9VqL1lbpwbagfwgO6
	 5uRam2XWdkBX6O8KtJfwIAPfzzQrp77MousLn9Fcqj9bffrmfC4y1YEZhC+w2IAlxM
	 90KPeAzRhkXiLaWxtubVihpXtfr5g85voOgnst6u4VzwhKOZFW3PWKekghF3XEWzvL
	 67uhldyJJAUbgX22VcqAdPOByZSFtIBB5jOVK0OqQgHxCgLYft6oRexcgOGj7AgpNL
	 Ue0bHGqUbGpjHToSe7WIQ2DDA6lYeD3CHiLgXbCwaPOo5ZT8JQCMCHU20vWZ374Rhp
	 nT0T4vBo6Xl2g==
Date: Sat, 5 Jul 2025 10:47:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v21] pwm: airoha: Add support for EN7581 SoC
Message-ID: <k3s7wp52oljegusctucabvo2wcmx7defklk7fdtqh32a2vvcux@7tuafqra4nrw>
References: <20250705072825.26497-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4pyhknw6rykkithc"
Content-Disposition: inline
In-Reply-To: <20250705072825.26497-1-ansuelsmth@gmail.com>


--4pyhknw6rykkithc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v21] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

On Sat, Jul 05, 2025 at 09:28:20AM +0200, Christian Marangi wrote:
> Changes v21:
> - Revert offset to u64 in airoha_pwm_apply_bucket_config
>   (do_div require u64)

I didn't look in detail, but I wonder if you considered using a
different division function to keep offset not bigger than needed?

Best regards
Uwe

--4pyhknw6rykkithc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmho5qYACgkQj4D7WH0S
/k49Ewf/eb5H0BDivxqGSGE4FxYY22shJ/S/6c+2o4Ljd3keIb9cBzUUpytzItK2
1acK30OHmV0nPrYBT881P2GCaDWou9nn4Vij9Tmo7hY49wZu2HDymRINI80TYvMM
TbjrfRrkRsblYmhmf+xn+0WhB8oJbllaEgOGtEB13Yn3zJvLY8QF/dUvuqX7Z4G/
JDwHwzHhzjR9iFcChADW9ruKQ8t4UsAd8pWhzlKKQa7WADhB3phZ6+I98/ouXhH/
PA2UUroNNdQAKrG7WWsZu1E/kZJDvdblClfz0xmnakh+TImNLUR/N+tBWrlhx+Lr
vUAZjERoVfEWh/oGXCptJ4zw5iraYw==
=xmrL
-----END PGP SIGNATURE-----

--4pyhknw6rykkithc--

