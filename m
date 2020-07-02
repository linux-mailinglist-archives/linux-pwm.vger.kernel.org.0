Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE64212DEB
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Jul 2020 22:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgGBUeV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Jul 2020 16:34:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53948 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUeU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jul 2020 16:34:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200702203417euoutp0160e06596ce4ff62fbf647c874d4e4783~eCcR_PQMR0733307333euoutp01X
        for <linux-pwm@vger.kernel.org>; Thu,  2 Jul 2020 20:34:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200702203417euoutp0160e06596ce4ff62fbf647c874d4e4783~eCcR_PQMR0733307333euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593722057;
        bh=F4Q9XhygBokPI3cCCxSxLMLJKoc/u8WErcqeoikqdC4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WvKJLSgD+f4uctkXhWJkGgYJvzU1UZfs/YwsD32tzkFJggS1OOfjlJuPizNhbz90s
         gD6Fv+/vv0XOjEsaMC5ziEZaj/PKOpPDlHX4dMTKIaeQbK1OeMGJKA4J39MCdZRWtK
         6WJyvp69QpjtwjKcb9JEGE6TQbO3VReKjbiasHpQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200702203416eucas1p2c6940acf003a255f05b579227c2ac1f6~eCcQ-qCUy0283902839eucas1p2Y;
        Thu,  2 Jul 2020 20:34:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E8.C0.05997.8C44EFE5; Thu,  2
        Jul 2020 21:34:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200702203415eucas1p1ebec4f5e3559a41ff6791b327c68aea9~eCcP3nXgI0693206932eucas1p1b;
        Thu,  2 Jul 2020 20:34:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200702203415eusmtrp2164b2cd894c3cf53a586980192cc5954~eCcP24ra23270132701eusmtrp2U;
        Thu,  2 Jul 2020 20:34:15 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-a1-5efe44c8db6f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.02.06314.7C44EFE5; Thu,  2
        Jul 2020 21:34:15 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702203414eusmtip253239c5cf77a3938c92b56b0b12261e8~eCcO-qCES1934119341eusmtip2G;
        Thu,  2 Jul 2020 20:34:14 +0000 (GMT)
