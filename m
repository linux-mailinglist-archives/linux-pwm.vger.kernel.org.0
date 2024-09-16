Return-Path: <linux-pwm+bounces-3278-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F0E979E20
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 11:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319CF280DA5
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDD014AD2B;
	Mon, 16 Sep 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojSHmGni"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635E14AD24;
	Mon, 16 Sep 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478121; cv=none; b=ugWmZbgsjEK+QuGfAYP0fS+ZcwTBovjMLFA3d7helwNpPkt/mYdka+j1bUPi/GJxscKEuA6nBqFkDXXeZNPH41CI1jMAgGIZCkPRrD4BYnm5V9bCAGmhYu7O/7ZvupoWJDY7dEJAYvAk4q3X6lU3ZkGMyzVgj2VSTDzvpWBNyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478121; c=relaxed/simple;
	bh=fnAPuBUu0/tTI7HoyZunJlTeMOKUsprJK+29sxMVwYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ8jmf1UbxJECfHIBufy4XDzR2Oh4nu9rE2p/F7bTxn0073dAmAl4/cLBIA3UFVIxi0/yAb0UCFN5HKyqxjDywHR/ua3NWXb+dIY1wgbgdXzHjk+BBbQgGbtsMM7SRvTRAl8B9mYweMjU7ewWphr+dsNR+T/dV4WdSfvJ1NDVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojSHmGni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BD4C4CEC4;
	Mon, 16 Sep 2024 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726478120;
	bh=fnAPuBUu0/tTI7HoyZunJlTeMOKUsprJK+29sxMVwYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojSHmGni3OGFIo7vnOCzqgHL0on0uhCTGQ91p/OyZ0gOs3O7l6ZurMGkGXB7dVVAF
	 CwxpFZxFfb2CIuVFDU9gKjMofYfKcsmxS84cZ6o9ExrXvt3sCQDJCpTBwhKkXmngK/
	 XVNyaKI5TXDzaxQXCBUtpsouMDwuTe/6jhKRNHZxY80MiRjXgwZAH0aiSg7E0iM6/A
	 FTkSBqwe4qQLxbg8vdiwOaW16KvQ9ejeSGamh875/C1zPnXt3lSZ5OpNtX5aP3308I
	 rgHfQkOIX839Icqxqkq5O2znrKoJSx9EZl96CGAYEWDDar5BgxxH1KM5gO+4nxYUqE
	 lPhQQYLL3sSiw==
Date: Mon, 16 Sep 2024 11:15:16 +0200
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
Subject: Re: [PATCH v4 23/27] arm64: dts: qcom: starqltechn: add display PMIC
Message-ID: <rfoxnd4axyqxvexgq3mm2zntzvpihv4g424hepkoh7bfr2izjz@htjeqbfuq2gu>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-23-2d2efd5c5877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-23-2d2efd5c5877@gmail.com>

On Fri, Sep 13, 2024 at 06:08:06PM +0300, Dzmitry Sankouski wrote:
> Add support for s2dos05 display / touchscreen PMIC
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index 865253d8f0c7..5e5684f84ffb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -39,6 +39,9 @@ framebuffer: framebuffer@9d400000 {
>  			height = <2960>;
>  			stride = <(1440 * 4)>;
>  			format = "a8r8g8b8";
> +			vci-supply = <&s2dos05_ldo4>;
> +			vddr-supply = <&s2dos05_buck1>;
> +			vdd3-supply = <&s2dos05_ldo1>;
>  		};
>  	};
>  
> @@ -101,6 +104,66 @@ key-wink {
>  		};
>  	};
>  
> +	i2c21 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&tlmm 127 GPIO_ACTIVE_HIGH>;
> +		scl-gpios = <&tlmm 128 GPIO_ACTIVE_HIGH>;
> +		i2c-gpio,delay-us = <2>;
> +		pinctrl-0 = <&i2c21_sda_state &i2c21_scl_state>;
> +		pinctrl-names = "default";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmic@60 {
> +			compatible = "samsung,s2dos05";
> +			reg = <0x60>;
> +
> +			regulators {
> +				s2dos05_ldo1: ldo1 {
> +					regulator-active-discharge = <1>;
> +					regulator-enable-ramp-delay = <12000>;
> +					regulator-min-microvolt = <1500000>;
> +					regulator-max-microvolt = <2000000>;
> +					regulator-name = "s2dos05-ldo1";

Useless name. Please use rather names from the schematics, but I guess
you might not have them, so maybe downstream has reasonable name?

Best regards,
Krzysztof


