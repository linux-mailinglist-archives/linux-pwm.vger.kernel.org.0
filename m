Return-Path: <linux-pwm+bounces-5675-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B50A98A04
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92147A6BD7
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8717E26A0DB;
	Wed, 23 Apr 2025 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1e7bsHo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508B620D51E;
	Wed, 23 Apr 2025 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412172; cv=none; b=te8NvSxjV0zxrWrKtiWkYI9PZCMJ+yBmDQv2weMX+l7ifR9um1UZ1a4tQo67LT6l5Bqr7S8QoheEvuh3bciQqWiMr+Tm7ub7aHUVJ9wgAMeihfvMZIdEpve37Do1R8CkFyG4F2WTPilZtiyzXlKjOlerYM6kU3tdxU4an5EJAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412172; c=relaxed/simple;
	bh=u3ZcKkgoB25HPKxRDflmB22KCmGVK2aSNrcu+cjWhgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru8VrNSEUmVRcYRl26/ElqhjXYvSjImwAg8orkGqWsjkR6wVgvo9RJ4GH62dqrkfbpAR8vYUHdSFtZlf1f4C/+DSyIHe1VPh53rQRH7g1ntg/8SNvhqoWuDFsSw/fu5HmP1s1V9Iigv2t/OR6gsWGQtlNEXUFTYDF5WCoxmThk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1e7bsHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85C3C4CEE2;
	Wed, 23 Apr 2025 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745412171;
	bh=u3ZcKkgoB25HPKxRDflmB22KCmGVK2aSNrcu+cjWhgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1e7bsHoDNO9UXqZkRsVprI8RdUubhWlnAprcIJjZLyY3sODt4/iMpdlKU+86e7/m
	 zNnPqicAf99qbZjjI0cBmMsA6Bgv8bQoAd7ISy+Z8mKqiH0sHG/ij072jYwZoQWwBZ
	 a+bF5t2mhRHb4z5bYMsClZbwZGP/OAo+ug4BU7vgS1cMDQJl/5lMwr07H/ue3tJoZW
	 YfiM6ZHxS/Y7NE8lgtxDDc+l2WxDXTFwDgA/igsJFtVENqd/HZBhuMJGzj8WdXBy1r
	 lGSjwDZ83KbT0BKLcUmDOHaGH+owFd/UlrczBGgDk5gubNpxSYR+dL1hrkMMt0piQy
	 z494dPyAjR4rg==
Date: Wed, 23 Apr 2025 13:42:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
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
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 05/12] regmap: irq: Remove unreachable goto
Message-ID: <b7c42d62-6700-4558-9034-29f78b6fc22d@sirena.org.uk>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
 <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
 <D9E0YCJXMSJ6.2689GYOSQDC8M@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JTE7YVeMq4uD56QT"
Content-Disposition: inline
In-Reply-To: <D9E0YCJXMSJ6.2689GYOSQDC8M@bootlin.com>
X-Cookie: If you have to hate, hate gently.


--JTE7YVeMq4uD56QT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 23, 2025 at 02:41:47PM +0200, Mathieu Dubois-Briand wrote:

> As there has been a bit of discussion on this patch, may I ask you for
> your current opinion about this change?

> Should I drop it from my next series?

Please.

--JTE7YVeMq4uD56QT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgI4EQACgkQJNaLcl1U
h9AMcwf7Bd2ZUEygD1Y+NmSxJzaxakCHL7GdfD9YDMUN7X0vQdZr5fyKnk6hI0+9
b57IP0skpP8OcKlom7bNTc13YjZyRdSms7lcObI0nH+84P+HeF1OibYqfCObMvW3
NAaGz6xhCWvXtZ6+PjF5ZTCYiY1lhP6VVwSwzEiVb9u2lA3Gwkq/+FgpLc9CQgyi
xB0EdEabDr3tBNPu0mcRmoN0uOiHZzBGKFvj+aJ9+PRhDTqN/V4L0Ik5L5tTOXJ0
N3ey3KuHahxMFdt5WM3dENb9dCRbx4CB2H9jHU6qs/QDiBqjVuR06e9teZ8jvb6I
MFIQ9dDN0eOP5ZintHbPzZ4uZp93iw==
=0EoB
-----END PGP SIGNATURE-----

--JTE7YVeMq4uD56QT--

