Return-Path: <linux-pwm+bounces-7697-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5CC84FBF
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 13:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 854FC34EED6
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF792DCC1B;
	Tue, 25 Nov 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s71mI/De"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2397218DB1E;
	Tue, 25 Nov 2025 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074186; cv=none; b=Ikn4qPRYUL0KdlZb+5UqzM6q6pOt/gPgKUwMasL5d3QVVgJOs+Ywf4QbPDHs619gpxIY01/bdGLxQT8cU1xNrWpGpoIlR7KveuB9GL+AwaAuaJJKJCfmsA+/Mb+RGSg+r8BfXj3x2xYJ8xk082ftNLyI6tTYOBlzB7Dr58EIeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074186; c=relaxed/simple;
	bh=hnRVB/ehi3CNuesTbt86mUP4IPb24x3WR2P8YUh/BrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmXJWVizUFm/a0JggOiM+72P9wDYLk0bWCY2RuWKz0wyEvErUtpdfD0eGo+qJgTM0MLCqs7Jyvd6l+XckOUCflQvY25tArIvZHoxZw62z95J5lEq0p+1zfp8Y0798zcBhSYPM+UpPZxcELGTICoX9v9DNZfGNG9Kv1Q/q90u5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s71mI/De; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EB4C4CEF1;
	Tue, 25 Nov 2025 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764074185;
	bh=hnRVB/ehi3CNuesTbt86mUP4IPb24x3WR2P8YUh/BrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s71mI/DeVo16tz0rb7jeUavKAUVUUMPR+3TPoiOBWphtjK+cejFZqDgThgORUZZQe
	 W7OVgJ6rQ5Ht7pBYmvDAYAryBON9KYpWz7TsZyP16BskFGd+oQ83rKxnBNZW6zK8lH
	 j8k3V6afO9ABXceQJPAg3WY6f1I6xqWdEeDh8NhxRhJa5prlYsVSb/tTsoDAzhzrQE
	 W51smgF2VFBBZP5wjdTqC2pIbiuTsPW6EGKDFUZ45nRtGKrg6HlU122hZQfReRAkFD
	 0m8llQBjV7sAXF3JzoL/uEHY/ogWhawTexGE3dJeM8kwKPEzz16q12mF40QKr0ngeU
	 Lm50N7dx65xOw==
Date: Tue, 25 Nov 2025 12:36:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Michael Grzeschik <mgr@pengutronix.de>,
	Daniel Thompson <danielt@kernel.org>, linux-pwm@vger.kernel.org,
	linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Pengutronix <kernel@pengutronix.de>
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <079e6431-7f8d-4d92-a2f6-b5a5e64d25f4@sirena.org.uk>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <f492d4d3-751c-40a3-bb93-0e1bb192cde7@sirena.org.uk>
 <aRxr_sR0ksklFsw-@aspen.lan>
 <aSVnulk0yfAd4UCx@pengutronix.de>
 <aSWUOoyusb2BJ6QA@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g7878LiFaIwPR7HK"
Content-Disposition: inline
In-Reply-To: <aSWUOoyusb2BJ6QA@aspen.lan>
X-Cookie: Too ripped.  Gotta go.


--g7878LiFaIwPR7HK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2025 at 11:34:18AM +0000, Daniel Thompson wrote:
> On Tue, Nov 25, 2025 at 09:24:26AM +0100, Michael Grzeschik wrote:
> > On Tue, Nov 18, 2025 at 12:52:14PM +0000, Daniel Thompson wrote:

> > > Should we back out the patch for now?

> > I would be fine with that. But actually I would like to see the
> > proof that without the patch, this backtrace will not trigger.
> > Looking through the codepath, I could not directly find a case
> > where this should happen.

...

> > Mark, is there a way to rerun this without my patch?

> I have to admit I thought this was why Mark provided a bisect log!

Yeah, there should be a before and after for applying the patch in the
bisect log otherwise it wouldn't have got a result out.

--g7878LiFaIwPR7HK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmklosMACgkQJNaLcl1U
h9A1wQf+KdCNGKGTVJRbYFZPBvmnhPqwvtIXJ7eDVAUcjhrBXU5tOr0psaatU6lB
4cHf1xmKFkyMGyT6J77Gl91JFkMe5ikPHf81HQF1AsU4sGWNPJX6/SXOmOlI7y/Q
DtPEmd4dHLgLI2Yf83qbtLSnGybDeSrjLoLdhf8qCELH8/hub211Nov/85RBa470
qKZ2pgyVw4XGjl0mnJSTix5Rq69VkF+ogEMyHmu68w9+o6Mt3a5IKEu0I6gI6W8g
fdzGo7O+Xs+9I6CnQbZeK08M6XI4rhfSQs3SJFQfw32xwb6QQc3MR0ouIsFqu3T8
baQ1b+LpXyrYJpkKa3b6L6qVtgPAlA==
=OHFf
-----END PGP SIGNATURE-----

--g7878LiFaIwPR7HK--

