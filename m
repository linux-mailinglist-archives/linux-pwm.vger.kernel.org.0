Return-Path: <linux-pwm+bounces-1989-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FD28A80E6
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA3D283996
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 10:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F332A13B7B3;
	Wed, 17 Apr 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tPS1FpQi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72F6A008;
	Wed, 17 Apr 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349677; cv=none; b=oKUdOXFCbk8rbXB97Snn9JskDlMI+EGgbxdMA70TsllDJ92KI9HFlW3ZFXhfzFsEXlPE8DfqS3MRVqtA7kst0PoeGShGwkeq+w+ZnqTSMsLcqJMXxYeV1pYS3HqCzY+7cj+Gpf5Vg+CPXA8/nRUlQqXvei24Jtmc6c750FWz5h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349677; c=relaxed/simple;
	bh=igKb1+9ORijlEOAngHwdjRu6XCuUhCp5tx6ifK5ZhJ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pUqiURkSaAwEhqhcDCzsCp+Ogh3y4wmwsco+C+13zFoCydgkHtxlDEhwBT1Y+pnqDnC8XZKeL9aWLED+qginM+DSq3Go8Tb4iQL/aNauxB8ZNXEsjkCYPCWrAKLntEfI+Kk7YDMIXn97+82u/ikCpClret8Kt1f4t8mm2vnOHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tPS1FpQi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713349674;
	bh=igKb1+9ORijlEOAngHwdjRu6XCuUhCp5tx6ifK5ZhJ8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=tPS1FpQidS4mEjupwQSkrvh2Y6jR4RzXxnuepn5ZYhPUzrkfgh745SW8jSLZOpipc
	 LE9QeKfi+Lo9+GTROFU3kPxkj8Zfwb88avWezJd53YL2GPyhLZuj2DdxtA81SNb6Tc
	 EZqBPLN3V7uORWjUGhaMUBunnYpjHTiggdyNwGASrDPosz/oI/gKB9pVXbglAbrhJ6
	 YGLkBRi49WHgYgbImowDqeO2rQnCHgFLIAz1hm+JDX4S5ldmA62HUxSaYQOQJl3ARX
	 vooHjnOmZjlJ8wD0ViSg+FvddinMn3KMKxHLPASKMxD8SLIY/5/knuxXtSA2U5pTYC
	 Jb1WTtJWHNJpw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D7E9D37820F1;
	Wed, 17 Apr 2024 10:27:52 +0000 (UTC)
Message-ID: <37ffdb00-8d7a-4305-8814-6794c755c190@collabora.com>
Date: Wed, 17 Apr 2024 12:27:52 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 17/18] arm64: dts: mediatek: add display blocks support
 for the MT8365 SoC
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-17-33ce8864b227@baylibre.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-17-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> - Add aliases for each display components to help display drivers.
> - Add the Display Pulse Width Modulation (DISP_PWM) to provide PWM signals
>    for the LED driver of mobile LCM.
> - Add the MIPI Display Serial Interface (DSI) PHY support. (up to 4-lane
>    output)
> - Add the display mutex support.
> - Add the following display component support:
>    - OVL0 (Overlay)
>    - RDMA0 (Data Path Read DMA)
>    - Color0
>    - CCorr0 (Color Correction)
>    - AAL0 (Adaptive Ambient Light)
>    - GAMMA0
>    - Dither0
>    - DSI0 (Display Serial Interface)
>    - RDMA1 (Data Path Read DMA)
>    - DPI0 (Display Parallel Interface)
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi | 146 +++++++++++++++++++++++++++++++
>   1 file changed, 146 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> index 24581f7410aa..a95f90da4491 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/clock/mediatek,mt8365-clk.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/power/mediatek,mt8365-power.h>
>   
> @@ -17,6 +18,19 @@ / {
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   
> +	aliases {
> +		aal0 = &aal0;
> +		ccorr0 = &ccorr0;
> +		color0 = &color0;
> +		dither0 = &dither0;
> +		dpi0 = &dpi0;
> +		dsi0 = &dsi0;
> +		gamma0 = &gamma0;
> +		ovl0 = &ovl0;
> +		rdma0 = &rdma0;
> +		rdma1 = &rdma1;
> +	};
> +
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> @@ -607,6 +621,17 @@ spi: spi@1100a000 {
>   			status = "disabled";
>   		};
>   
> +		disp_pwm: pwm@1100e000 {
> +			compatible = "mediatek,mt8365-disp-pwm",
> +				     "mediatek,mt8183-disp-pwm";

Fits in a single line

> +			reg = <0 0x1100e000 0 0x1000>;
> +			clock-names = "main", "mm";
> +			clocks = <&topckgen CLK_TOP_DISP_PWM_SEL>,
> +				 <&infracfg CLK_IFR_DISP_PWM>;

same

> +			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
> +			#pwm-cells = <2>;
> +		};
> +
>   		i2c3: i2c@1100f000 {
>   			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
>   			reg = <0 0x1100f000 0 0xa0>, <0 0x11000200 0 0x80>;
> @@ -703,6 +728,15 @@ ethernet: ethernet@112a0000 {
>   			status = "disabled";
>   		};
>   
> +		mipi_tx0: dsi-phy@11c00000 {
> +			compatible = "mediatek,mt8365-mipi-tx", "mediatek,mt8183-mipi-tx";
> +			reg = <0 0x11c00000 0 0x800>;
> +			clock-output-names = "mipi_tx0_pll";
> +			clocks = <&clk26m>;
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +		};
> +
>   		u3phy: t-phy@11cc0000 {
>   			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
>   			#address-cells = <1>;
> @@ -732,6 +766,13 @@ mmsys: syscon@14000000 {
>   			#clock-cells = <1>;
>   		};
>   
> +		mutex: mutex@14001000 {
> +			compatible =  "mediatek,mt8365-disp-mutex";
> +			reg = <0 0x14001000 0 0x1000>;
> +			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
> +		};
> +
>   		smi_common: smi@14002000 {
>   			compatible = "mediatek,mt8365-smi-common";
>   			reg = <0 0x14002000 0 0x1000>;
> @@ -755,6 +796,111 @@ larb0: larb@14003000 {
>   			mediatek,larb-id = <0>;
>   		};
>   
> +		ovl0: ovl@1400b000 {
> +			compatible = "mediatek,mt8365-disp-ovl",
> +				     "mediatek,mt8192-disp-ovl";

single line

> +			reg = <0 0x1400b000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_MM_DISP_OVL0>;
> +			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
> +			iommus = <&iommu M4U_PORT_DISP_OVL0>;
> +			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
> +		};
> +
> +		rdma0: rdma@1400d000 {
> +			compatible = "mediatek,mt8365-disp-rdma",
> +				     "mediatek,mt8183-disp-rdma";

ditto

> +			reg = <0 0x1400d000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_MM_DISP_RDMA0>;
> +			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_LOW>;
> +			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
> +			mediatek,rdma-fifo-size = <5120>;
> +			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
> +		};
> +
> +		color0: color@1400f000 {
> +			compatible = "mediatek,mt8365-disp-color",
> +				     "mediatek,mt8173-disp-color";

...and all the others too (maybe not all, it's fine until 100 cols anyway)


Cheers,
Angelo


