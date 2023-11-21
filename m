Return-Path: <linux-pwm+bounces-124-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A27F353E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 18:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D3EB21A14
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254120DE6;
	Tue, 21 Nov 2023 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGIlfsuW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE909D56
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 09:48:40 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso5542953b3a.2
        for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 09:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700588920; x=1701193720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAK/ItuSDRPVMNR15AwNhdUvFP+x071LcAQ3w3yTJs0=;
        b=kGIlfsuWV9pc67/zTpkfc8YdnXt2hAE3qr+ewTild/gLqpQ9CS9/PsmFolWYr0Re20
         baGlZQTup9TPCYqBz2blkdq7pSK2JrFq6643iRt+jfyw1R/jU798ExGNdjQXWkJtUOc+
         qJnOczBjgR6QdFJFMGCdoA+BEVkKXTRoWaMW/G4wWJimH1PmmJllb4EBPaJ4HdT/rB3w
         feCv3oNiWOGIeuLqszBBQ/1EzYEuPo6unTnYDCBMkMCP5apxWosN8AjWCGqNfRhObimy
         uOPX0fJ8KpyF0HfQ+M4Ub5D875vEt23/jIXPzBu9mL0he8lpXtR+EGB8ZiIM5FrlHbli
         Pprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588920; x=1701193720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAK/ItuSDRPVMNR15AwNhdUvFP+x071LcAQ3w3yTJs0=;
        b=Bx48JQXom7CX35EtdQBXDxVKpb885f2VG98BsnbOU/I9BOsRDrBKHsmf5bmkSAEgAN
         6FcjQTzsiG/FmmRPP/bSi4LYuxpr9/uwe0byCyVgEtMcxEZh11+bL6A7c3pg9T5J4o44
         +oZszV59fWMML7E/OtteJMtghI0VgRrUZ/uItXLaacswZ/gxnUDwjSJTAIyW0w1C1Gkk
         +wc68yO6etqL+kK8jGTk/TiyKy/cPNMqzQvbLBW32rSDwbYeu7ZSzxaldYptdMoecf/V
         ngfgB/sCkJfd4BnNR7TsF9YTKScgK6QFPRKj0MvIn9wxvvAvLTR9bhATfNyGKNoqle4D
         mL2A==
X-Gm-Message-State: AOJu0YzoPo2X2xur3GhTG50vm0CdXoGghGabt1p7q5ZCLdz/8N3+21L/
	DQEzenpONYPvScSf5r9cI5P74O7Vl/JYAB2ZV/uZlQ==
X-Google-Smtp-Source: AGHT+IGsVYAziCjXoCBHiftycTLKlFRj+F3xZDSfXKxIguYqxWX7xqT/er/I16AqY0h4UFWzZ5qHqodRZyjJQpRXSA8=
X-Received: by 2002:a05:6a20:4306:b0:187:5be4:67e2 with SMTP id
 h6-20020a056a20430600b001875be467e2mr16406256pzk.53.1700588920073; Tue, 21
 Nov 2023 09:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org> <20231108104343.24192-17-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231108104343.24192-17-krzysztof.kozlowski@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 21 Nov 2023 11:48:29 -0600
