Return-Path: <linux-pwm+bounces-7591-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6365C32493
	for <lists+linux-pwm@lfdr.de>; Tue, 04 Nov 2025 18:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AB64201A3
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Nov 2025 17:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8472561AB;
	Tue,  4 Nov 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tY3Lt+AY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289B2333756
	for <linux-pwm@vger.kernel.org>; Tue,  4 Nov 2025 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276527; cv=none; b=SQu0hRd0xbwTCnHCksmdHKiHRmQAgPnXr1nETZaJ1M2iZEbwW4o8I6FEBYhwHIdRJuOhPWXRbtngRkdgE+e+IGuZZuzUiOaLd2Gi7ZYNic9JXFLXCEpvs7RfJsFB+FDvblcmg02ysqvXFQufo9HqTbBoQJVzGSjRRIvI4HTqgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276527; c=relaxed/simple;
	bh=11bSiUD+SmZfIvfIbLOIP25mSIZX2XAi0MWZOiJraoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvkZX+YgzB4hU/l15n6EJU3mzvIlwzAQuiAq9nYbQNojB9ChfywWn4LUMmQ8pO7f09/zGserP/drkG1289cpBBdNGVQs4mD3zlLm9y19ntGX9Ovbs6/O0ryyWdFANJFyrJ/pjy0/iE5qlJQKy2IL1Jj/mPlBizsCa9D4GV6d6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tY3Lt+AY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47728f914a4so30324585e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 04 Nov 2025 09:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762276521; x=1762881321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11bSiUD+SmZfIvfIbLOIP25mSIZX2XAi0MWZOiJraoM=;
        b=tY3Lt+AY6yHBKYp5bbvrBKkMFTD1Smlz2K34PwHV8rRADTkwnABgxYF2W/7wFL5ZC1
         njbfNZh93Dtm0hQOU0M3mTdCWVDuKOk+PQiS4y1JtlEOvCqFdtXNpCIr2WUVcaEzY0wG
         yQVjjfv5kkEHO5NpqbMqzZSVP6lklLqzeYSg5/5SfHG3zytfTIVFuSqYvxHbeX1J/nrz
         ghUgnljus87kvC4l7zwiC2aeqZ3be/7+riJVe76cg9Atx03MqOqDDsFOtTYSCiR2fF5q
         dF5dVav14KmvI1Nq3UB5hvNarkr88nCRfvBKv36JOA7Rhdy2HAsdFNW1up+YMtyd8T3S
         1HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762276521; x=1762881321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11bSiUD+SmZfIvfIbLOIP25mSIZX2XAi0MWZOiJraoM=;
        b=LwyQOetUmxSlPDjfSKtut6pEpu1hdNg1h4PcAuodcs7Va/d4UWcKN2wRUv9X8i0prv
         ODfU/fS6mmxZO0QpiV0dFP1vsB9RJfEehu46V5Eh9Pc0iYdBUQ1Bnin7Uty0YwDVIdv4
         5k9RfK5dqsAi7iqEhGb4cLpb2TvSgkgmrVk9uF1jzTAn+aK1AlE0aml9xTML/0ZCsFCJ
         7d80fTtTak76Z6Ol60p7MqOX9xP0uhLylNuuUl7IN+ThhTMHwJNwhYrHKCvXoUH/hKD6
         zedFBoatwskpVNQAQcYw4Q+d7uZhty7+xYbz92+2DC7jkrIRcEpdFGWt214XajuBMLmR
         A8TA==
X-Gm-Message-State: AOJu0Yxa35OZdPNI5ccWlhVLuAjQqhJToemzi/N9Makg4W+/zq9OdD5B
	OMW698cwkmCdOHlHnd1J8RMTetWx1D/LMvyhd6wE7RtfcgMhhRibQb6kisHn4yyNd9s=
