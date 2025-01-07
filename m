Return-Path: <linux-pwm+bounces-4549-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB95A041C0
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 15:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E7C7A26E0
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119DD1F2363;
	Tue,  7 Jan 2025 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pybg/ajI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51061F0E2A;
	Tue,  7 Jan 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258745; cv=none; b=YddYkDBoyH7kXeUZ0fPlzco575mcUswAwLg8KPOleS+fLYdnjo7hz0fntO/KjJ4y3W+nuiVcwh0x4vCCNHuSEMT3upnemsj5D12gTUF6/UyXspb89rs39hFcyynumriAYCWqS3OqcNiszi+qgubWD2jhQHRX0Pn2HUBrbfDkxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258745; c=relaxed/simple;
	bh=ogDvQuxZCfNt1Ru7I9JPhd99nAVbLXq1Mqqm/59cazg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H2pYB79dfp4+sWxnpXYDIsTtIy18vUfyCP4dJ/oDZcTr1imQ0KW2aJTYrZ+b+ZsvrzHEY2wVtBItTcoqtuRyV8OavrvfMGZBdrRh4F/BH8NA4OwlIENVVSK8jDYaMsFcIIyqjqytMc6BDmDaujb+cbKKkmc9WmQPkl8ClXQiwxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pybg/ajI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso157962475e9.1;
        Tue, 07 Jan 2025 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258740; x=1736863540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogDvQuxZCfNt1Ru7I9JPhd99nAVbLXq1Mqqm/59cazg=;
        b=Pybg/ajIESOYB8uohnhST5mIokHlU6QBt3KqgVncEG+v9kRnVcw444T6FaQF0WEOzN
         4gdQ3w/Ux3ba0b2d4Oi5r7cDRdLwaLVWWPHI6/hi4KSzJWg1gkEU0+SOobRwzVJAMOXk
         7uFsPmMzFrTKko4Z+LUTY9PTckMpu0lHybCwDNxpLMoNd3Aet2yOI8efy1pCfkIXaBBL
         yrAFtGYGJ+6IX1XUKL9kUqSyk77kvXhuTK+oz07SGdmTmWUeWwvryEjDJy92Y6DaEuDV
         cgY+ErySQ3jzrc+uGNFH0rIRDW9bxyyt+v9DJ/z8e+IzW/LK+NnJMGmMxuPUqSxEshvs
         HWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258740; x=1736863540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogDvQuxZCfNt1Ru7I9JPhd99nAVbLXq1Mqqm/59cazg=;
        b=G3TvGHr1rwidC+xF8n/6rOwGsJhYe1WbfOHfHSvZi8/nyWbV/zUQK4UCt+FMgQYgd/
         RbmOaj2IYMtvJsT1aZQh/Bbe1ZcSwt5sC+q3zppwbptzfk9sBI9r5tFdVD9DQg1VEOIN
         dKNCjOA13wAMX2tvN9c5jXjFsGbL/U53+ozFEuWEkeFZZLmwSGD7Xn7Cms45WUcP+7s3
         loUmoLOxe/F4qrIxKtLA8kiz+44PuxGUq1zTqpVRmew3Bf0+9W8m7OwQMEKmZXauiTQY
         xa7IFdq1INr327KQTB6+v6m0PixiNhTu+G27XMTDbpbU5D04d8MUqVWe0iRvAcb6tQYr
         6tLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFfASg1iy82hMmsIhEO9QRVjt2NLGJ5ZzFVHvdiulZLQSCKl+ZUu5GnrjNJYFJ8tFJ6ecTkS/FW6VB@vger.kernel.org, AJvYcCVlt5h5K5Whs0BkswQzEbgIU8PxaCmCk7TrgZXbmEOo6M13PM1ZmztTrrMlyGmuJI5Ds+l6BEmYeY6T@vger.kernel.org, AJvYcCXw7S4duM0hUJpdRmCWbsShYM+g2FdHtNTl1hb6lOCcsixPXOfZQtwayXrCgI6T8Canf9fUnqHHcZuxHNDs@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkizhsJyeGyGxPdU7875NpUHOreXFESDqSITadw2rMtT6B5+k
	QosFEihZxXcdHd5K2dJslKd0A5mCzPa0e8WZnUu+4HYcTCeKImVNpLlViOHt6o0=
