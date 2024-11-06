Return-Path: <linux-pwm+bounces-4033-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCB59BE014
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 09:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B125B224F9
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC81D5151;
	Wed,  6 Nov 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v44/QYXW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D31D2F76
	for <linux-pwm@vger.kernel.org>; Wed,  6 Nov 2024 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880816; cv=none; b=APbAkEJJ0xLSeaQrk9GfTm5irR9JzCtJg7eC/i2d8FPHzUOKFs6UfaOwr1LGjMyo4z7V1WgU5zRGvUbH1s6MKaz1Ew0TcMXyM7+cj+cDRAzQgDpkKU3Nbo8QKL9W3g+15JV5ggolAE4cFktzx3nh5h7lNak30gtjng9zR7MLSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880816; c=relaxed/simple;
	bh=39oPjtpebp5GhAYDuduuaxLDvPhFVrS2MKVO0YN1SyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPkRPFDByMbRO168N+/Cpel34zDhQptemCBl7pldg0AnJA+5oMRuEtXIxzLAqFBMLiiRVyFBW54/wRqfc3nG41B9+Ib/VdmpEQ6V0BOjmBJKks7kWFerS5mI7My/KYR38/hNTgjCpuNE/BP/h+a6h8G+Qpa6NTCT2Vb95fUmiBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v44/QYXW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa086b077so823988866b.0
        for <linux-pwm@vger.kernel.org>; Wed, 06 Nov 2024 00:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730880812; x=1731485612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dtq8iQE0SFCyweopqsqMbbfSb6OPmzQGXb5kTOJ8hYk=;
        b=v44/QYXWvPHIhx9R4Sq7pVA9PPgu+PJNLm+KrBhbeYtwa/moqH2Lafh/lrv7SW7zjH
         pNO7ZPNmUicYwfhJgGO7OISa5yYi+EasVATsfff8ODHVjTzxIle1UWQ91I4v/02kmZJu
         ZmoQPU4O2MsQgb+YswmSn5ROsPA/Ey3FuINRPDQQondnmAYKb6XJ3J2MQJvIO80mznPk
         NlpWNVYFNnG+J9QTOV8MHSFtPktYzTM8xbpJTF9ktnkXt+B7/OLqZli5hnMJNHj6/Y1q
         ZpZaD+DGjvyfcnRVAn80Q8Fj6O5w5RcyK59+Iz5nn+Qt2jPNk5l/nEhto2vnJi5dRUA7
         4Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730880812; x=1731485612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dtq8iQE0SFCyweopqsqMbbfSb6OPmzQGXb5kTOJ8hYk=;
        b=Mod7nv71wioDV6nYcwyQd8mVAiZ2MHZFP7A+7p/r2dqr4Rt3f1EeO2uDswBpZxko8p
         qjcHMZIYFclNQM/p8ztikkZHeh1ABsEAbXFJYyFG9SNUsl74nC4NGMHesQjGIMOr8XFk
         qBsECfxS+g5EpU/89CDNiLLdRX7l4yeqsvzmvXWKwn9S3VHHxqZD36GQIlgMJQaGVStX
         vCNTfkXOSK0QldhLCMZhMkB4X0cBJl6YZ9qb5esXQ72jcTl+YHkOPci0Dmkweq5YMOkz
         EYY3ixspnvy5P+bIipLz/UuucSe+//yl6b0CQ4IZ3Z3Nyp+3Tl9VoUgGt705j7joPi1Y
         FhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMWa+JBV+kZIIcMk7+KGKRvoGUWbZedlu9rAXNddi2jDmtzA7ucQbqIVzbK40vFdNZH/SmZkQzSok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZDVc3IoTAEBRev7JxWRJOdvGdv5GaXtJecJuUOUx3DG2ddLX
	1ePY874nQ9TS2DHK6l20g0T879h0b1ntITEO7KvmwX9YvI025eeG9iDZcbIgGwTf5lrkOqnQ4xG
	x
