Return-Path: <linux-pwm+bounces-7944-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB55D3B2F0
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 18:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 670D63147DD3
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C6139283A;
	Mon, 19 Jan 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vet8+dRQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135E30C619;
	Mon, 19 Jan 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840886; cv=none; b=QM+1CCFAZy2ZAMEVr14Q+Sye+S4paUmJLkbITIPMmOFHPNWn9a9JkTxrrVnYR9e9JcEv4w0y7/xiqrDPpvMVijeFf1V2TNU9DoMtrvV3cv2yJ4/iRJWSLiQfSwTKhi0I1FmApWTv8UCYjtJcy9bOpJLLBzHEfiGeyQOamMgFheU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840886; c=relaxed/simple;
	bh=YNvQdTjzzov2cZczYT3rRjpzQMiOwdu9Sj+m96xZ4+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzB70srbJErIxSZIzf+YyJ5xTMlI8VQq0A2eDXDMHYx5CkyvNciR+7VLYqnpzzLHJJrEMw6FK5m+fvvnzMgZywtk3AaW+LWALhfPssanRTEsglUWRqHKoMb6NgUCUBoU3j8u4t8nQg2LdXbWvhYE2YMfJVaftpUE0gZOvVgvpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vet8+dRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B77C16AAE;
	Mon, 19 Jan 2026 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840886;
	bh=YNvQdTjzzov2cZczYT3rRjpzQMiOwdu9Sj+m96xZ4+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vet8+dRQydCn18sJ3c14v/RiPuSPJ/LhX8zlbJt/HUPXuvlx637nnvWe8NDrUF2ZS
	 7tBW0M4jfrp3GRRKmrGgWeoI6ByVuO+Esn9PvIX2MEr1tJRR7R8Ca2wcSNxLc46duN
	 9CpG41GlWuaezR4lXmCdmUJvBBY1OTKKF4MPgWBrqLybZ+WSwB0AYQ1cSsggWySPIj
	 m+qQmxka49mCu4VZodiakf1hDkywi64yPw66qSWNQqYqJdjYjAegEZpGxAPCRrZhao
	 qDu4NMzWuKUDGcE3mlq7eJml7S1kQglJgiZFjitUCYFiJvtiz/SaKbYM7i6cRjK9yd
	 b7CvQXQvcCPSQ==
Date: Mon, 19 Jan 2026 17:41:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>, 
	Baruch Siach <baruch.siach@tkos.co.il>
Subject: Re: [PATCH v19 2/6] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <xnrjz7v4trkhayskyn5efksqor4xnxz7zbf6qgk3qvnybncrit@ejgnw2hl3fon>
References: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
 <20251128-ipq-pwm-v19-2-13bc704cc6a5@outlook.com>
 <3aa86b13-9505-4f64-a168-4c46962b715e@oss.qualcomm.com>
 <BL4PR19MB8902F80FE2D7FD5BCBE340689DA2A@BL4PR19MB8902.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="swptr2pfrym525fs"
Content-Disposition: inline
In-Reply-To: <BL4PR19MB8902F80FE2D7FD5BCBE340689DA2A@BL4PR19MB8902.namprd19.prod.outlook.com>


--swptr2pfrym525fs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v19 2/6] pwm: driver for qualcomm ipq6018 pwm block
MIME-Version: 1.0

Hello,

On Mon, Dec 08, 2025 at 07:40:21PM +0400, George Moussalem wrote:
> On 11/28/25 15:32, Konrad Dybcio wrote:
> > On 11/28/25 11:29 AM, George Moussalem via B4 Relay wrote:
> >> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned=
 int reg)
> >> +{
> >> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(pwm->chip);
> >> +	unsigned int off =3D 8 * pwm->hwpwm + reg;
> >=20
> > This magic 8 could be #defined as IPQ6018_PWM_CONTROLLER_STRIDE or so
>=20
> good suggestion, will add it should another iteration be required.

I don't consider that an advantage. If I see a register dump and want to
interpret it, I think

	8 * pwm->hwpwm + reg

is much more helpful than

	IPQ_PWM_CONTROLLER_STRIDE * pwm->hwpwm + reg

where I have to check the value of the define. Yes, then the 8 appears
twice (i.e. in reg_read and reg_write), but IMHO that's ok.

Best regards
Uwe

--swptr2pfrym525fs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmluXrEACgkQj4D7WH0S
/k6cnggAsCQqWsDFQVUkeYVImS9/l5GX6eHwnikgTTnlW6a+ZgWaTTReANaJcOWi
Xg2ReisUE9OBLMyy26ZTyyJhtbtBcM9j7Xh+cPJJU9+ldPO+Dj0LCzwxzf9h16h7
iI4mYNmPhlX7guGfEmlZRp5jiPWjLNuPeBl+36rW3D2CnfVGZ2/eCStO3YEUAqEf
KhSoE51+4/wY7M7/91RIQQmAo2bu+kM7r9sQ1arcg5jgprkeBTwxkV71IFhnrcER
yE1iBb8DBwvX9Or6B8YNWFihen2IeNnRzmZ+ESPHRvgYOpG6YviBg/6jPKflYmhR
jh/y8WWPcDfZW7OMQN53zjW43QQmkw==
=Wjqu
-----END PGP SIGNATURE-----

--swptr2pfrym525fs--