X-Gm-Gg: ASbGncuLKHFYqmPQE3ZWReHnwygnxHJEeTRjIZa/Ldvd6IYYAtG7eYBK+ObcYdnRESK
	husLDAoM4zqUHqCH61tsFIQPrs71CkjY/wdj1i4aawIySc11N3arRTtrl3iZUxjF2K6dqE1Uvsb
	mKyMpmCg+WzsqokEwgupINesz44S54WcL5MNqdPb4pfzck08irDGy6N+9alfIlcqA0MIig/lli3
	Ch8Vcxj97Y7lSHpFT7JvRfoOYY/ab5Qo1Ux9VzS+3oSub+Bcf+3cPXTeT5BPYcMuzcHU2Zd2o/z
	XMvzmcaVpYRXR8QMiTYDLPzxR4S/
X-Google-Smtp-Source: AGHT+IFfnR028agDjwlWikAvh1/VvkkB81kquDbtSxlA/ds53ntX4cuO1Pb8zCXNAsdBuSSK5XCcsA==
X-Received: by 2002:a05:6000:4612:b0:385:df5d:622c with SMTP id ffacd0b85a97d-38a221f36e3mr46390632f8f.30.1736258739438;
        Tue, 07 Jan 2025 06:05:39 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8ace0esm49742230f8f.106.2025.01.07.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:05:39 -0800 (PST)
Message-ID: <bc6a76d6e59c0271bf907cd2cf6dd3c03cc59c2e.camel@gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: Correct indentation and style in DTS
 example
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Trevor Gamblin <tgamblin@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 07 Jan 2025 14:05:37 +0000
In-Reply-To: <20250107125831.225068-1-krzysztof.kozlowski@linaro.org>
References: <20250107125831.225068-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-07 at 13:58 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
>=20
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 8 ++++-=
---
> =C2=A0.../devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
> =C2=A0Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml=C2=A0 | 8 =
++++----
> =C2=A03 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> index aa35209f74cf..45e112d0efb4 100644
> --- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> +++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> @@ -41,8 +41,8 @@ unevaluatedProperties: false
> =C2=A0examples:
> =C2=A0=C2=A0 - |
> =C2=A0=C2=A0=C2=A0=C2=A0 pwm@44b00000 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-pwmgen-2.00=
.a";
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44b00000 0x1000>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&spi_clk>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #pwm-cells =3D <3>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-pwmge=
n-2.00.a";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44b00000 0x1000>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&spi_clk>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #pwm-cells =3D <3>;
> =C2=A0=C2=A0=C2=A0=C2=A0 };
> diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
> b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
> index 119de3d7f9dd..44548a9da158 100644
> --- a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
> @@ -35,8 +35,8 @@ additionalProperties: false
> =C2=A0examples:
> =C2=A0=C2=A0 - |
> =C2=A0=C2=A0=C2=A0=C2=A0 pwm: pwm@f0408000 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "brcm,bcm7038-pwm";
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0xf0408000 0x28>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #pwm-cells =3D <2>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&upg_fixed>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "brcm,bcm7038-=
pwm";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0xf0408000 0x28>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #pwm-cells =3D <2>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&upg_fixed>;
> =C2=A0=C2=A0=C2=A0=C2=A0 };
> diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
> b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
> index e86c8053b366..fd785da5d3d7 100644
> --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
> @@ -43,9 +43,9 @@ examples:
> =C2=A0=C2=A0=C2=A0=C2=A0 #include <dt-bindings/clock/bcm281xx.h>
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 pwm@3e01a000 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "brcm,bcm11351-pwm",=
 "brcm,kona-pwm";
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x3e01a000 0xcc>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&slave_ccu BCM281XX_SLA=
VE_CCU_PWM>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #pwm-cells =3D <3>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "brcm,bcm11351=
-pwm", "brcm,kona-pwm";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x3e01a000 0xcc>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&slave_ccu BCM281=
XX_SLAVE_CCU_PWM>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #pwm-cells =3D <3>;
> =C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0...


