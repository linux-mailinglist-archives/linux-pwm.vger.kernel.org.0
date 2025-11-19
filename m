Return-Path: <linux-pwm+bounces-7644-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D06C6E37D
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Nov 2025 12:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B911C352259
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Nov 2025 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3FB329374;
	Wed, 19 Nov 2025 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mlK+JDrY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712929ACD1
	for <linux-pwm@vger.kernel.org>; Wed, 19 Nov 2025 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551185; cv=none; b=r2aDgUHJo72LLgKvkHe+69Zxbcl4tXJBnhAYsj9on113OH6WnvleQO9ngQFKTt8z5LGTyJzg1pbsTaAhR/6+xbHj33LHyWV3/+FQEj1Tft0loWKmyFfMXQIAv9lML4oiWtNi7XVaVd4FDi4k3lVCe2+aRKqZTQja3d+fv1EtEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551185; c=relaxed/simple;
	bh=8fJxTC88C21yeNFGMIY/pX/Ki+oZQWoHGuw21vU2xsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmZG9CP1NiOJSqnS8nWke47zZ63WZ1x8uIkrorRCZ7atW8cgtIzv7XzPdibM6+cx37SwTegOKy/twiS0+SHrRNP7Ru5YHME9pxZuOp58N+2xhJlM85A99Ilg4PPoeCDvnmE/rdbBRjXvAdJzLJJqAutnKQCuftRTgx07UbeCg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mlK+JDrY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3720e58eso6035769f8f.3
        for <linux-pwm@vger.kernel.org>; Wed, 19 Nov 2025 03:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763551179; x=1764155979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fJxTC88C21yeNFGMIY/pX/Ki+oZQWoHGuw21vU2xsc=;
        b=mlK+JDrYZUVCeSg0KpZs55j/OR2Xyt1ZZG8YQoKLbDw6G6gW+dWGarny3t7HwXv9ee
         qi0hS5LTCtxfA64+DmpQYZVmIWEqDW2z35SzMUDbjGPmQlpCi7uluG/AREYyDiCfmVNK
         5VoA0GwN/L7Ca4PoXAl+IZZicbF4MptwLp1hMF4ProoZOyrP2F5PbhgyhkP6MDzQsvsi
         G1kWRJE3CsvFX4Byf9jSZZYZTUaJtR7b/offaMGu84PbmGYvLPvxOriU9jJwKokw+sDY
         c0GDvl7HcHkjbYktwbErTa4U7Jo+0JetHRJIit3KTyuLYRx+gKMtkF73ZXEXcL8L745R
         kn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763551179; x=1764155979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fJxTC88C21yeNFGMIY/pX/Ki+oZQWoHGuw21vU2xsc=;
        b=Jq8NJKhCTwLU4PHtsmGR2cq5c7vFSL80l901oGKTlt3zrAeTzHEMCNXSu0MU6/g7AJ
         2hVvDFg7txg4R9SL632tDEwxEXDo/38jqDtrs38Ns14the2sV3wLh16d07Gc75RSARkK
         W6W4Sd75S6Zt1N+1oWuN484JnMAu08J/5LcKJZf7NMQp+vqXm4PhozTGTMwu/fkY6NNk
         UDti7Xenn5FB3Jj56dDQ2qx9k2USDnP/cUlpJhGk7xqUOkOg1R+o46HCF4QnVQjUZJtr
         TNL1uyVSzpEBV5D0RonrMyusqpnU0oyW2FuqKB9zTXu/vWkuPKACiRtT8OYrYmbmymoH
         lyuw==
X-Gm-Message-State: AOJu0Yz4NtK3a8Lb3dsCKC8IH90ddV6U4XWf/VBEi2T1KwidZs2qsYCx
	9FokcXdW3BTiP2EX/kHcOC/404nHQ3V2NSByMJ1dcK7sPTxP6t/QItEZ8JAmrAxvMuE=
