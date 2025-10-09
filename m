Return-Path: <linux-pwm+bounces-7428-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1A9BCA470
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Oct 2025 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D07188A549
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Oct 2025 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB922DF9E;
	Thu,  9 Oct 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDeiGwaM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750FA226D1E;
	Thu,  9 Oct 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029114; cv=none; b=kD1zHVErJDeYAK1wkwOMO9yFMCTIHMexBRALT+6WIfLHxNXnz8OCK9Aw4L8E8rq0bJq4t5GOR7EI7rBG7k8smIEqKXVaX3bXzQhC16gVAtkQtLtiV4o4pTGsCj0fEz7Ub1LWnJfJrfbULYNeDncetR2p0nIKn+EncS4ywXtNUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029114; c=relaxed/simple;
	bh=ouGPV7oXLO0nXJOGjQeFcq4BgOQGJoUl/Z0W43w/T/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGywaCISVzyBBUmwm4gKDJpBAUXv6SjYo4cvyEtNehylfggRF8hL5lAxaeL7yTMncdyMnFWlIotoxlGw+XHYJiFTPh//BAFw35X7EuWPbJH1UDpnTRGkojCP5/FdUk7TLETplAS1X2s4EbUs9el+jem2cv9Tc5UouGFwMYpNrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDeiGwaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FABCC4CEE7;
	Thu,  9 Oct 2025 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760029113;
	bh=ouGPV7oXLO0nXJOGjQeFcq4BgOQGJoUl/Z0W43w/T/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDeiGwaMBznqqiv2IJw492Qxj6TZBLlPZqEJ+urDxl5HvclEpTnt9Q9uOOlesnw35
	 xVEmPn+KnsIlTnU+5Jn0zq7CaoRfFnjsNqLP7xhdVwKHcztoE4O0iGTR706FLO2GmC
	 vsr306KtmweaLHjBaifUvRrr8YXMJM97RVbmax3F0wsmUrWqzoNwPyFEVdGy7G/ute
	 aaEf+1fYs6gJoZiSl7M466NxXHJ/gYWrNKmUYJkJC9Fl8Pj/Gd/ibyH35P3s3Yi5lK
	 wUWdaTQiH5Fgfp7dy0L5vCVfgyRxlsasyJfPbM3QV1ygSpTmcb7oh5WRem0s9MZ/o0
	 UYKF2sol7iBnw==
Date: Thu, 9 Oct 2025 18:58:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, michael.hennerich@analog.com, 
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, 
	marcelo.schmitt1@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 1/8] pwm: Declare waveform stubs for when PWM is not
 reachable
Message-ID: <cuq6eh3vcrkgr7tj3xpo7ax4ruiy4ra6fjxgu45a3eqs2jbtah@ualgnhdwxnih>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <129ff5c5b7f7be4f4f3f9cf8aa3e1957d713acb7.1759929814.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4les542qp6fpfvza"
Content-Disposition: inline
In-Reply-To: <129ff5c5b7f7be4f4f3f9cf8aa3e1957d713acb7.1759929814.git.marcelo.schmitt@analog.com>


--4les542qp6fpfvza
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/8] pwm: Declare waveform stubs for when PWM is not
 reachable
MIME-Version: 1.0

Hello,

On Wed, Oct 08, 2025 at 10:49:44AM -0300, Marcelo Schmitt wrote:
> Previously, the PWM waveform consumer API would not be declared if
> CONFIG_PWM was not reachable. That caused kernel builds to fail if a
> consumer driver was enabled but PWM disabled. Add stubs for PWM waveform
> functions so client drivers that use, but don't depend on PWM, can build =
if
> PWM is disabled.
>=20
> Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for wavefor=
ms")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509272028.0zLNiR5w-lkp@i=
ntel.com/
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> I've included this patch in this series because it should save us from be=
ing
> notified by 0-day about the build failure this patch fixes. From contribu=
tor's
> perspective, it's easier to have this patch together with the rest of ad4=
030
> series. Though, no objection if kernel maintainers decide to pick it [1] =
through
> the PWM tree.
>=20
> [1]: https://lore.kernel.org/linux-pwm/1ac0fc529e02744aacfcb9140ed597ff60=
886f39.1759873890.git.marcelo.schmitt@analog.com/

TL;DR: nack

I replied to the original submission about why this patch is wrong. See
there for the details.

Best regards
Uwe

--4les542qp6fpfvza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjn6bQACgkQj4D7WH0S
/k5meQf/ZUbpWgJbz2gIbDh0ItNlTparKj2Q4WVhgedGfKCY8chMHQTmFuUhtvQV
iuFLynz2QJ4XDGg7SQ6zo2WMvE+DG+aSvELz4adu+8KV1M7FtoWfFP9uACVK2iZV
Ls6lMV4ZyrCM+2me6/oa+uuKSrr+2/tUXTXz/GZzouBjuAYnsYEoYHjLuCbbjL7/
XadRRmCRLPBMyDUlLk+b5MAXtLPXVhP9pMby8FAB4i2nQmq6JgdV0VzgpslhMV9b
F3ekcy9YOJZifaAkQIORUsj9ChFkj86jy/H3uz5YVEGxSAyy5oLvqOgf9RZGZyiE
2DbWbyB6lqRcjlBEyqWKxo8MGDj/lQ==
=ZygH
-----END PGP SIGNATURE-----

--4les542qp6fpfvza--

