Return-Path: <linux-pwm+bounces-7819-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46CFCD4449
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Dec 2025 19:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B983007C6F
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Dec 2025 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B1D3090FE;
	Sun, 21 Dec 2025 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzfXdfh6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46CE23D7DB
	for <linux-pwm@vger.kernel.org>; Sun, 21 Dec 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766343176; cv=none; b=kYSA0YfUtLUzcZqKPfYpEiZd/LOVq18v/Z4gH3NkOQtTZZrEPYjo1FzpN6GOeWdfy88BqZiJ4WKbicbWUDJWDvriaghLTqU2Ejk4OC8v2wbHSvdvZefvA5aXdhmbT/wOGEWOhvcdLDqYsHjGySTGW6Yik13Qqxa7QtNh3Z1GTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766343176; c=relaxed/simple;
	bh=wTYyJ6KNs7lcO1LDw5mry706MHNd9SS12sadjX2FW+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLqDkEm80mYEnjxEbACYM4UgGER1Vf9vRqEsSHFlU1T15WSs5vt0LsqIsy9iMe2jqYZPitUbb2i4Dkvbj4lJTfijIs8KaEKZJ4VvujNon0S3X+eDS4iqYEqtOcr/w3dHxKl1kYxF/US9juUoOxrAZqVfBA0TYtN/0A5KDPLEsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzfXdfh6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so2718056f8f.0
        for <linux-pwm@vger.kernel.org>; Sun, 21 Dec 2025 10:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766343172; x=1766947972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkFUuskD3aXQcMoKgf00kBQMcF6mPoLg5bi7MGfjH3A=;
        b=KzfXdfh6NwIpnEQ4xNJnZZg+yOATN0UgK0sDOfv83+I7tzjFOsfhCiCOfWou024bSY
         EMD90GWxJYj22UpfJPEDq+7Sg2rowa9AVgDxPZ/udfGKvDRk3CRtfoXY3v3DtZBM12Td
         DIDYD4f5mgRF5XliMEgO5SoNHPQBgJWoO4YkU4Wdmf8SiMSYrdd/bvBIrKeA8MfzDcjf
         wz/8t9zs0Cb5Kbc3mCPBqqmsVtgg5MOJXuBQZk5THfpGDCePrZfr7T8J/YMIiQ6MvL0q
         5cV7C4bmeDJ4RCLxjRh1vmELDTuzCFUQt4lJukGsaW1HKDF5goh/KSCSN2c/Pl9fzt9d
         CQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766343172; x=1766947972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EkFUuskD3aXQcMoKgf00kBQMcF6mPoLg5bi7MGfjH3A=;
        b=IibHWXY4UL6EOgGPLo/p3HCDcyT31ONnskNOAmSpzDMnIl6WQJhzv0l8AeKV/7mCxv
         BOhgUieZaIqUDrnst/78arVF9DHCuxePqjRCoNi2uzsj1mRGs14tp+L/QkS7p2yN7iuP
         3GPDm5/epndbGR5D9gZ+DTrI88VhF+Xq0xH3ud9Iek9Ho4442N52FEeis7qwi3BXD22Q
         pWhzdV/oAHZTy59rsR93lbqOWaCql413j8/iu7YlbbFSmugbt4OXVYslaaDt3wGaRjb5
         lCfF4qt+p0NqFBDmmBg6BBOfsjw9Tmr1kjKjftMYRE4v7nMprPu/gO60ep9YBI/eKhsq
         9cjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmyNbQlCyZwVr70Kve86MWmjes1PYJyb6Fmc4NdBftER96wqCNOy5js3gz3s5BivY4jEk6PflOlmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOc7dQWJdOpt5zLyFTnsUN4tQG8s0+iQU8Lo9W5x9ip/BOlwF
	l78JWdn3BSreOD48ttugohjAlMosR/CVhVBZJ20iegoRTrt/l1EdHVJU
