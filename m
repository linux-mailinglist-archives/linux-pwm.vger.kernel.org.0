Return-Path: <linux-pwm+bounces-6911-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80791B151D3
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 19:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98CE543681
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387FF298990;
	Tue, 29 Jul 2025 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Disheym"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2E295DAF
	for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808964; cv=none; b=ZjITBeNgFfPumc6bvdwWzNxW2yqYOJMRm1LYz3OjjR/S9AprKlxe/Nzb3GFnOjQkton7+INyJDWOB/UedffguFjrvRTjwSfsyJPJWHTtgMETE6PXBULQgw+0UAXTJELGnrsbXz2XnTmMo6FFK5NJhheoRzlJRT+nAte+IXRFyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808964; c=relaxed/simple;
	bh=hlotwflxM5Y/ASgiHBfZDd3BxqBFV7VrqO5GVm5jNQ8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck8oGaUFf/zptGCPUij6cMOFWLA205lHPheyEpzGQ3RdKI3oJKWuacphegsLqRcLEIastyTi2ViXWITKqaw6b0E4pvcTLz3sxNitfSWI7+Q/Ftnz4aJnbcmultanxaTsjl/scthZoYlsb9CGTne/7pg7GaZn90QWmQzGOfFIBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2Disheym; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae9be1697easo15072566b.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753808957; x=1754413757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlotwflxM5Y/ASgiHBfZDd3BxqBFV7VrqO5GVm5jNQ8=;
        b=2Disheym9fyFV8Pwn/Q9ta76FNii4UM9hJxfiNdR5h1lwT7tltxAQV38N7GkcWRKgi
         +lZKZi3vhfTUZjDSwwxQU0kIUdnrSGYhBUwxGtlLJvlm7EiMAFSHsszLgIYjOdDcyW4C
         ozoxdQRRVTOD9Vjue5+DjDt/qsyq9pcv7/tmThJu9p1banKGIGlFmUjA6/yqhL+FBW6k
         J53qoIuEqzrpYBD1MveJ7LrUYEboGnMFg30LWi452k22mlIeDdNE2QcrovOTQaJZIFUQ
         K9srC8EhqniF5XU/GyP0bQA6yLIMxhTSIDd0ZWr1giJmxGFQknLi2aTu5KrZ70aGSyCP
         34Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753808957; x=1754413757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlotwflxM5Y/ASgiHBfZDd3BxqBFV7VrqO5GVm5jNQ8=;
        b=Nn5T+nA7PBGVgdb/NdNWUyM+S9jKiDpGnvG/LyQIXuSSXcPaqIaK//JUa926Zes5VN
         ygjcMH8Lf9xXp0QMR5wU3a8Pal0EQuXouV/oieIJv69emYYRysKLTrhF+j/oGtgoKxGv
         oESzC7GDdXVy24JkvcQyUwyMkQgsB61OUgJ2/kySDAiF7pXJcBTfFgCaMx39AvF/YQni
         1+HuZSDjTIUAWlJZTFTsxJ7bq2HURcyOiuNUWs2lZtWW8+JSN7+zM07nzf90aYVABw+B
         wjDHLu+ViUZEgna+VX7yz0cn6uHgZxCRBx9ntrVrbkK3hErROYaCYWgBPf/3x23i0/kg
         IYiA==
X-Gm-Message-State: AOJu0Ywue74+ulfSbVuP+kJOMXWHqm4Qoh7wRTzn8quDhFtHp98m1HYy
	7K4ieBL9l42bDcN9r3EKwz6x9k7fLz3XIfGHjdKmTgHSX4x17sSETifGT1gzeJWG6bJ1Bh6W9JR
	jBSfG
X-Gm-Gg: ASbGncvNlT3DkyS9lLgsunZhs/tNH0GGnD5jtNvL6pA4jM8A0Kyg8NsRhvzyD95JSCe
	e0IANhZRpDd0Ocl0LH18bU0zRv7XbKgHOqp3Q4bmZl8kd+TPU0obRH4QTJwWFJJ/tpisE1SQUsM
	zzoAumSmVc8P/RFxjTx3XAJhbLanb2OVto1H02lvOQ28pm6+1dQUJIsTsHfNCs2PFisQxVDZYhg
	FxAQ8D4KH8o0RU8l2I1QlTJn6sxtIE/aE/h6H3fumyB7lqi1vunbTqHNQCCdblV8gSQnVb3riGm
	ARrLvNIvAr7LVXVKt3wc7xFd8XPWIpF6C12NmaLGW97Oe+itLXNa6uX4oIQ1vtd/7S8UAcyEQ92
	EVc2+RtXhdiw7XLKw9L0xUCOOBiPX1xDbYdr79VdkT2c6Uk/6pKHNXgXqWhipOf4Q
X-Google-Smtp-Source: AGHT+IGdjCwbJdFWw2UknjdcMMMtaBv9CiXoS69eEVbXIxl/vdSP/TWre5SnYGtquhoCmndYOhDjAA==
X-Received: by 2002:a17:907:3d03:b0:ae6:d48e:f18d with SMTP id a640c23a62f3a-af7b502040dmr525011266b.12.1753808956673;
        Tue, 29 Jul 2025 10:09:16 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af6358a18absm617072866b.52.2025.07.29.10.09.15
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 10:09:16 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:09:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH libpwm] Fix error messages to contain the correct chip
 and pwm ids
Message-ID: <u7gg5hg2uuicxbvhaijvu7lp3dt3rja66b4lsvhybm27g4rbhh@xkkzuhhdpy7b>
References: <20250721161423.2273295-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwkvrxzh7u4zxj4h"
Content-Disposition: inline
In-Reply-To: <20250721161423.2273295-2-u.kleine-koenig@baylibre.com>


--mwkvrxzh7u4zxj4h
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH libpwm] Fix error messages to contain the correct chip
 and pwm ids
MIME-Version: 1.0

Hello,

On Mon, Jul 21, 2025 at 06:14:24PM +0200, Uwe Kleine-K=F6nig wrote:
> Create a variant of perror that takes a format string and arguments and
> use that to replace the hardcoded zero in the error string.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git main
=2E

Best regards
Uwe

--mwkvrxzh7u4zxj4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiJADgACgkQj4D7WH0S
/k6a+Af9EYOcMpRR7uLF11IMgcLFVI11lt1IergCfUk7wlnEGB7zwsTPUoScIy9Y
bQRiiakn2TlPCfYT/8ReRl8S1P7wmJ0/qFDI7hgvaDwVeYn1f8FCP+1WprkVY9Of
4wRhSv0P3EW8BILeQQP5stB9KD6iezWa7SPHcSvZmMHVoLoTewTk6KNCBS7sO/3z
l42hIjXz3FVx3lFWcmnS1Lpkbk64un7QpdVN/AKQOuLvjwvfTVJt1HFloUZU2uji
BSZmHdInX+FuEoW20sJ76Vun0xINbBaQEn96np4bimjr2oKyJwy99SwrtLUyOc1r
8IIv9iXIyuy51A1w5As605VixSTD0A==
=JCLE
-----END PGP SIGNATURE-----

--mwkvrxzh7u4zxj4h--

