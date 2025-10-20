Return-Path: <linux-pwm+bounces-7466-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F56BF01B8
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Oct 2025 11:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A7A3E73AE
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Oct 2025 09:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7812E9ECE;
	Mon, 20 Oct 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zd05K4JF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CE29ACC3
	for <linux-pwm@vger.kernel.org>; Mon, 20 Oct 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951452; cv=none; b=kPRwfdwSaYlxxrXHjRPfRVaRjq/+oZInAoaafJMmdK/Q7ueXEhtHedJ+T7qAzyjP2Pg+Ccdutsdl/pNF/8KJ6wlXB0NrXW31kfbQyodQswHikGWs0xMOcWmZDWoa3AoUnoMIcw1sZ1w+xP9x9F+m6hnry82j5a6X38MX5nAOLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951452; c=relaxed/simple;
	bh=JN4hv9R2L9jFNo/jgt/CUThZTtFLosT7JAkI2qBkxMo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNfUva426NyZdVzokroK3feOMjE2hBf1I5eMCxk8IwjkQ41K6Xc7jkpYbbNqRRtVJgWj5YCh3CTdx5cwtlqcm4XHY/lIYkQGLZJ4Nh3eUsItdi2XtAsoyynRrDo+6PrMVez5ME2BGMOhv5dSxNYldZsj9EILbYXkmLWpWBtTAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zd05K4JF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so3588882a12.0
        for <linux-pwm@vger.kernel.org>; Mon, 20 Oct 2025 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760951446; x=1761556246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JN4hv9R2L9jFNo/jgt/CUThZTtFLosT7JAkI2qBkxMo=;
        b=Zd05K4JF95XRsHAzF5+zCh6jyLcFtdjFbKzZlaqg/n2xGQ9MmfZ51UeBrTdtZ/NQ/g
         WRtzcgM6fNDd4wwRe3hyovGh+V48v+id2wXhNWn3iVv3hI2vzt20ftxPxysW0uL01p8S
         trdSjueq2I2310HA04vH7Lz/XO2YDE+qPxPmzNhkbHzD+J9ksNYMz+VJkEz2/dK0LKzc
         zCyZU9bBLrtmdO8K1mgqp4rYes3kKlwHLo2tYQhA1vx+/IgXD5/ScyxYia3UPqE5pLtC
         6K4o7HZ1aw0D5OlpNI6BfqWgBQR9OAz5ltNgTCCs6+92f7Wtk/8oK//E5lNBbI14E1CA
         qRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951446; x=1761556246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN4hv9R2L9jFNo/jgt/CUThZTtFLosT7JAkI2qBkxMo=;
        b=Phshk+Vl0F9UhgGPginpUWxwjINVrPGIMTQf3hCJF4nWnzluheTsgYq98u1N8RbQ1C
         NRxycJYoP4ySd44PSw3BxFKNQxWiBJ1JsIlpmO0PGuzQctDz6JckV60VjLr/RcflnBKQ
         sAHVrU1Qbu6tTMOyT2ElGXH3kPH6xt/304DGp+iASqo1JjlepDOxb9YenxBFzoG3Lq6/
         IZfSNaLg17P+tE+67EvK8VVfTiVpPl/jVKtguiGijeDbkKuZpm7emx+RBLugb6zFzr9Y
         oC7gqOLQQY4SQUdEPQAZ3je6N0AC16ssxrPGxqcMABWIwh6B0dYMxDHLo3ALxK106PbY
         nWNw==
X-Gm-Message-State: AOJu0YxtLvrP9nhzWOAwwxQARLMOek0+t8qba4N7arZX81u/m8YdSBvJ
	y31vWjktGh03+8sUBJ+sXB5ziu4G7GthUMxUDgJm8imSw6rlGKvNEEVfBRDkzTKrFRnqGYwVYKI
	tMw/p
