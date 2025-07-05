Return-Path: <linux-pwm+bounces-6735-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DE6AF9ECF
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 09:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215E31BC1A61
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 07:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E69A207A18;
	Sat,  5 Jul 2025 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N4rVEXBd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C719D8A3
	for <linux-pwm@vger.kernel.org>; Sat,  5 Jul 2025 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700923; cv=none; b=txrDXWauCSXR4jPnRZflmFli8a0BdXIVmBfOpxP0/cO9dCvOmEssFsM+WbAGGCviwF4m+hY8yuhU/2OhW5k4UzNd3i4fP6XylJTUCh//rhSk3XSy/LZxqeri7rg/I3M8/S2/INbpHqfwn+zfrspJ3IADZeps25UUiaByTgjewK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700923; c=relaxed/simple;
	bh=ipNd1HQQ2Ma2pisa7/gO96wA/WYXb5+4l3FrYAWC8qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfhsJ8rG+xan+UmFFCxt9UpzafvZYUh3WEyiZ+rJmKWwiCuDppm1iw478uRhFciZatVU31DbAixItlXiee2/P1ZJdxzkcYgcVq3BaKbB0Ur+DHJzhZ75NNmtGRNibNsphT9YGVVrOJYjywnGXORL5++KJk/hjegs6gVjmBJED6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N4rVEXBd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso2925083a12.2
        for <linux-pwm@vger.kernel.org>; Sat, 05 Jul 2025 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751700918; x=1752305718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipNd1HQQ2Ma2pisa7/gO96wA/WYXb5+4l3FrYAWC8qA=;
        b=N4rVEXBdIutvkuv1XNXx03aNy9mJYQTMdPya3StnFJklurt3d3qS0IjUeBPVT4hDhh
         uSqiit54a9bIlzUl4368ooCHhAaJRFKEVSmykGMGIroOpWFUV1nFl216FcBzCM7WmA8e
         fcxaxpyh1aKKKcqmrbablhWDyC8J0zRHUHCqRq4uyFPnx+gSwBhmCJGPsHo71KSu2/cZ
         2hNAI3ELAsZ7B6fguemHuJaSg+0Knr5H4oOrtRVSqrZKp4/n1FdLbIuaoXJ5iR8OUAym
         fzZoCjsIVYZ4YYqQ3zlIwYy3T850r0MYCd9rs9CINEiLSvDSJWHVWaKp4NR5REUv17Ug
         vFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751700918; x=1752305718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipNd1HQQ2Ma2pisa7/gO96wA/WYXb5+4l3FrYAWC8qA=;
        b=USJ3xJr4a54L3wJagPdLieayZmPjx59BGiHfxxFjSxJOhJbjZzsDJWuxW2GvCBqlYH
         mJ9q5VeNAhbKaAXtdPLqz1l7jMFXHv9PRVhaVXrmXLNbbUwzpCK2Exmix3P35E096PiX
         RcX/Fz9Hlt0iCbeT2nYzItfw1BFeme2grQcQqmWIbwXptmQFQGzNnNc4+7D5w1+EkhZt
         aDtq6dKc1Tob9bpnHqjd4CujtNUg73EIiC88i+zpm9Y1BXr3YyqXUs36oc5HknFOqvrC
         SYQTg4IEKLIAjNi+D1kbGwKYqnaXR6ROhacXSZnHoMGEmdx2IKxszXXZY+OeDTbQtDEX
         obUg==
X-Gm-Message-State: AOJu0YzQCsdMsn/qTIbRVSHq+FAgShd82bm9GRrBnLkUfoO5U+txLoYa
	L7o+2tYet9EXlMvygMayHG0Vd1M6A4a9JFt29WZkg10eUGPkmYgwOUfbjtWGGwPX6Og=
X-Gm-Gg: ASbGncthFIMa7RlrCYddshDoiPSgG5tSe4/fqEAYNemDsJP0Py63i9sx6VbGlquWCF8
	gPoMnjoR3Uck5JfThDi30Qa1+9s8Fk0sEoFQD46I0mDejMZzQ7unVdHlNEyvsUT+A5xv9tghVs4
	LC6tycxPrjE+QEIzj481zwo3untfefcXqIOyODRKBqA5fX3FB7mH43qA350+fsE55eDqp1URdGf
	vqI535UkJApEbA4szceC7zVO2BMjP1UaJQHWFu/8h3944+tsE1yQ7etK2HIygAohpB/xaBBXOwo
	J/ZvIvimFK5qnsPDWpe4b0kTODQbuQZCBLHttdvZlS1GkM6z+fsWYD3dgTPeLX00tIWC9EDP3gd
	5Uw==
X-Google-Smtp-Source: AGHT+IFxMK52Ys26C4f3voCZTaLQ1Z4j/f7jjualB3g4BAkzo8LsAb43BYWlC0Jml4RwTMj13AKgTQ==
X-Received: by 2002:a05:6402:1611:b0:602:bfc6:f99d with SMTP id 4fb4d7f45d1cf-60ff3e20afdmr948476a12.24.1751700917862;
        Sat, 05 Jul 2025 00:35:17 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60feab9b483sm758267a12.22.2025.07.05.00.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 00:35:17 -0700 (PDT)
Date: Sat, 5 Jul 2025 09:35:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pwm: mediatek: Ensure to disable clocks in error path
Message-ID: <5v5u4nzvlryu5vqaihufqpkzd2v4xqhbdsgqgrxbj4r75oeu5c@sjtdsmjd7tqf>
References: <20250704172728.626815-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5hbbon3em7477z23"
Content-Disposition: inline
In-Reply-To: <20250704172728.626815-2-u.kleine-koenig@baylibre.com>


--5hbbon3em7477z23
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: mediatek: Ensure to disable clocks in error path
MIME-Version: 1.0

Hello,

On Fri, Jul 04, 2025 at 07:27:27PM +0200, Uwe Kleine-K=F6nig wrote:
> After enabling the clocks each error path must disable the clocks again.
> One of them failed to do so. Unify the error paths to use goto to make it
> harder for future changes to add a similar bug.
>=20
> Fixes: 7ca59947b5fc ("pwm: mediatek: Prevent divide-by-zero in pwm_mediat=
ek_config()")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

I applied this patch already to my next branch and will send it together
with
https://lore.kernel.org/r/20250704172416.626433-2-u.kleine-koenig@baylibre.=
com
to Linus next week.

I'm still accepting acks and reviews anyhow.

Best regards
Uwe

--5hbbon3em7477z23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmho1a4ACgkQj4D7WH0S
/k786wf/WU3raOHbDhvJS1ZL3utHhPXKLF/aFzrojFTP+stDBRrBRc3kKsyxUrfE
On/ZlJYNchwG1kTUh0i3kzgInRxvJTZADwkmsVuBjp9TTbMWVDywhJeQXDkF+r3Z
VbVDNnInWH2DytpwCoTPzppMtLzEk+UaKaboxHfL7t5izNKeuat4UXqHKX+C5i1s
45wZVhPeMFnzN6s8bqeLNGIbkl299gAqU/IgpgUYz/RhlrSKkfl+Wa3OXsuO+riK
O4xK6BXGwS4H5DOHpJXB8/5iagEoEJyWrk2mfDKw0yTxoLjSJfNbzINnHY+mNs3D
qJDLigEtxsN3ZNv+QkD90zYP+E5tHA==
=VHIx
-----END PGP SIGNATURE-----

--5hbbon3em7477z23--