Subject: Re: [PATCH v2 5/8] ARM: dts: exynos: Remove DMA controller bus node
 name to fix dtschema warnings
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <11b9adcf-251f-81ad-2559-9d96c0a3ad78@samsung.com>
Date:   Thu, 2 Jul 2020 22:34:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702155149.12854-5-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fO2TmOZse18smiaEZR4S2NXlKkImEQRdmHRMtaeVBpztq8
        FpSX7LIkbx+awzRWdlnpdPNSdkFNnaa51LAoV4ZGmEgXt0BLy3Wy/Pb7v//nef7PAy9DSN5T
        Xky8KolTqxRKmVBE1rVN2Hzat09H+z/OlOHB0johrtaZKPzS8ZHCZS3dFM4bGiWwzVZF43fO
        VoTNQ/0U7msoEWK73YiwzvZYgA21DhrnPGqh8bkPIwSeaCgl8ZuCIrSFld/X22m52XhBKB/o
        fyiUW66fludN+csv1RiRfNy8fDcdKQqJ4ZTxKZzaL/SQKO6a1Ukfs6SmNessggz0I0KL3Bhg
        g+DLk8+0FokYCXsLwYPcqr/CgWCwPY/ixTiCzBs3hbMtA7p6xBs3EZSXNxK8+Iygp62JcFUt
        ZJXQYRolXYaULSfAMmGgXAbB2hHkF8a7WMgGgHZM+2esmA2Frv5K2sUkuwqelmWRLl7ERoNp
        pF7A13hAR/Hwn3c3diNMXqwU8DNXQP1YCcGzJ7weLhO4goHNYaB89BfJ770dSqtv/+WF8Mla
        Q/O8DH7dn23IRvC+u4LmRS6Cviwd4quCYaB7cmZVZiZiLZga/FwI7FaoLlrMozu8GvPgd3CH
        wrrLBP8shvNnJfyM1aC3Vv5LbXreS+QjmX7OZfo51+jnXKP/H3sVkUbkySVrEmI5zQYVl+qr
        USRoklWxvkcSE8xo5uN1Tlsd91DDz8PNiGWQbL443zoVLaEUKZr0hGYEDCGTirc964yWiGMU
        6Sc4deJBdbKS0zSjpQwp8xQHGkYOSNhYRRJ3lOOOcepZV8C4eWWgYGfX0m9hxuzs3oJaj4cC
        br+0KnkwzLSp6as0NDfxrdF7Mxk1UX1ypTNtwZ0rp7zUnfavMXct0oyIiuECb+WJ9cWOzlpz
        DbXnRa1PijPEfdvO4Z7w8zlrLpQU7+qNmrf3rKooaMmZth1TjMigfRn4Pbw1V27YKdiHIxtt
        xkNix3EZqYlTBKwj1BrFb3VrRx10AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xe7rHXf7FGRx8KmTxYN42NouNM9az
        Wlz/8pzVYv6Rc6wW/Y9fM1ucP7+B3eL+16OMFpseX2O1uLxrDpvF3burGC1mnN/HZLFo6xd2
        i9a9R9gt2p++ZLb4uWsei8XtiZMZHQQ8ds66y+6xaVUnm8eda3vYPDYvqffo/2vg0bdlFaPH
        501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
        ehmLj39lL9hcXnFoxmamBsbfEV2MnBwSAiYSd2ZsZ+xi5OIQEljKKHF1/28miISMxMlpDawQ
        trDEn2tdbCC2kMBbRok3vbUgtrBAjsTJ9a9ZQJpFBJYySzxc/5YNxGEWuM8ocb7tJzvE2M2M
        Eh0r34ONZRMwlOh6CzGKV8BO4sy1dewgNouAisSp+U0sILaoQJzE8i3z2SFqBCVOznwCFucU
        MJX41b0ObA6zgJnEvM0PmSFseYntb+dA2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNI
        amlxbnpusaFecWJucWleul5yfu4mRmCMbzv2c/MOxksbgw8xCnAwKvHwTjj+N06INbGsuDL3
        EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTD95JfGGpobmFpaG5sbm
        xmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYw6v0WmMn7731gi/9Tva6qorc6v5jm/2/
        5SSa3lBLFZl36OzMa4UaWy9/vf7rzcmbQUp5FZJrY4Jz2zq3lQtwvnlm+/5zyb0tQm1GPD6W
        XQ+mbJ185llH+72yi7827b38WK/dZdf0jrAT3XqZOu4uK91LlI/sOrEh4nTcA0cRmWNRrxa0
        Bp1wV2Ipzkg01GIuKk4EAMeebagHAwAA
X-CMS-MailID: 20200702203415eucas1p1ebec4f5e3559a41ff6791b327c68aea9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702155216eucas1p2424c5998e09d73e3b758e4cd8ba27157
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702155216eucas1p2424c5998e09d73e3b758e4cd8ba27157
References: <20200702155149.12854-1-krzk@kernel.org>
        <CGME20200702155216eucas1p2424c5998e09d73e3b758e4cd8ba27157@eucas1p2.samsung.com>
        <20200702155149.12854-5-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 02.07.2020 17:51, Krzysztof Kozlowski wrote:
