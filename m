Return-Path: <linux-pwm+bounces-5424-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD4A82C81
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 18:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E93F440DC8
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901C926FDB0;
	Wed,  9 Apr 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2cVLyjc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C0626FD82;
	Wed,  9 Apr 2025 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216383; cv=none; b=p+p7R/79W+yAXvX6t1oWY+OQOT/XgMs3kFcQnVmRtbJ2NCB45uksfE2Dn6ib6oqCA5a6P/UhYp0BQzQItyuXGqltDh6Coi4qVhHohDzGtIJbEAAuGRKZTYsd8t1HKHBhPXm0F9ZTKJuXC4jVoNSPgem0BD1ln/2Xn88112wOmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216383; c=relaxed/simple;
	bh=+zh54aNkHP/mqRcFoVtVjVdoA/g3zXyXjMEKojcSlmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMzrN800+Do/zg7s1IvUyEIZ6drXM55HB0B2tjiP0gTOXQh3fjdT3JjmxPY44DCvw6s2L/wurB+sJzDDoKJS6QgW3RPAWVNCh/CT7tQyn2HjGoRE7tTKbQ36NtrOxV/3D64nRcmH4mZymESIiA8wLsqOUr2mq6Nknmf2QkDss2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2cVLyjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9052BC4CEE3;
	Wed,  9 Apr 2025 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744216382;
	bh=+zh54aNkHP/mqRcFoVtVjVdoA/g3zXyXjMEKojcSlmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2cVLyjcm5li+kBXGvwvfPBSxMq2GHqplkN8mdDuMrfXORPIsYvqlHQmXr2hoduM/
	 OfJ99Oq1QOLwqV11rjJOJKFjjGsZ6hrT7yK5GFEb7O8uFUb0xXtbY90UIEPTQXNiK/
	 qVVrrjIuVhXzeoWC8CJCodYtQSEkW43Z1gGHRVBHXdaWuPhuhQV98CAfNhyPgL9yB/
	 OxzOlenNR3cSvD7iXd/AP6dHhT2PPNJ6AJvgem0Mt52lPxe7LIke4ql50Q6eKW2N59
	 WrT2YqhS2Iu8CuQssMcnKNKWkMgptAH22Kz4bh2LBZc274fb3RsuKzV985Wiy9twf7
	 ar1OKe2C1uyMg==
Date: Wed, 9 Apr 2025 17:32:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 05/12] regmap: irq: Remove unreachable goto
Message-ID: <28982424-d425-47c3-b910-58c787e13510@sirena.org.uk>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
 <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
 <Z_aUeKm0k1zReS_D@smile.fi.intel.com>
 <7126e672-a829-489e-a0c0-8d6d64a8b2f4@sirena.org.uk>
 <Z_aZmJxPwIBgcwhG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ZFwjRLHOfbg+hZe"
Content-Disposition: inline
In-Reply-To: <Z_aZmJxPwIBgcwhG@smile.fi.intel.com>
X-Cookie: Words must be weighed, not counted.


--7ZFwjRLHOfbg+hZe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 07:00:24PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 04:46:04PM +0100, Mark Brown wrote:

> > unreachable() just annotates things, AFAICT it doesn't actually
> > guarantee to do anything in particular if the annotation turns out to be
> > incorrect.

> I;m not sure I follow. unreachable is a wrapper on top of
> __builtin_unreachable() which is intrinsic of the compiler.

> https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005funreachable

That just says that the program is undefined if we get to the
__builtin_undefined() and documents some behaviour around warnings.  One
example of undefined behaviour would be doing nothing.

--7ZFwjRLHOfbg+hZe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf2oTcACgkQJNaLcl1U
h9CUkQf8D91/bSxx6/QkmKK0V19A44BPDEWreR11m1p2ZsAnoHUox6vHzD/HW1Wx
T0JS4yzFEASUGtoAjXCndX4OhrR9xkUpjEDLqfzXHpBdpdQXakbRuWPSh7g19Kgz
R7PQzS2xKwmXHd6fH6Kf3khfdhVEdItfZTbhGnIKB3rneOId9OAiRn0oI7YQfIH+
Z9foAXg593J5xjN91orls7RqgJpAlcDBipTaB+EF9jVz4nNkuBBm+nATS47f/hA6
2TG/eXXxilmUwwisKSNSs5glX4MCaAl4Xo1E+vebsddJnhdzA/TwdJl6iFAAI18J
ByfZNimm2Pmqd0NBzq2+REfdhgtM2A==
=uVCq
-----END PGP SIGNATURE-----

--7ZFwjRLHOfbg+hZe--

