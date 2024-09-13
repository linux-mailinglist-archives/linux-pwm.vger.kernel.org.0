Return-Path: <linux-pwm+bounces-3253-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D250978437
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25551F258BF
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3C418733B;
	Fri, 13 Sep 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWs4o221"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F65185935;
	Fri, 13 Sep 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240151; cv=none; b=SAzzLZV9kpuvX/M0aKaJqAE6k88/guIVCYC5QLo1S9uAisE9ZWCmQcF4TDoHaUR/qXXtdIE076TF+yOKFH6wLFzpCt+honAc/AWHFxVSBuoUGWYv3M0wK8OKHTIg0SfxUYGuYJ1I57Y8bOw4R4eXp/5OpV1fdO6NoHxHUfffF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240151; c=relaxed/simple;
	bh=v2ECB5b4RvqZNQX0iHQLIiWI4r9KcdLBWF4yxk3AOSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbd1mVPMsgnfVF0+zyKySnaA8msXoLsF4B1cyCYV2BPLQTxgzdzyFddEz9XWNLqGeC6enFi6OJiQUXZCnI7xAZP//rEULWjm78qmU4fz/1xsP3HZSyrJdmkPhJ9y+ctl7lYoqniUJFYN+WK08rEgVscFsiA+HB9LTWVYAloEfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWs4o221; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f752d9ab62so12227591fa.3;
        Fri, 13 Sep 2024 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240148; x=1726844948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55ASwlpj93CUVgS/uPubEqfpV10Z+LfDh1X/v5EhTrc=;
        b=NWs4o221nBkCsWgtKoECYtwJ8xJfCIg+zRoz27wyH0II3wdcgCYpLUFwLhjq8Q6hty
         Qe7VzohsNkLAmj0NN4j8YOQPzuzkEXou1I0+RvRbo68abo/Ykr2zZDNqB5O/sPUIoxVU
         jOKfo+mtFtG+gjpcJc1nGV21NgSQtP1vCcf5wJj+X6bT0CdvHqc9JH96aeeF86kSYCWE
         eaOt2f9iozSA96hVgjVbVZvc8nJnqLTQl46hXtpJbs1sCvlZ+shF9tYFRAUk22zatfjx
         u2aL7Zqbiy89bn//I2cB7lVxdQlfjYIJ6wUIPDHgJP1vFp+AtJ9KJ9ExRnSKFduG7O+4
         hveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240148; x=1726844948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55ASwlpj93CUVgS/uPubEqfpV10Z+LfDh1X/v5EhTrc=;
        b=SohmWlPAwUhF1al2yItX2MRKHlhc2tUL/MuujmEFGB6F9pOkP9U//nUkPM0Q5/YeU+
         8u9nd3QFzpl159TCAweHxlYyFJhSVVcwIn+soI9T0hRy0SOAg4naBD9HMCzNXkqY6Cgf
         SNYVnEvdfD4AZfQOeMilB5p1xf9nmBzpNpQHz7Zd4PlXh1Ydp+LUXhZw4mxpYbG3lEYL
         rph0boeyUtDhKnpdvbQw+/Y46Wbt51sGgvy9vEiSVS3AYTdHWeAaHHIFLT+S4kPRtARP
         vTo55ZP3f90KSpBLjrpKylgkYmeNZOSyHLZ5N8AKfaBuqxWKCSe7a453fOYHzO4tCCiH
         gU5g==
X-Forwarded-Encrypted: i=1; AJvYcCU4PpV1LZhNdJp7k6kyUdbITsbFjUs3LRVHoaD7ziTwqnI7eU1BlwepGy54htMveUKU4/xw9dxwU6k9@vger.kernel.org, AJvYcCUfT8nO+u4GAaO+Xu305QqiS8uV5S8oSZYGejmCKWdbOZGD7rZe8puU9Qe+Azfm4YrVlo1KOGGGXU4C@vger.kernel.org, AJvYcCUvIxMTGkIs0YY1xPj7qGbgGeSs+irLzRA5BwkWLEUq2SK32rCgnGAFpVwIOyqFt1jBK/fO2X4Q6GspxjeV@vger.kernel.org, AJvYcCVBGS67PyUNtRmFAMd2BzetKUjLM0bGOokg4hTH55Sl6Zsiu4mVoEXxnLN6/yoRM7yMdsKkC0t1mkg5kghGgRxmxa0=@vger.kernel.org, AJvYcCWij0RFladrh/jVPzIDfJaSevubP6qUhL1fQEDiMKIHKN4qb5H6/eAgHrV4V2CNMlxJw0x1HovVynRO550mCw==@vger.kernel.org, AJvYcCX2KG5xaudZZiDVutiT/Lk2SD/xmGrHcidNiSrZin+mq1Q8d/Rp8S4BJd1PId9KvIoE2X0ZfYW4cB3r6Vg=@vger.kernel.org, AJvYcCX4dI/2mSIcBwfKtv2Dp5pP6LTnVLeQn8f1U5emd5uwJowyMrJg4AHYsFjYGPZl/vTJ9ADRq+igvM6Bzw==@vger.kernel.org, AJvYcCXaCB7YEvnqQ+/JpmHivqC3HRxv4Vbhp5e+Mcczs4NAiwPn9BYH6VpqTd8hS7qZ6Z72f2UzkaxGnWIx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7SpG8aspAbCBgUSI87PdVXyw7xblMGqqbPyTRVD4d01SziMH2
	/hrHj/qmZcJZLELEeHlKFshYX4yWWU5ZyW5H6P+v1rZc6cBgazVDSsYUyg==
X-Google-Smtp-Source: AGHT+IGTgrigkN3pYFgry+y4pbIiHE6qcSI1txzxF+Y/VDsmiKk4E4issoAeEk9L+DNueAZu2NHRsg==
X-Received: by 2002:a2e:a99d:0:b0:2f7:5239:5d9b with SMTP id 38308e7fff4ca-2f7918e095fmr18494721fa.4.1726240147864;
        Fri, 13 Sep 2024 08:09:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:07 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:03 +0300
Subject: [PATCH v4 20/27] arm64: dts: qcom: starqltechn: remove excess
 reserved gpios
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-20-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=1067;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=v2ECB5b4RvqZNQX0iHQLIiWI4r9KcdLBWF4yxk3AOSQ=;
 b=4rmtARmU2EIXalBZ1YEh56okxvR/WWLGICjzf9qlRYTxw4Wc2L5F5ymCc5pFjSqPbYSbY8eqF
 A4xNCOKo9FLCLQtQSVVyxjvBnH72jTVfhz9UR6iFZq/Bu+mqtgmcbo2
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Starqltechn has 2 reserved gpio ranges <27 4>, <85 4>.
<27 4> is spi for eSE(embedded Secure Element).
<85 4> is spi for fingerprint.

Remove excess reserved gpio regions.

Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 8a0d63bd594b..5948b401165c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -418,7 +418,8 @@ &usb_1_qmpphy {
 };
 
 &tlmm {
-	gpio-reserved-ranges = <0 4>, <27 4>, <81 4>, <85 4>;
+	gpio-reserved-ranges = <27 4>, /* SPI (eSE - embedded Secure Element) */
+			       <85 4>; /* SPI (fingerprint reader) */
 
 	sdc2_clk_state: sdc2-clk-state {
 		pins = "sdc2_clk";

-- 
2.39.2


