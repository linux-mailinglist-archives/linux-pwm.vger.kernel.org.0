Return-Path: <linux-pwm+bounces-7426-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CCFBCA339
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Oct 2025 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D7EC4E05BD
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Oct 2025 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4B1C3306;
	Thu,  9 Oct 2025 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eZXI3GSU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7E1A9FA4
	for <linux-pwm@vger.kernel.org>; Thu,  9 Oct 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027808; cv=none; b=n1d15vEci1gZ78pIb09ClO3fSHTicAqNs+UQ78Ku+kTEE0no6T6R68k7WeY0pfdObYplVrO5Eq8E0rCPRpx0hUknBoVyXU8V/eJfJh4MovZoj9lb3vOzPvDTHJBZqxQei9JvOEFeLa+Zs15LjllSllyCf9plaNBuDCsyFPXIw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027808; c=relaxed/simple;
	bh=C5iraH8VHY2F+UDhGG7XxgCiV0gjj5Rx3ve6QLjUL3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC0vw/ABWjFCoae4cpDaTwbuzXl4HKK7AiboPutUPYd2QPKtfbSlatE+gTjoW0IK5A1DgK7DxAq/K+qHocqeGORi1BBWSF+rgPOC6YkpLCnvEg5gpOzSc6o+GXQV2/Osg3aKrtDTFvh4oItNnEF8ZV0kLgU19Flk79gBM5+gzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eZXI3GSU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso728262f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 09 Oct 2025 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760027805; x=1760632605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pM0xsZeNADKlqNSbccGk7i8pI5/s940oeB9cZiu3dyU=;
        b=eZXI3GSUvFVnMCbmO5wQykgqqLVVkTeBoLKMM6U3L0rrAvIyQcDuT31im/kQcJNApQ
         b4+R6EiQktQ2k6MNDsW7SONhplQhXEANIaqruLCATZ580XhQ/jTfaxiCfenD5ydnH5wn
         NMkCpiNXYa5uh3rLzdIalUgLwGlaoltIve86UjQgur/g9RV4lBjnIan4PUcoCbheKbKm
         yfpMYpfmahlGDBkiume2fr2bsoC/fyUO1Bb1t6Xx8oALRH8dvM8PSAT4C7aLoYJZp8lJ
         WUu3wSheieSnZj6DvA8Dzb8MVbAwW/H16dx4oT9HkUDfUm6PgEt1a8Y3HuXSXLgPK3LT
         yoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027805; x=1760632605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pM0xsZeNADKlqNSbccGk7i8pI5/s940oeB9cZiu3dyU=;
        b=wYohoCdaA5Zro69DqE6gA+Co+MsaPoty/MNpx88iKmXoo3TRfwk/XjwOnDgUB0gBhs
         7TQfe/BIItAcLWeUxAsC1A5zbKRO/mSRl7lkI5fDM0bpmsiBAJ4sxTlTKVomAdZohaMR
         08D4itHiN5gsg48Stq9M4zhoj011YXqmPWDswuZl7W6p0xSPxcACH8rQvTP7Qy2zGZiB
         nUj/TJhQ9S6VJPQqwhjPVN+Ikdat5Wz3CEtIzwe3YqeSYuqhKb7+H3569nfYErrDK0Q1
         0Kq5zQKrTS7pujPNuTyVD7zueo+v/wwTqKLPCyKt+hKk5yFOLAMV2TUn5fx7iJAxr/8A
         z6Xw==
X-Gm-Message-State: AOJu0YydXTKvkm8M5iusNZEi2NIXQ3ILDmvckKaetwfHcrTZxtwdkEss
	0bx6nZtpya5b1FpxBf9ZtYlAGDmKyymU1mcyLr1vGFKnVHhqXQd6biUS9D8mfYVEJhawO0objAq
	5MJ3S
