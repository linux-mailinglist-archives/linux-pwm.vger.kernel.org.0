Return-Path: <linux-pwm+bounces-799-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E5882ECA8
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jan 2024 11:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0180F1C22F9C
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jan 2024 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63D134DA;
	Tue, 16 Jan 2024 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kpHNPqFe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F3134D5
	for <linux-pwm@vger.kernel.org>; Tue, 16 Jan 2024 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CAAA23F272
	for <linux-pwm@vger.kernel.org>; Tue, 16 Jan 2024 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705400459;
	bh=xU+S+uXFFj2cwv3uk43aNu2KbGErrv7KCMlpZ+iS0ZQ=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=kpHNPqFejZke64zOWf2zxi+lbiuNCMCJojW0Ct0GdDMO+82GoqKeG34bOH8oxcKqK
	 6My5kg/DyaEhpprQPMI7WVQ2LSGB6iIGFdld7SrlG30lCDPhGfhD2jL7k20ryjWXCK
	 czdIe8uq6lPuyU48nRCrsEhOKdySM/lcO86X4+1LPXnDYI9WpG6xRuxSyIck0Jz/na
	 P7ZtEsTF7Jrn+zx/0HNhBEosloaR0mcY6YUEfLh1FdUy2dOzWvvEzHT4gw8PdJCjon
	 IiOkT02FbqdFkzt4eSsnDUUWh9OvD+hzR1tIOS71JTqDgj6O5PPm78UfxdB0ACHxxZ
	 oL2Osk49yWyWQ==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-429ad752bb7so95549141cf.1
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jan 2024 02:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705400458; x=1706005258;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xU+S+uXFFj2cwv3uk43aNu2KbGErrv7KCMlpZ+iS0ZQ=;
        b=KsWBOhhhr9ssNG1hfm9f7DEHxByio/1HkxGLGy3eyyBa7P0yi1c2v+cLm64TcvvgEj
         j/G0rItWHPzNFPoKcDF01FHGyKTX9S5iMVM98il3hPT3ceqcS2peqoiphEBRPc1xyNrk
         OLylqT/gdOWSr3526sQbqRVKrRSBjpgZltH5FqNX7fugke9kN/TZmjU34iRTSGHTUxqj
         aiG48d88IG96FpWB9M2PuFEFrIgHgC3DqqClThMnmkyrDT7e2bR8xhGMeYSMsw4rZhoU
         4wI0ZY+FUzdAA6YZthldzEyicd8/7Ion/RkKZMYEusikz6suLuagKdFMNy4+jAc8+FFf
         GSVA==
X-Gm-Message-State: AOJu0YzXdbEmEhXfkGYu/vkJ0pdOduZXbdh54c1x9Rjd+VjLoUW1DbIo
	hhzVry1KmZjTOsmXkMHvhVU4kgJWHKbbTBpFnFl2MRNTRVfV59/hkwWBcHbK17FYgSjk9yh3yba
	LL5gDl8R/8bmc/sEEpApx/i20njAypuCTJ5bs8tXIzWFHyQSk92WA3ViYz4XV
X-Received: by 2002:a05:622a:314:b0:42a:9f3:f98f with SMTP id q20-20020a05622a031400b0042a09f3f98fmr59861qtw.31.1705400458724;
        Tue, 16 Jan 2024 02:20:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyHQK1zxeZizu8qJrW9Hsx4AGxq9c2N/E+5X7YH8Yr1ZSbWwOhH277LwZ3NAq14oAPDip5nwCUUFeB0BgriaE=
X-Received: by 2002:a05:622a:314:b0:42a:9f3:f98f with SMTP id
 q20-20020a05622a031400b0042a09f3f98fmr59852qtw.31.1705400458380; Tue, 16 Jan
 2024 02:20:58 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jan 2024 02:20:57 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240116041054.11641-2-nylon.chen@sifive.com>
References: <20240116041054.11641-1-nylon.chen@sifive.com> <20240116041054.11641-2-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 16 Jan 2024 02:20:57 -0800
Message-ID: <CAJM55Z9ZbmbPKaJ8LJ5KyoCW9fAEJaT3Q4PbcadwLNCq1NXbxA@mail.gmail.com>
Subject: Re: [v6 1/3] riscv: dts: sifive: unleashed/unmatched: Remove PWM
 controlled LED's active-low properties
To: Nylon Chen <nylon.chen@sifive.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, 
	u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com, 
	aou@eecs.berkeley.edu
Cc: zong.li@sifve.com, vincent.chen@sifive.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, nylon7717@gmail.com, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Nylon Chen wrote:
> This removes the active-low properties of the PWM-controlled LEDs in
> the HiFive Unmatched device tree.
>
> The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].
>
> Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf [1]
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Co-developed-by: Zong Li <zong.li@sifve.com>
> Signed-off-by: Zong Li <zong.li@sifve.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++----
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
>  2 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 900a50526d77..11e7ac1c54bb 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -49,7 +49,7 @@ led-controller {
>  		compatible = "pwm-leds";
>
>  		led-d1 {
> -			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> +			pwms = <&pwm0 0 7812500 0>;
>  			active-low;
>  			color = <LED_COLOR_ID_GREEN>;
>  			max-brightness = <255>;
> @@ -57,7 +57,7 @@ led-d1 {
>  		};
>
>  		led-d2 {
> -			pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> +			pwms = <&pwm0 1 7812500 0>;
>  			active-low;
>  			color = <LED_COLOR_ID_GREEN>;
>  			max-brightness = <255>;
> @@ -65,7 +65,7 @@ led-d2 {
>  		};
>
>  		led-d3 {
> -			pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> +			pwms = <&pwm0 2 7812500 0>;
>  			active-low;
>  			color = <LED_COLOR_ID_GREEN>;
>  			max-brightness = <255>;
> @@ -73,7 +73,7 @@ led-d3 {
>  		};
>
>  		led-d4 {
> -			pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> +			pwms = <&pwm0 3 7812500 0>;
>  			active-low;
>  			color = <LED_COLOR_ID_GREEN>;
>  			max-brightness = <255>;
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 07387f9c135c..b328ee80693f 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -51,8 +51,7 @@ led-controller-1 {
>  		compatible = "pwm-leds";
>
>  		led-d12 {
> -			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
> +			pwms = <&pwm0 0 7812500 0>;

Here you remove the active-low property, but you don't above. I'm not sure
what's the right thing to do, but I would have expected the same change in both
places.

/Emil

>  			color = <LED_COLOR_ID_GREEN>;
>  			max-brightness = <255>;
>  			label = "d12";
> @@ -68,20 +67,17 @@ multi-led {
>  			label = "d2";
>
>  			led-red {
> -				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
> +				pwms = <&pwm0 2 7812500 0>;
>  				color = <LED_COLOR_ID_RED>;
>  			};
>
>  			led-green {
> -				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
> +				pwms = <&pwm0 1 7812500 0>;
>  				color = <LED_COLOR_ID_GREEN>;
>  			};
>
>  			led-blue {
> -				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
> +				pwms = <&pwm0 3 7812500 0>;
>  				color = <LED_COLOR_ID_BLUE>;
>  			};
>  		};
> --
> 2.42.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

