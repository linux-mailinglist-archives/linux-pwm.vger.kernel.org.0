Return-Path: <linux-pwm+bounces-5976-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A3DAB6416
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 09:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEC51B6224A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF461FF7B0;
	Wed, 14 May 2025 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="OJBazy+c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81420298A
	for <linux-pwm@vger.kernel.org>; Wed, 14 May 2025 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747207331; cv=none; b=s3gli0sB8sJxtFWbHxAukV+DgylLuasUONWSAP0tHQlayIaGW7Vqp3Ohr7tUQ9Gxcq+GGiEaDQkHY0l3TzlJUyFIYkUeNQGqJrRD310kupBTp0x46Z2xb8jSWRb+enhDzckL/HzjFJhNGJMYZOX1ILqhgK8tesJjCUgCPbruYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747207331; c=relaxed/simple;
	bh=xsIXzxcogPEj7WI1OQx1l9ITv7ODZeAyB0f4aMhmg0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOalvROUb2v3Dvv6790HCks0vNq/UrV3MyOppG/lontP9zaicCZslOx/yfaEmjbO2ws0zuNxcRBP+iwqC/+sTmhJ5/jdj2jWt46py8U4Wt02XgUo7v0afYuq9WNU1JME214Jym8lId2kQ37eX/GiXSITnMtkLJnzZ+7uFPkRFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=OJBazy+c; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acbb85ce788so1237279966b.3
        for <linux-pwm@vger.kernel.org>; Wed, 14 May 2025 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1747207327; x=1747812127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcbw5sLrHE1qbiw4ucHwavhVf9qACz67c1w54poiYio=;
        b=OJBazy+c3+gEW5HW4kB/WltiOBKafN68yV1O4L8vwACBYd26ud99VGXZPIxIQcocKt
         /Ex5DKanYGbYSrqz+G3NYcdm1SS94pkXfrj57y8WflSHslm5V3oiHYtkdKVx2ikuTNiI
         Hwo7DhqTkVTS8i6VURaZWKuBGEW8kYfVqLa7UQ+BpqQXYnLzObqTWaOK5wRsRiaNtwIK
         dqEf/7OjGLlgxQEyZW7GKkKnz3o91LsJg0aBylI3ijscxPW3GtmRUhEiPjroNO8au4It
         MwxIP82yFosa4fGK3MAJ48iB6sx8oN492j29U3J64RHwqQSOMSAaH1NVyokLeM9/DWZk
         uXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747207327; x=1747812127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcbw5sLrHE1qbiw4ucHwavhVf9qACz67c1w54poiYio=;
        b=RmDMqDJis2BIXxfg/sCRnS3QjY6Ow6hJUXUJsmV4dYpMs6/ErycwHspPsGetUTo/UU
         DngfksV14zN9/7HtaZy1b4e5yU3Ow9zndK31UlqJ0LkPHCfzrwYTiHzYAdLuJfxuGfvT
         m752egRzliP2zlxK//II3IrGl6xCMFViOeAGqyVc5K8yvw18S/O5XI2CCrf8sYdBkUUo
         ayNyxRuow7qlw5gJ/8XVYHtgo30tHO0saedQ/gTfBlWrEmq+W/V6uOK28ibwqyAVB5Xr
         5NHa9FryUdArmHnMIrkaefghazAFtd+TckF05ywoQ3An0Y/SHSkY+6iilP3ySgtd75Bg
         A9/g==
X-Forwarded-Encrypted: i=1; AJvYcCW9KlwKwLmmtN6Dqmdf0H4oURI8jo9VbVuFcvI46Q/6OuNGUueNx7g/sO/3bWM0MGtRehKLfAsqw7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQOELGTXWLuXVApK2p6uEngG/tNJT20OTMl9Kfz1yfMZZUSQZ
	Pa1n3ResXNU5In/NSGJCmviHOrqdx3rCOE2AXKwolcwm1lcJeHQ6HoSvJcWb20537BxmJETar8G
	JS22vOBYHSxwZcnULLTsfkV/54wg+6UWwKvZUQA==
X-Gm-Gg: ASbGnctkPa41eU2x+rsH9r2BHoY5w4RUJ2QOrE0yzw3gBeeW5hpuBne+Q/jDP+7nCY1
	yW9gzuJmVlCcyM4ENjnjkIxRCa43LqQ6OqQ8RFNwYySuCg7FiIG/2rp8BZWkTFoHRoHOhxhp4Yh
	GANUlqjbDhuxVyAikcvzbsm/blwvhY9I8=
X-Google-Smtp-Source: AGHT+IHqsMqx3BaDCWn45qMLaOEYvPW7XUqjv7SdJvzZ3hWp+AKyoxb4KrcmHMVJwGZocnpesHw3un4CM8pfyBJnatc=
X-Received: by 2002:a17:907:7f94:b0:acb:b1be:4873 with SMTP id
 a640c23a62f3a-ad4f70f6129mr261521866b.2.1747207326486; Wed, 14 May 2025
 00:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429085048.1310409-1-guodong@riscstar.com>
In-Reply-To: <20250429085048.1310409-1-guodong@riscstar.com>
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 14 May 2025 15:21:53 +0800
X-Gm-Features: AX0GCFscwF3i-VATg9tXixD2-TDlOGgy-oyXk_jgaiYVherKFdQgiFo0yj7WIAw
Message-ID: <CAH1PCMai91WjooaF8HzY=rJWpFT4Drnx7fcs4+NCsLT4pGEKUA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] pwm: Update PWM_PXA driver for SpacemiT K1
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, conor+dt@kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, alex@ghiti.fr, Yixun Lan <dlan@gentoo.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, drew@pdp7.com, Inochi Amaoto <inochiama@gmail.com>, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, 
	hal.feng@starfivetech.com, unicorn_wang@outlook.com, duje.mihanovic@skole.hr, 
	heikki.krogerus@linux.intel.com
