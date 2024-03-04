Return-Path: <linux-pwm+bounces-1687-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5A786FF65
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 11:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEE41C21096
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3479837179;
	Mon,  4 Mar 2024 10:48:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36D20B27
	for <linux-pwm@vger.kernel.org>; Mon,  4 Mar 2024 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549322; cv=none; b=Da7AKrIMExZRReZ0cwwIBrh1CEnqe9FwAaPTglHXM7qXh3JWnHy18CTR1jTpYz1Fk5+zOQbjQaReRgM5nU2xn64+aAM1W7CgqQ2vP/603PPZou36kGN4mjLgaQ2wVWp6lypVV2Tpx8mp7l+X7W9IUCR4KdQ0YX83lcW7lAkY3JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549322; c=relaxed/simple;
	bh=kx2zpyXI8oxJfPrLUgbgStNZsYw4K1yjsM3fNQrI1l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrwVvZ4qZgjrdJ9n5K6g/Vqox8328AWcllR1fadmFLTrCtE0jLg4ljpG6hCUgS4VUSUaj2ZREcY0S6l/QeDpHy4Wp4LPqrNLR963TqAm9Fk/vI491UkHDmfadiiTgGYM07LsqHkDgD4n/NCWRuB4hYj3CsqlcetBfND7Pbq94UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rh5s6-0007d8-1h; Mon, 04 Mar 2024 11:48:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rh5s5-004Klt-GL; Mon, 04 Mar 2024 11:48:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rh5s5-00Gbba-1M;
	Mon, 04 Mar 2024 11:48:37 +0100
Date: Mon, 4 Mar 2024 11:48:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-pwm@vger.kernel.org, imx@lists.linux.dev, dongas86@gmail.com, 
	shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] pwm: imx-tpm: fix probe crash due to access
 registers without clock
Message-ID: <qpk3pwirjmxf4agstv6bisdefrzv5k24uxiszyobpf7yw3mxt3@ryj7hoyvp4cc>
References: <20240304102929.893542-1-aisheng.dong@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2oimvvwb6qepn7wc"
Content-Disposition: inline
In-Reply-To: <20240304102929.893542-1-aisheng.dong@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--2oimvvwb6qepn7wc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dong,

On Mon, Mar 04, 2024 at 06:29:29PM +0800, Dong Aisheng wrote:
> The following commit abf6569d6482 ("pwm: imx-tpm: Make use of
> devm_pwmchip_alloc() function") introduced an issue that accessing
> registers without clock which results in the following boot crash
> on MX7ULP platform. Fixed it by enabling clock properly.
>=20
> Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0978004
> [f0978004] *pgd=3D64009811, *pte=3D40250653, *ppte=3D40250453
> Internal error: : 1008 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc6-next-20240301 #18
> Hardware name: Freescale i.MX7ULP (Device Tree)
> PC is at pwm_imx_tpm_probe+0x1c/0xd8
> LR is at __devm_ioremap_resource+0xf8/0x1dc
> pc : [<c0629e58>]    lr : [<c0562d4c>]    psr: 80000053
> sp : f0825e10  ip : 00000000  fp : 00000000
> r10: c148f8c0  r9 : c41fc338  r8 : c164b000
> r7 : 00000000  r6 : c406b400  r5 : c406b410  r4 : f0978000
> r3 : 00000005  r2 : 00000000  r1 : a0000053  r0 : f0978000
> Flags: Nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6000406a  DAC: 00000051
> ...
> Call trace:
>  pwm_imx_tpm_probe from platform_probe+0x58/0xb0
>  platform_probe from really_probe+0xc4/0x2e0
>  really_probe from __driver_probe_device+0x84/0x19c
>  __driver_probe_device from driver_probe_device+0x2c/0x104
>  driver_probe_device from __driver_attach+0x90/0x170
>  __driver_attach from bus_for_each_dev+0x7c/0xd0
>  bus_for_each_dev from bus_add_driver+0xc4/0x1cc
>  bus_add_driver from driver_register+0x7c/0x114
>  driver_register from do_one_initcall+0x58/0x270
>  do_one_initcall from kernel_init_freeable+0x170/0x218
>  kernel_init_freeable from kernel_init+0x14/0x140
>  kernel_init from ret_from_fork+0x14/0x20
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Fixes: abf6569d6482 ("pwm: imx-tpm: Make use of devm_pwmchip_alloc() func=
tion")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

LGTM, applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2oimvvwb6qepn7wc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXlpwQACgkQj4D7WH0S
/k4jAAf/UWWbceHFixLTHxbBE2mSCAfOAeD4DOXlqnbQiV3tw1COJ3yM2sEynPC9
Ipxjbohbf1F6m5ShNEtbgfLiT6Di7O1+0UowAtYGKU3EgHDJzz0Yd5ApYbxlTdH5
c70ARDxsuGIqaVNLoXxR+5FAG+qYrXSjeWNo99WpehBaVPBfa56E32NfBfmAcVUN
WXPf9Bqgvjf6oies7xXDFZJSpePd4J633nYlHYTax/7S7jY/HY2IMxaviFPRyHN8
j8r51XUSExdch6H1DU8gUM4318i8ZPyZ5SBkSTBrqBig2TDUfU1pFv7A8KRpX+wl
zMFGYXhxUJVbkTgUL3XXvEe37GLcWQ==
=kMEF
-----END PGP SIGNATURE-----

--2oimvvwb6qepn7wc--