X-Gm-Gg: AY/fxX4LS+SiDjJtnHaVEbA6F23DWOb4EfCqNo2S1U2Ja2R/AGw+IHrVnXc+niB/0Dz
	1MiMzL/OCGCLB/06JvjGa79/ZsUnaUMAU8yvWD77p1v4yhxApUz8acdCMOlTHGQ1935EdkGAzl7
	XLiPl6A7EpjnDXYVA6DrB2CeWqyT3E79GT2Er8wJ/gTG5QmsuAsGKlKggQOtzoNKe5rFeANdtDQ
	kKcl8AgOunRsWv1SjLol2Mtfi09agWwF/AwDVOOpPHQvyASemjCipvu+G1rVsDTOykS41sTt1kX
	z83KFsq9NWv9vBnQh7RJh6c2iETNh/26DP6TRMEWpFCqBzbrTNLWP1BDX1zbGyvSoQA4pcB65Hc
	4eFcjmOW5dwmrC8Jcb0ReBIqFR1RKRJw6MyC0LT8bJOFfGRAMgLzRa2hjtCzeM9v/E+sjXg2NjG
	xkO0dtnJJ6Wufag3CJOJwpm0te/7obsjiahvSEMxwBoRrj6TY8S5UEOVkKPbcxOCo63lgQ
X-Google-Smtp-Source: AGHT+IEkkDr9J9+zdibSJ3aQ9iWL0xgIJ5GrJUheHH61EjSouzXE+O5/goeHQ+aazrE5IYrzxVO9HA==
X-Received: by 2002:a05:6000:4008:b0:430:f241:a11f with SMTP id ffacd0b85a97d-4324e4fa8a7mr8787306f8f.30.1766343171984;
        Sun, 21 Dec 2025 10:52:51 -0800 (PST)
Received: from jernej-laptop.localnet (82-192-45-213.dynamic.telemach.net. [82.192.45.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325d10cc48sm7775667f8f.16.2025.12.21.10.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 10:52:51 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject:
 Re: [PATCH v2 1/4] dt-bindings: pwm: allwinner: add h616 pwm compatible
Date: Sun, 21 Dec 2025 19:52:50 +0100
Message-ID: <10771871.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20251217082504.80226-2-richard.genoud@bootlin.com>
References:
 <20251217082504.80226-1-richard.genoud@bootlin.com>
 <20251217082504.80226-2-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 17. december 2025 ob 09:25:01 Srednjeevropski standardni =C4=8Da=
s je Richard Genoud napisal(a):
> Allwinner H616 PWM block is quite different from the A10 or H6, but at
> the end, it uses the same clocks as the H6; so the sun4i pwm binding can
> be used.
> It has 6 channels than can generate PWM waveforms or clocks if bypass is
> enabled.
>=20
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pw=
m.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> index 1197858e431f..4f58110ec98f 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -14,6 +14,9 @@ properties:
>    "#pwm-cells":
>      const: 3
> =20
> +  "#clock-cells":
> +    const: 1

Why #clock-cells? I don't see any reason to add it.

Other properties seem fine.

Best regards,
Jernej

> +
>    compatible:
>      oneOf:
>        - const: allwinner,sun4i-a10-pwm
> @@ -36,6 +39,7 @@ properties:
>            - const: allwinner,sun50i-h5-pwm
>            - const: allwinner,sun5i-a13-pwm
>        - const: allwinner,sun50i-h6-pwm
> +      - const: allwinner,sun50i-h616-pwm
> =20
>    reg:
>      maxItems: 1
> @@ -62,7 +66,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: allwinner,sun50i-h6-pwm
> +            enum:
> +              - allwinner,sun50i-h6-pwm
> +              - allwinner,sun50i-h616-pwm
> =20
>      then:
>        properties:
> @@ -83,6 +89,17 @@ allOf:
>          clocks:
>            maxItems: 1
> =20
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: allwinner,sun50i-h616-pwm
> +
> +    then:
> +      properties:
> +        "#clock-cells": false
> +
>  required:
>    - compatible
>    - reg
>=20





