Return-Path: <linux-pwm+bounces-2095-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630F58B13AB
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 21:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40B61F23E8B
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95F3762D0;
	Wed, 24 Apr 2024 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnTp92i3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F136678C65
	for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987542; cv=none; b=jtQMKYha31bswQhQbpqa9FUwFsEfAoD08WIjN6UtFZGHdecm0GunPln0mH8go1ek8kkkCUTDHarje0tWJzBuIfCtMjSF9Z7nOKmcwPEwNKltJZ2bUmpebeWCyXkqnPSVxR1okk0r2X1u90GT2pcZWXTr7BLQGDVMe9T0mBERtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987542; c=relaxed/simple;
	bh=ZqTzd6GMt/fiJJaaQjZVUtPvdBWkCBKV8o4UAHsH4Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqa564+yO1McPPDhtYWPgD1x/+wvxgGl1abKec62OEih+nYnTHfa69+KV50f6sU0VuKUmxE4sBvFEIuWeb09u3ebFa6Z5sU3CSri5UOSnmB400vgQFibhGAJ0tT05R8ZozW3LzFhv6PPVWxfR+aJ09GC54jFCVw78Z/D+nfwJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YnTp92i3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so2241011fa.0
        for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 12:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713987539; x=1714592339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZYXf5FQbLErGRBPIZbwjjZKcA9SV/r7uJA19KAu/Yw=;
        b=YnTp92i3i71xKeVmBxDwPHDrIDoAkowUnzRvjQOFcMj17TqpHldWWlg0WPBbv1tZS1
         ie2zYgx2u+gSKzMEzq2hGRP+TSS9Qft84Dx7lqLfj89J6N4+pkFYoO4bV/aKTo7+3AKc
         T6oGKFsBv5pT+f5iH4nexV+W5QvEZTuwqmIpP2sTTpg2XMHU5ht7kmwlRgrpruhfzqaC
         sEiIcqGNpozcnioU7DxAmLWQJUbypyvUpXMU5y8vAvyiE4eLSBkHSJMax0w63PS9Mws1
         N9gGdwVG7PSinJXzIWRNioIALhWJb+Q+Z+RNWe7140i2rw2pEhtYs15ya1uzNB+Scxq2
         N3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987539; x=1714592339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZYXf5FQbLErGRBPIZbwjjZKcA9SV/r7uJA19KAu/Yw=;
        b=ItpLZhXzghoCGJJLHn3eHZRRd2IgyAYxabtPZMUQbS2er2UCtdK8y9UoEwDKWeTd5d
         4se0tj/v8/MydVaUulterTodG7STcNm5IMR7EJR+aornajfwGHhlL5Q5ZpGGW9vTKz+2
         ASl9nxMWQy6iuT+UFSSR0E9HVxN4gyxdaGai3GkSqyZSNuK5dgSkoxGakhf8CK2hySps
         iE9ebIUj850NOFxM3pyqKdTxtcNCvOgjjR/y3bUmkOvvIPoQDVemg26blVL9t7GmdPwh
         P3QQr8t3FHPPR3jYuf8PG1O7lu0+aldEndt37rOwmtUInZyzrPKki68ddlnVokqXJ3O2
         pr7g==
X-Gm-Message-State: AOJu0YzpvjIn60GDR1AXF08ZPvSZQlZt/mk6yUZ8hlqFOPYctJE9euRp
	p+wYnXEgWnYqxn0GzAio0PX1FVYwuBsEqcYNpYOVGHlFcGjQ+jv7weGWE0G0N7o=
X-Google-Smtp-Source: AGHT+IGSVxrR0Iz8DXzUJljexIWXhVudz/lf75SnOdPFt3EleNTKOAx41xfw4abru9MvTfCcXkSnsg==
X-Received: by 2002:a05:651c:10b3:b0:2dc:bf5c:9648 with SMTP id k19-20020a05651c10b300b002dcbf5c9648mr2007333ljn.19.1713987539078;
        Wed, 24 Apr 2024 12:38:59 -0700 (PDT)
Received: from [172.30.204.223] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k24-20020a05651c10b800b002de47101c98sm484229ljn.16.2024.04.24.12.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 12:38:58 -0700 (PDT)
Message-ID: <98c013ef-7d03-40ab-973d-cc1d674eef75@linaro.org>
Date: Wed, 24 Apr 2024 21:38:56 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] arm64: dts: qcom: pmk8550: Add PWM controller
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
 <20240424-ayn-odin2-initial-v1-5-e0aa05c991fd@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240424-ayn-odin2-initial-v1-5-e0aa05c991fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/24 17:29, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> Add the PWM function to the pmk8550 dtsi, which is usually used
> to control PWM backlight on platforms using this PMIC.
> 
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

