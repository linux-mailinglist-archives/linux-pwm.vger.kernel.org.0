Return-Path: <linux-pwm+bounces-2581-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9920912107
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 11:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633E31F2354B
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4CA16F0E7;
	Fri, 21 Jun 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UolwustF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57316F0E8
	for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2024 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962886; cv=none; b=mvdleXa3T9DFjsBf4DNuHRZ78S1++jYULlwhXklRdofaWLd6qvhBF2xXryQYlNlTI5bB3p+1QPKifANTl1f/6G7MNyc5milqTvAeW4E7z1CzcZhM1F/8jqDeczImZilkeowehOF26MvBf7/2L2kChp7zf41sLxmu3Mhi0x8Q+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962886; c=relaxed/simple;
	bh=O9HyFK/NnmKv5delvTLS9zFrvLw0dUE+thosttEfFTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSXiwSf632I50KRxnRIXzs73dX4o7ovNgFS9/OgQsiN988jW5Lh9zSFSv4Nat0OhIH3lemB/T7yV73p3Kdo4OLwwAwNRY512MgDU2F96un46t8JjrJizAyEKi2lYFt1s7FFOWLQwUzEpjSNBcPQFKNm4X9z3ZWVCcNshLchAbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UolwustF; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so34229191fa.0
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2024 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718962881; x=1719567681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dvkU9iF+DN79uYvXF33RQtDOLlIxLB1Ru4Q2pJouso=;
        b=UolwustFV8BQ3q8fS+j7Luwb1u71qlfBYGsAzn+qf3BqqX1uB2uur3Ya2sSZLa2PQU
         PcAzKJBzpFFL1bU7VPTFEhrmfvbE1acJOTVju4BAO4X0R/JD3amFfNFfnJ1wRBABJ+LR
         wJIJTchuMEQOaueXQPtnfuZZbRRu5nPHR7A1wWoOSWxiwSx1vlGRI9fzmVzdr4CO5h7D
         cD68MtbRHrhCQISg0qVh8xXPMlSMa3FIMaAYTBhZ6+aWCPzZPAUz00A1v+Ixy2lc0/7/
         h6Z9DB2ZLnbI9tXfAYX0lI/VYHCXT7fz7QdQD4jgZSB0D7vHetVynXh/jJ0+YVn9jRAE
         ZdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718962881; x=1719567681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dvkU9iF+DN79uYvXF33RQtDOLlIxLB1Ru4Q2pJouso=;
        b=LkF6aJM7ypGUVpWUlNkN18wnJcGshBn0eZ4P/iY1e/zzlxOF5oA9WTHKm1g8w1PkHE
         qXmjX2goWqVYV7Vgs7YgmGT3+t0k2WS/LoQBwbOk/+vPob+sgr6ZgNWGCn1sNXp/3E1T
         fAXz3cNza5eMIfvXDKowdgfYqPd8rby6cIEjHMfYhCIYhgAWWa6ZmSu8edzeK+HeesDf
         wugt+yAhVErCOXMXRd095GjMEv5E8n7MAkvPDmK/ctQ2fdqbYckoAKsYs25CBltTQjVW
         hsWGGeWeiY5QYyH69r+klShvRzQ+SOMB8G7vXFnKLt/1Na7R4o5OoXWa3JFaziXSf1kd
         mzWQ==
X-Gm-Message-State: AOJu0YxnXkgErLnJDIWUcBxLhZgLsoWjMxYIsbsjm1XiDuzDLtGY5qKF
	cMLtVESJf+K8kTINXgM9QRREpku8VJYuHqYgYZg3+t3Beo4FVuBdv33lmESEvV0=
X-Google-Smtp-Source: AGHT+IGxqAR/TkSSBuhMkzUfNO6HRVbVXMRf1o11aCz4XIQNN82BVPmPGMar81cYR+v1A9G2jTtjgQ==
X-Received: by 2002:a2e:8712:0:b0:2eb:ea6f:f2c2 with SMTP id 38308e7fff4ca-2ec3ced12f6mr62088371fa.24.1718962881341;
        Fri, 21 Jun 2024 02:41:21 -0700 (PDT)
Received: from localhost (p5091583d.dip0.t-ipconnect.de. [80.145.88.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf56e9fesm63828466b.204.2024.06.21.02.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 02:41:20 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:41:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [GIT PULL] pwm: Three fixes for the pwm-stm32 driver
Message-ID: <yqbe2d7pbsqpoqm4ozoliipmyjf2pibythw5t7dx35qcj3g46n@35wfdemyimmj>
References: <2d2qmxla4hcug3mx4puvhrnezwjw6xp6xdnwodggcdglghmx4w@wqd7rv5qys73>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qxu63b2e4r6ngx5y"
Content-Disposition: inline
In-Reply-To: <2d2qmxla4hcug3mx4puvhrnezwjw6xp6xdnwodggcdglghmx4w@wqd7rv5qys73>


--qxu63b2e4r6ngx5y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

On Fri, Jun 21, 2024 at 09:18:08AM +0200, Uwe Kleine-K=F6nig wrote:
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:
>=20
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags=
/pwm/for-6.10-rc5-fixes
>=20
> for you to fetch changes up to 4120bc75cf95bb1b10df83e85a0478f292ea97cc:
>=20
>   pwm: stm32: Fix error message to not describe the previous error path (=
2024-06-21 08:57:12 +0200)
>=20
> The first two patches were in next since Wednesday as
>=20
> 	215d1aa8b5a7 ("pwm: stm32: Refuse too small period requests")
> 	ea80bdb90a5d ("pwm: stm32: Fix calculation of prescaler")
>=20
> I rewrote them for this PR to add a review tag and improve the commit
> log. I also dropped Cc: stable for the latter, because the offending
> commit is only included in v6.10-rc1; there are no code changes.
>=20
> While preparing this PR I noticed the bogus error message fixed in the
> third patch. I consider this obviously right enough to include it here
> without cooking in next.
>=20
> Please pull this for 6.10-rc5.

I assume you didn't pull yet, please don't. During some more tests I
found another corner case that isn't properly handled by commit "pwm:
stm32: Fix calculation of prescaler". I removed the tag my repository,
will send you another PR once I'm convinced I really fixed the problem.

Sorry for the confusion,
Uwe

--qxu63b2e4r6ngx5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ1SrwACgkQj4D7WH0S
/k7LLQf/UNGIfBJerxebLOfyzvNpOkMKhSgnVEJwPgBXGNWDVw/wc+8rmwQv7CmY
5+ptvW1xWnVK6w4p/7oMhWVkon0jki/q1f+02Jvdkb8kBDFGmwJ3iva2MQw4xlwL
WCRcq9LlGaCUOA2+QPmTVCFdFPQmrNtYofA5uiPqb648F9mHy5LqFP15frbcz5zW
MkfgU0IXvGOl1nSCsDZtBMnLLSCpwFTK+c1kWXM4Md8OjOeKDkwnr4gL/673Jgx8
l76VZ0yD2OFYy6UIDCkITCvX0K9MobTn+4TwlBqS8qJbtY362YWpfinV+Fe9e49U
bNh8ZYLdygTNC1D+L8YEUIskt/DUpw==
=MO3k
-----END PGP SIGNATURE-----

--qxu63b2e4r6ngx5y--

