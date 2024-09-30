Return-Path: <linux-pwm+bounces-3402-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F27C989B1B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 09:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054441F21068
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 07:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040EA14386D;
	Mon, 30 Sep 2024 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eTT/giHQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB310E6
	for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680477; cv=none; b=l7cN6K+cmuqXRK5zgdX0wr2MEAVN7AY5afRNFf8UZyijeDFeBqIIByf0r4gzv7IiQLtxrb78YEjAHJwmrQMBpsPkGBeBM2i+YblUfpFKCXogo+ZN0VRbRVG7F4iMZLwCsXwXwM2lNbHQimUgpURtpEM8IJTrqEIthn4tGus5HmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680477; c=relaxed/simple;
	bh=l0FXb/A2D1cvyh8qyUDJTJHrWpHxWmzrtDlwSI89q1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K866iFsBczPSHrsXICkwAEutHMDl3TXXZewruzh/EFE9NEZidxmFPeIc9a8bmbhyOlZlFdX6UvpYuQYXQU9ZqCcDtcIqtIZPU/2VmOl262Wtd75whCK8X9Ggn0n+O5+uD9OdR2QrDSEdqARGfmO+QjAgiBTIh/Ul9kJ0OwXtEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eTT/giHQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso36909575e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 00:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727680474; x=1728285274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0FXb/A2D1cvyh8qyUDJTJHrWpHxWmzrtDlwSI89q1Q=;
        b=eTT/giHQUy3YW4XBWxdtyV4+ohjcTPr+GPNpoYr7vDrt6Aa6qOIoDfBM4semZs7AG9
         1NI8IehOh7QEKz05kmd4UcH5ZtGChAvVg330eV1nqpwm+ywlNtr/SdQElPSpBLGE/aaR
         K5wdE8Yj/s5y3mg9IfRkBD7W16i2hhBdnimPtm97rGjgOxpT6Hcn3AYerR5On3efDNEA
         gB7ofP/rsTlg0GVgyaTNJlRrKLlbCcOZTK35zWMfKhwO+xBoGDyK2PWf4yN6Trhvl51D
         Zo34WQI0ijKnDq65EXaHSNuDCEG6LvXnJJSfbHzJmWuJYTtgLQFbobRPOpp/5ipMUggV
         d7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727680474; x=1728285274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0FXb/A2D1cvyh8qyUDJTJHrWpHxWmzrtDlwSI89q1Q=;
        b=Q0KSyo1XGYXKJ35qovEBM7QEHssp2Gz5RkHqcQSbznTe8otVnnjUeVoFtw6EHTEonk
         oX8Duwlj9sBjoQKty7kSKv5zw5eACpIrk6ufXdbiq9DE4TquEElA8eFtZyPenWmxI/m1
         pMfSqy15G71Ktx8o/EHpKlOI5PtoAdXmwRqSayo0YD3dVSoL3LcDx0RH5o4z3EoGZyBV
         MKUIXGEcAv3+0vbzovf5EilNgjZEcOmOMt8j3/YhUvu17lFjRq+cmvwAy/XorYmLeB8k
         xazlqIx9iP86ZNwOdRZa/HYl0ayPU6tROOY83SY45rb8BukKB9D7nLz26Cfp7xeviPjF
         QSTA==
X-Forwarded-Encrypted: i=1; AJvYcCXB3sDgDqjhNUV4xrqiRcVE89lpHuCQrIbG6bbS1FSQgm4r+GG8MZSoqShKEp8ojBEb15gIxyGvies=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp0K2OFGy5bQIcHxjeTBLgNXnFV4F05c69JYgQIaVaceW95EhA
	iRR5pCTtBBZUoFsDbA+MdN6LGFuhiuRDbFE9ObbpIGZBfqul0HXDl3FgJtdn4vE=
X-Google-Smtp-Source: AGHT+IGJyNHTZESTIIPs/3AcS9Tim8KLQ/LJqIjWRJOSFXTe2ROkCkOJlz373yVP1zJE3bTl0/RU7w==
X-Received: by 2002:a05:600c:a4b:b0:42c:de6f:6ab3 with SMTP id 5b1f17b1804b1-42f5840e0eamr78362085e9.6.1727680474216;
        Mon, 30 Sep 2024 00:14:34 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6596sm8303854f8f.63.2024.09.30.00.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:14:32 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:14:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: dmitry.baryshkov@linaro.org, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mehdi Djait <mehdi.djait@bootlin.com>, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, christophe.jaillet@wanadoo.fr, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <xaxa2phqlg4vbdexi2atyf5kvu5rixqrprbvcwumbfy5cdwazb@s7fqm6yttsjt>
References: <20240923162205.55658-1-lanzano.alex@gmail.com>
 <20240923162205.55658-3-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mjx4wdiimu3v2vxz"
Content-Disposition: inline
In-Reply-To: <20240923162205.55658-3-lanzano.alex@gmail.com>


--mjx4wdiimu3v2vxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 23, 2024 at 12:21:35PM -0400, Alex Lanzano wrote:
> Add support for the monochrome Sharp Memory LCDs.
>=20
> Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

JFTR: I gave feedback to v6 as I missed there is already a v7. See
https://lore.kernel.org/all/q2njnpzpkd3xrrv6icr5wq6uztja3wfmy2x2ldreqemzbwk=
edv@ixywmn7qy34q/
=2E

The TL;DR; is that Alex intends to send a v8 to address my suggestions.

Best regards
Uwe

--mjx4wdiimu3v2vxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb6T80ACgkQj4D7WH0S
/k4q+gf+NRWnSFReYhgI+VSM690varWV9lp9Iyql+s7nR00KEfVpP2CHMV+HP64f
gA4pGrIcJf79pxHSzTs5FgGym38r/hQyM8YLUeuqdfPPsANSGaPk0LI0//ka8N4c
GI2n+5YJ25ZGJBZWa3pVmcIljqJWrcV2xIpiqkeNTvH0IqODQqdTkLQZVhLij3Lc
tqjylRfiI5TCRqXDKJjsiw4xvW4Y0E377rytq1WhVvCKX2J3rufgYQFF7p1xG8HZ
LvZqEDEe5j55SwePTrGlHcE2cQo4v83EApzgr+OctACGoCmh4IMLnj4alC+zAYdy
Jeulu7OUyuDKVIvc2rxQrZtAc5VNvg==
=Wa/t
-----END PGP SIGNATURE-----

--mjx4wdiimu3v2vxz--

