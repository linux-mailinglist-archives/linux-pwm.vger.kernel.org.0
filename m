Return-Path: <linux-pwm+bounces-3626-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6BE99C274
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 10:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA768283C38
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DBA14A60F;
	Mon, 14 Oct 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x9gGR+60"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4113B792
	for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892963; cv=none; b=REFo88FQTD1V99+mowEUrrObnCs0FUzHODePORQd07Z27fZcrpjRmip6mw9L5I6FRKzPUftcp6ITIgp2Gas8+iRAjid18XTGUcvK72ox7bRsw0UcNiu02dyQG5yebjvvl9Yg3H4KxuNWPsQkH5IMrWMQ8d2Kjv1LBk8W6lNnod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892963; c=relaxed/simple;
	bh=4RlZOlgSupAxgWagLLro/53S7NCRTENxGSsZn/UbRdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJptux8gGNegn9/bI+7jp4m+cBiL8yZN3v6d4KB/tfyK5E3DNkGNNY9FxXDKZ8sad6B0mNxDYot7568z67Kj2SudDTWckDadyehLPpVXT2S2CtsEbnOHIz8BT3YB9Vq3hcRci/7ki+TY8ufFAttMGfs0jERBJ8IRRFRPEZcpeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=x9gGR+60; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cea34cb57so2615609f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728892960; x=1729497760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RlZOlgSupAxgWagLLro/53S7NCRTENxGSsZn/UbRdU=;
        b=x9gGR+60wvZ0qvORTFqLbGAuzN6S8gV1lxEAC4RKEBoMyxHIoOaj4QsmCkHzd55Rc8
         DWZlqJatAQKUfek39+uEEj/e7LSG6y2RImsjhSXE1PVGfU4tfAEUazfrPHXzXy2Zhtw/
         RWlog6JyJCqfmbwkyd8MdNhybTXTQXUylD6i0WYRYfakR/HU7/98LTvdLaEYT4+aemTo
         ft8+FtvlOaXsNEmRSUEBLUVPGNKzNa2Sl/zKfFCqp05ROgNeqDH17I6WZ+R4evuj32ry
         P4GhhgILIDg1e9G6tKLtCaHFl644ngITrGkLKslQ1puYXoGThT6hWh8XsAVkmZ1SulXX
         nqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892960; x=1729497760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RlZOlgSupAxgWagLLro/53S7NCRTENxGSsZn/UbRdU=;
        b=EW8RhFMDkxeafnfL6i3ZDbG7r2ndiUI2KySxnEegzcJan4sdf0q5vHQ41JHwF+or5/
         70s5KiPedcv+8AymVUQO5w2sWk2YAZPvRbF4DynRvNQDlFXTsQPSeDFvZdlx2SzwVlgb
         AW5nfxHJrHIyXtQyYkD/axa38yVmeLQDIXW1qEYfmNNYMYHKbLY/T6EqCTG28qx5a6Kz
         XEZdC/vssDMd61HexwwnIfl6UAleFLl59MfLIxSs5POKQm3EXmoMy2ryoxO4NwrCeG78
         sBUZhP3GdHGC7msLZaJdEs7QXUD+PUvlej3+VuL3diBep1YJpk3uZI8Ug8QstI30pZWI
         dXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaSbfepJDNygebr8ZrNRFI8/XcLJM2foRaTFaB2VRH/rzenywps6zOp6qLP/afqJTRHDKI2yyVsXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7obPYRyZDqU6d5eY76MGGRVj2JGdnVZ98ZM8l7ulZbHYcjiS+
	g5RYvfQoWYThjfsMMkzqcWnXeNskBYbvWeeYlgPtUpVR0Gzb3luH80CpMvwZYqA=
X-Google-Smtp-Source: AGHT+IGHI1oWFXV9DcSfHKsT0K9KY6FX9DQ9bVpIzkaaGAOafugiZ3ojqGus5aCjg1CPitlaHNm9Qg==
X-Received: by 2002:a5d:688b:0:b0:37d:462a:9bc6 with SMTP id ffacd0b85a97d-37d552fd82dmr7764949f8f.36.1728892959854;
        Mon, 14 Oct 2024 01:02:39 -0700 (PDT)
Received: from localhost (p509151f9.dip0.t-ipconnect.de. [80.145.81.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm10751841f8f.70.2024.10.14.01.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:02:39 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:02:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Mehdi Djait <mehdi.djait@bootlin.com>, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v10 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <zlgxam2ph67gbxaf64tznc6gaediik5vzfus3kgbanu6ke4vxs@6emuicykaike>
References: <20241008030341.329241-1-lanzano.alex@gmail.com>
 <20241008030341.329241-3-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nfdjdy6igf2fhtdw"
Content-Disposition: inline
In-Reply-To: <20241008030341.329241-3-lanzano.alex@gmail.com>


--nfdjdy6igf2fhtdw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 2/2] drm/tiny: Add driver for Sharp Memory LCD
MIME-Version: 1.0

Hello,

On Mon, Oct 07, 2024 at 11:03:11PM -0400, Alex Lanzano wrote:
> Add support for the monochrome Sharp Memory LCDs.
>=20
> Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The pwm bits look ok now.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--nfdjdy6igf2fhtdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcM0BsACgkQj4D7WH0S
/k5wWQf9FfmMItjVRgRZH9tOPUX8zANyqph7Rsnz7icv4muLFmBRJDz3p4s02Ifw
vnjzp3F3ONPAom9POqZn5akcxHl+98+LD9D/fX4eKwdQVxYZsPlFi72VcoQ1Bree
tIfmZxTDoP0HWpqDB4zDyVbvRlnYgtPHteFddN4vCa81Ua0K5zOqgl1lqTyen/FX
XfhKS3GGBml9wTgjQ31Us0EXkQaELjXwURwCRobwCRiEm5j5bJ5o7juVymoKwLSc
c07MB/X1DR7G0Z2CegTx88SCcpBq/wd68vzn5bn8fbf+JoMvJ3YGp1j9pdjyJpQK
RRVObhQN7P7/nIVqvo8XhmUk3Rf2Yg==
=IozP
-----END PGP SIGNATURE-----

--nfdjdy6igf2fhtdw--

