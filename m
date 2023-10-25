Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96B47D6E50
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Oct 2023 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjJYNpu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Oct 2023 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjJYNps (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Oct 2023 09:45:48 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47F9191
        for <linux-pwm@vger.kernel.org>; Wed, 25 Oct 2023 06:45:45 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0EC503FD3B
        for <linux-pwm@vger.kernel.org>; Wed, 25 Oct 2023 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698241542;
        bh=+60nkze2sRRgfeFsZmoFML77ioPwo/jReraRdMDEs5A=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=D32IySDfcHOg9N18DpBJ6uTH4PMwR1cvd0q2Tuu1SOrLS+BZ59pnjYSkccZ2g4V7U
         tvgOw38BuXVSFDcchyhy/lbZGIBseBIkheFCgrgEdWK1lwT+NToxV4v24L4nR+YOe/
         fXVUwnmFvGGUT9CNMCTlQduu0F2zC/RWiyRIgYJE1DBf6bDmwI5A5HKPt47iXwGgM+
         ivnS0hjXvruTiOhW+UZj3I0OLyT7XMRJtfklvxv7Ct91RCgobJJ7YvY9aIQEGQmoz6
         OprX8ATcdk2kO6ebIdyagITi9z0aItEIdej4ndhzBa4E/c7OvdTOZfTAgkcu+fSAZw
         fMApW7kYXVOEA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cd433742dso73849041cf.2
        for <linux-pwm@vger.kernel.org>; Wed, 25 Oct 2023 06:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241540; x=1698846340;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+60nkze2sRRgfeFsZmoFML77ioPwo/jReraRdMDEs5A=;
        b=q9BBWCjQ2TuFjFNd2cfX3kQkEGlAR/9kHiEZXFlG311fjrsrxbPrmA83Xkmo09qNKK
         XK+UwZDDYK3ugoTfjoZFIFkGot1NJXs9PnsYV8bIPVoUHKopLKrrDjKc/masPRYRpoho
         5mCuMltB4YTYQ2my8nuDGyI2jY22wFZoHpQUjtjIdO6HA8VoXGaiTCODe5QXZMp61p1H
         tgG4NApBmNFo1ZNhOxRFa2Z3O2rozSspbvzGSDLE0elcR0t9devGfxS0J0Yjh85JuH4+
         5PkSRUT+E3x2PUzl6EvbkKcMXMNVVjOK6pL8GvSU44UUMRVtVMniUK748unjftg/JcIN
         5mBw==
X-Gm-Message-State: AOJu0YycNTcfB4VLnKlK6GA4M1sTvVGb67+MKF92D/RaFh+w9+hyFauE
        JdIcYi01nYcckIErFW2FMK9BbGhYajGOdlG64UN5rxT2zCbv+L26RoHN6jBKu+fZW4CMGqk2YNl
        Y0A9jaZxuOdBvoZ6a8YAuPE2UY0i+XgSfuDkedwZJdCIWo+x2IbxsKQ==
X-Received: by 2002:a05:622a:546:b0:418:2242:7823 with SMTP id m6-20020a05622a054600b0041822427823mr19590888qtx.32.1698241540172;
        Wed, 25 Oct 2023 06:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOVt8UpkWDt9syG2uUYq+GKDBm1AQ/uLpT42Eg0N4uYLR9c2VyMtFdKW/1yQYgIadYQ81RXcVGJLbHiSFOWBI=
X-Received: by 2002:a05:622a:546:b0:418:2242:7823 with SMTP id
 m6-20020a05622a054600b0041822427823mr19590867qtx.32.1698241539921; Wed, 25
 Oct 2023 06:45:39 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Oct 2023 06:45:39 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231020103741.557735-4-william.qiu@starfivetech.com>
References: <20231020103741.557735-1-william.qiu@starfivetech.com> <20231020103741.557735-4-william.qiu@starfivetech.com>
Mime-Version: 1.0
Date:   Wed, 25 Oct 2023 06:45:39 -0700
Message-ID: <CAJM55Z9aR0rwK9CSyGw_YJP8VN5sKax1JH6bPEaiX_gjkE049g@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] riscv: dts: starfive: jh7110: Add PWM node and
 pins configuration
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

William Qiu wrote:
> Add OpenCores PWM controller node and add PWM pins configuration
> on VisionFive 2 board.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 22 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  9 ++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 12ebe9792356..63d16a6a4e12 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -268,6 +268,12 @@ reserved-data@600000 {
>  	};
>  };
>
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_pins>;
> +	status = "okay";
> +};
> +

Hi William,

I just noticed this node reference is out of order. The references should be
sorted alphabetically.

/Emil

>  &spi0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&spi0_pins>;
> @@ -402,6 +408,22 @@ GPOEN_SYS_SDIO1_DATA3,
>  		};
>  	};
>
> +	pwm_pins: pwm-0 {
> +		pwm-pins {
> +			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
> +					      GPOEN_SYS_PWM0_CHANNEL0,
> +					      GPI_NONE)>,
> +				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
> +					      GPOEN_SYS_PWM0_CHANNEL1,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <12>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
>  	spi0_pins: spi0-0 {
>  		mosi-pins {
>  			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index e85464c328d0..4024165d4538 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -736,6 +736,15 @@ spi6: spi@120a0000 {
>  			status = "disabled";
>  		};
>
> +		pwm: pwm@120d0000 {
> +			compatible = "starfive,jh71x0-pwm";
> +			reg = <0x0 0x120d0000 0x0 0x10000>;
> +			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
> +			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		sfctemp: temperature-sensor@120e0000 {
>  			compatible = "starfive,jh7110-temp";
>  			reg = <0x0 0x120e0000 0x0 0x10000>;
> --
> 2.34.1
>