Cc: Alex Elder <elder@riscstar.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, All

On Tue, Apr 29, 2025 at 4:51=E2=80=AFPM Guodong Xu <guodong@riscstar.com> w=
rote:
>
> This patchset adds support for the SpacemiT K1 SoC in the PWM_PXA driver
> and updates related device tree bindings. The changes enable PWM
> functionality on the K1 platform through driver enhancements,
> configuration updates, and device tree additions.
>

Gentle ping, any comments or concerns on this patchset?
Any feedback would be greatly appreciated.

Thanks in advance!
Best regards,
Guodong

> Functionality has been verified on the Banana Pi BPI-F3 board using PWM14=
,
> configured as a pwm-backlight. Per community feedback, the actual
> pwm-backlight node is not included in this patchset but can be found in
> patch 7 of the v1 series, with modification of pwms property to 4-cell
> format to match updated binding (#pwm-cells =3D <3>) since v3.
>
> +               pwms =3D <&pwm14 0 2000 0>;
>
> This patchset is based on [spacemit/for-next]
>   base: https://github.com/spacemit-com/linux for-next
>
> Plus the following dependencies:
> 1. Clock controller driver, posted by Heylen Chu (v8), with most of it ha=
s
>    been accepted:
> https://lore.kernel.org/all/20250416135406.16284-1-heylenay@4d2.org/
> 2. Reset controller driver, posted by Alex Elder (v5):
> https://lore.kernel.org/all/20250418145401.2603648-1-elder@riscstar.com/
>
> Major differences between v3 and v2:
>  - Patch 1:
>     - Added: Reviewed-by: Rob Herring (Arm) <robh@kernel.org> # v2.
>     - When compatible string contains "spacemit,k1-pwm",
>       #pwm-cells must be 3.
>  - Patch 2:
>     - Dropped the addition of a reset_control field to struct pxa_pwm_chi=
p.
>     - Using a local variable in pwm_probe() instead.
>  - Patch 3:
>     - In k1.dtsi, changed #pwm-cells =3D <1> to <3>.
>
> Major differences between v2 and v1:
>  - Dropped the addition of spacemit,k1-pwm as a compatible string in the
>    PWM_PXA driver; instead, it now falls back to marvell,pxa910-pwm.
>  - Removed pinctrl settings for all PWM nodes (pwm0-pwm14); only the
>    pwm14_1 configuration is included in this version.
>  - Changed PWM_PXA from built-in to a loadable module (=3Dm) in the
>    riscv defconfig.
>
> v2 consists of the following patches:
> Patch 1: Add spacemit,k1-pwm compatible string (with fallback to
>            marvell,pxa910-pwm) and support optional resets property.
> Patch 2: Add reset controller support to the PWM_PXA driver.
> Patch 3: Add device tree nodes for all 20 PWM instances on K1.
> Patch 4: Add pinctrl settings for PWM14.
> Patch 5: Add ARCH_SPACEMIT dependency to the PWM_PXA Kconfig entry.
> Patch 6: Enable PWM and PWM_PXA in riscv defconfig for SpacemiT K1.
>
> v2:
> https://lore.kernel.org/all/20250420070251.378950-1-guodong@riscstar.com/
>
> v1:
> https://lore.kernel.org/all/20250411131423.3802611-1-guodong@riscstar.com=
/
>
> Best regards,
> Guodong Xu
>
> Guodong Xu (6):
>   dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K1 PWM support
>   pwm: pxa: add optional reset control
>   riscv: dts: spacemit: add PWM support for K1 SoC
>   riscv: dts: spacemit: add pwm14_1 pinctrl setting
>   pwm: Kconfig: add depends on ARCH_SPACEMIT to PWM_PXA
>   riscv: defconfig: Enable PWM support for SpacemiT K1 SoC
>
>  .../bindings/pwm/marvell,pxa-pwm.yaml         |  35 +++-
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |   7 +
>  arch/riscv/boot/dts/spacemit/k1.dtsi          | 180 ++++++++++++++++++
>  arch/riscv/configs/defconfig                  |   2 +
>  drivers/pwm/Kconfig                           |   2 +-
>  drivers/pwm/pwm-pxa.c                         |   7 +
>  6 files changed, 225 insertions(+), 8 deletions(-)
>
>
> base-commit: cb9c3aeae509b36afbdf46942a7a0a0dfc856ce7
> prerequisite-patch-id: a5d2fb43fd88525fa6c8ee767c31adfee87f1012
> prerequisite-patch-id: 8a8d0eefd0b4423d87f3c093b451a0fa60622ec4
> prerequisite-patch-id: 30f92f93e5b3577bde61424303f21c709a715ec5
> prerequisite-patch-id: d774b8281b5c6a822445365ee94925e1ab6c7a93
> prerequisite-patch-id: 54a4f5d065eb9f212fd99efec6e7e06abbb9bad8
> prerequisite-patch-id: 93962be60d1b58a98d947edf51b4af9edf513785
> prerequisite-patch-id: 5f53f8bf16fb067628092daebc4831293261aa01
> --
> 2.43.0
>

