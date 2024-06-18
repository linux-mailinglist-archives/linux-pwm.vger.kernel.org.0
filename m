Return-Path: <linux-pwm+bounces-2523-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA06590D4FD
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C221F2330B
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D591179958;
	Tue, 18 Jun 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgk1EWoC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34A17966C
	for <linux-pwm@vger.kernel.org>; Tue, 18 Jun 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719588; cv=none; b=gP31r5XyhgNR/jRzhPW+b4QeNNWCl3STvhZ1q4F1Nrc1R36tpHy37xNV0ztUsAbtZsnwALlIrn0oPv2H5HwhLNhNBMbSuQ5svD4/9xaeT0MKh2VJBW2cDl7uuAcCGv77X0SNNlRqWA3956vQu5o2lBm3D4gtpbW+lHNJrfTwajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719588; c=relaxed/simple;
	bh=7hLqheXnE9W0qWhH3a25KKsYl8gJBb+w+/flsviwYBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nugzj1RoHm28aH9C+tvgvDUamUGTTtk1f8S/GGOGI9cxCqxeqXpZskmFHLaVgpd6bWQL7ZT44NJcBONqsxr1ahv4BPzIwMM7fpwre/1LBvam3a6lHzN27q2ckVOqQ4sEDncA56OHLboORaUiYghoDM4szVOeAqu5AITva1+by/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xgk1EWoC; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so96732951fa.0
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jun 2024 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718719584; x=1719324384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+So+e4AIxy5W1wf2KjSmogFgzVVYZd75IixT8YReE44=;
        b=xgk1EWoCl8tP+E8X1Y51Wk3TJv5r3RQI0LzQ7SWU2G9qHwThPnaWunvGD6RBjFYKD9
         YCaNmldQu6vttxm7XSDmDx0A8qEWy3tSlYi1CpF7wnd1EnHFasUbo0jVn8fQPEeORloR
         q1t3pkpYGH2Xm3rp2XF/EDrQjH+x+p/wz0XzDbtLZmY40W6yObCFGOQQAE050mVoLqKX
         WAAPtlt3cGGI3n9WpfVfsw3IHwDv/rkur7ogqoAlmhzpJQRpmbOgiUiDppAMH+j8pdZp
         RmeIUxq7hmrsazEqaV3dkomjFpkyCuPyMWYGkqWY4cedEKxmT/HvRK8JMasJgNi3rs0s
         ldxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719584; x=1719324384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+So+e4AIxy5W1wf2KjSmogFgzVVYZd75IixT8YReE44=;
        b=BkTBFQhrBJ2WBR8ODA7BB1eaOglfgWJcnlfeNTVClawJnD22xJeH/j5ChRZSeB+cF1
         UY0+Zadu1PBjqqruJ35zasnPW1dxIVNCqz2gxn5WKwj+zir5ObWETxeqwkhzD2ZUteEh
         ZeKkCA8ThmQmTEStIXmYJ0jgNZVmxEUTdJsuiNa9gML/XONDsWESq0xvB/LSNqMjR5c2
         J2mlE1mnZMw2YmkXKdfQFS7OaSd8x5j0O6atDETk1JBJTWFw/oUYFG/14fmvY7zUyNFV
         3waviYxxettcl7ehTaggMuaq8gQMgE9S4o5m6kF5ZMwxs385/OpYW9fsfLLxESytTl79
         Kjwg==
X-Forwarded-Encrypted: i=1; AJvYcCXP7jPpjJI57Of3C9U9bKF7SAw0V+XkieQ5zgsBu3OqTuhS1z4E0qDfoOre788iNOMt5fqtV4ZFvxDDxOxHXE0SrZUsFStU7IXP
X-Gm-Message-State: AOJu0YxkxKiHRVJKwHzm78L8/ISMok6bn4U+HLtUeGV+IwHwH0hZVwjX
	JnaSX7VZyLnNYnPE20i49FmnGmBdRWCiVJFKoNU8OoOWqeAzdv+N2xt35QmUsUw=
X-Google-Smtp-Source: AGHT+IGY5kISvhIt6rGqgfv/SlC1aIqmQbwMlMYxf3oPhg19EaPl7J618YwZRjbodQ1Ardwyi8neOw==
X-Received: by 2002:ac2:44a2:0:b0:52c:a5cc:27e7 with SMTP id 2adb3069b0e04-52ca6e9dafcmr9013751e87.66.1718719584220;
        Tue, 18 Jun 2024 07:06:24 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287ad4fsm1536033e87.201.2024.06.18.07.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:06:23 -0700 (PDT)
Message-ID: <31921e1d-da7f-4846-9d69-4e27d61cb464@linaro.org>
Date: Tue, 18 Jun 2024 16:06:07 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/23] arm64: dts: qcom: starqltechn: remove wifi
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-20-e3f6662017ac@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-20-e3f6662017ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 15:59, Dzmitry Sankouski wrote:
> Starqltechn has broadcom chip for wifi, so sdm845 wifi part
> can be disabled.
> 
> Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