X-Google-Smtp-Source: AGHT+IFOiZLYl9p7fXS9SJkoBSOvsaanhDLne8lHROTJqLWKZRRzxv+g7HXejeHBWWi1TeT0t5DzMw==
X-Received: by 2002:a17:907:31c3:b0:a99:65c6:7f34 with SMTP id a640c23a62f3a-a9e3a57380emr2601209966b.7.1730880811570;
        Wed, 06 Nov 2024 00:13:31 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb18144e3sm238129066b.203.2024.11.06.00.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:13:30 -0800 (PST)
Date: Wed, 6 Nov 2024 09:13:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <nmlnzinyynah3wqgszk7p3ojxdtekeiftmpkusuyqj2yhymd5x@iudiukib25ea>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
 <20240927125745.38367-3-dima.fedrau@gmail.com>
 <oppdnsda4tqjcpsb26j5ew62t4bkkmtxuu7e2fpinnazubk5ky@tmz76o5xdrlj>
 <20241023125221.GA197308@debian>
 <eyom32milbbqp6floun4r5bpozuewbe5kk2htvhp5cmcytj2oy@bpcrd2aiwk6m>
 <20241103190709.GA466098@debian>
 <atkj7wnhl4n6frl5swjwrto6r6dhofjtnqisqrn5z6w3cmfl3h@dgqgdxovrqb4>
 <20241103205215.GA509903@debian>
 <dy5abepkqhkmbgirwjkblbmw6vwb56vaqgazluyt675qflzioz@glp4djy6fhuo>
 <20241104130753.GA14681@debian>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l44dbdpqwkklzq3j"
Content-Disposition: inline
In-Reply-To: <20241104130753.GA14681@debian>


--l44dbdpqwkklzq3j
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
MIME-Version: 1.0

On Mon, Nov 04, 2024 at 02:07:53PM +0100, Dimitri Fedrau wrote:
> Am Mon, Nov 04, 2024 at 09:52:51AM +0100 schrieb Uwe Kleine-K=F6nig:
> > `echo 0 > /sys/class/pwm/pwmchip3/pwm0/duty_cycle` should result in
> > MC33XS2410_PWM_CTRL3 having MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm) cleared.
> > When mc33xs2410_pwm_get_state() is called then it returns state->enabled
> > =3D false and in that case the above mentioned warning doesn't trigger.
>
> Yes, as you explained. But the warning is shown.
>=20
> > Where is the misunderstanding?
>=20
> if (state->enabled && state->duty_cycle < s2.duty_cycle)
> 	dev_warn(pwmchip_parent(chip),
> 		".apply is supposed to round down duty_cycle (requested: %llu/%llu, app=
lied: %llu/%llu)\n",
> 		state->duty_cycle, state->period,
> 		s2.duty_cycle, s2.period);
>=20
> state has previously applied settings and is parameter of pwm_apply_debug,
> in that case s2=3Ds1, and s1 is returned by get_state:
>=20
> state->enabled=3Dtrue
> state->duty_cycle=3D0
> s2.enabled=3Dfalse
> s2.duty_cycle=3D1908
>=20
> Due to the code the warning should be raised. If it shouldn't the check
> should be different, something like if (state->enabled && s2.enabled &&
> ...)

This should be fixed with https://lore.kernel.org/linux-pwm/20241105153521.=
1001864-2-u.kleine-koenig@baylibre.com/T/#u
Test feedback and review very welcome.

Best regards
Uwe

--l44dbdpqwkklzq3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcrJScACgkQj4D7WH0S
/k5gXggAqPu+yRoXyGFQb73n3hZivFCZ9JKqoIVvQt8+1uDS+FUmtlMTX/LZ3gfx
sBpqANYsq2B1f+fV8dekuQYY5jqFa+OI9YQNZja8muf4WvauRftQAInEtiOlPrRG
MZWedwP/Ie8N7q+GpNKjs5IaNgTJO68MqvYowi5ZujfHTRGCV/5oRBLZBTotqTZg
HxZP+S9jO+BQ0R5WdPx2lHzg6S44ETemK03znqun5Uy4Vw6iG14NsrcSfWehe1zO
CT1R/iWhEXhjGzx5c/uvsALe8DoHa4Ldrzmjft3h+SLMB7QHGXWkiORk2ASDIjgn
yKKzdKEBXpVwR6Ug5Y0ZlcbXM381+A==
=oxv3
-----END PGP SIGNATURE-----

--l44dbdpqwkklzq3j--