Message-ID: <CAPLW+4nkrMwc9GiQyn7ojaPz_50NQ3vAcMt9+tOzpHfq7G7+Tg@mail.gmail.com>
Subject: Re: [PATCH 16/17] arm64: dts: exynos850: add specific compatibles to
 several blocks
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaehoon Chung <jh80.chung@samsung.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-serial@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 4:44=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Exynos850 reuses several devices from older designs, thus historically
> we kept the old (block's) compatible only.  This works fine and there is
> no bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
>
> Add compatibles specific to Exynos850 in front of all old-SoC-like
> compatibles.  This will also help reviews of new code using existing
> DTS as template.  No functional impact on Linux drivers behavior.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  arch/arm64/boot/dts/exynos/exynos850.dtsi | 34 +++++++++++++----------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/=
dts/exynos/exynos850.dtsi
> index 53104e65b9c6..df5ea43ebcad 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> @@ -396,7 +396,7 @@ pinctrl_aud: pinctrl@14a60000 {
>                 };
>
>                 rtc: rtc@11a30000 {
> -                       compatible =3D "samsung,s3c6410-rtc";
> +                       compatible =3D "samsung,exynos850-rtc", "samsung,=
s3c6410-rtc";
>                         reg =3D <0x11a30000 0x100>;
>                         interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> @@ -406,7 +406,8 @@ rtc: rtc@11a30000 {
>                 };
>
>                 mmc_0: mmc@12100000 {
> -                       compatible =3D "samsung,exynos7-dw-mshc-smu";
> +                       compatible =3D "samsung,exynos850-dw-mshc-smu",
> +                                    "samsung,exynos7-dw-mshc-smu";
>                         reg =3D <0x12100000 0x2000>;
>                         interrupts =3D <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells =3D <1>;
> @@ -419,7 +420,7 @@ mmc_0: mmc@12100000 {
>                 };
>
>                 i2c_0: i2c@13830000 {
> -                       compatible =3D "samsung,s3c2440-i2c";
> +                       compatible =3D "samsung,exynos850-i2c", "samsung,=
s3c2440-i2c";
>                         reg =3D <0x13830000 0x100>;
>                         interrupts =3D <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells =3D <1>;
> @@ -432,7 +433,7 @@ i2c_0: i2c@13830000 {
>                 };
>
>                 i2c_1: i2c@13840000 {
> -                       compatible =3D "samsung,s3c2440-i2c";
> +                       compatible =3D "samsung,exynos850-i2c", "samsung,=
s3c2440-i2c";
>                         reg =3D <0x13840000 0x100>;
>                         interrupts =3D <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells =3D <1>;
> @@ -445,7 +446,7 @@ i2c_1: i2c@13840000 {
>                 };
>
>                 i2c_2: i2c@13850000 {
> -                       compatible =3D "samsung,s3c2440-i2c";
> +                       compatible =3D "samsung,exynos850-i2c", "samsung,=
s3c2440-i2c";
>                         reg =3D <0x13850000 0x100>;
>                         interrupts =3D <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells =3D <1>;
> @@ -458,7 +459,7 @@ i2c_2: i2c@13850000 {
>                 };
>
>                 i2c_3: i2c@13860000 {
> -                       compatible =3D "samsung,s3c2440-i2c";
> +                       compatible =3D "samsung,exynos850-i2c", "samsung,=
s3c2440-i2c";
>                         reg =3D <0x13860000 0x100>;
>                         interrupts =3D <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells =3D <1>;
> @@ -471,7 +472,7 @@ i2c_3: i2c@13860000 {
>                 };
>
>                 i2c_4: i2c@13870000 {
> -                       compatible =3D "samsung,s3c2440-i2c";
> +                       compatible =3D "samsung,exynos850-i2c", "samsung,=
s3c2440-i2c";
>                         reg =3D <0x13870000 0x100>;
>                         interrupts =3D <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells =3D <1>;
> @@ -485,7 +486,7 @@ i2c_4: i2c@13870000 {
>
>                 /* I2C_5 (also called CAM_PMIC_I2C in TRM) */
>                 i2c_5: i2c@13880000 {
> -                       compatible =3D "samsung,s3c2440-i2c";
> +                       compatible =3D "samsung,exynos850-i2c", "samsung,=
s3c2440-i2c";
>                         reg =3D <0x13880000 0x100>;
>                         interrupts =3D <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells =3D <1>;
> @@ -499,7 +500,7 @@ i2c_5: i2c@13880000 {
>
>                 /* I2C_6 (also called MOTOR_I2C in TRM) */
>                 i2c_6: i2c@13890000 {
> -                       compatible =3D "samsung,s3c2440-i2c";
> +                       compatible =3D "samsung,exynos850-i2c", "samsung,=
s3c2440-i2c";
>                         reg =3D <0x13890000 0x100>;
>                         interrupts =3D <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells =3D <1>;
> @@ -640,7 +641,8 @@ usi_hsi2c_0: usi@138a00c0 {
>                         status =3D "disabled";
>
>                         hsi2c_0: i2c@138a0000 {
> -                               compatible =3D "samsung,exynosautov9-hsi2=
c";
> +                               compatible =3D "samsung,exynos850-hsi2c",
> +                                            "samsung,exynosautov9-hsi2c"=
;
>                                 reg =3D <0x138a0000 0xc0>;
>                                 interrupts =3D <GIC_SPI 193 IRQ_TYPE_LEVE=
L_HIGH>;
>                                 #address-cells =3D <1>;
> @@ -668,7 +670,8 @@ usi_hsi2c_1: usi@138b00c0 {
>                         status =3D "disabled";
>
>                         hsi2c_1: i2c@138b0000 {
> -                               compatible =3D "samsung,exynosautov9-hsi2=
c";
> +                               compatible =3D "samsung,exynos850-hsi2c",
> +                                            "samsung,exynosautov9-hsi2c"=
;
>                                 reg =3D <0x138b0000 0xc0>;
>                                 interrupts =3D <GIC_SPI 194 IRQ_TYPE_LEVE=
L_HIGH>;
>                                 #address-cells =3D <1>;
> @@ -696,7 +699,8 @@ usi_hsi2c_2: usi@138c00c0 {
>                         status =3D "disabled";
>
>                         hsi2c_2: i2c@138c0000 {
> -                               compatible =3D "samsung,exynosautov9-hsi2=
c";
> +                               compatible =3D "samsung,exynos850-hsi2c",
> +                                            "samsung,exynosautov9-hsi2c"=
;
>                                 reg =3D <0x138c0000 0xc0>;
>                                 interrupts =3D <GIC_SPI 195 IRQ_TYPE_LEVE=
L_HIGH>;
>                                 #address-cells =3D <1>;
> @@ -738,7 +742,8 @@ usi_cmgp0: usi@11d000c0 {
>                         status =3D "disabled";
>
>                         hsi2c_3: i2c@11d00000 {
> -                               compatible =3D "samsung,exynosautov9-hsi2=
c";
> +                               compatible =3D "samsung,exynos850-hsi2c",
> +                                            "samsung,exynosautov9-hsi2c"=
;
>                                 reg =3D <0x11d00000 0xc0>;
>                                 interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL=
_HIGH>;
>                                 #address-cells =3D <1>;
> @@ -778,7 +783,8 @@ usi_cmgp1: usi@11d200c0 {
>                         status =3D "disabled";
>
>                         hsi2c_4: i2c@11d20000 {
> -                               compatible =3D "samsung,exynosautov9-hsi2=
c";
> +                               compatible =3D "samsung,exynos850-hsi2c",
> +                                            "samsung,exynosautov9-hsi2c"=
;
>                                 reg =3D <0x11d20000 0xc0>;
>                                 interrupts =3D <GIC_SPI 63 IRQ_TYPE_LEVEL=
_HIGH>;
>                                 #address-cells =3D <1>;
> --
> 2.34.1
>

