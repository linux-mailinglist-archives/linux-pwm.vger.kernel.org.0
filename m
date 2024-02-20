Return-Path: <linux-pwm+bounces-1570-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1379885C07C
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 17:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30F7283B3D
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B40E763FE;
	Tue, 20 Feb 2024 16:00:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD9762E5
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444858; cv=none; b=dB7MYb2sWKTDWgJTnzIk+h+94gK4GmMEiFdsUFGoYYeJrLZ0hfpAoTDJVnDFOuwQTYFJLZXfZsqvVmafhC5APOoJSeWfB+/Gm/CvhqKkkB5aWmc0JDAVqXzN/wriLwMCG1w0gVmStmWzG2stNqJhgqAQQahFhz2Ta7xac9u053E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444858; c=relaxed/simple;
	bh=9IKEKRBaF7Mp5szpy8X2Zg3RvvGz/jH79UcTz8k8G8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocNuflBSDcU+MCqZrZMJDHI16DBJBXcEh2fBNG8BSfOcxEXnK8ndO0BD8GhLwyw/3XVceDI6/k0Z/w8Nc53PyV/hHeNixLAOdb9dvIpAvKJKxiLYzXn20q4xAwkW16QBVKL3JXG8uGq5JkdFVzCavbuA9FDdvgbk2DoFpMS22hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcSXr-0006Fv-Uh; Tue, 20 Feb 2024 17:00:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcSXq-001sFF-Ty; Tue, 20 Feb 2024 17:00:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcSXq-008Yql-2j;
	Tue, 20 Feb 2024 17:00:34 +0100
Date: Tue, 20 Feb 2024 17:00:34 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] DesignWare PWM improvements
Message-ID: <hnkjhnbikthtsqeqk2wetfvs7pjmcucrix3tj6a2g6lmtryany@3qprg5nnmpvh>
References: <20240219033835.11369-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cnwbkgxcdl7id6yu"
Content-Disposition: inline
In-Reply-To: <20240219033835.11369-1-raag.jadav@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--cnwbkgxcdl7id6yu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 19, 2024 at 09:08:31AM +0530, Raag Jadav wrote:
> This series implements 16 channel PWM support for Intel Elkhart Lake
> along with minor cleanups for DesignWare PWM driver.
>=20
> Changes since v3:
> - Fix PM regression
> - Add comment for removed error check
> - Drop accepted patches
> - Update tags
>=20
> Changes since v2:
> - Remove error code duplication from dev_err_probe()
> - Update tags
>=20
> Changes since v1:
> - Drop redundant error check
> - Provide dwc_pwm_init_one() to initialize one PWM instance
> - Use dev_get_drvdata() instead of pci_get_drvdata()
> - Use pm_sleep_ptr() instead of use pm_ptr()
>=20
> Raag Jadav (4):
>   pwm: dwc: Fix PM regression
>   pwm: dwc: drop redundant error check
>   pwm: dwc: Add 16 channel support for Intel Elkhart Lake
>   pwm: dwc: simplify error handling

I squashed patch #1 into the offending commit and applied patches #2 - #4 n=
ow to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cnwbkgxcdl7id6yu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXUzKEACgkQj4D7WH0S
/k7S6AgAo/SQLT56ZKRERqRnH6iP+DslOStw9DGoVoc1671CGy5KZ0zijcbg8UaG
MndJbEmWP3s5gxSLflvFvhusijjjaAmq+0hffK0nUHSPMtN0L/QLP79apViuOm6p
8HF9qo6rje4KHZl8cTE6zUJEJbwXk+UrLEFonrWwWMecn4s0rGV/jO7JNWfdR1o6
b7u1yhatlGZvE3XglhlNeSfWg1ODLUx8HEV2j116KlehdWjkmimBCGCBS+8tf+Cp
naqA6vVYXeh88hz4TVz/nnkscqx1ivf7qqh3/a5QxVHWu9Q/8ue/QUp66zP5FDPm
nvKBSaYXwBXrCHyzT9Tv49DTSelX2g==
=Q9aQ
-----END PGP SIGNATURE-----

--cnwbkgxcdl7id6yu--

