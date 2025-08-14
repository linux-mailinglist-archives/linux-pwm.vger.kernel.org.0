Return-Path: <linux-pwm+bounces-7054-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F8B267F2
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD511CE2C5F
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6442FD1B5;
	Thu, 14 Aug 2025 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3TFREvM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF21514E4;
	Thu, 14 Aug 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178429; cv=none; b=dUpTggMM4qq5R4lleY+gKe9vBHUvY8aWrXd6qFWB8QFTnBUmxZxbN95dNG7KTAu73qpHlERP/FbzIMn0B7eLE4+0vfVBOe7uIytP46leyuH9ptMfxEHNrr8UVwCwIs4FeqgQ6CuYMw8nQ99xJiZqj863nT813D5l9e6XFA52LZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178429; c=relaxed/simple;
	bh=qzHOrb660hNBXkxGw6DWMOMC3lLxUoz/yT/E1S7tZKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmW4Ys8h5pnFaqpq+frJ4K4nAngN0V+2GyoD/vJoQZlO52BH2aWWRTUSHGnEoX5FjZB29zUTjpP9SFJx4OGHtWitt9MmpOeq1DmYT57s2KYd4XOUWx2vLxq/Fo66hTY+vUBehFBgY1khBjqdBoZwkxM445CzOBWTmoYYQEidB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3TFREvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D9DC4CEED;
	Thu, 14 Aug 2025 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755178428;
	bh=qzHOrb660hNBXkxGw6DWMOMC3lLxUoz/yT/E1S7tZKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3TFREvMs1WoLOVL2tGaVT1AakYVA6W35J8m4vEyfQfAyM33dod6zbIvi5EZ1o4ab
	 +wMY1hRryZmJya4eBLPwosoXvYCs7Hm8DP4mJqMxIjz+fK3bTqZyQyIajhMwZadJ3A
	 VgKFpqwqWMz5XEiP87KZltrdbdpp7ekrl4gAU2w5KnSxbY9Tc79i75ZmxsSbc6noSa
	 14Zr9EcpAfOR6dYy1EH27ORo6AzIYNG9OjyukxBmc9XHqR84SWyKav01vmYQ15nCYc
	 kS4Zb/fu4eIRpPpxjviCrOuPbqL1PgkfEYx1n7Bl6BVDLraINW34jdIQrNZEM8PE8E
	 hX7jkkQX4Kkqg==
Date: Thu, 14 Aug 2025 14:33:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, andreas@kemnade.info,
	peter.ujfalusi@gmail.com, dmitry.torokhov@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, lgirdwood@gmail.com,
	tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org,
	ukleinek@kernel.org, gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2 7/9] Documentation: omap-twl4030: convert to DT schema
Message-ID: <8c9366a5-482e-4bf2-b8cc-79e789bf2ff0@sirena.org.uk>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
 <20250814132129.138943-8-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4nUJ618zm+2DpXSV"
Content-Disposition: inline
In-Reply-To: <20250814132129.138943-8-jihed.chaibi.dev@gmail.com>
X-Cookie: This sentence no verb.


--4nUJ618zm+2DpXSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 03:21:27PM +0200, Jihed Chaibi wrote:
> Convert the legacy TXT binding for the OMAP TWL4030 sound card
> to the modern YAML DT schema format. This adds formal validation
> and improves documentation.

> Changes in v2:

This should go after the ---, tools use this to remove the changelog
when committing.

> - Fixed comment formatting (added spaces for better alignment).
> - Updated commit subject to align with subsystem style.

Should be ASoC: dt-bindings:=20

--4nUJ618zm+2DpXSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmid5bUACgkQJNaLcl1U
h9A2/gf8DYx2qBWKgxDl5J/9xk1Tol23Uwe7rnV2+wSVddxlxcPYEO+lCQ+ktiYz
EJi0x9SUpw/em43nQulrEBY7vvJH6jlOMpM7qehbhuCdkAqIN1Be8e7/bR3LfGCM
27wWzx1+Hxoun9V4q7w0MuKhjztsmti5MouUB03NQbR13uGmV9kNxJWF9juqAujI
xfcamPWNGGyPF6GRjiuuBhPmrjl8yFh8u2UyiI4E1IS/GL3kth1FjC8igDAMniou
2Fgn4M+BQrHi94iGGe+T19uAue1VARcg2RkYU6WUkuiBSRr673eL1OJQVOIoiFn6
dm6JtgM4fu3FxSdbGp+fonGTJEdUZA==
=3+dF
-----END PGP SIGNATURE-----

--4nUJ618zm+2DpXSV--

