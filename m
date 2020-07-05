Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4FF214E64
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2020 20:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgGESNS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 5 Jul 2020 14:13:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37127 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgGESNS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 5 Jul 2020 14:13:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id a6so38399601wrm.4;
        Sun, 05 Jul 2020 11:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=weHUVg6eDRuIYzJUSwT20hFFOTaLh3Ab2q7bi5NEwVg=;
        b=e4fRkhgUkg0LUaU+j98/Kki1sIUihrkvjVeOYuH4RpJ2tUvZz8RSar5PoqHHPeDZfT
         7WlP55WPVsIo2QdSGbJ2MGZNhmlXhHHMPQRDN++jXuJmnjCoLvncH46pU0hMXOm4wKuj
         JWJyeVs34NC/B/54pyY+s3EQygWSI6x5nAGx7+rxFXm5jfEQIyrVt6zSQyz3br9aN6ue
         zgbBy39wguQCzt7Gp6j42NRRuYH+oqsAiQrrEx46ENwTaeKOqvrdx/gLW7wa4wMLWXru
         5z/ovrbU81HNIHWLwx3rQAZtdPpdi9q9b+5vI2Re4bemvpybDI4Tu9IPabOEtzojxMvA
         Vaow==
X-Gm-Message-State: AOAM532SGz+sn50mWaAj0Wztmt+PddiH3GoGAgsmgcsdNSc5mECIdANu
        ioHzMOHRTLJ+IwwyCi3TvPI=
X-Google-Smtp-Source: ABdhPJwzAAZIoa0Oy6M6sME9NpyTTqSGnpPGmpWLf/ydf9WThHEur1M9tx3hbKGIiOMrU1aaoqGUYQ==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr45022015wrs.365.1593972795430;
        Sun, 05 Jul 2020 11:13:15 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id l132sm21031246wmf.6.2020.07.05.11.13.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Jul 2020 11:13:14 -0700 (PDT)
Date:   Sun, 5 Jul 2020 20:13:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v2 5/8] ARM: dts: exynos: Remove DMA controller bus node
 name to fix dtschema warnings
Message-ID: <20200705181311.GA3611@kozik-lap>
References: <20200702155149.12854-1-krzk@kernel.org>
 <CGME20200702155216eucas1p2424c5998e09d73e3b758e4cd8ba27157@eucas1p2.samsung.com>
 <20200702155149.12854-5-krzk@kernel.org>
 <11b9adcf-251f-81ad-2559-9d96c0a3ad78@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11b9adcf-251f-81ad-2559-9d96c0a3ad78@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 02, 2020 at 10:34:14PM +0200, Marek Szyprowski wrote:
