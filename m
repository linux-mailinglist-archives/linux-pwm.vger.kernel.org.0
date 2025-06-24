Return-Path: <linux-pwm+bounces-6501-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4CFAE5DB8
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 09:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FBD400B06
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9581B25524C;
	Tue, 24 Jun 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INdGmHE0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB82550A4;
	Tue, 24 Jun 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750169; cv=none; b=hBsFc5K0/l0sh0T4zSLHfbkrfw9Enm0IWLP/7Dk89BsiPa8yJ4skiCtEEQ5rgFcAf1oYm9tDJNvNxbIvjOGPUUiXW0y7Kt82//ffDPjGiYzDbPrA7vNmfiYXxnQJqG8P/wl9DtvHWUMWnxHMVWBTJ9Z0CEGQMDecDyaB8qzlHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750169; c=relaxed/simple;
	bh=AIK2LQnI0Fr6rSBceS6Vs/7J3Mt1l/fq68vg6ZWA7xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNIr1hpcuRH39Kk6JabLoE+obn4ZLUgjpgkQDTCHpiTK3vXuLpa41a7SZVSQ12+iGbvm10HWLYt9NvhGDxeBilS65cXH3iiOLKMJItd7wrHtKZE5FWf5QymTo9Uf2QuuEzMoSlY7SubX7WMfxE2CtVedf+69Raokr5pioIUZgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INdGmHE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D59C4CEF1;
	Tue, 24 Jun 2025 07:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750750168;
	bh=AIK2LQnI0Fr6rSBceS6Vs/7J3Mt1l/fq68vg6ZWA7xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INdGmHE02uSmZsmqCajakdsQfLlPMSPd/z8ZvXimIJJXIvCt7iEgB4YYA4zQI8OTa
	 7lJHKDaFJIhePG6J7VnXDqoi9ImReyrAFOUco4W3jSejBD1chXNZAksqn90VwWp9DV
	 YExfhdDCYRNDLVvs3QTmANd+sAkif5aA8UzKWXKHOMSWBMDEzbNkvaoKRk0tuVde+m
	 n8Yu+rpHCgzDj78D3CcotCtiue2rlqgwbUMXe5h0LGKPUx2V9da3M83l9Q58ZoYeM2
	 1a94uHnRAnhc7AEr3MVwN0tY1k92UFzECSNm9TnsZawmf/hgZZv5zcHL2mSKfQW69D
	 RemlgTa/vo6mw==
Date: Tue, 24 Jun 2025 09:29:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: dimitri.fedrau@liebherr.com, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <u4aigv7nhsqygisyrhcohq25tvktsukjexng6zddib6kvj6hwl@vaa2pset4qbi>
References: <20250619-mc33xs2410-hwmon-v3-1-301731e49f8f@liebherr.com>
 <cviovwci5fgtyina7p7zqjns7cwveivy3vetqhhagwmrlc2gm2@jrqgorif7xff>
 <20250624070442.GA3383@legfed1>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7vlhrsw6pmzxempg"
Content-Disposition: inline
In-Reply-To: <20250624070442.GA3383@legfed1>


--7vlhrsw6pmzxempg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pwm: mc33xs2410: add support for temperature sensors
MIME-Version: 1.0

On Tue, Jun 24, 2025 at 09:04:42AM +0200, Dimitri Fedrau wrote:
> Hi Uwe,
>=20
> Am Mon, Jun 23, 2025 at 11:07:24AM +0200 schrieb Uwe Kleine-K=F6nig:
> > hello Dimitri,
> >=20
> > On Thu, Jun 19, 2025 at 07:32:42PM +0200, Dimitri Fedrau via B4 Relay w=
rote:
> > > @@ -29,6 +30,8 @@
> > > =20
> > >  #include <linux/spi/spi.h>
> > > =20
> > > +/* ctrl registers */
> > > +
> > >  #define MC33XS2410_GLB_CTRL			0x00
> > >  #define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
> > >  #define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_C=
TRL_MODE, 1)
> > > @@ -51,6 +54,21 @@
> > > =20
> > >  #define MC33XS2410_WDT				0x14
> > > =20
> > > +#define MC33XS2410_TEMP_WT			0x29
> > > +#define MC33XS2410_TEMP_WT_MASK			GENMASK(7, 0)
> > > +
> > > +/* diag registers */
> > > +
> > > +/* chan in { 1 ... 4 } */
> > > +#define MC33XS2410_OUT_STA(chan)		(0x02 + (chan) - 1)
> > > +#define MC33XS2410_OUT_STA_OTW			BIT(8)
> > > +
> > > +#define MC33XS2410_TS_TEMP_DIE			0x26
> > > +#define MC33XS2410_TS_TEMP_MASK			GENMASK(9, 0)
> >=20
> > Keep the registers in address order please
>
> Aren't they ? There are "ctrl" and "diag" registers and I didn't mix up
> adresses. There is a comment for each of them when defines start.

+#define MC33XS2410_TEMP_WT                     0x29
=2E..
+#define MC33XS2410_TS_TEMP_DIE                 0x26

> > > +/* chan in { 1 ... 4 } */
> > > +#define MC33XS2410_TS_TEMP(chan)		(0x2f + (chan) - 1)
> >=20
> > I wonder if it would be cleaner if this was abstracted using mfd. Then
> > the hwmon driver could live in drivers/hwmon
> >=20
> I will have a look into auxiliary devices as Guenter proposed in a
> following mail.

FTR: auxiliary device is also fine for me.

Best regards
Uwe

--7vlhrsw6pmzxempg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhaU9IACgkQj4D7WH0S
/k5DxAf+P3GugKuOyN+mF0JasySC6A4I4dHuRHgesRzkUS0WETYZiDHn/qVcnVsf
3A0x6ZiewS1joqgJtXNBvN/t/zVP0/BoN57tNUkhKMb5VtWPw0xG8k3pMY9w+x02
L6jyHsAVd4x6Wph8mbcRXg3BnkE/sXLZP/+mnyLVXMQIIJwMyUDoz2U897LCkA/k
DkHxYuMVnz5qSLUFOedeA7lfcSrdLjLP74DrUofP+wgqmLxdVOBE/O+Wf1LMhgO+
IuRN1wQu8KGSdqROSRnOCjWVEipp2eGU0gHxLCkUVpMzdfXWQT+H+hmso0l6mUkD
bDihzmaYvaqlWtePwEEYEkC5V1Ltmw==
=65/L
-----END PGP SIGNATURE-----

--7vlhrsw6pmzxempg--

