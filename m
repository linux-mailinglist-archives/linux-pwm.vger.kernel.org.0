Return-Path: <linux-pwm+bounces-5416-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14EFA82A45
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4AD17F358
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A41B266B5B;
	Wed,  9 Apr 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceZ7VEhE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175521DFFD;
	Wed,  9 Apr 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212120; cv=none; b=LRADe5YzcnB3xkYz+uyy66KxxhzQ5jhO4uUXsZEtE3SmlMQXPEqt9BzokgqJphlb+223f6wPpL4jf0hkIgmnx0NTzFktzoBQpnkizQC++DlkaY99ynqJ77jg3IlW7wgLQpu/+xRWwFKE9uwNtMHqHwyykBLyp97OupXqybEjWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212120; c=relaxed/simple;
	bh=u5W4TCrbWdKfRSjbjH7egyZ1LdGXBg+M4qrZrD7b9Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aec5V8lpTNANJkHS6n0onYaxtGsTjobCWOWIkfgwDOxNTYwRZCSIH9iIKMnDlr64ArpEJpe+0UF00xz+HenCDSRDFEFOC3g/Q4nJytr9/Sfr+wq5T+w63Z6g4GzRBjQWCtwgWVFKgNLVm8CS7O+mi2aU0ZbQF+g2LGtYGHW1XyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceZ7VEhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C0DC4CEE2;
	Wed,  9 Apr 2025 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744212119;
	bh=u5W4TCrbWdKfRSjbjH7egyZ1LdGXBg+M4qrZrD7b9Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceZ7VEhEygjxAY/ZmtjtSee2tS8m3BUDq6PYYOe7aVrpnm/PndrMC1scPqUocIEtb
	 XW/BOgYiyJthMHc2ZE/qI7IXkYU8xu7gxWC3m2O05dq8WrXGSNGZqvo0AxxL/S4fXX
	 eSYuktFroO1Ub+rzbDLV455T4FDOsv6iOTpQHAbg6QL6JIQGO0VpPdeKgm0Z2ZaLZc
	 98YQtLOjGYGP1E66G7zvdm7al3Sij7GhLhEzyT8hBgUqN+nuYwKS3+Ry9pDB8LHxbP
	 cE/kHjaACiNYS/b6ef6NDqdYc2drWzuS2B6rJxfjuo0F2fcpNSGMmN/9+jZrM7Xbfo
	 +/Bj7NZUmWqMQ==
Date: Wed, 9 Apr 2025 16:21:52 +0100
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
Message-ID: <257e1b1f-f51a-4c6b-8569-ce203571f031@sirena.org.uk>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
 <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sw3b3aYhYdHvnH+A"
Content-Disposition: inline
In-Reply-To: <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
X-Cookie: Words must be weighed, not counted.


--sw3b3aYhYdHvnH+A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 04:19:34PM +0100, Mark Brown wrote:
> On Wed, Apr 09, 2025 at 04:55:52PM +0200, Mathieu Dubois-Briand wrote:
> > BUG() never returns, so code after it is unreachable: remove it.
>=20
> BUG() can be compiled out, CONFIG_BUG.

Also, please don't mix irrelevant patches into random serieses.  It just
makes everything noisier for everyone.

--sw3b3aYhYdHvnH+A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf2kJAACgkQJNaLcl1U
h9BLcgf/ZI2t5Tk08vPrVn5NdkoJRctpDx1tYf49MYVCdfU96F2xKR665vyQL5lS
C67LdMLJMrUtezqWn5g1ul7Sba7GATqEJfPHurOxuS/ThnrwD+a9VEHZXK3Vh5ah
RYqGeuPqpYvIysjgz5vbdti2VzDdKL1WcntEY/ctkqqRmOJVGtwYkZixVQcC73Vq
nyMAhfPV5A6JpF1ioi+AarBi0Q4alReQiEY+6QClsmyFVQyqNEQC77uokmL7IUL/
wXoMA6RIeu3Bch3MpnpiyFoWj6bMsGeyS8Ay1bAuFV57Zr1zagkg9/z5Lizv0MRo
AZGa9JTGZYm7DF3eVz1p06F8Pwglzg==
=Hcu+
-----END PGP SIGNATURE-----

--sw3b3aYhYdHvnH+A--

