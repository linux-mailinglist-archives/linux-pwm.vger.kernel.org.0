Return-Path: <linux-pwm+bounces-3953-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03FC9B43C1
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 09:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854B228382B
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 08:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6692036F8;
	Tue, 29 Oct 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o31f09ah"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F952036F2
	for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189267; cv=none; b=a4s1539w/+C1Wias07rE40aIMHOIKOcQmmYmDJaflSteIrfvc6uQnr5SdKkRYAVvoqPAvKXux0nYT9tGdaVIcRy7xP3Z7yIAIhPBC5vhUhFf71DbhEjP4MTXzh8WcMfSj1TSiexfre5KafKwmMupuQuGJC2io6S0Go9eW2Fi9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189267; c=relaxed/simple;
	bh=fz7RRww98aR7+TFIOi8xsXZBrEV8mkiqw5q+W3z+x50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwPo9sOiz481xgoslTH/XHt3oymyogCR+rustZGJhZE3BGR7e9IFPINbGdIDwkMeWyjhRGT4zw4I+dqwqh12rgzmV4ZBP9iKpL4S9rhxwYw1ypyY1TyQVy7k7GadxhdU1r3jUqMXXoP37cXTmNgnzSXCi5BTqjMxJqRnUDvQCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o31f09ah; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so51199475e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730189264; x=1730794064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fz7RRww98aR7+TFIOi8xsXZBrEV8mkiqw5q+W3z+x50=;
        b=o31f09ahPL7oxI9IqfM4TUH9Cfr7UOYTJD08MuVtiLA3JXRfEzDh5hy3FHJLbBpA60
         vf86cbt7KG9RVBfqrqoZRQzZ4QR9YzP6n8fAVRlA96ZIKOowsZr2GEfWR4pA0t97K72Z
         fFelNXsiXURzAp4+56pvnvSETaAGKhc2xaQED3YoAHpBJINQ6eDnXf0O/nvuTbH/0u+T
         Je7J8WPgLDLm/CEf1z3LFT4PK19UNojxCU7RMv0+qgMpCs09xK4f8tti6jueHvgXfcKT
         1M9N6gElthnzx7eVBF6/zo9wL02tFjI5JzWohS2xh+oCi0M/qLRp03AVvQiJa/WcvFa2
         23MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189264; x=1730794064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz7RRww98aR7+TFIOi8xsXZBrEV8mkiqw5q+W3z+x50=;
        b=Cb7SDwFHpJBOrKUz6pxoFFmAwTt4n/wKTkRC0xyZlu9L6KHciG8IO97E6YSZ0hx9Pw
         JMltAMLGLtwC5seeH2HtsvIZy/cI/FhsSnDoX7O3s0HxAZkP3s23CIWuwAYNGdZKWQ9n
         8OCAF4AhMAwRkYYGVvZJM2SowrImeBp32MrSVLko5Gbm7CCxxkokPv/zHprRseh8YacW
         UjatkQENfotoPJJvBQoi17yRsfSCMB4ZgCissGQC/wDeFNlwloqkSnme1bmUGVV1QnAE
         DwBZmsPw+yZUMMTcdAlh+OIO2jFU5U2U2YKF2tmvj4RRJE2nFCeuI/rP5XaQHui3RRbS
         RJkA==
X-Forwarded-Encrypted: i=1; AJvYcCWjhPzOO8NlEJtImyl41XKKpICgCgwIQIe1e8YO39ZqKzuhIJ2axDeK3YUPnID8ZXILXByUCujkDok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/A5dO1ey4laCq3FwNTCIaPCXsuoN9TkaoP2NESW1NzkS4nWK
	SfUevnpy8lOqjn4ZNP54ejQcDi1aDv2hxHoxhgh761HEEMqwFibRytnzxO1ykdc=
X-Google-Smtp-Source: AGHT+IHdtLAytGreUBiJVRVj0CzK2hX+LtTYIjY1HGXyXgeH85JAHHDcJqmfe2WqX6/D5uWSIjYTxg==
X-Received: by 2002:a05:600c:4f51:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-4319ad2d6aamr98759075e9.29.1730189264124;
        Tue, 29 Oct 2024 01:07:44 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9294dsm11699741f8f.105.2024.10.29.01.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:07:43 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:07:42 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, pratikmanvar09@gmail.com, francesco@dolcini.it
Subject: Re: [PATCH v3 2/3] pwm: imx27: Use clk_bulk_*() API to simplify
 clock handling
Message-ID: <zbtjpemahkpoabonf2td2i62qrlbb2xv7wlw3te752h6hgnsjm@ba7sdyqgbvms>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
 <20240910-pwm-v3-2-fbb047896618@nxp.com>
 <7kplk52i7e2nha5ym4loza5oc3lwghifjfk3aut24w3hjagfk3@zusb2naeaevw>
 <ZxfMZobFdBA7ffhU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bgnhgnnffifnsrec"
Content-Disposition: inline
In-Reply-To: <ZxfMZobFdBA7ffhU@lizhi-Precision-Tower-5810>


--bgnhgnnffifnsrec
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] pwm: imx27: Use clk_bulk_*() API to simplify
 clock handling
MIME-Version: 1.0

Hello,

On Tue, Oct 22, 2024 at 12:01:42PM -0400, Frank Li wrote:
> On Tue, Oct 22, 2024 at 08:53:40AM +0200, Uwe Kleine-K=F6nig wrote:
> > I applied just this patch to
> > https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/=
for-next
> > . The others are still under discussion, right?
>=20
> Yes, thanks. I think 32k is not necessary and need more research.

OK, thanks for confirming, I discard these from patchwork.

Best regards
Uwe

--bgnhgnnffifnsrec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcgl8wACgkQj4D7WH0S
/k6ehwf/fyJogWx9JiTzSrjVr39U4buCC6TCylJbTGIiYDJGRW71DmfsuQ1S8OP7
nsN41Lb2xbF4Gn0s1IgZph5+a47bIwqzDINtl7YJ6Zj4HuHMC3dDE6GNjCi7uHr7
JvWfImw8m0R9jvEPL25ukoSgqFNeBYJHYVssLk86hZWC4ffVePMXpTzGQNVgMxey
LsUqNa65gIVzdxzBETe7bE0qZeidDFssFVBBBT0AduDDbB3NGpD9lb0Qa7Du3V0T
4ci550yhekpPrtartCbPKvFb6cfcOvT/mOdNqhAM12F3g3WOnx8au/XT1TMgu6o8
A880c+BSCnfEAgpF9xctUfVlLQL8Ow==
=EBhu
-----END PGP SIGNATURE-----

--bgnhgnnffifnsrec--