X-Gm-Gg: ASbGncukzSUPuBcl82xOSHmtDaNDDLutAQZmzlOFzeiqqBpwKo3lR63pW8rYXWFulo6
	Sf1/ncJOuom4bgwZ3H9bv9N2OcgsUVZMvGoff1TxTn5SRV/5a9pKiz/EQtupOFYkPw6Sv0fHmlx
	pcEsvhtON2DflrF60DhPkofCWO6/DrHCuhs0YnqqnTjhQdtuIYCsq57iELyECO6M1Med0D55Omx
	U4dnJb+G3HSPotd+gK6s2HIVdKjPgYTckqStFSWBiKHNRVgNyhlKMuvxZ991dSs/+E1509batqY
	sVaCOyKh66OOfbi6D3dbvluxXHeQ2ab9qeSyL8H6iniPXGgLM21OiRVXwVyvZJkQPd1IudEz5Gd
	glXuXUqCELbLKxZXnG8OYPJiGW3Aq1SE/BZuksBZrXh9KmDufd1PIRxOIEbtjyWeVzYGrWb6Q1q
	kVYF2rNF039uDnrW22YWEjNtcGSXk/uM3bmepk2cBUJzh8oWEzb5y7g3Ml7jj8P5A=
X-Google-Smtp-Source: AGHT+IH2cDARqfekJBd+QypZedAMjpj3N8XVrXHGzsTEFrBBUx3VpydymdPIVNeluGlYVRpj+6J84A==
X-Received: by 2002:a05:6402:2113:b0:63b:f91e:60a2 with SMTP id 4fb4d7f45d1cf-63c1f6c1fc8mr11740439a12.25.1760951446164;
        Mon, 20 Oct 2025 02:10:46 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63c49430272sm6148432a12.23.2025.10.20.02.10.45
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:10:45 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:10:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Drop unused function pwm_apply_args()
Message-ID: <h2sdkzp2y6es2cyfxxxxgfen6rd76u6lpxj7w3laiuzlgaeyyt@faaxl2kaq6xv>
References: <20250922094327.1143944-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zg6q6cxbxgfuwzmt"
Content-Disposition: inline
In-Reply-To: <20250922094327.1143944-2-u.kleine-koenig@baylibre.com>


--zg6q6cxbxgfuwzmt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Drop unused function pwm_apply_args()
MIME-Version: 1.0

Hello,

On Mon, Sep 22, 2025 at 11:43:28AM +0200, Uwe Kleine-K=F6nig wrote:
> The function pwm_apply_args() was introduced with the concept of atomic
> PWM configuration and needed for drivers not using this concept yet. Now
> all drivers are converted accordingly and so no callers are left which
> allows to remove this function.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> as of v6.17-rc7 there is still one caller left
> (drivers/video/backlight/mp3309c.c), but commit 2720c87b7621
> ("backlight: mp3309c: Drop pwm_apply_args()") that is currently in next
> scheduled to go into v6.18-rc1 removes that last user. So this patch
> isn't ready for the upcoming merge window yet.

2720c87b7621 is in v6.18-rc1, so I applied this now. Find it in

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E

Best regards
Uwe

--zg6q6cxbxgfuwzmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj1/I4ACgkQj4D7WH0S
/k7l4Af/Ud0fzjncZ/ktd2p44SyRShplIWgc0urTNCQZ/H2ET5BcdDNjTR3CmeT4
EqZrk2PKoBnVQ/xURB7gOq05NWa/0r/wKN26wwbSB7itdmovAk7wCE0nicX2SiRY
IAqoQ90i+6zaFGVBPsI8O++iUjnKnJCRc4QgMfQjElYci7dM08/vi9wlUTeDtzr3
3dj2i1IekJgbRau6lJ3Lq/pf80LHGi/OKzKxfVhcMVoR2+wul/QgZ/jK6EN7VPKe
tkks0aUaMt/5MpNlXsVwnLhGLg/SOvmWCk+BlQyxYicV6Wb5D8Mmx+xz0+bEOGo0
mBCsUavzvONF5zGHIgoxhvhMIZdHcg==
=jl+D
-----END PGP SIGNATURE-----

--zg6q6cxbxgfuwzmt--

