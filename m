Return-Path: <linux-pwm+bounces-2144-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBB8B6F9F
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 12:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2324928193C
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83E13D273;
	Tue, 30 Apr 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaXcaxov"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A412A144
	for <linux-pwm@vger.kernel.org>; Tue, 30 Apr 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472795; cv=none; b=hBMdm19+gr+obAKRAiZIkAxiQTtFIauZz9dIMTwPwPghmKlgKCL8qRB/wUNoE9TROPm/Sb9X8UwfN5V3Gxl4rswg90gcbjck3GJIEnRA6rQ5FCTeYaIbKNqi7DCOF4DJMUVpk4GcKmjoEWsvRs7Haik4gCnAryWC4GaY8xsMwzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472795; c=relaxed/simple;
	bh=Tx+zXl41UygFVaRh51l0QbdbnejH4NtOtfQ7nvL9xfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6CjXNnFz5Zn59vpSznxi2RFuwvat+V4sxfNF8FzrLBAUDupwlTZO9o0MPbhZoFFQv63tNUMLBTiSJ46kOHhcWqB7C1BSDh9SyIyX6URIfqHf4CIml+vzRv5tlCsMQpgrYj6vdfX7VewMfOinaIU7DIm6YQrjT0lQCLymNG64VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YaXcaxov; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so5762676a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 30 Apr 2024 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714472792; x=1715077592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6KX84ePfZzFlwa4FRm7kcHRU+sZmx+bj41bqfQ4RTt4=;
        b=YaXcaxov6H1JT2ALvIppMrKBW69NrEwfrpPnPsJ/8NLR67o75amfoU9SONVyb7o/+Q
         32/XzGEpwOcN8fFjFLOsLmMzAasV/XSJJnQrqABcVO+SyqLL7znOLxpmD/FcSZUkPY1X
         k2BeyMT7jB106PTlSDiVkZAuTVGAJTigzlUN9KV26HVy3sbmHK9f4UNehG5lwLPmx5Rz
         VUaCnQaElliAAsNFgdnfYOxyfhM9PgeenU1g9mTsnx85SCo+3Z3jSrPOgHYu628PXSXo
         A6IwKH45yPOjCWW82N43gVLI5ehuSdYMB+V8nLd9cX+uBHH1WwxBR/HvsqCqc1g9p8h+
         9LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472792; x=1715077592;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KX84ePfZzFlwa4FRm7kcHRU+sZmx+bj41bqfQ4RTt4=;
        b=ShkafffsdIaokf9bP4oNf3JK1i4EioOT02ZuBnX7IpvheQZ0KMbU5N0eNSQj0bcMsn
         OBbizcLcczdB/XEPtkTa+n71TD6aE3PV4dXwT3MDH3RlZF2HmLcrwWVaVU1FxyNTF3y2
         k4kqoJnHXxllMh54s4rQTvWPhyZiFd0NZH8Iduo8ZZ50/PQUt48ccqPn2PLOWU9jRi1v
         4GSvsHfWwo4ZPlnAiu3lG7mIWKX00JYTmZi69fyTAoVScJiU+brbN/MzWbcClbnlCq+i
         qleRKpS4rZKnwd4peMcOMbykmnGPijRL53cn4BqR9yv+TUMiB2q+quXJ8OH/JGphb5BN
         qZyw==
X-Gm-Message-State: AOJu0YzMWjPWiJam0OCIryfBSddx40EmblK21TOEZhD8e+Bp88wx6G5t
	nrfsCVL0f5u6FRNmoa/uDirWfRTS70exlbRtlcErLv5qczyx5ehjqQCHMQhpIOc=
X-Google-Smtp-Source: AGHT+IGz4X1P5MLr+GfqXOEtE44ttGoPTZTIZ1pp5+OWkfRJcTED2HBtfF0bxURBaOZi5n1TrBDZ/Q==
X-Received: by 2002:a50:8e13:0:b0:572:7142:4594 with SMTP id 19-20020a508e13000000b0057271424594mr5879252edw.29.1714472792206;
        Tue, 30 Apr 2024 03:26:32 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i18-20020a50d752000000b00572336c900asm6934614edj.74.2024.04.30.03.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 03:26:31 -0700 (PDT)
Message-ID: <b01b34d1-aa55-47be-8069-7156dd5be978@linaro.org>
Date: Tue, 30 Apr 2024 12:26:28 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] arm64: dts: qcom: Add AYN Odin 2
To: wuxilin123@gmail.com, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-10-e0aa05c991fd@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240424-ayn-odin2-initial-v1-10-e0aa05c991fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.04.2024 5:29 PM, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> AYN Odin 2 is a gaming handheld based on QCS8550, which is derived
> from SM8550 but without modem RF system.
> 
> This commit brings support for:
> * Remoteprocs
> * UFS storage
> * SD Card
> * Type-C with USB3 10Gbps and DisplayPort (4-lane requires a pending
>   patch)
> * PCIe0 (Wi-Fi requires the pending pwrseq series)
> * Bluetooth
> * Regulators
> * Integrated fan with automatic speed control based on CPU temperature
> * Power and volume keys
> * M1, M2 buttons
> * HDMI output up to 1080p 60hz
> * four groups of RGB lights
> * GPU
> * Internal DSI display with touchscreen
> 
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---

[...]

> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pmk8550_pwm 0 860000>;
> +		brightness-levels = <1023 0>;

Huh? Is min/max swapped?

> +		num-interpolated-steps = <1023>;
> +		default-brightness-level = <600>;
> +		power-supply = <&vph_pwr>;
> +		enable-gpios = <&pmk8550_gpios 5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm_backlight_default>;

property-n
property-names

[...]

> +			cooling-maps {
> +				map0 {
> +					trip = <&cpuss0_active0>;
> +					cooling-device = <&fan 0 1>;
> +				};

Please adda a newline between each subnode

[...]

> +		/* Setting regulator-allow-set-load here will crash the device */

??

> +		vreg_l17b_2p5: ldo17 {
> +			regulator-name = "vreg_l17b_2p5";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +

[...]

> +
> +		backlight = <&backlight>;
> +		/* touchscreen and display panel share the same reset gpio! */
> +		reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;

Perhaps you would be interested in drm_panel_follower

[...]

> +
> +&sdhc_2 {
> +	cd-gpios = <&pm8550_gpios 12 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
> +	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
> +	vmmc-supply = <&vreg_l9b_2p9>;
> +	vqmmc-supply = <&vreg_l8b_1p8>;
> +	bus-width = <4>;
> +	no-sdio;
> +	no-mmc;
> +
> +	/* SDR104 does seem to be working on this device*/
> +	/delete-property/ sdhci-caps-mask;

Eeeh.. I'm not sure about this. Maybe it still has some issues that
don't manifest immediately.

[...]

> +&uart15 {
> +	status = "okay";
> +
> +    /* Gamepad controlled by onboard MCU */

As in, that MCU is connected to 8550 through this UART port?

Konrad

