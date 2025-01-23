Return-Path: <linux-pwm+bounces-4718-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E554A1A662
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 15:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75F03A7C3E
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1A6211712;
	Thu, 23 Jan 2025 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WAcDLjzr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048420FABF
	for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644323; cv=none; b=kiOJbm8gaUFumtVs2+XmYG2TaTGkSazAGQUFPl2bdVzCYzK36IyazRfrxPbLup+ZUQN7dGs25+eKCYPSP78ALT7Ws6gTFjeYs8DZsOp9IbkGzR+IAqGzhZXaaIw2Sj5CYcxTJdSOsi0PZZu1FkOBefYM3dqyC7VHphzNkIqjeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644323; c=relaxed/simple;
	bh=bX7TEjc4sIqFhFyR/bKbA5r40V87sXP25fb6VjCMSio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8dbbRxYk8vFupmE89a16+Y2LGu9Q/ii+T+XqX5U4SWnwXoyUwQ8J7wKFQQPU1JxKQyGNkSL0Vt60SdBlz5g8FY45J2ahEt+NARo2ZOaxzRzomf29YGpQXxdtqVPhgsIihYyBn34ax9PhsYbl+58mTGhHtiptwjOD0CTSPTSMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WAcDLjzr; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso888922f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 06:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737644319; x=1738249119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCQM5mtHV8uQ3jUDihd1RP4w39jdCw6q5uWclHcACFM=;
        b=WAcDLjzrV9FHTdAojsU4ElYkUJC3Hy82Li9KeYg9+DhtaHPw5I9KFKJobH4MuacJ9y
         YdhpkFsWKD8MMeVjRersaaKOPQsHsMJcyOkF1Bz0+xMQdri943osbTVGKHZx7xOWj+lu
         +msNFvUv0yaWzc9/HTL2QDO2hml8MN33hgERFi6NSlXMOBqT7zPjsPF0DYu3rgUelo1e
         te73aNKNF+BIy9NgtHyvebJUxVBkPkMN4MNQwBt0jEQd8yNH8YL4AT9PRgGDBdfcF1uU
         UA3/KJsuju7U2d2Ojk8y11xBav9eB6NwVHib44bj8RiQyMcBRMaW9esNXvra4J5X/X9G
         kMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644319; x=1738249119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCQM5mtHV8uQ3jUDihd1RP4w39jdCw6q5uWclHcACFM=;
        b=ig8h96MiFBvFD03+UkkITD8uny6/lb3DikYzBA/eRmfKivMkURc6GeIfzidQEddfVv
         TVqvuwpGAwL4q4jsXO+NrHg9EgwrLViZ6atbTvW4Gy8SeitYTPbAyjnWfAXE27dDAF2M
         94rWy+zvp9xpi6iWeuYk4gwYbwn2TO+kWznGsLDHNranw4AB6JZf8dsCj7FAS5c6gAKV
         UhLgSkljZmQdkoLj4GzZXWU8P+fec/ueG2WIXeRyTK6slRfSKM5+fPOKPBvStKqhkQzn
         UpVcFAsDQiAQLd504tZgsVRU5xR1XsPiKZYCyWi3wGLcQDFAiuo5ICbpkWjlRhRrni/B
         sPCw==
X-Forwarded-Encrypted: i=1; AJvYcCUMM9plTg1sJ//JaXmcfamWfRxlRYJm/9aRWM5x2obMTINiztBBhJlB2cyj3g4EPOouOmrzz2MyFJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0ynebE56tbawQ3qVIWQ483dpXjUnpRqnCaMkp/q4CSXCR5VW
	ePBJm/SZsZ5xKW1BRmSLSa3csEyqwLzdAk41qIMzs3TpFw76HtfBGYFvbmG+YHU=
X-Gm-Gg: ASbGncsH0xTKKnHKQT896AGDQV+YY9UXtV+Q/q+YEM5VkqfxYvpG87D1BE6nyCmZq2+
	SkjuTdWAla3npgvdwiFlQT1GcTAKjolY8m54Tb86Ci09bvrQOL3EXgAFHqRzprHFruIwyFQaieg
	hzJEUJtaWvmvkiO3BRCImIyqXeA6YUp35kYvJsgUPt7XKkARao3J8s4MJ/5xt1CTN7uhB1KZW9q
	YLJI0u+XdIhqCH3kfie+ZBzg83oTubCxz1r+cdLv6Ts34VZPZk0a5iva6l0/98GSHwf5FpR/ZER
	Qri77m1bdstyTf6nU5VPKeGJfWHSnC1i05B6AFQI684COyM=
X-Google-Smtp-Source: AGHT+IFFRB7ycr3a0xym5R6bjcGHc3rpFWH3/XzvSiXn5KBZKskZUZ69kuMxyYsBnIbKt61icwmOYw==
X-Received: by 2002:a05:6000:1445:b0:386:37af:dd9a with SMTP id ffacd0b85a97d-38bf57b76a4mr26176165f8f.35.1737644318723;
        Thu, 23 Jan 2025 06:58:38 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3214b4fsm19332784f8f.2.2025.01.23.06.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 06:58:38 -0800 (PST)
Date: Thu, 23 Jan 2025 15:58:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: lpss: Only include <linux/pwm.h> where needed
Message-ID: <bedf25q5itkcffamqft2kp5rsaqz7ccnspyivs7n3stgyi2zgm@ap4a6amhn3zu>
References: <20250123103939.357160-2-u.kleine-koenig@baylibre.com>
 <CAHp75VdxGSxzeS3qGxdGmE2Z_xvDyCX5e+oAE6B23Mas-Ln34w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uyreaknuyapmkofg"
Content-Disposition: inline
In-Reply-To: <CAHp75VdxGSxzeS3qGxdGmE2Z_xvDyCX5e+oAE6B23Mas-Ln34w@mail.gmail.com>


--uyreaknuyapmkofg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: lpss: Only include <linux/pwm.h> where needed
MIME-Version: 1.0

Hello Andy,

On Thu, Jan 23, 2025 at 01:31:03PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 23, 2025 at 12:39=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Among the three files that include pwm-lpss.h only pwm-lpss.c actually
> > needs <linux/pwm.h>. So move the #include statement from the former to
> > the latter.
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Thanks! Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-nexxt

where it will propagate to pwm/for-next after the merge window.

Best regards
Uwe

--uyreaknuyapmkofg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeSWRoACgkQj4D7WH0S
/k4ZCAf/WTV8OFZCOY1Oy8VTIK7yOU5GoOP+5AsvELGr0OZyAtYnkNbmcBCcuCuc
t+objsiJ4vcRMfzvPOapr0ePeMLZ3IyMJBo48g+qQdt5FmPffnpS+wxesuWNWPLP
3dvdiIa692wH848LiSL+HLVb+uQmEzoQb7e6SLhd4Bq1/c4enoWD9bu8pSEpI+Og
Y8ifCcAZTguqB+3vNbB9398yhXunwPRMt+84brgI5lVZ0SANE+jcZJplFa734MIx
t/OApnMxyt+kvPOcIy7R+6csbG9DUllVl/qj3qGwbGaFduTWpogw3kxshKSBdJqe
ZagigTDSroPh1uoFXbgUF8exh/8/kw==
=SvsH
-----END PGP SIGNATURE-----

--uyreaknuyapmkofg--