> There is no need to keep DMA controller nodes under AMBA bus node.
> Remove the "amba" node to fix dtschema warnings like:
>
>      amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Remove the bus, as suggested by Marek
> ---
>   arch/arm/boot/dts/exynos3250.dtsi             |  47 +++----
>   arch/arm/boot/dts/exynos4.dtsi                |  70 +++++-----
>   .../boot/dts/exynos4210-universal_c210.dts    |   2 +-
>   arch/arm/boot/dts/exynos5250.dtsi             |  92 ++++++-------
>   arch/arm/boot/dts/exynos5410.dtsi             |  46 +++----
>   arch/arm/boot/dts/exynos5420.dtsi             | 130 ++++++++----------
>   6 files changed, 174 insertions(+), 213 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 044e5da64a76..d3fb45a56527 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -418,33 +418,26 @@
>   			status = "disabled";
>   		};
>   
> -		amba {
> -			compatible = "simple-bus";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges;
> -
> -			pdma0: pdma@12680000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12680000 0x1000>;
> -				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&cmu CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@12690000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12690000 0x1000>;
> -				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&cmu CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma0: pdma@12680000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12680000 0x1000>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@12690000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12690000 0x1000>;
> +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
>   		};
>   
>   		adc: adc@126c0000 {
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index d2779a790ce3..a1e54449f33f 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -669,45 +669,37 @@
>   			status = "disabled";
>   		};
>   
> -		amba: amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			pdma0: pdma@12680000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12680000 0x1000>;
> -				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@12690000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12690000 0x1000>;
> -				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			mdma1: mdma@12850000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12850000 0x1000>;
> -				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> +		pdma0: pdma@12680000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12680000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@12690000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12690000 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma1: mdma@12850000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12850000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
>   		};
>   
>   		fimd: fimd@11c00000 {
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 02fde1a75ebd..e07aa3aa93bd 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -181,7 +181,7 @@
>   	};
>   };
>   
> -&amba {
> +&soc {


What about the alphabetical order of the labels here?


>   	mdma0: mdma@12840000 {
>   		compatible = "arm,pl330", "arm,primecell";
>   		reg = <0x12840000 0x1000>;
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index b6135af7ef39..e3dbe4166836 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -679,56 +679,48 @@
>   			samsung,pmureg-phandle = <&pmu_system_controller>;
>   		};
>   
> -		amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			pdma0: pdma@121a0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121A0000 0x1000>;
> -				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@121b0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121B0000 0x1000>;
> -				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			mdma0: mdma@10800000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x10800000 0x1000>;
> -				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> -
> -			mdma1: mdma@11c10000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x11C10000 0x1000>;
> -				interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> +		pdma0: pdma@121a0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121A0000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@121b0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121B0000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma0: mdma@10800000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x10800000 0x1000>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +		};
> +
> +		mdma1: mdma@11c10000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x11C10000 0x1000>;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
>   		};
>   
>   		gsc_0:  gsc@13e00000 {
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 2eab80bf5f3a..abe75b9e39f5 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -189,34 +189,26 @@
>   			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> -		amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			pdma0: pdma@121a0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121a0000 0x1000>;
> -				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma0: pdma@121a0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121a0000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
>   
> -			pdma1: pdma@121b0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121b0000 0x1000>;
> -				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma1: pdma@121b0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121b0000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
>   		};
>   
>   		audi2s0: i2s@3830000 {
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index b672080e7469..c76460b70532 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -433,76 +433,68 @@
>   			power-domains = <&mau_pd>;
>   		};
>   
> -		amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			adma: adma@3880000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x03880000 0x1000>;
> -				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock_audss EXYNOS_ADMA>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <6>;
> -				#dma-requests = <16>;
> -				power-domains = <&mau_pd>;
> -			};
> -
> -			pdma0: pdma@121a0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121A0000 0x1000>;
> -				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@121b0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121B0000 0x1000>;
> -				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			mdma0: mdma@10800000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x10800000 0x1000>;
> -				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> +		adma: adma@3880000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x03880000 0x1000>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock_audss EXYNOS_ADMA>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <6>;
> +			#dma-requests = <16>;
> +			power-domains = <&mau_pd>;
> +		};
>   
> -			mdma1: mdma@11c10000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x11C10000 0x1000>;
> -				interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -				/*
> -				 * MDMA1 can support both secure and non-secure
> -				 * AXI transactions. When this is enabled in
> -				 * the kernel for boards that run in secure
> -				 * mode, we are getting imprecise external
> -				 * aborts causing the kernel to oops.
> -				 */
> -				status = "disabled";
> -			};
> +		pdma0: pdma@121a0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121A0000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@121b0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121B0000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma0: mdma@10800000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x10800000 0x1000>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +		};
> +
> +		mdma1: mdma@11c10000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x11C10000 0x1000>;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +			/*
> +			 * MDMA1 can support both secure and non-secure
> +			 * AXI transactions. When this is enabled in
> +			 * the kernel for boards that run in secure
> +			 * mode, we are getting imprecise external
> +			 * aborts causing the kernel to oops.
> +			 */
> +			status = "disabled";
>   		};
>   
>   		i2s0: i2s@3830000 {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

