Return-Path: <linux-pwm+bounces-7129-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3674DB2E75A
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 23:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E125E1CC3AA1
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 21:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6D236451;
	Wed, 20 Aug 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="mRLvGFFV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A211E49F;
	Wed, 20 Aug 2025 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724711; cv=none; b=e4uthysS5IEp8g0g84mvnXscG8gctd1EczKPD9yOatv7cniIjKIBvsgcmrwV33sIivkqNgtMRh9U2miKeErkpPrJStlDjprDojaqvfWNEV69Zng1rzbsZMSNbV70glQpYH6Slvl15ykquexFNrIt78svuNz4ZoYh4pg9iDIcHN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724711; c=relaxed/simple;
	bh=U8X+7JyRirW1YLSFkGAfUxC6jQP6XhgmQavoB6gUt1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2CMQLy1SXWvQD4vdYGsR8QNgqypYlNtd0ngrkYiV5K3BX2wAicRgvjFi2bXVpXEKcqVLi7GiPeUHvhQxzGkf7iXTVpqMi0hzycKRuIwRFIFH5dhyZpzi8Lf2qVfXNi+SklKIyRiGnpMq3VzIilCQHbCeQHtLhXf8WC+jTi8r0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=mRLvGFFV; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755724706; x=1755983906;
	bh=JSAu0mbSO2Oo3ckHfGpNPMrfRcVmm1IBIVSUbO2haro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mRLvGFFVkHAjPY6dW6j4TC3cu15UDw7jn+8RL+wwYwFZnPibfP9rIdPa5JoSZqdeW
	 hTwbO0p0XfJIKGVSKxmHOvoxIF5tgYrdKTw+wA5DVRCApljOBOZiHvHn5nd79Q4Xps
	 ifGPh8vOhsgomfFKt0jegcZgLAuYJZmNeLAWlI96R3J6sBOzhVUCNc0LY3UKKkLggO
	 SQNWmv3GezO8JbPcImZhi80xrGooKo2tKBq1NaMkG4D7r3BuSzwGbgkbdrRerZgJNV
	 VUbbzhV+5ABBsao24jlN85kZOkSq4tRBTNL8D8h7UrlAklZtkQ7c+VoUnwdqrh9IPF
	 thz5dnIvz+tmQ==
X-Pm-Submission-Id: 4c6fSc1kpbz2ScPD
Date: Wed, 20 Aug 2025 21:18:18 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Drew Fustini <fustini@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v14 7/7] riscv: dts: thead: Add PWM fan and thermal
 control
Message-ID: <aKY7mnaQwZtgqryR@archiso>
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083548eucas1p2a40775d53dfd9f8608671cc20003fd7d@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-7-df2191621429@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-rust-next-pwm-working-fan-for-sending-v14-7-df2191621429@samsung.com>

On Wed, Aug 20, 2025 at 10:35:42AM +0200, Michal Wilczynski wrote:
> Add Device Tree nodes to enable a PWM controlled fan and it's associated
> thermal management for the Lichee Pi 4A board.
> 
> This enables temperature-controlled active cooling for the Lichee Pi 4A
> board based on SoC temperature.
> 
> Reviewed-by: Drew Fustini <fustini@kernel.org>
> Tested-by: Drew Fustini <fustini@kernel.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 67 +++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> index 4020c727f09e8e2286fdc7fecd79dbd8eba69556..c58c2085ca92a3234f1350500cedae4157f0c35f 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> @@ -28,9 +28,76 @@ aliases {
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <1000>;
> +			thermal-sensors = <&pvt 0>;
> +
> +			trips {
> +				fan_config0: fan-trip0 {
> +					temperature = <39000>;
> +					hysteresis = <5000>;
> +					type = "active";
> +				};
> +
> +				fan_config1: fan-trip1 {
> +					temperature = <50000>;
> +					hysteresis = <5000>;
> +					type = "active";
> +				};
> +
> +				fan_config2: fan-trip2 {
> +					temperature = <60000>;
> +					hysteresis = <5000>;
> +					type = "active";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map-active-0 {
> +					cooling-device = <&fan 1 1>;
> +					trip = <&fan_config0>;
> +				};
> +
> +				map-active-1 {
> +					cooling-device = <&fan 2 2>;
> +					trip = <&fan_config1>;
> +				};
> +
> +				map-active-2 {
> +					cooling-device = <&fan 3 3>;
> +					trip = <&fan_config2>;
> +				};
> +			};
> +		};
> +	};
> +
> +	fan: pwm-fan {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&fan_pins>;
> +		compatible = "pwm-fan";
> +		#cooling-cells = <2>;
> +		pwms = <&pwm 1 10000000 0>;
> +		cooling-levels = <0 66 196 255>;
> +	};
> +
>  };
>  
>  &padctrl0_apsys {
> +	fan_pins: fan-0 {
> +		pwm1-pins {
> +			pins = "GPIO3_3"; /* PWM1 */
> +			function = "pwm";
> +			bias-disable;
> +			drive-strength = <25>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
>  	uart0_pins: uart0-0 {
>  		tx-pins {
>  			pins = "UART0_TXD";
> 
> -- 
> 2.34.1

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

