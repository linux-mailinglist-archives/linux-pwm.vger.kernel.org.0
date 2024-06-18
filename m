Return-Path: <linux-pwm+bounces-2519-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283690D45F
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8629E286B41
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0545A1A071A;
	Tue, 18 Jun 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6fjO+km"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E303E1A01A0;
	Tue, 18 Jun 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719236; cv=none; b=gYjytO48/UBPgAKecbQRD1hLhe5qw9VmsdhJkoJ9c5xDvrh6xk7KOa+Ug+O4bJwbId3H1IqZ4DvvfwQDB1MIzlyPKoU3St1Y+sJXkN3kWSwiVy6lME+Gz1UjALiqV20NsYcZ8MmHfysX0pCMtPzyXKr80l6rAIylPJdBUI/rlbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719236; c=relaxed/simple;
	bh=MWsqiRVXsQwpa/BJsSBZlzlVtHIs1c7rhP0PmAUfrYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MruAjGMNCicQyxF/DPA4mKxIF1idDE8bwQHzoABKfxPQ7CXOCAWRchDscRDSTcAlQIx5M/Ptb0U4RckzQ4p12jGr6E489aInYtEwJs4UJecGJZ1SSL8uUJB+ZvNVL9dHm25G45MUsAxcNYNnar6NLATe8TUer0GuQc3ULmZFF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6fjO+km; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cfe600cbeso767945a12.2;
        Tue, 18 Jun 2024 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719233; x=1719324033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9Gf8rtcSoFk0i/i8QsJvx4g8bW8LJTVUFR2J5NOhaQ=;
        b=T6fjO+kmemNjYRnXPu12NFYyRMGuOBd77TzgZz7mFCEdkUzv1hJBiDfSfooKEcJVJz
         pUOf46Ibit45vNQJMBl6/pIYojBaltUz1Q80Nk92vEALPeECGBXPNPgIeUQKDjVABkJD
         Z7TilmOIPrlQFVNwxwZcqPYDn2rWqim6ss9E/kHDafVoovCGgTs/I9DXb+bAdyqT3yMs
         YIvN19yQfJo9gUsyDkmwJpfqv8NnT1O4zyxhWoOdikn3J+O8IT+dQKzMn2lRO1F5yIBC
         Bw9OTPToE72xk7E8MLPqqWi0r0HKLTUwrpBgcbiHfythxwBgURscIP7M48lrwAyx8hI2
         0JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719233; x=1719324033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9Gf8rtcSoFk0i/i8QsJvx4g8bW8LJTVUFR2J5NOhaQ=;
        b=vrdRBlwEiDVkVEmL+z9MUnZXY8jxDuRW9irfTiwI6hDBpYLg6UV5MGIwxeurzOyMyE
         hip/XxzOLfGkaTxremS4AXdmHiDlQOpyZ8qNM9sHSA2JUSKFQe0nSscdroAuKxMHlddM
         1BmPfiIVQPmc2Y2Gh6yi71n7FoLeZ5vhtbUjmiOqg+DDStVzg/i+PYmaPtnB7C+7bBHb
         WjtFynLpLZC+ze1KtRKu2e1+vqu8w9zaatBYb17ggBlCAaVP8dF0W78qmxJQIih8IrYU
         sntWcoGmIEeCbuGJeGKiPHWwKZ1YbLgJL0N+ErEZwKkNnCs8VzWLJpFg8qvw24eVirZA
         UOpw==
X-Forwarded-Encrypted: i=1; AJvYcCWX6eWZN1eUzMFU6L6cnVz0r4ojsw3ViHrkAYUfWUKQBArGJVqtx9UQiwUNNnqe5Guufg7qnJ7eCDDa/FwpfD9DdJpMMGe0Ty8MA9Qu13SXFkZLolZlKmxc8jJG4fJDKYlStHxZF3W64a5+c13RHaEed2Q5aoI9L53aMbRYJK3g6Yxc8PD+TE8md8TFc5b86BaRpnqjzzSRjAhpvmnLtLbLAX2/R+RcQwGSCYh9SOduwm91TAck+lxpEZemrh+Hw5j1a5gAsbmqPXYAGOxb/PYLypbEEF36t7yZtLJ66OniLwgtHP1PLr6JAnsvwGvk53vMnMmqub2V4DlAg5OkxNdRAKH67+3ZGTlexBnxVQBAu3UGU2VVhtkXbFrSQp2vzKQa8e/8kjBLQ9Jd/NVuMZkPWxywhOid
X-Gm-Message-State: AOJu0YxUfaM2S22gFeZ7FgKAi++3TN/MPdTXlNwenX3DbktQ62g41JZ2
	dG/RabmsFD7G+guQJDkFn1FXar6r2x7TcsSq9G8IrfaH/LVv4X40
X-Google-Smtp-Source: AGHT+IEzlujelQJZgkVk9tQETLWjgeiYiRGiSHlbCzMcWjnBZo37sEMYpBAy10o1Z/JwAfiRNQv5Xw==
X-Received: by 2002:a50:d51b:0:b0:57c:c171:2fb5 with SMTP id 4fb4d7f45d1cf-57cc17169a7mr7086495a12.5.1718719233288;
        Tue, 18 Jun 2024 07:00:33 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.07.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:00:32 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:54 +0300
Subject: [PATCH v3 20/23] arm64: dts: qcom: starqltechn: remove wifi
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-20-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719185; l=998;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=MWsqiRVXsQwpa/BJsSBZlzlVtHIs1c7rhP0PmAUfrYI=;
 b=CAAGH21zd8iXQILS+hUtOdlu9JiX3XNwrCbwiN0odP2njtPSc+QFw5o7AN1NWe7kfsnx1w+NM
 KcvYyY+WBKUDjmAQvVktkCpOX6OsdZf3SgbEbhhMovjd6H42UA08T+G
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Starqltechn has broadcom chip for wifi, so sdm845 wifi part
can be disabled.

Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index d37a433130b9..6fc30fd1262b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -418,14 +418,6 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
-&wifi {
-	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
-	status = "okay";
-};
-
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <27 4>, <81 4>, <85 4>;
 

-- 
2.39.2


