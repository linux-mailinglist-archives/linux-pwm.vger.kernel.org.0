Return-Path: <linux-pwm+bounces-3279-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C63D8979E30
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 11:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BFC1F20FBD
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781C148850;
	Mon, 16 Sep 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbdrOnJZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8423482EF;
	Mon, 16 Sep 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478236; cv=none; b=lDc7sk6TfjRLVtd7SpO8OP+mZb20ztTw8gi6DZBdmNveHZi4u1IoiVfUB8+kzHYadB/6C0fd2PIwx3Woy73fKriBj6SeuPT6w3qd+jWb5lYrWXgYpMCeMyeDfB9mCdEa0cwY6QgT5i3frSGJycT+1hBMAoqX7eVyh7O7JSz5jis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478236; c=relaxed/simple;
	bh=Hf78NC2O19esKVAGkRW6er0cOjPx5E32KUQUQLtJM/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhoFyPpmoaRNLIi2ecknc/I0bSztG8JOh1stgKuPd4SWneMjkPZg8OyinPHUfybeVf0Li5I3QvIjPisoXrctYzYCgNE5dcThN1FRXNuYaEInRGf6hfVAivC4QScXXThnWcNri88mNbD6mNYRDN5iWT+1xX03dq+11dQcj2r4FtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbdrOnJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C4EC4CEC4;
	Mon, 16 Sep 2024 09:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726478236;
	bh=Hf78NC2O19esKVAGkRW6er0cOjPx5E32KUQUQLtJM/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pbdrOnJZrQPWZZ0hXGwLCKBjLzdhzCpUaCrN9zaRgsLA4SgW9Glr9NStq9C3LhS5G
	 ChSDKXbeSA+2FB45JP+Wv/6EwA1sqp6u+5gzdxi8m1yDx5H9ACjCjX1x39cIidOyuF
	 o+w5RJRx/ZlroJyeWEk/cjPZv3FFmL/8Zpp7vrBqC8WtnMETlYs2ynpIlXmbB6NHq1
	 +fl01P5aYzoc9xajvW4+NQWXU8dZHIIKmunXI6ME5eTUrrTLvpBIivNcUtiyWFDmA8
	 dEW8todI+dRvTLB6Q8tmUEi2bZmiM4LTrP3mlt68NlUDEMedt3skHomeN2F72Q68FQ
	 rLtaN6Nmtjz2w==
Date: Mon, 16 Sep 2024 11:17:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Simona Vetter <simona@ffwll.ch>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konradybcio@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 22/27] arm64: dts: qcom: starqltechn: add max77705 PMIC
Message-ID: <2zdatzzxd4jjev7uwdfacyrv4fmukqwbtabewfsxhgonxuhkjh@ty7v33g57q6h>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-22-2d2efd5c5877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-22-2d2efd5c5877@gmail.com>

On Fri, Sep 13, 2024 at 06:08:05PM +0300, Dzmitry Sankouski wrote:
> Add support for max77705 MFD device. Supported sub-devices:
>  charger, fuelgauge, haptic, led
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 103 +++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index a3bd5231569d..865253d8f0c7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -18,6 +18,16 @@ / {
>  	model = "Samsung Galaxy S9 SM-G9600";
>  	compatible = "samsung,starqltechn", "qcom,sdm845";
>  
> +	battery: battery {
> +		compatible = "simple-battery";
> +		constant-charge-current-max-microamp = <2150000>;
> +		charge-full-design-microamp-hours = <3000000>;
> +
> +		over-voltage-threshold-microvolt = <4500000>;
> +		voltage-min-design-microvolt = <3400000>;
> +		voltage-max-design-microvolt = <4350000>;
> +	};
> +
>  	chosen {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -90,6 +100,27 @@ key-wink {
>  			debounce-interval = <15>;
>  		};
>  	};
> +
> +	vib_regulator: gpio-regulator {

Please use name for all fixed regulators which matches current format
recommendation: 'regulator-[0-9]v[0-9]'
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml?h=v6.11-rc1#n46

> +		compatible = "regulator-fixed";
> +		regulator-name = "haptic";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio = <&pm8998_gpios 18 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vib_pwm: pwm {
> +		#pwm-cells = <2>;
> +		compatible = "clk-pwm";

compatible is always the first property. See DTS coding style.

> +		clocks = <&gcc GCC_GP1_CLK>;
> +		assigned-clock-parents = <&rpmhcc RPMH_CXO_CLK>;
> +		assigned-clocks = <&gcc GCC_GP1_CLK_SRC>;
> +		pinctrl-0 = <&motor_pwm_default_state>;
> +		pinctrl-1 = <&motor_pwm_suspend_state>;
> +		pinctrl-names = "default", "suspend";
> +	};
>  };
>  
>  
> @@ -385,10 +416,66 @@ &qupv3_id_1 {
>  	status = "okay";
>  };
>  
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
>  &uart9 {
>  	status = "okay";
>  };
>  
> +&i2c14 {
> +	status = "okay";
> +
> +	pmic@66 {
> +		compatible = "maxim,max77705";
> +		reg = <0x66>;
> +		interrupt-parent = <&pm8998_gpios>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-0 = <&chg_int_default>;
> +		pinctrl-names = "default";
> +
> +		leds {
> +			compatible = "maxim,max77705-led";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			led@1 {
> +				reg = <1>;
> +				label = "red:usr1";
> +			};
> +
> +			led@2 {
> +				reg = <2>;
> +				label = "green:usr2";
> +			};
> +
> +			led@3 {
> +				reg = <3>;
> +				label = "blue:usr3";
> +			};
> +		};
> +
> +		max77705_charger: charger {
> +			compatible = "maxim,max77705-charger";
> +			monitored-battery = <&battery>;
> +		};
> +
> +		fuel_gauge {

No underscores in node names. See DTS coding style.

Best regards,
Krzysztof


