Return-Path: <linux-pwm+bounces-3703-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D79A3873
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 10:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0011F29539
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2503E18E025;
	Fri, 18 Oct 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aaGa3toz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4118DF90
	for <linux-pwm@vger.kernel.org>; Fri, 18 Oct 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239908; cv=none; b=nSMGfqmslfnEbWJ3lG3hGhp+vWSbu+q3q5IrYCayTOOL32jU/8cIHTU2Jc9aU0cuqSE+gXW0QgPQE5tigUl3rydxwCiBU3F3fSPkkHmRREJudS91QX5UOer8fds8sLtGnz2StHBjLTOFfMjxnSSfGQnfOvjoLxYeChQXG8aixg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239908; c=relaxed/simple;
	bh=zHWvZeWAw1nXOZSuhULXmpmjc+rCAaz0RWexDlypXUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz06Fzyfuwxt1GQm6ebRhzR1Xhu1b1dlj1Q2OVdmwlfG78EI4w1T8aUG410VrXJf0MtHbXo19t1R04p/j9Lde31wfHMvvs8WTHxA6taykvaO88lRjFzORt47enal8Bi2Jb1Qlm3gMWjZXfKpVlKrS4kl6spMvjNy3Y1Q/a3qDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aaGa3toz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d461162b8so1233597f8f.1
        for <linux-pwm@vger.kernel.org>; Fri, 18 Oct 2024 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729239904; x=1729844704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHWvZeWAw1nXOZSuhULXmpmjc+rCAaz0RWexDlypXUU=;
        b=aaGa3tozDZzwc2G8DgWDvcKyz4jXffvunwttv/sZVbdvnn1MNI2JeN3c3Ya/jmk2MP
         qeZDwQWeOxYp28VwA2qdG7iKDFEF0dG/ONz8cwLKXELPE64Lq7LAk1Gb5NSggL/aKnDE
         tTIMJvDgt040Pul0tQlyO8j/wtO236ftXnUHTk8u3oZIkxDGIRky5/K/koGo12OteU2M
         CfNSmtor8L12MpkzezHSxfVJit1oX7HLufaCQuTv+LqdES/B2HRHfe/Oa92ijfxQhiPU
         rHvdP4Bt8r4JW/UC1jPuuX74Z7/Zu0fRorFog8bnRUPqSHnk5kn4iNFcZJ7xdSj+tiaP
         fakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239904; x=1729844704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHWvZeWAw1nXOZSuhULXmpmjc+rCAaz0RWexDlypXUU=;
        b=kDuMJUjKtNVizLNEDD6N2BOs59lXNM7xJFRBOZZKo7xd/2DYA+d6x6EoC8oDHhzyS2
         frT1hba8L8yZ494je8nYTZc87gXdpxm+HOuA5q4eWf/MQbbXsjx35YXOkNi4sZdAWkLN
         NTFii3Y2/jO1vY4rV7SGwI3iUVu1p/yck00EyegFoKbNTJyRw8i4eAWE47lXcbv+AeRy
         cKNgqd9Z4aRLruVg5/+z2y56X6GG8NXnBDeXDpByIMTDNVoQL9MiifqMM84HXB3pAqgg
         JLsug9o0sat9CG9oSNlh4O89iNihwTGHCRnvnW8EThgcoKQ6vv5O7yYZS0zTLIN5jDUt
         RpFw==
X-Gm-Message-State: AOJu0Yy5ZDlv5PmL9eIgV1aeREl2sCwPIWvdPIoJkPexvlbYpeD7fs13
	dDUdv4s/LXgI+VPVIsy6EpgcYsMcvnf5ea3mn9h/kW7J54QaXTn0jfiP1f7GtOw=
X-Google-Smtp-Source: AGHT+IGfGYoF1ues4V7q5yChqm3acmG0UxUp8HRtoojXSyzX8A69mfET9xFWRaEMAwwgylLokS3E1w==
X-Received: by 2002:a5d:5e10:0:b0:37e:d2b7:acd5 with SMTP id ffacd0b85a97d-37ed2b7afc9mr386203f8f.8.1729239901491;
        Fri, 18 Oct 2024 01:25:01 -0700 (PDT)
Received: from localhost (p509151f9.dip0.t-ipconnect.de. [80.145.81.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf027bebsm1284373f8f.7.2024.10.18.01.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:25:01 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:24:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, michael.hennerich@analog.com, 
	nuno.sa@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add self as reviewer for AXI PWM GENERATOR
Message-ID: <rk7vlz4dgs6oisbhwhewq6yah367t272pr7bzns6fz3rwlpv5i@mcom6trat3tj>
References: <20241017174744.902454-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgwtgw3kyjry6xim"
Content-Disposition: inline
In-Reply-To: <20241017174744.902454-1-tgamblin@baylibre.com>


--wgwtgw3kyjry6xim
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: add self as reviewer for AXI PWM GENERATOR
MIME-Version: 1.0

On Thu, Oct 17, 2024 at 01:47:44PM -0400, Trevor Gamblin wrote:
> The initial author of the driver has moved on, so add the final
> submitter (myself) as reviewer for the AXI PWM driver.
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

Applied and pushed out with Nuno's Reviewed-by: tag.

Thanks
Uwe

--wgwtgw3kyjry6xim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcSG1kACgkQj4D7WH0S
/k5KPgf/RAAOaWwDMeXosltGXTcpEW4MQSHihXQoqed8LB8uGfbMtbC57Wt9A5nY
a8J2Q2xS3ztKFV9E3qedy8hBK0AayA2Z4WZLScRX5hAMNLhcMzMcXmgBf4SEjQgV
oZu3999XtH4VqfFocVWpQswZoCw9qwhi/MJ2n7G74ym2hYDW83nSPBaAe9MDjjjO
9oJ3tpBa3806fIrSnohg//tEiJc4bkgjz4t2VMc4J0P26g1R+sCuf6icyoIw1azi
cUwk0lBEMv7mfnEyLsRlV0CzUJzBkWRKHDckEmJPWYvwEEwQHiIrG98O5lhDzAM4
hHeYsmvDrNGLqDEsph8rLXzQJ+oBcw==
=ekwB
-----END PGP SIGNATURE-----

--wgwtgw3kyjry6xim--

