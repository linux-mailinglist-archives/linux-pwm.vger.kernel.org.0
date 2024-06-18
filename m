Return-Path: <linux-pwm+bounces-2525-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E6790D519
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98E41C249B2
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345E158DB9;
	Tue, 18 Jun 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MyGyVX0K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775B23BE
	for <linux-pwm@vger.kernel.org>; Tue, 18 Jun 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719689; cv=none; b=K3AwXtrFDaqMffIMTa/HCYI+2/3ZqpNHCpPojeHmMzzGq0Uy6SPSvis2mVVHzFWsIEIj5bVz4YeWop6BrXNKZL7NqgFP2N7coCBgZMJEYQT+nM54xRKgHmqc0ykPTPmv4BZ45Unvjwo4gj8XRv42W36kg6K8MQmyFm0kYlMOJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719689; c=relaxed/simple;
	bh=n+QilORxP3RK1yVnaHzKUmNkVSKNJe6tBhnWisHRmlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPYk0cGOepBqo1xIdDYFS6iWHgX/szRsNmTkixFi2tshDp7r21PKkY1V2X/SGDlqbEleYCUEKF/uzs7DCqBa6+K5y1C1KtYhhuCbRDE02FOQO4GJB8YxOo0XdI7ZHzkuy6nUgs4sl+ug7/3V+XLkoTGsUkfH2q3WsIzcKktHVdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MyGyVX0K; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c85a7f834so7030580e87.0
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jun 2024 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718719685; x=1719324485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPYowminOVvr+nmoaSaS+pLCI6yVw569Zh9cdjJsE7M=;
        b=MyGyVX0KL2B1uTed/G7P+E58qdzbpV+ZiM4cp2Fd/GzqbTTWJXIKfQBldd/YEmYOL2
         0UNBV3ZkNIAr/JRnUI27SPV/OQJo/Eq1QOFzY8ebgfxVn3cjoNBLebWtKuSCT+ogdfJn
         x+CZyxLTnF9tE3Tj7LYi+QlthpetvcVgtJX2fjjDyPiBMIbqGazw8T4OmY71mRHhz/1C
         Rc/nuJM0QHXgMgTR+m3v9rvYdY6gFlClpi8HKguMEBdMVrdISbXm3oOr2gF8zjQMMb5v
         2pnB8eH3uPq+XpeSz2M0W6IwQc3R/u/SqXwUUG0AJbyrgOzbSICdZJwzqfA6++RMfcuH
         6fAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719685; x=1719324485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPYowminOVvr+nmoaSaS+pLCI6yVw569Zh9cdjJsE7M=;
        b=VsZDe/9bpTcOhmtRD5OI7QdYqQu8Nq/PqQwDhJkiQtasCzOm187IZQJvV8cdz8IaCh
         j5gDb81CRewYNmfm1bCvpZgji2FONDxL7OIwYt3OYk0kF9RrYjUgfzlT3xWgnAZXU8I5
         Xhn+K3mSeoZP48AeOJYdU3+WBwEti+9MlZjn1Pxzbhm7LXWlh1Yykj0Fw+7Wr1j5gUIZ
         vGOivdKuYFXMolQ/TKBb4Jv0z+Vyn/4562njnSW4hOakt+304HLIU19U/zsnATJyGv1g
         5YLVyuy8AKwF3bvS+7jZttzefTGZR8CBvYKNNBY/p299vf148qVVb4Jqwi5a1tVHtjBP
         F0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUEJmPiLWXQs3ILcdd5eYp3muyKLnZEe24tlgvnUQ+4+7hXkGOSpv1EQW+kOKoB3z2pAOkOJpviqiAcVNgVYa76aNkl4FVJJR4e
X-Gm-Message-State: AOJu0YycJ5ljfiyBXcNCDj0aCX3Tdakhf7LLV4KE+akjTE7Z4eoYkZpW
	9dzBqOjKfK8v7MKOODAfpBLrPS31VNWz5krmpcWjMUt7+YKQ5xtx1uToGJ4YABc=
X-Google-Smtp-Source: AGHT+IFjNs+7IdOYMMPvNdFNexxA9RGwd73g79/svh7QWdlywyc8T5oNxWK+VByqXQUr181S1dbiZQ==
X-Received: by 2002:a19:8c5a:0:b0:52c:88d6:891d with SMTP id 2adb3069b0e04-52ca6e5637emr7805302e87.9.1718719685041;
        Tue, 18 Jun 2024 07:08:05 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282581csm1520479e87.37.2024.06.18.07.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:08:04 -0700 (PDT)
Message-ID: <e6a81932-0609-4476-82b6-43ee30b7de43@linaro.org>
Date: Tue, 18 Jun 2024 16:07:55 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/23] arm64: dts: qcom: starqltechn: fix usb regulator
 mistake
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
 <20240618-starqltechn_integration_upstream-v3-22-e3f6662017ac@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-22-e3f6662017ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 15:59, Dzmitry Sankouski wrote:
> Usb regulator was wrongly pointed to vreg_l1a_0p875.
> However, on starqltechn it's powered from vreg_l5a_0p8.
> 
> Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

How did you confirm that?

Konrad

