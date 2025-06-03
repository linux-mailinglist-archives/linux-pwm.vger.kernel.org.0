Return-Path: <linux-pwm+bounces-6238-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDA1ACC6EA
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03E91883FF7
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B73A1CAB3;
	Tue,  3 Jun 2025 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTSmGMB8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533674A11;
	Tue,  3 Jun 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748954733; cv=none; b=kz/y6kv/V2WaxFFIZgUSiX1CyqqHiTrnAUh2STH86hHJmG0C+pJJQFp2VWNA1sT9RJGMb+qbDZKXIDxBITr8XOpxVuWtQV+GxM2Ob0/f5nvQH+yk+lKkDACenhz8w2ClkFlfX+J+hgoPoJKtzUKgutDvlLGJ85oriBbsjttcPsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748954733; c=relaxed/simple;
	bh=WtICf1yQw6GKvIVc9UQ1VFFH9bbz3D0zT7ruxlzNogk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaC454cpybZR8/tyZpMvmngnBl8O/7AiQuH0dMPoswlnnV6ztcxjEJ/hApFZbQhhqLmhWtg089ih5HSUt260bepVHB1MkM1QNmwfFxDO3SsQmtM8JE+2ubcVAAw+xUdJ7rtXAzpP1neTwN0CjEdJSZv0rMU0dJ8n1+d6B/lHRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTSmGMB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08C2C4CEED;
	Tue,  3 Jun 2025 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748954732;
	bh=WtICf1yQw6GKvIVc9UQ1VFFH9bbz3D0zT7ruxlzNogk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTSmGMB8EtvHklBJmOR/eKWUDTgYzAW6DCvPQONVftUSYPWEDjurj8jRMWxe/xCfQ
	 Fx64zcHt1TYJpmMyJ6iGkjSSxR856chNokkkfE3H5g1T+lap4RBWH5I62JUeF6Yqyq
	 AO/2d4Lw581FU3mKuZdOZUKwKSS7QJ67P/dqcQwv+QEnE9J5xL97MtY89P2EcEHtcB
	 jp/HWFZPCAQopYiyh2mlqEuL+NoAKhx7acs+bUiWXRawwzjzRzJXyjmTUAAbOTFkSA
	 8U6YtGlh++Zn/IuwqQJf5BZ9xOyDvsdNELkY9GU+PSxFIeUsznc0nwaa+96heZ3gJ/
	 DaYU2RjbyoDVA==
Date: Tue, 3 Jun 2025 13:45:25 +0100
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10 05/11] regmap: irq: Add support for chips without
 separate IRQ status
Message-ID: <7fe6fd7f-75aa-47a8-bf90-1c0680a3334a@sirena.org.uk>
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-5-ce3b9e60a588@bootlin.com>
 <aDmKcNez0Bj41Tcv@finisterre.sirena.org.uk>
 <DACQOEWJPTU2.34E6UEWBOQ2X8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6stFWgWuRNK/tCCW"
Content-Disposition: inline
In-Reply-To: <DACQOEWJPTU2.34E6UEWBOQ2X8@bootlin.com>
X-Cookie: Avec!


--6stFWgWuRNK/tCCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2025 at 10:01:55AM +0200, Mathieu Dubois-Briand wrote:

> So my understanding is I should have rebased on linux-next master branch
> instead, right?

You should at the very least have identified that it was being resent
and wasn't changed from what was applied.  To be honest it'd probably
have been as well to wait until after the merge window given the minimal
prospects of anything being applied so late anyway.

--6stFWgWuRNK/tCCW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg+7mUACgkQJNaLcl1U
h9BQZwf/Sq8Nz5LE9ydUHJnyLRvnUX2yI/CC6D8qUKyCD8aMsHcY9Mp4KsUxxMz/
KGBycbKKY7lkVwj3znPpG1Sv4PRIIV3rfIBFFxQI20AgH2uvELVOeUghI1F3pZxY
Ba+XBpcmDpBD85hgn5KHldT7Cs0B1OG6ICikd2u9rp1WXADOL8DYqVAv52oC3ckO
SlWmPdPU/pZur7ABp3OXou2kWaPrlpt38I64cqGlJq+nxT3nd7FhqDBZVn7oFwml
dDYZ9pbgH33vvyvUpVFxx3/WE9hWzpxkIxEkktsjPmFL+4rqOTbOHySXjUK9vieb
8TPzCzypsQumzBuVlTTKbWRtbH5QLw==
=akC4
-----END PGP SIGNATURE-----

--6stFWgWuRNK/tCCW--

