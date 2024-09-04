Return-Path: <linux-pwm+bounces-3087-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B707A96B861
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2024 12:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3147DB25307
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535821CF7A3;
	Wed,  4 Sep 2024 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XcF/4ysP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8961CF5E7
	for <linux-pwm@vger.kernel.org>; Wed,  4 Sep 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445509; cv=none; b=LjHkw1j96HTExd0JBPrAZXjMLkm2EwNlY6AvT0QcDFU6dHapDVzIJCqcCQDwOr2pfLAazvjudYny5LzgZ3fBuJZvgo2cYEmXnqy124jrxIXRk5H6Mz4ya/McBSjYrgIRxt3ZhdUFqMbCrcVoXRdVGYSx7bQG3kXth0wmeYgGXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445509; c=relaxed/simple;
	bh=KeEC/ktHY+Jul3NiZdV9A9/RK+EBb7Ot6DDoOSLaS6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei8WQ9X5CiBs1n7ptBwY9l3n0Tupispxh5bg4xG/YCBzwvC4ys6W2m+C4Y6JvVhOmN78S3a6w1EzECeilPx/OoQaNuz4/NseAN6RRvgMEiSUZArKAow2mM+5ObktTUaz2DnXvk1pM1KwubcDByFpYHjupib7M7oSbUD9LTJNLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XcF/4ysP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so6090343a12.3
        for <linux-pwm@vger.kernel.org>; Wed, 04 Sep 2024 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725445504; x=1726050304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KeEC/ktHY+Jul3NiZdV9A9/RK+EBb7Ot6DDoOSLaS6w=;
        b=XcF/4ysPPVa/p3sadKemtzQ4aCvu2w/eIVcsddAaeX57msqwVBD3EnSQ4ECOMCXczn
         vpEcL0i9MUorkJX/BmOjGip8qpsjnJ7evyBHeMOtIEEa7h8JgBzo72IvgEtGMTLZu7B1
         YQtE7Kmo1GNcEH94x3DSk4TD4PqnX8lyk+vxqnrF+Zyu29prasfUPV56WflsZZsDIAFu
         GdkplUbsr6sCrXzfc/VDHmOOBMjZ5tFN5qDlURcSLl0ZF08JjPmXkMZ7tAUWf3prOkgW
         TYc1L0J8qrzRoaMfTx20g1XwZRrZ18J8NUS9G80I+7Dvi0zsLMgQVE9P5DUFstioo2M/
         2bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445504; x=1726050304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeEC/ktHY+Jul3NiZdV9A9/RK+EBb7Ot6DDoOSLaS6w=;
        b=Q4QCSdotXldEjNdElAaV5JjAl1V9bHOL8E48zaMK8EX2Lkdo2Mn2PbKAdp2j3gDCUZ
         9jfRew/Jc+sfQpf7kX82uNjkd1LOA/DwIg6vSiXRrOetNq204WhxAul2zqPGqiPyAkut
         qTb/un4jgxult6K8MsqUatRGF1IeiZbilO1TyPaTOSNYal3yp+s2za1V85lmaehasWTa
         BldQExP4uyUt+e5NRDktM5KOPUrWbD/13WkKUZf+rW9ypLEPYAvl3C39f8X9C85lVv68
         7C5QvZv01fiaE37I+f2CbW5p0afO+N9q0+Ecagsxy87/+kcE0v4B2N9wjMqawUQy4XYk
         zpsQ==
X-Gm-Message-State: AOJu0Yw4YD+xZcJqr1fLP+EUFRnO6q4ZSJpp9SurUC2TYfuGaLYg1sQt
	K94E0LIK962xspCio8dGVc15xOnsvVa84PTpSAVkUnkYxvclkXi/zQZBIdQFqRq6Zcy6SoLoPFk
	B
X-Google-Smtp-Source: AGHT+IGHnlwn8PeBRbWrCkE6PlBNjih9suoKjgeYv/xHSVojqgc0gwSQjLfLad21cyZE8vZSts/h5g==
X-Received: by 2002:a05:6402:40c1:b0:5c2:5d97:ec9c with SMTP id 4fb4d7f45d1cf-5c25d97f02amr6958756a12.1.1725445503485;
        Wed, 04 Sep 2024 03:25:03 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c256f49edasm3858423a12.93.2024.09.04.03.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:25:03 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:25:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev
Subject: Re: [PATCH -next 0/2] pwm: atmel-hlcdc: workaround
Message-ID: <b5q734k2jc5jkolki7jyutea75y6gxpiy3qw53jlpxfjexmryh@ags7wtfhyxom>
References: <20240831075059.790861-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3cvo3rq7mj4vs7d3"
Content-Disposition: inline
In-Reply-To: <20240831075059.790861-1-liaochen4@huawei.com>


--3cvo3rq7mj4vs7d3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Aug 31, 2024 at 07:50:57AM +0000, Liao Chen wrote:
> This patch enables the autoloading feature of atmel-hlcdc module. By=20
> registering MDT, the kernel is allowed to automatically bind modules to=
=20
> devices that match the specified compatible strings. This patch also
> drops trailing comma from definitions of device table arrays, which
> makes the code robust against misrebases.

Applied this series to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards and thanks for your contribution,
Uwe

--3cvo3rq7mj4vs7d3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbYNXoACgkQj4D7WH0S
/k7xxAgAk+MXkMuGiv/69NgEgXVju1dY+sd83YLNl/B95o8renazeYwy4BcNdrp2
V3hNT4GeqMkK+zKcCj1PPBRfVpEzBl0o8d4+96B6K+KJmlmNFIrTDTJevOJLX3S3
65uXAEGMvbkyK/kj4qbhqywDlO5/dw+jnQqR+mZyGuXARSHcGGNu1KPJEzArnyh1
Lu4W7kCkKTl57rxg6/MnLjKtZ7Ym0ya4m3iRgzCxsZXjixGkGZvVrfS/iWRw9NDy
+AtKIvNkFLir9J1IfvRa19j4owa0c8dj2Yu2siWTTjJz2K8vmNDOO682S0VgnN1u
o+Vy8cZ1MW+YeRZILAcsSeszwyVhAA==
=pRuK
-----END PGP SIGNATURE-----

--3cvo3rq7mj4vs7d3--