X-Gm-Gg: ASbGncuTwnCkC9oOny8lPb6OGUWucYk11b5Y9gSfLuYSO/JxSofzeDB5R9Q5HKzHHFM
	TlFNOqRulbPNsMZ7tm0w4c5mrqcCfTEJQjTqjIHX+lx4iuOP3Ud0hrYiTHiTtLZyR9C6WuCkSRR
	SPJ8s/MJG2pV1VCtpvukBC/JUBYeczBUOGIBYUx3D2Fl81ujh5bjsfDWozYtVXHo1zezp9c1KjX
	ie9L3kJk4ape6qZYFLDJmIw6TtXRV3jOsyb0FId3pzK4i7hhGE0coKjzYbPVd0BsRLB9ap9ZNfM
	iShigNRD2BzhjBP6xKiovhzUmPymvfmUo5jKq1bPBxKp5wdIijBDT3THkflH1Yx3ia7IipW6Fro
	Qkgf8CYM3nBNrQIeTCyMQ9tbUqtmLwJG5D+w9pxIMRM7uGDT2NeogblzKVdck6DYjON9C3E4uoY
	pdGRL9fhZSW9V2Ok5AzIS+9UK8bSAbqrFAwO/aLzrhQ/6EjCrYMmAGdgELYBMtoiU=
X-Google-Smtp-Source: AGHT+IFpMrzCIsXvLTd5b8XuFo0wIfmZVyUx0mnZsXXbHF9m50QWrTTxklhGAl+l4IINovmoHJhrEw==
X-Received: by 2002:a05:600c:5252:b0:475:dd9d:297b with SMTP id 5b1f17b1804b1-4775cdf46f0mr639525e9.33.1762276520536;
        Tue, 04 Nov 2025 09:15:20 -0800 (PST)
Received: from localhost (p200300f65f19f50455bf0a672b3091a5.dip0.t-ipconnect.de. [2003:f6:5f19:f504:55bf:a67:2b30:91a5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4775cdc341bsm786535e9.3.2025.11.04.09.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:15:19 -0800 (PST)
Date: Tue, 4 Nov 2025 18:15:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Julia Lawall <julia.lawall@inria.fr>, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pwm: mediatek: Make use of struct_size macro
Message-ID: <dvpvyk5zravy6e36pykntlnakdoolpszehxdnicccgvihcrqsn@j5m6u4ua3bl3>
References: <20251030222528.632836-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r7rl6pu7vlvbu2rl"
Content-Disposition: inline
In-Reply-To: <20251030222528.632836-2-u.kleine-koenig@baylibre.com>


--r7rl6pu7vlvbu2rl
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: mediatek: Make use of struct_size macro
MIME-Version: 1.0

Hello,

On Thu, Oct 30, 2025 at 11:25:27PM +0100, Uwe Kleine-K=F6nig wrote:
> struct_size provides the size of a struct with a flexible array member.
> Use that instead of open-coding it (with less checks than the global
> macro).
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202510301753.iqGmTwae-lkp@intel.com/
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks to Julia for reporting the issue.

BR
Uwe

--r7rl6pu7vlvbu2rl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkKNKMACgkQj4D7WH0S
/k74UAf9HU98YiS3UFfrhwdGdgRt5/Dn7zjzTxHcsT2z+/Qs8mXkBp6qqze0euW3
FFd+RE8S9d4D0TQyUKo2N9xO++lzRazRVdbt0uLo0x2P2m+d2WsWT/sirKjYHXN1
zWL0LT6ZCYBEP7kBVkpNAqmjYgu0rXCSnsqw8NhVqWVe5uiazoZwemLZdHXMu9rH
gMThXn4BW80o8CSMTEddBH3VWuKbmMF3RJIIKFKi5oHhYkxPzr4V8rAL6T0tQw6D
vIDpOdzI5vzwZYqzF8ELE86k4VDCZsrgWE+s0x3rO0MCkmFzuY7DLlpiWGifeqca
myF70WwZC2nHjxnlKpOq4vA4BL7FYQ==
=/igG
-----END PGP SIGNATURE-----

--r7rl6pu7vlvbu2rl--

