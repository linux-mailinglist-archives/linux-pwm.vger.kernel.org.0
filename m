Return-Path: <linux-pwm+bounces-2555-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C990F37E
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F08B2824F5
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626F15AD9A;
	Wed, 19 Jun 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IylMLhlN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C015253B;
	Wed, 19 Jun 2024 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812335; cv=none; b=J102YcQn6JLE0HnjApZw/hEz+zwSknyZGv5WTZ0daY7fMinuRoO3HVqgsmrdye5zXoI36h/nM/zNjYtxaLxzah2tAY2RYznqnO26enZ09X6tReD9ox8gXxDPUi5I7pUNtHNrKXmSDFzYvTPhD0GTjCPSfP7vRCR5yhOj2dbzi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812335; c=relaxed/simple;
	bh=B/QDewZ8f8pxC39ZfdvW4tjMlJycPZjA3D7QbLHaMqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUT4UBkhU6hZ8TdiWoKJ+bQ3/x5Ejb2KffS0x1ZM76gV9YFhpI2jHCPr8dDPaxTDXKfH0pTPGjZupCqCF0Vdtml4WqiF6SLZHKm4uGxFFfbt4W1pkiMi6XRQAaOJ7NWFsrbL+68TUgsMyx6/2CzpwdAKz9LWfFKjGPqKZOkddwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IylMLhlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87025C2BBFC;
	Wed, 19 Jun 2024 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718812334;
	bh=B/QDewZ8f8pxC39ZfdvW4tjMlJycPZjA3D7QbLHaMqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IylMLhlNZi/cBkkmZVPI7bXXgrSd1kDiDEp6eLLOo2nGFroQz5C5LHISQRpu8OsT1
	 ZebKIkh/37BE+tCC0dPbTunx+Jf7mW8Lc/X9ck1GnvrdFV8SeypZlwHN5y4jU0KjX4
	 /Om4T7tnb4jG4zTwBY1QpJBsKP21M1OBf8KPqReV2NUXM/7Ia9OgMKi5a9I82MS75F
	 fwMjiOFF79nRb6ImdtvUJ9f9VwuKSH9ux6kPUoE0ufCRYD2awuICQff7QG5YsKlyVv
	 axYsRc5alGXsGKOx+fl5Ye2CssDPfd7Be2SuLIfb099sEGElhi8KhOh1MpHQddk4Be
	 A4y3g2uw6MFjg==
Date: Wed, 19 Jun 2024 16:52:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 18/23] regulator: add s2dos05 regulator support
Message-ID: <c17669b2-5fa0-40d4-b88d-8dee6a264321@sirena.org.uk>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-18-e3f6662017ac@gmail.com>
 <4eab619f-6da9-4aff-b956-69d8e2ecd47f@sirena.org.uk>
 <CABTCjFDUKgeYWuwo8eLt+5WD=4O+kLbFwMRxsTufGnqK0Ecpvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sNyOiMkks8z+Tn4L"
Content-Disposition: inline
In-Reply-To: <CABTCjFDUKgeYWuwo8eLt+5WD=4O+kLbFwMRxsTufGnqK0Ecpvg@mail.gmail.com>
X-Cookie: Don't I know you?


--sNyOiMkks8z+Tn4L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 06:49:06PM +0300, Dzmitry Sankouski wrote:
> =D0=B2=D1=82, 18 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 17:08, M=
ark Brown <broonie@kernel.org>:
> > On Tue, Jun 18, 2024 at 04:59:52PM +0300, Dzmitry Sankouski wrote:

> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * s2dos05.c - Regulator driver for the Samsung s2dos05
> > > + *

> > Please make the entire comment a C++ one so things look more
> > intentional.

> Do you mean enclosing the first line (license identifier) in /* */
> style comment?

No, that would be a C comment.  Please use C++ style for the rest of the
header as well as the first line.

--sNyOiMkks8z+Tn4L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZy/qMACgkQJNaLcl1U
h9DGWQgAgOa8X/ixdsOMeRWsYHbb7eeKRUufmB/VZK2WyLNILPGYtncD6cuJ+cLr
AvUANsF0WqGXnetxElS8Y2jV21tcbGNT1eGe64GUPss6hdDebteb63GcRbB8N0Fd
3L+HI4CWnr1oqwLzGGmVRLifr3h/4alGz6R+jy9O5drxEHxalZPdRFVdjbZ8jyr/
3jg43CkWP2vdnZz08OObTm8jI197PhpxgFleekSlSmPqIqtMV/a3krF5CCSh4M8V
n1CJGe6mr4M9lSZ3UpDJQCzWW7EfTmM1iu8RW6IpF5T6JZFtj+cwfS9Ba6kIK4+E
zrmidAhG51b6MN5sNypIpxv0bh1Jxw==
=zdP0
-----END PGP SIGNATURE-----

--sNyOiMkks8z+Tn4L--

