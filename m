Return-Path: <linux-pwm+bounces-4965-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A92A3EFA3
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Feb 2025 10:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6084E422E25
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Feb 2025 09:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C80202F99;
	Fri, 21 Feb 2025 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JClM5MEs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862D200BB8;
	Fri, 21 Feb 2025 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128907; cv=none; b=dtuYBdF7RPyEPMkRXo8YeCzp6MYwHV/EC1PdPrytE13ne5Npkhpo+garUbw7P/BM1cBgWwDlTxU8FXls/1Y95Ul1s81odacj8EnEqtAxVfO3e+Y9moLsfotCSiPplI+DhAs+RWKiY92OPRwjMq5tNjbR7ZhflomZwzoe/Q8rXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128907; c=relaxed/simple;
	bh=oimX8Q/LxRwlfk+t54o1mqJdiaT+zvHD2n1g78Yevyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWZCVOFrUNvxzn2axlrnulSo6WCxUhb1oA/77+mXqDtwQKhwjTQ/QVd6GSsTEyyE1f/OT2AK32Smbd917zITAGIAJnhDSuZAv74apBy5GVYcqUIozvGSouXx5LL24B1UxtxOzpsRDRTt50zZJ/5W+/GiCMi6mwOFf8SgItrugXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JClM5MEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0642C4CED6;
	Fri, 21 Feb 2025 09:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740128907;
	bh=oimX8Q/LxRwlfk+t54o1mqJdiaT+zvHD2n1g78Yevyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JClM5MEstLWw6w/T8uUGehpMEt3dq/s2eDp9+GtkyXyLoak10+VKVrUaDo3SVYzBr
	 qOJILi55XlxfVFZBj8KyETVvp3mTXn5W5WoMcO9mnzsld87a3jr7aMrqOSOJBAZf41
	 Alqg95mv/MI43DgUp2Q8dRXA5bBFE1Gi1DZg92lmDDwz5V609dFscVct1r+LxFXMb0
	 keBbOaEpJSLcTdgo4DtdXvWxqX9aBqoE+zjJUpnSjiXX35F6yL4EjxUe52ywu5J0aQ
	 AnFQKfV+44glIbtY3xwzA0Sq6kqATZ0JF3rJHNbq+M4NZkn/5BwbCXYuybXLRKnIdB
	 2EL+uArOtSmkQ==
Date: Fri, 21 Feb 2025 10:08:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: kernel test robot <lkp@intel.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <hb7agtiqcuotiie646a2nzwg2cfwmahtgzzexxsf4tqu3rztf6@qqq2a7qkazh5>
References: <20241217132921.169640-4-biju.das.jz@bp.renesas.com>
 <202412182358.9wma1UUE-lkp@intel.com>
 <TY3PR01MB11346CC402843A628226F5C6186122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <b7woae7iquvuzs4vcollns7qcyand4ginrbjqs75bnsiockrjc@c4pyody6zdcr>
 <TY3PR01MB1134690173EBB583582DE8E3386132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k2zrcougat4y5ihj"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134690173EBB583582DE8E3386132@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--k2zrcougat4y5ihj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
MIME-Version: 1.0

Hello Biju,

On Thu, Jan 09, 2025 at 09:32:58AM +0000, Biju Das wrote:
> > On Wed, Jan 08, 2025 at 02:13:09PM +0000, Biju Das wrote:
> > > Please let me know, if there is any feedback for this patch series or
> > > any new API to be adapted in next kernel version which simplifies the=
 code, So that I can send next
> > version.
> >=20
> > I didn't look, but if you're ambitious you can convert your driver to t=
he waveform callbacks.
>=20
> Is it ok, after the acceptance of initial version, will switch to wavefor=
m callbacks to enable
> the users of GPT(Reason: lot of customers are using GPT for backlight for=
 LCD panels)?
>=20
> Please let me know.

I'd still accept your driver with the legacy callbacks, mostly because
your effort is already that old (which I consider my fault mostly).

> Is there any documentation available for waveform callback? What scenario=
s we can use
> Waveform callbacks compared to traditional one?=20

There is no nice documentation available yet. The improvements include:

 - arbitrary offsets for the duty cycle, so the active phase doesn't
   need to be at the start or the end of a period any more
 - consumers can query the result of a configuration request (before and
   also after the request was issued).

Both are of little importance if your focus is mostly backlights.

Best regards
Uwe

--k2zrcougat4y5ihj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAme4Qn8ACgkQj4D7WH0S
/k7FvAf/SOI19tb6fGsBqVcRMh6WfkohHjyd+hY6mT9Ldu9nlH+O/29gn2WT7q0V
0Vxl7YzQFTAg6yi9CJVFTTxUYI0Lguc6axHEZJpEqbgGHTa6wxL5xBEFneEbZ2O3
PbMfFIFtGrpYWz9ThcDbdwlamRBaAVFOFgP3zIubK7m3Qn/Esdvtj88ZVGur+D6n
DvuxxmaN1wD3d4YWI/prGd1LwlGAarvjWDVzFOIvlUOE1fooxeN0mvlam/sDl1x4
O++C/ldxqSRhEl7pL1iZy7321/ofkqdlBlIPLgDF2azF98jDAfUvYy3wUOklj8Vo
r0daeIGYwIoCRibBTvmkRTIlNrhCFw==
=ajkb
-----END PGP SIGNATURE-----

--k2zrcougat4y5ihj--

