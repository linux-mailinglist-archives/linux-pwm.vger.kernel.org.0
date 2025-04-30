Return-Path: <linux-pwm+bounces-5788-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC7AA4A92
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 14:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4CD3BDE25
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 12:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B124728A;
	Wed, 30 Apr 2025 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YqZc4dGS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101A7E107
	for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014686; cv=none; b=qJXbbwcJ7nlQ4LttirG25aM7Cx1BI2KG8H7bgzjNouuTHqXla9yHIpccQgcbfrwmZjIk3dMCLg2ZsFj+st66HcjpHxSAIonZOa/2UvJ4E8YRf1gMWvaX5suPpJYYVc8xPw7P7/9Y7+Ogy2qcl8nBq63eRi8s2zRph55Q6nnY6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014686; c=relaxed/simple;
	bh=G+5FibWWWLvg7K1gCq7/ZEbzCv/dW8PKVC/LnlsXxO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oI1kgghXLQ3rOWYB5zxaHMBjY7gs0t/M9/AwCevk+q2HaqxhGuCaWr0gIkcUv9Fwa/bZwWacRzsrVcjyXoSbztUGnFem1BLq9jGXsuB3NTdvQrf29mV2CYUNo/HjGL1m5XTkQS3GXMs4DJaCxTsTk/wi0PI2kFwHdXcufDnaJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YqZc4dGS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c14016868so7723438f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746014683; x=1746619483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+5FibWWWLvg7K1gCq7/ZEbzCv/dW8PKVC/LnlsXxO8=;
        b=YqZc4dGS9JJgicN7LUwJ+HOvDnQlEuN4fYj3vIXp3VefP+jYaWIpJWijMiC3e9xs+E
         zy7EcmUSCKSr2+0jl4UbswxesvLHQMllLruXcOmeY4rz8cbhobj6nIPe7fj69tgnjVWi
         axp31JY41LE0uNJwZSBsUL79c0wsRr6bQXSEjSEeJA5Er2EuVh5kYTfCVjnZbnDfjyDE
         FPRJBPHPWnlr9VrVlS7x0ZDqkDl8JOd2wn4dXJovfTe3s8VbXOanf+NcmBGEw/WYADs1
         Uwpw8MVmSsbJGn98M1GuJQWffK37898z58OA6/D24LCax2TkDMA3BlfEC7RnFEfEJIH6
         1w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746014683; x=1746619483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+5FibWWWLvg7K1gCq7/ZEbzCv/dW8PKVC/LnlsXxO8=;
        b=k1OgpgPK0UmV1D2jBp8pfWB5H5H2qWOe2XVvTNf6vbR/cpze3y54I/HYuVxcxEQZIf
         6xA/crJmwD13EfHxaqZVGWlfEfs8rWvou9Nzpq1a/BrJEs085qdEBJ3Om++lzzokvh6u
         eCaIYsa446AxLlmDv09N+Zd0X58/ts7c1Ig5G2DIKJ7W9wE6DjCnbb6AL83rPzR8zuRq
         M9rD/heGAUvp2RUG4lpaLRPkvIe7WH+LX3a2NVIvaoV+/nAPloY1iQept/Jjbykqj/XB
         OBfX5kxiEcs41p6MZrPfTXSFYRUk7Pdws1XFDDKtck5whyfdlcS+aaqBEzTHfxXHRNKJ
         0Bwg==
X-Gm-Message-State: AOJu0Yz01jYGvPsqfn2ETHcEG27yET1FN13YVaZzucXiXFXdNJNEA7CJ
	vHZ3L+37IQYqWZddCqMV3L680zxeZxWJ4JfuoUXGn4/Oc9JBfNUQ+Ir/ml/qKZ8PAgE05uPqAUx
	0
X-Gm-Gg: ASbGnctIePQrMkkviOEeg9y+4Lz6PKrb4TWepUd1xKmutdLtuYwK1tDCiVj0QwWzElQ
	hyuyJLvHRyDgsjEw2xIb1YYmXUFOEUyekSupQIt32grrzmfzx7sA83A3SgDVFcwuHy+4dhEiudZ
	BMTbbak6PHve2hi2DZGQXFBXQerF/fTBkULihFOoMlPnpnk54hYtZqW80oJY5QP+fUFaSPzH88B
	ltS4WX4guut0U9/stGMC4LGae22IqXMmSUJYtv89UwBpQH4q0uzFsGA5s34Hkc8g7K9MguP9DL7
	EHuoKDz69V3Co4usNS6GIPIIlqBbE19gSjpQ9pcu4RSviLH2XRPs7fOUlo4GBa+1IDpjP7Q5Kes
	o6WP8dJvgryihx+IfLA==
X-Google-Smtp-Source: AGHT+IGd3vdiUTiLVBgnDR5dqhZhw5L0hduc6PSmeXt0yr8SkjJ5vxlE0r/PJfRQd5VE73nzXn2pcA==
X-Received: by 2002:a05:6000:2510:b0:39c:12ce:6a0 with SMTP id ffacd0b85a97d-3a08f764e8cmr2752357f8f.21.1746014682794;
        Wed, 30 Apr 2025 05:04:42 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073e4684csm16797700f8f.76.2025.04.30.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:04:41 -0700 (PDT)
Date: Wed, 30 Apr 2025 14:04:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, 
	Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] pwm: userspace support
Message-ID: <suxk5xq2qcr47ltpi37ynh4hov5ppyptwg3q2zpqqbsegz7m6k@r4yrog3uzgby>
References: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7s4k6i3ogher2ir"
Content-Disposition: inline
In-Reply-To: <cover.1746010245.git.u.kleine-koenig@baylibre.com>


--p7s4k6i3ogher2ir
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/4] pwm: userspace support
MIME-Version: 1.0

On Wed, Apr 30, 2025 at 01:55:57PM +0200, Uwe Kleine-K=F6nig wrote:
> after the feedback I got from David on v7[1] and some internal
> discussion here comes a new version of the patch.

So given that v7 was the previous revision of this patch set this should
have been v8. :-\

I hope all the annoyance that results from that fat-fingering is on my
side only. Sorry.

Best regards
Uwe

--p7s4k6i3ogher2ir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgSEdQACgkQj4D7WH0S
/k6sMAf8DX1WYTAxw7X5OV77oIWpx/9jKPfbrbgkR3iu2ak/bjGZ0oJLf67jjl5B
pUTToSA88nqW3gvlSGnlnipvncX+lPFDSq4jmj8+tAQR9KAvSwG0bLcZVW24q9M4
Z6SY2xzmI7yCZto9qRpZQASSaly+ZTUd5iRfZmLTkZVLv8dvP1+/hAncjT3shr+l
WaRqg+KWbO/VB8I3D/e6XLm/77+mWx2Qe8ne9vKkzElR2MhrnJtgX3HGtfo8Skn+
fsUSXMiRu2dh1rRPxl81qcjT4hLHagLB6jAfp/Qf7czTfcn5zjZPnaczbuEXSwMd
S/ILPPAnLYdpiGvEB6a1d5bEdgOjOg==
=L/3N
-----END PGP SIGNATURE-----

--p7s4k6i3ogher2ir--