X-Gm-Gg: ASbGnculr9Y0eCX/g79sUHFZLTIoGRKNaFTMir0+IGwa0MoRWkxMTlnjkVx49OXp3Ts
	n63HLNLqOz7TIQaEWdGWnrcHIVpzVuibdcZ53OXYX9v0ZyjRyI0J2KH792UqqQW+HMbuvc2Huc+
	pjGVogopt/f9YUZ5Est7X7KNJmc0EW1hzHXJywaTVNJ9u61IGoni/b/J5HweqyPbnKQpC4+xhae
	Rz4OiSgJ5dNN87y7DlG+CNyhzvPrzdjXkc/K3BxA38gacBo+o1VO1iuxuoq0iTfOsX9m2ZYbGHG
	BcIPadqDKV6FHZpYK+/G5esI80/TFBYgLjOaHyBe/sYUlx3jjAJaYerzvQDUBz8u20uNOlBr0Jq
	qRaiCIBA1WLh7BwULbNqcWwma5J/0Dv6scqJsmt73YnaQY77udaGRxnnxoygGy07THnq+02kVj0
	N0TXv0QFS/tc0ceLYmTLiQko7nzXerOrm4TsgYBm8H5NtuMrXUE+Hv8bln/TXZOJo6+ycNG+Hwx
	A==
X-Google-Smtp-Source: AGHT+IFq1GA91q//TrkmVfcNjTkIUmvZgFSX4xKbERurbDYmKl5z8LZcwIfT6rBfD7C7M0ukrHgu3A==
X-Received: by 2002:a05:6000:2585:b0:426:ee08:8ea9 with SMTP id ffacd0b85a97d-42b593901d2mr19722728f8f.44.1763551179590;
        Wed, 19 Nov 2025 03:19:39 -0800 (PST)
Received: from localhost (p200300f65f0267088a174c85357e02bf.dip0.t-ipconnect.de. [2003:f6:5f02:6708:8a17:4c85:357e:2bf])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42b53f17291sm37474614f8f.32.2025.11.19.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 03:19:39 -0800 (PST)
Date: Wed, 19 Nov 2025 12:19:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-pwm@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, 
	Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: bcm2835: Make sure the channel is enabled after
 pwm_request()
Message-ID: <bsqf6hgasifmp4nutvw2yjnqsptppjr3c2v4ieehz6x5oukvxo@vzwfybpwozbg>
References: <20251118174303.1761577-2-u.kleine-koenig@baylibre.com>
 <719eeea2-4338-4caf-ba95-ded99d40da5e@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkiyctjyhojxgbs4"
Content-Disposition: inline
In-Reply-To: <719eeea2-4338-4caf-ba95-ded99d40da5e@broadcom.com>


--xkiyctjyhojxgbs4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: bcm2835: Make sure the channel is enabled after
 pwm_request()
MIME-Version: 1.0

Hello,

On Tue, Nov 18, 2025 at 10:33:25AM -0800, Florian Fainelli wrote:
> On 11/18/2025 9:43 AM, Uwe Kleine-K=F6nig wrote:
> > The .free callback cleared among others the enable bit PWENx in the
> > control register. When the PWM is requested later again this bit isn't
> > restored but the core assumes the PWM is enabled and thus skips a
> > request to configure the same state as before.
> >=20
> > To fix that don't touch the hardware configuration in .free(). For
> > symmetry also drop .request() and configure the mode completely in
> > .apply().
> >=20
> > Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks for your review.

I decided to not include it in my fixes PR for 6.18 that I just sent out
and so applied this patch on

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

for the next merge window. The problem is so old---it was introduced in
v3.19-rc1 more than 10 years ago when the driver was created---and the
change is not trivial enough for me to be completely confident to be
suitable that late in the development cycle.

Best regards
Uwe

--xkiyctjyhojxgbs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkdp8cACgkQj4D7WH0S
/k44lggAo/+afKXHmS/XCt/UMLgULBD//3A4T7Oz0htQ21YnTd7B/7wkw+hfsveh
IShSykW4d66JqCtnydF2oVOd2BZBB47upBn/XtHLVy3rVwUuJfMTEFWuwEgtzHRe
bxOt7xh/kIjB9Xb1DGGQGvM/1UeHzfKJGskLIeFLixm2fJfmm1EsPDoBHuUuPmm0
TKEuuCrS4NQQKoUx+K+X05mPYY5AmayXf8+7FmeJwZZImUkD+UwsHe9y+7KFFNuD
8FXXaARX3selk6uPOsoRPYKFfiH009qFCRnEDW/dQl1oSWoo/ECCmNcwpyP6jWFZ
yPBWllQlApureiJnmYyqXT1VUeDd2Q==
=UPeN
-----END PGP SIGNATURE-----

--xkiyctjyhojxgbs4--

