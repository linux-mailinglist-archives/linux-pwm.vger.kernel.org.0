Return-Path: <linux-pwm+bounces-642-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F50981D8C5
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Dec 2023 11:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF9328245F
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Dec 2023 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE63520F8;
	Sun, 24 Dec 2023 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="s/fRoIh8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46B23A8
	for <linux-pwm@vger.kernel.org>; Sun, 24 Dec 2023 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC7A73F741
	for <linux-pwm@vger.kernel.org>; Sun, 24 Dec 2023 10:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703414976;
	bh=T6CV/w/Oj4/yKhfarK+UEYWwoSl7TNmHch082+K72XA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=s/fRoIh8SY0TKT7w5PsksY/lcSI8UApq2MHVl8DyiQFRguc04FhM2gmwAcF2L2Wqr
	 maVTFHaZ8WlhYPCnsTHJSzSkKAk6M/mF/6qbwS8udCB69dW+ysX20SaQaBi7KlF/V+
	 7/2rK3KJSsZ0UH7Vh03wqWQh4PV3LGpf6Yatn9er5sHGnZ+tgaqDd8giffpzbdpnWu
	 dJyQ910RIv9vzqM4GWKoz9bGIRFi8EQTxzzGOf8dH2UuQv76aCnC4GcKviDr+B5X74
	 UeJexQqFxIX14gYoVZYSYd7A0NNakCaxgveR9p0uUkiiiQHA4qdqyP2SEBBpJH10t7
	 fcOxCrUkZ7Gsw==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-427cf4a843cso3929371cf.2
        for <linux-pwm@vger.kernel.org>; Sun, 24 Dec 2023 02:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703414975; x=1704019775;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6CV/w/Oj4/yKhfarK+UEYWwoSl7TNmHch082+K72XA=;
        b=Ta5KY7USmfJseHbjEvodo4GnYSVk4aumnPasuhaW+1rZLahBtdDrxZBGUyNlt+695K
         e7kYo9aWLhcp8AVn5jXJoxuDVzMTbvYTX8XOPbzANQoJ7nq/bzpc7VllHNvt0apAL3hh
         V4NDlXC9cTATPkY22XLQ6MrPPY6CF2BwggP//hSQoGdut7PUNyjmiq3ghlBSAzUGsH+m
         5VYijM5z7FkLDuW2zd439r3NJySbs7vdpVuEdqAs8tC0V3Gq1ZlsBIwJGff5A5JqiOZg
         O2GoAfba/U21EJxjMiOD2TyfsvmYHiJcrSopxWGiIzM8iB/4bSqNMW1bSDkdEs9Zly1O
         ojrQ==
X-Gm-Message-State: AOJu0YzIPCMw17LgWX3dFe5YpmtObVtIvfiu7SfI//eeY1tBjcyOMqyX
	s5PChUHoKWonVP+kJGYkE71sNRvpDxvbCuXiEudQygIgfPZ9AaH2HVgc1Z9VUNT1CoGa6diYnCs
	5pp7f4jZgVKaB2tk9m8xVeFFRsQsAf77GH5Dbai82OUWkhBZ1JVBMsFjmx0zZ
X-Received: by 2002:a05:622a:590:b0:425:4043:8d55 with SMTP id c16-20020a05622a059000b0042540438d55mr4267072qtb.112.1703414975521;
        Sun, 24 Dec 2023 02:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqn8DRlJOSAfcEfKAUiBJCl7hAhOpHxzVr7CqiVH5tkrER/1XMKIqe4ro6dC36GAEU2oObR93Kusddr00jIj4=
X-Received: by 2002:a05:622a:590:b0:425:4043:8d55 with SMTP id
 c16-20020a05622a059000b0042540438d55mr4267060qtb.112.1703414975298; Sun, 24
 Dec 2023 02:49:35 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 24 Dec 2023 02:49:34 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231222094548.54103-4-william.qiu@starfivetech.com>
References: <20231222094548.54103-1-william.qiu@starfivetech.com> <20231222094548.54103-4-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 24 Dec 2023 02:49:34 -0800
Message-ID: <CAJM55Z9tyrR7emEBrY0+Fnc_LUFQHkqYHLQ4ptL=XQMy52qtVw@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] riscv: dts: starfive: jh7100: Add PWM node and
 pins configuration
To: William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Hal Feng <hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"

William Qiu wrote:
> Add OpenCores PWM controller node and add PWM pins configuration
> on VisionFive 1 board.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

Sorry, I thought I already sent my review. This looks good.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7100.dtsi      |  9 +++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> index b93ce351a90f..11876906cc05 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> @@ -84,6 +84,24 @@ GPO_I2C2_PAD_SDA_OEN,
>  		};
>  	};
>
> +	pwm_pins: pwm-0 {
> +		pwm-pins {
> +			pinmux = <GPIOMUX(7,
> +				  GPO_PWM_PAD_OUT_BIT0,
> +				  GPO_PWM_PAD_OE_N_BIT0,
> +				  GPI_NONE)>,
> +				 <GPIOMUX(5,
> +				  GPO_PWM_PAD_OUT_BIT1,
> +				  GPO_PWM_PAD_OE_N_BIT1,
> +				  GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <35>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
>  	uart3_pins: uart3-0 {
>  		rx-pins {
>  			pinmux = <GPIOMUX(13, GPO_LOW, GPO_DISABLE,
> @@ -154,6 +172,12 @@ &osc_aud {
>  	clock-frequency = <27000000>;
>  };
>
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_pins>;
> +	status = "okay";
> +};
> +
>  &uart3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart3_pins>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> index e68cafe7545f..4f5eb2f60856 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -280,6 +280,15 @@ watchdog@12480000 {
>  				 <&rstgen JH7100_RSTN_WDT>;
>  		};
>
> +		pwm: pwm@12490000 {
> +			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
> +			reg = <0x0 0x12490000 0x0 0x10000>;
> +			clocks = <&clkgen JH7100_CLK_PWM_APB>;
> +			resets = <&rstgen JH7100_RSTN_PWM_APB>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		sfctemp: temperature-sensor@124a0000 {
>  			compatible = "starfive,jh7100-temp";
>  			reg = <0x0 0x124a0000 0x0 0x10000>;
> --
> 2.34.1
>