> On 02.07.2020 17:51, Krzysztof Kozlowski wrote:
> > There is no need to keep DMA controller nodes under AMBA bus node.
> > Remove the "amba" node to fix dtschema warnings like:
> >
> >      amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Remove the bus, as suggested by Marek
> > ---
> >   arch/arm/boot/dts/exynos3250.dtsi             |  47 +++----
> >   arch/arm/boot/dts/exynos4.dtsi                |  70 +++++-----
> >   .../boot/dts/exynos4210-universal_c210.dts    |   2 +-
> >   arch/arm/boot/dts/exynos5250.dtsi             |  92 ++++++-------
> >   arch/arm/boot/dts/exynos5410.dtsi             |  46 +++----
> >   arch/arm/boot/dts/exynos5420.dtsi             | 130 ++++++++----------
> >   6 files changed, 174 insertions(+), 213 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> > index 044e5da64a76..d3fb45a56527 100644
> > --- a/arch/arm/boot/dts/exynos3250.dtsi
> > +++ b/arch/arm/boot/dts/exynos3250.dtsi
> > @@ -418,33 +418,26 @@
> >   			status = "disabled";
> >   		};
> >   
> > -		amba {
> > -			compatible = "simple-bus";
> > -			#address-cells = <1>;
> > -			#size-cells = <1>;
> > -			ranges;
> > -
> > -			pdma0: pdma@12680000 {
> > -				compatible = "arm,pl330", "arm,primecell";
> > -				reg = <0x12680000 0x1000>;
> > -				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&cmu CLK_PDMA0>;
> > -				clock-names = "apb_pclk";
> > -				#dma-cells = <1>;
> > -				#dma-channels = <8>;
> > -				#dma-requests = <32>;
> > -			};
> > -
> > -			pdma1: pdma@12690000 {
> > -				compatible = "arm,pl330", "arm,primecell";
> > -				reg = <0x12690000 0x1000>;
> > -				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&cmu CLK_PDMA1>;
> > -				clock-names = "apb_pclk";
> > -				#dma-cells = <1>;
> > -				#dma-channels = <8>;
> > -				#dma-requests = <32>;
> > -			};
> > +		pdma0: pdma@12680000 {
> > +			compatible = "arm,pl330", "arm,primecell";
> > +			reg = <0x12680000 0x1000>;
> > +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_PDMA0>;
> > +			clock-names = "apb_pclk";
> > +			#dma-cells = <1>;
> > +			#dma-channels = <8>;
> > +			#dma-requests = <32>;
> > +		};
> > +
> > +		pdma1: pdma@12690000 {
> > +			compatible = "arm,pl330", "arm,primecell";
> > +			reg = <0x12690000 0x1000>;
> > +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_PDMA1>;
> > +			clock-names = "apb_pclk";
> > +			#dma-cells = <1>;
> > +			#dma-channels = <8>;
> > +			#dma-requests = <32>;
> >   		};
> >   
> >   		adc: adc@126c0000 {
> > diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> > index d2779a790ce3..a1e54449f33f 100644
> > --- a/arch/arm/boot/dts/exynos4.dtsi
> > +++ b/arch/arm/boot/dts/exynos4.dtsi
> > @@ -669,45 +669,37 @@
> >   			status = "disabled";
> >   		};
> >   
> > -		amba: amba {
> > -			#address-cells = <1>;
> > -			#size-cells = <1>;
> > -			compatible = "simple-bus";
> > -			interrupt-parent = <&gic>;
> > -			ranges;
> > -
> > -			pdma0: pdma@12680000 {
> > -				compatible = "arm,pl330", "arm,primecell";
> > -				reg = <0x12680000 0x1000>;
> > -				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&clock CLK_PDMA0>;
> > -				clock-names = "apb_pclk";
> > -				#dma-cells = <1>;
> > -				#dma-channels = <8>;
> > -				#dma-requests = <32>;
> > -			};
> > -
> > -			pdma1: pdma@12690000 {
> > -				compatible = "arm,pl330", "arm,primecell";
> > -				reg = <0x12690000 0x1000>;
> > -				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&clock CLK_PDMA1>;
> > -				clock-names = "apb_pclk";
> > -				#dma-cells = <1>;
> > -				#dma-channels = <8>;
> > -				#dma-requests = <32>;
> > -			};
> > -
> > -			mdma1: mdma@12850000 {
> > -				compatible = "arm,pl330", "arm,primecell";
> > -				reg = <0x12850000 0x1000>;
> > -				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&clock CLK_MDMA>;
> > -				clock-names = "apb_pclk";
> > -				#dma-cells = <1>;
> > -				#dma-channels = <8>;
> > -				#dma-requests = <1>;
> > -			};
> > +		pdma0: pdma@12680000 {
> > +			compatible = "arm,pl330", "arm,primecell";
> > +			reg = <0x12680000 0x1000>;
> > +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clock CLK_PDMA0>;
> > +			clock-names = "apb_pclk";
> > +			#dma-cells = <1>;
> > +			#dma-channels = <8>;
> > +			#dma-requests = <32>;
> > +		};
> > +
> > +		pdma1: pdma@12690000 {
> > +			compatible = "arm,pl330", "arm,primecell";
> > +			reg = <0x12690000 0x1000>;
> > +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clock CLK_PDMA1>;
> > +			clock-names = "apb_pclk";
> > +			#dma-cells = <1>;
> > +			#dma-channels = <8>;
> > +			#dma-requests = <32>;
> > +		};
> > +
> > +		mdma1: mdma@12850000 {
> > +			compatible = "arm,pl330", "arm,primecell";
> > +			reg = <0x12850000 0x1000>;
> > +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clock CLK_MDMA>;
> > +			clock-names = "apb_pclk";
> > +			#dma-cells = <1>;
> > +			#dma-channels = <8>;
> > +			#dma-requests = <1>;
> >   		};
> >   
> >   		fimd: fimd@11c00000 {
> > diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > index 02fde1a75ebd..e07aa3aa93bd 100644
> > --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > @@ -181,7 +181,7 @@
> >   	};
> >   };
> >   
> > -&amba {
> > +&soc {
> 
> 
> What about the alphabetical order of the labels here?

Yes, I'll keep them ordered. Thanks.

Best regards,
Krzysztof