X-Gm-Gg: ASbGncu3NLRhyW7lTxRkzRGc6NQ1MWDzDvYK9Xnf5fKR7RyxlpxbNNi4dNuYPOl/TJw
	yZhgYvvKgBitCytnqpXzR07j70GnYsFmMMEOPIcun6K+8QKLdjf5NoShGHaTkgNpWHgXsV8/ClC
	eURkC5Vh+ewnb9vk4BPMT7sASWYzwA0DUK66tlzjktKHSIlN4k2R506drv1JjFvUhhKip2iWGo6
	jrmI/W9dlTPTmadAQQa4VHvbnhyPG7SV5GKdq2+6Hrl26WUwlXNfYoVscTo7yZqjFy/Qt0J886A
	TAvPrkQsgYSxoynx9HXhmk4dh/lyQhNxCN4V+8BKs1kF0a5G38Z2ebd8rzWOhjJJZxsfm8bCiDr
	3vLQ29WgQswpQBd8QILGncv4X7+Gov8pfZ/uN1+fww8gmR4T2dwk34CrdxY3oa8782F+SY7mgwR
	Byn/V1Mm04Onlj
X-Google-Smtp-Source: AGHT+IGzrXwP/1qoDAA/VS5vFbmEWrrF+6Y/kREmqtgme4xUKuaZJd2hb1/4UjLbaVWkIQ/vxuTMBQ==
X-Received: by 2002:a05:6000:2285:b0:407:23f7:51 with SMTP id ffacd0b85a97d-42666abb54emr4984137f8f.1.1760027804745;
        Thu, 09 Oct 2025 09:36:44 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426cdb8a0fasm130794f8f.47.2025.10.09.09.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:36:44 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:36:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: Re: [PATCH] pwm: Simplify printf to emit chip->npwm in $debugfs/pwm
Message-ID: <4i5qkxt4fad36bktz7njjkqmdrsckpad2pglp6vhvuf5nhpueb@5yuv5x3fdnru>
References: <20250926165702.321514-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uzm65jr6ardzvjwg"
Content-Disposition: inline
In-Reply-To: <20250926165702.321514-2-u.kleine-koenig@baylibre.com>


--uzm65jr6ardzvjwg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Simplify printf to emit chip->npwm in $debugfs/pwm
MIME-Version: 1.0

Hello,

On Fri, Sep 26, 2025 at 06:57:03PM +0200, Uwe Kleine-K=F6nig wrote:
> Instead of caring to correctly pluralize "PWM device(s)" using
>=20
> 	(chip->npwm !=3D 1) ? "s" : ""
>=20
> or
>=20
> 	str_plural(chip->npwm)
>=20
> just simplify the format to not need a plural-s.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> this implements the patch I mused about in
> https://lore.kernel.org/linux-pwm/fol4hemfnbh7km5dfdkbrfxx3txc4wtv7jvdn4h=
2xlzxlcoyht@ax7ml3rq53zs/

I applied this patch to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

as v6.19-rc1 material.

Best regards
Uwe

--uzm65jr6ardzvjwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjn5JgACgkQj4D7WH0S
/k4Wvwf/ZGWcmM+xrFu2G+khHJ7rtgPXl2Rap/u3Xen9r1/0V/rRtP2FW0HNf3jx
5wCD/wOO8Agst5Z/smDPE8uv7wMpODAZsDdlFF3USENEBq9riI2HvsLVgkvovKdf
FGLB3y7bbL/JIl+gEKw4sSaoCjLVff+wREc55XN/x7vGI97tp2WAZz/955MwDMZG
TJgs/fRVyJVLr243DN0MDOYQjyWFPEE7ARRCjkZ69adzzFurQXk0pourO313tEzQ
z3t0HJa+D2OHhtV0jS8O+zvzu50ujVi5axkFiAmf5l85NGSyaeTsO7FkA0fggSaN
lmaPtfnhLAlKLtFIIPrVvfVx0j+2dA==
=zRJj
-----END PGP SIGNATURE-----

--uzm65jr6ardzvjwg--

