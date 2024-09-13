Return-Path: <linux-pwm+bounces-3251-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859FE97841E
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B66289C90
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D1916F0EC;
	Fri, 13 Sep 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+Pk/Wzt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F9156871;
	Fri, 13 Sep 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240145; cv=none; b=pn8bx8QhZWz8lM3pyDa1HlJHLBO/Oxce5lHOdaqNgO5WeZjnV0xI9PR0UPMKTMCFGVqi3qQnfockByfCwf4j9M2cDRy87w+czaL2psKLRNChPTkrMUTqLfSMilcU7i0GukAx92jVrY+Iq/k/uOZuZwD5U7gMDrDa2QmYQzOY6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240145; c=relaxed/simple;
	bh=HSWoKU+U+LciT4YeTMc8x2BUj723ugWiGdsGsQ5TSgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3RqhTmJAfa6gpAXY0OeeuOp0OrkN4lbNEZMDPhpqXoHrJ8vaTDwHamMFRyXwibwqaUDTemoExyJYQWkcBYR5v9Pmn5WmVsMCf/q/BU6gaS9jUyx6m+1iMX98F/YK/15exc4whkofUP65UZbppwItST2OSMU5ToRKsge1gPQUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+Pk/Wzt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so3784986a12.0;
        Fri, 13 Sep 2024 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240142; x=1726844942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXU7Bk7WbuxNrJusNNOpHMNB9jnyfgFFtQVMoYQpR+c=;
        b=C+Pk/Wztsj1YTOaALYUmaADnjo6ukJirZNbnpDH75cvetONlIMLl3CJdYBDYnTp+hl
         qUKhgAC63UZY5XJyZhz2B3f3wssTLuNk277w5L1WC5ZqYdQZkcfG0v5CwmakrQAj1Hxz
         v7gVeovWkDGoBNRBZcRgfYSCKx2K/DR9MyL2BnCr4FTpDGjSEoV6OC8PXpIpKTnjwXyJ
         hE76skqlWZLQ/mIXbfcBz1aSIEZF5tx0CcGyIKCaQzoz/kCVtW7SvwavL9g4STgWiKli
         +3rPHS5WGLLLMpGUHmtYYfwKW0EXPRRFLsGyORJ+Q4dtQ47/5xr6jNg3yk33Qqte0jrd
         vzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240142; x=1726844942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXU7Bk7WbuxNrJusNNOpHMNB9jnyfgFFtQVMoYQpR+c=;
        b=MQYVz/yb8X1L/3juheg7W64lLSymsItpHQQAChGFmSnhjcbBU5r57Zpai5LrnWrfU+
         Se3Vs4y8rEL+VcA9M4JXPbQQQYOLPSrPSaQkIdwja45wWeA5eAnvBVU5GJM2Z5Y8jvt+
         mqOmPB6U3z0AkcAxoLpbQqvv8yzQ5ryc7LFNooSov36b7IPIknliZiaBYiP4QircjTPc
         I++ILfyUEDSGUSetq+oVt7/aN5WoaUQgmgN69FySN/1ZJ7A/gMkzM1DRcunUj8L9SkqZ
         CZPXiomxE+m1IjRv6lU8gzqRjtwiMExin1pbNg1ZiZZTVAV2OWLufaUEGJ2myZDV1AU4
         fO5A==
X-Forwarded-Encrypted: i=1; AJvYcCU1y90E/AlNx81AOxb6lGOjVi+gacXkY2xqYGqUqdQuPvUOrj4m0D0nVvwPoTxVFVVeObmQWZ5eUb32@vger.kernel.org, AJvYcCUBW9BSvWEd3mQRfc6r/GxVF+ZL6FGtuF1HPHuNBunOb+75eHgoOu+oGCKo86Eb5OnsMa43uzUwWxzcWk8=@vger.kernel.org, AJvYcCUa/XUWzgkAiRoiCCVJbcW+V+xyY432Aum3YXzSNyR4hDPcQBh0KFLSEm1Bo8DVYvUBKJQiDnBpRr/TLnyX@vger.kernel.org, AJvYcCV5OMJtLU7xIc8J32sTf8Ckhn6tssMg74G7eRCHPTvMLW9QggjWi64+OYhZQkJqHbqy2td9Rdr7eXZM@vger.kernel.org, AJvYcCVTdMJuIN+RsJepQN9ehMQZNFXlydwr/LiikgdVlFQBltassvwS1oE1rM9oFg7AKV0YbaUnpuARVPi+YQ==@vger.kernel.org, AJvYcCWSQo/kLRWShXNNGoWQ/HhzBNdf7GIsHZ7zuD9QMmk4HlMxryi0ckIF9Y8SnuFe4QQHsRBBnqhqsfEoDI8x5k5lW84=@vger.kernel.org, AJvYcCXLXvUY6b7TahGEtnES2LrgL7cLCSnszWHmfv+FXnMFlz6LweX0evmnL/+uabf5SlOVdQ383Pi7FbVyBeACsQ==@vger.kernel.org, AJvYcCXPdR6B4HBntPxVNTOXjG7AcDObQBBdpAT/+WJdnlD33IDLt5DTmefqM8qu2MgGMIykM1VipI8Ay+Hr@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0xrRRlQsj0PPjfRPFfIQrBBpV9qoioDIzAWrWMuDEMH91X3e
	l/P6zU8en89vfLxcYAI3yIrkzo97+QzpZ+TzvRPvTQzoZ2z1jlkWsbIK0g==
X-Google-Smtp-Source: AGHT+IFPFN2hgO9Tc/ykeRzTBK0HjTBEB69PqXe0jnVSoprAC4LV1n+xcHFAg/BqAAvInrtE8uuQOA==
X-Received: by 2002:a05:6402:4144:b0:5c2:6f35:41af with SMTP id 4fb4d7f45d1cf-5c4018e5d05mr17183384a12.16.1726240141881;
        Fri, 13 Sep 2024 08:09:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:01 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:01 +0300
Subject: [PATCH v4 18/27] arm64: dts: qcom: starqltechn: fix usb regulator
 mistake
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-18-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=1140;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=HSWoKU+U+LciT4YeTMc8x2BUj723ugWiGdsGsQ5TSgI=;
 b=D+7T9Oxef0XYg20n1/Xa29buVBAn6lwn1W7nUsmHfsGRH87CSRz/m/NLhRujUszUERs1tecW+
 t3C465cB/vWDAK9O9guDMz1HyewrsAqz5qVyv4APhCKKFgtGJkHCywI
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Usb regulator was wrongly pointed to vreg_l1a_0p875.
However, on starqltechn it's powered from vreg_l5a_0p8.

Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 6fc30fd1262b..f3f2b25883d8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -135,8 +135,6 @@ vdda_pll_cc_ebi23:
 		vdda_sp_sensor:
 		vdda_ufs1_core:
 		vdda_ufs2_core:
-		vdda_usb1_ss_core:
-		vdda_usb2_ss_core:
 		vreg_l1a_0p875: ldo1 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
@@ -157,6 +155,7 @@ vreg_l3a_1p0: ldo3 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vdda_usb1_ss_core:
 		vdd_wcss_cx:
 		vdd_wcss_mx:
 		vdda_wcss_pll:

-- 
2.39.2


