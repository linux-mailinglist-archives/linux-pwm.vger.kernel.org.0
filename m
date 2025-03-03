Return-Path: <linux-pwm+bounces-5026-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D35A4BB06
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 10:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD751892A85
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2E02E630;
	Mon,  3 Mar 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d/J4U97z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC791F0E4B
	for <linux-pwm@vger.kernel.org>; Mon,  3 Mar 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994994; cv=none; b=e6CGk6Q2pu3LUTzk8b95H91i7ufPjkhAK3u6ZgHw9Yrfvrlpk7iFnNLczs+lO9jN0dieHQiY3FZjvZtQiBBTYWSWPxt2IEAmw2onm7cStkK+myqDtvLNyYE2Q+JyDUO/6d3tiusqWPCzTvXEjkmHW1NneWbYpBx2y/FhSx5zTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994994; c=relaxed/simple;
	bh=I7HD702RfpHXjFSS9LnmCasnaIsMWIVtBEVPu04XVSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEzqqzn8WCWcbQsYsF1XU7qQtUVchwntt+RTBZMkJnIQlUdrkHPice/A14M77nG/BEuGlVRQIqdmdULJc9k5IrLGT0aHMtG7H9m8+zCIHI9KlnAGQACTJPp/iZVHYNFBr/isZJpcOFG4gWNnw4SGU6Dixwy0fAKED4UJgIMZfik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d/J4U97z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43998deed24so39797705e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 03 Mar 2025 01:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740994989; x=1741599789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I7HD702RfpHXjFSS9LnmCasnaIsMWIVtBEVPu04XVSc=;
        b=d/J4U97zq7tqVyf4OtpuiAlTvIFyMilB4xOJs1tIKWqm/kmyzYpg0a6t15/UPpma6t
         iaTqT4bksUaVu7OSxfmotwkMJzzATQAnlekRwjbK/JWWDfL8adHFImMqqKeXmo1/gU6t
         Ugl4Zyg055GpzfwAx6dykSTiQ7WaWBZpIo4xV47m2cBLUAr0bw7k8kCdXVlKsrGsUJEH
         0nuyqWDHIeRee3dpIrmru3yLk/4dEtswbs/jnqam5iR2VmEKeaBxW9HQQgTcpDtWzfg8
         Gaq+SM7b/fr7hAMZy+QzZ3+L0BHnUzbfonjXnBVEb9yMzWr47zInhxbzd+XtXckYNSgS
         t58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740994989; x=1741599789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7HD702RfpHXjFSS9LnmCasnaIsMWIVtBEVPu04XVSc=;
        b=twDl2qLYzaqUva8I6G0RTDapnIDsDY8ZkBjd6qUts4qJZCNo4rNfvqnXAiQ5rDGtWp
         ws/Gbji2dksdxlshDHyECiQ8745P1vQ3s2hWjei+mPW5HjosFpqbv7RmsWi2+M1ms5c2
         S2ALwubHprsI6g7XivJM44xZYnJ0RJfTTUSeFbpX5aygxUqM8cukCnjYZbvp63Z20Ie3
         WfGTYwhVwVWnBVEv3A2912xA5bZK5IxFR8kPE1EpxjUgmxn80jVfI3AxXrWvs0JKw5X9
         it0Hjmfr/86222ecLddFtNpEhrutvw6Al2fUVLswYooMbfPvp96nUr0/IJyO0Pbrmta5
         36Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV8oMM8oJ1wM5KXBZ61tj+p3JON/7JfgRmsG0SwpnfaaKa5StLAsQRlRT3wKmSuCC6CmrfQ5mus+ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfUZG8RrhZzUgxSiq54ruwec1OyWlmJkJ1CpincrsZ1aR74a5
	UjvkRJG+hcI4M8M9ayWdrd1xFm+HPhOKt4809LqN04XdX7ZFw13HcyUTBmYJ8NA=
X-Gm-Gg: ASbGncsFbSdfD+bDyl98+NyKrapylTCZ2uTzTMHWnrKdFuKA+BilrkDui4McajCaSU/
	yqXZIGRgv+nh8xVXoYbTmQ0lblNynWI8uaf+/5KZlrdXc4KUeXd+rUUytNtJZtpfU4ISV0+aKI9
	9XoX4NNMG551B96GESMSMD/YWeNFPjY3v+JvNYXFsmXsRebJ18i6kLueOoKnwf2YkiZ/b4BW3SQ
	EqO+P3ldrCOEUzzC8KZYcP2BF1JeYTVnAuvoBmfct+O8GyvjlxeJJQbTh9Dt7MtUbJxdVMyQG6L
	E83IIDB26wDns4UndS//p2AhatTg0dz9dWeYH/iYE4MPWI7e5quD0JqRzBu+tF02t2sciNpggoi
	K4e7/wfxmnF4oY0syOoQHwCjJIw==
X-Google-Smtp-Source: AGHT+IGioXL+ceLlmWfZZmydFoO+5l0CmYAT/WRogvwkcEnYKD7My0ndm6CmTHlXPf3FtWobh/14Lw==
X-Received: by 2002:a05:600c:1547:b0:439:98f6:8bc8 with SMTP id 5b1f17b1804b1-43ba6760ca3mr81796515e9.26.1740994989516;
        Mon, 03 Mar 2025 01:43:09 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7b6asm14251498f8f.51.2025.03.03.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:43:08 -0800 (PST)
Date: Mon, 3 Mar 2025 10:43:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: stmpe: Allow to compile as a module
Message-ID: <miozabyaeoagqrw7evl4c44augcfbrdtupf4ium62xz5kb77cm@vndlz2rcoyj4>
References: <20250215143723.636591-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dszzsrs7iiegpzat"
Content-Disposition: inline
In-Reply-To: <20250215143723.636591-2-u.kleine-koenig@baylibre.com>


--dszzsrs7iiegpzat
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: stmpe: Allow to compile as a module
MIME-Version: 1.0

Hello,

On Sat, Feb 15, 2025 at 03:37:22PM +0100, Uwe Kleine-K=F6nig wrote:
> pwm-stmpe is the only driver that cannot be built as a module. Add the
> necessary boilerplate to also make this driver modular.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E

Best regards
Uwe

--dszzsrs7iiegpzat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfFeagACgkQj4D7WH0S
/k5Q0Af/fTmRfYYk6lWXxsIcFhHDAF6paE6ZWIq5+TiCzoRCcX8S4fiH92Kmz0kD
FcFDNskZuj/MZEUmfQ+xXClJVwpXTEhZL0589ALzo8uSv1FNZUg2tHk/tPT30Rxw
wfNynJPHkyO4gVQ6dm81qJ2e82VI6B85KNxN54DkJphIYhynS/OstQdsuT/kvsFf
cT1ei+v101ww6s1ycVH44lrCbC06sb9tC4XVkS3ZCQw443EzJM2A4nIE6MrIdLsa
A8pb7ggUHf/sUtQC/BDssdTAvWvq1hgXDDQSnVpuhg8lXhUyAW4xeoCZan2mFPrk
8nJ2zdNMDZPQ4WWaLC8jEJy5z4syUw==
=Uees
-----END PGP SIGNATURE-----

--dszzsrs7iiegpzat--

