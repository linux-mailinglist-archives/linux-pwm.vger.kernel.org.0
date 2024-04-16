Return-Path: <linux-pwm+bounces-1947-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3648A6C01
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 15:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CACEB209CA
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649912BF29;
	Tue, 16 Apr 2024 13:18:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1712C466
	for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273513; cv=none; b=Xbcp2ErFYRk8iW1B3rWgPQUYx4lrQvVRim0fJKCzPU4M4LYoxHreURL0ZIHkzNwdwIR7uj2TBEFvl2Vu771UVmv3j9B/rTjAmV42r6GaQVfmLg9rpEhsZ+EO35sLr8spPzL0RhSv700DoogcIo/JtL7UUf4dd7NrZWE++DgFYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273513; c=relaxed/simple;
	bh=u3r3BNHWn0VNuX0IDcCiM+gYMJzoSCvGaQ+eZeZOnUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm++x2b1HuJmms7usAXDulaaNNch/UvZpfyN0yOBzQ4unZPMKycg03V55LSTwR3rvZw9FpJmKkF+Cr7keb4RqULxmhtFrcV7f0oOJRV0S3tzTHiXMaVNVMAuV+L/gfjs37Q7VVihmhubzb6sHEnnArJrttXW1lgsQzz2wpCprqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwihY-0005sO-EE; Tue, 16 Apr 2024 15:18:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwihX-00CcPG-Ut; Tue, 16 Apr 2024 15:18:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwihX-002BWp-2p;
	Tue, 16 Apr 2024 15:18:19 +0200
Date: Tue, 16 Apr 2024 15:18:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] stm32mp1xx based targets stopped entering suspend
 if pwm-leds exist
Message-ID: <dqibafuvizvltkblfizxvgrl3744lpxbwgdjid5ekxsju7gmxm@fys22ievmgz5>
References: <5da6cf8a-4250-42f6-8b39-13bff7fcdd9c@leemhuis.info>
 <2vbwacjy25z5vekylle3ehwi3be4urm6bssrbg6bxobtdlekt4@mazicwtgf4qb>
 <256e3d3c-d43f-4bd6-9a7b-50fc870e75e4@leemhuis.info>
 <20240416121519.GS2399047@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mgrsmbcc7mtyc46w"
Content-Disposition: inline
In-Reply-To: <20240416121519.GS2399047@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--mgrsmbcc7mtyc46w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Lee,

On Tue, Apr 16, 2024 at 01:15:19PM +0100, Lee Jones wrote:
> On Tue, 16 Apr 2024, Linux regression tracking (Thorsten Leemhuis) wrote:
>=20
> > On 06.03.24 09:18, Uwe Kleine-K=F6nig wrote:
> > > On Wed, Mar 06, 2024 at 08:05:15AM +0100, Linux regression tracking (=
Thorsten Leemhuis) wrote:
> > > > [...]
> >=20
> > Jakob confirmed it helped in the bugzilla ticket. But the patch since
> > then didn't make any progress afaics -- or did it and I just missed it
> > in my search?
>=20
> [...]=20
>=20
> > > ---->8----
> > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Subject: [PATCH] leds: pwm: Disable PWM when going to suspend
> > >=20
> > > On stm32mp1xx based machines (and others) a PWM consumer has to disab=
le
> > > the PWM because an enabled PWM refuses to suspend. So check the
> > > LED_SUSPENDED flag and depending on that set the .enabled property.
> > >=20
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218559
> > > Fixes: 76fe464c8e64 ("leds: pwm: Don't disable the PWM when the LED s=
hould be off")
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > [...]
> > > ---->8----
>=20
> Did you submit this?  I don't see it in LORE or in my inbox.

Yeah sure, apply it using:

	curl -s https://lore.kernel.org/all/2vbwacjy25z5vekylle3ehwi3be4urm6bssrbg=
6bxobtdlekt4@mazicwtgf4qb/raw | git am --scissors -s

:-)

If you don't consider that suitable, I can create a patch that is easier
to pick up.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mgrsmbcc7mtyc46w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYeepoACgkQj4D7WH0S
/k5gugf/bpVGAeUjhxmd3eLjzH0HtU2qSxWQG4LFIRegk08Ex4wJNhpopT1kQOhN
SMdNDgjcgSxvo9tqfH9cBTltJF0Baedv3dWGb4G/pJEfJRmUrk0+mkC/ZIoL/fTE
VT0zY6pg3+zAXij2/W73VzFMGIf04A1CWrbOdxaODWlNVX/hb/MlS7TbbATp2PSZ
DDDZhQe8kYQ9FPVvqM3HJRlZH5BJA/uLLHz+EK2H8QiMzqL6V/tCaY/ewjv+ZoO1
20RPRH45JQA5LEALCkdAJ8+0OCHjxuQd14SHagxVW85U+vwA8CmTdDOwZFFnUTfw
82MlSpgXg2z+D+tOpuqNd/HVKvO7sA==
=NwBy
-----END PGP SIGNATURE-----

--mgrsmbcc7mtyc46w--

