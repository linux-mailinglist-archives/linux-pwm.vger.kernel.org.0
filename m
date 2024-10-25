Return-Path: <linux-pwm+bounces-3874-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B39AFF07
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 11:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10F8285F65
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504A01D359A;
	Fri, 25 Oct 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dXgmjQ3Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE001DD0C2
	for <linux-pwm@vger.kernel.org>; Fri, 25 Oct 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849889; cv=none; b=uUwkP/FnqWpTzirSraN7oZN8KPynNGUQtyCG96FmhSdn91ZW0Zs5N5qFtlr/59+YKYTOUHyy+ljv0Eg6wbu5GYmjFEv+JKYDb34iSzUO/SSll4URx1aqzUbSvopddnl10RJIbAqjGPM2D6v4npX4/2fF6hd9FoZUe73xUURlvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849889; c=relaxed/simple;
	bh=eS8rX5mMOZuM7iOmnVlMjMWTsDYulm8Wr/Ffg5REB0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5DN75UJrX9t/pZu1JpgCe8oFRcYQSIVieulobo+8ksCeH2VyAiksCIezRouGHVKcwAxTiriypSfVjCcr4Qq7uoGwjmdlPc5lonOSFDmI0PCsQ9ZEF29g9mrSwCd44AJcFA3lOGyB0CKRPO6qcATIPUtL5DcORw39DG3DKzJ6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dXgmjQ3Y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4319399a411so3976045e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 25 Oct 2024 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729849886; x=1730454686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eS8rX5mMOZuM7iOmnVlMjMWTsDYulm8Wr/Ffg5REB0I=;
        b=dXgmjQ3YIcv8sbthSh6Cf8zeibSSTsEsF+HdVP8AwpxFOYBswt+27N/5GQrVxbs+kI
         v7Ac4UMbMcpSZn1+ub4MxXo41J8WaRfcvdF1CzjRRf2cR2HkClI1K45pNEv3i5sdX2Nc
         s/YV2UUwYvjzRkRaQOUJdbdpA2J2Xf+RODgYKncocN7tbL8HrPjhfF2r9xfCy/y5bKOj
         S5IqZ341K5M4Bc93Y7+K6JKRMuaOfIwkkoWe2GNx+sH8uZjKXhjps31VOCpc2mZxd/bW
         IogNb3wz2jmuclG3zqm4U/OgpbqkrlEOYEpDuABGcdYN8idEo33P9IRKseHnflEEF2x2
         vWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729849886; x=1730454686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS8rX5mMOZuM7iOmnVlMjMWTsDYulm8Wr/Ffg5REB0I=;
        b=MXMwc93wYDHnUkwYXr0BSuYFdA7FB6EDkP400XkUX1V0Wxgx8C9f4cjA5edmbJqUc/
         4I1rLBmYyFOaMlhhBsGUoV/vh+jxj1anQlzKJymNBA4RwkTigee+oRaW6CIgAIeWqUs8
         OzznB4g84KPGvFkA7Wf01XsiHEFcIc0P8kDE4KMcXvRpK3fnXY+dPrZE0g92oqU+Oun6
         tCj3O9OKIn7/x8pkDu2it5xfSRcScz8E75U6S/cYfut6Vu2trztX+Y5Cdwnhot+3Ev6/
         b26cQXt+YnZi6IPGN3qiWQ6MMsFOETk9+rRUlD7Hhmzf/YUafRRYioe3jrb0FF4uBo/F
         phYA==
X-Forwarded-Encrypted: i=1; AJvYcCUe4WmDT999BJT4eejnT2FQaJBlg7DHJArZ3oriMcPzY9NgVOdm9F9ve05r33c107ZsgSa2v9wMEx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoT56XFRadPWimG7gGT0g9oOJnHfaYFOgdIhijWj8PaHViX+Z
	8fh49uoQYiAKs/XftqL9rcHp0Usnus3M14y2vUXCov7V3rrLVPQqQ9gpdSNvvto=
X-Google-Smtp-Source: AGHT+IFDV36MWuOmWTSfdyoZelQED1y92jdFLEPG7iTL0qbLzm4EM0LgHmwk3kn2qqGpjQjCt2H/Mw==
X-Received: by 2002:a05:600c:4f90:b0:42c:b7f9:4bbd with SMTP id 5b1f17b1804b1-4318c7568e6mr46185845e9.26.1729849885628;
        Fri, 25 Oct 2024 02:51:25 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193573e47sm12984395e9.8.2024.10.25.02.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:51:25 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:51:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Erik Schumacher <erik.schumacher@iris-sensing.com>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Message-ID: <bj7bgcwkesq3ixhkqveduid2uaieiq2dfu3u7yq7wxemkde2j2@yejpwvdqwpah>
References: <1a3890966d68b9f800d457cbf095746627495e18.camel@iris-sensing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sl7dqqmbdj2g2fww"
Content-Disposition: inline
In-Reply-To: <1a3890966d68b9f800d457cbf095746627495e18.camel@iris-sensing.com>


--sl7dqqmbdj2g2fww
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pwm: imx-tpm: Use correct MODULO value for EPWM mode
MIME-Version: 1.0

Hello,

On Fri, Oct 25, 2024 at 08:37:00AM +0000, Erik Schumacher wrote:
> The modulo register defines the period of the edge-aligned PWM mode
> (which is the only mode implemented). The reference manual states:
> "The EPWM period is determined by (MOD + 0001h) ..." So the value that
> is written to the MOD register must therefore be one less than the
> calculated period length. Return -EINVAL if the calculated length is
> already zero.
> A correct MODULO value is particularly relevant if the PWM has to output
> a high frequency due to a low period value.
>=20
> Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Erik Schumacher <erik.schumacher@iris-sensing.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes

I let it sit there for a few days to get some coverage in next and then
intend to send it to Linus for mainline inclusion ~ mid of next week.

Best regards
Uwe

--sl7dqqmbdj2g2fww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcbahQACgkQj4D7WH0S
/k7y1Qf9G4+8zoyZWisqpY8A+jAeBGbPi1/KL1HUprlJN2yFlbZ4lyvECyFr2yzj
UHP5qZiEvwREAnytE93HWPUdr3WJIgCw6Qxa5fYKBX/KYZ1COZ3orrasz+EpTk6P
L8ve8uBsuCzALHBmtPeceuhYk04Qg5/z7ybqhR42G/+PG25V4avWrvsb2w/Cwttz
StADVmVE03DhKoswdKdte1NkZ85Cq+H3pO4bykCA2SZou6mVqOV5CE+amJ95pzgO
jniVWLVJQRM750OSB4jDWG52GlEwswThV2eL6uUqiHnZhuuAd/AhZvbmHG+Vwcdn
tdcYKNFg6UsZsVKSZOxMfO/C74oHiw==
=jWQ1
-----END PGP SIGNATURE-----

--sl7dqqmbdj2g2fww--

