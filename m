Return-Path: <linux-pwm+bounces-2521-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEA690D46D
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D90B280E27
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D71A0B0E;
	Tue, 18 Jun 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijxzbX00"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E981A08C6;
	Tue, 18 Jun 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719241; cv=none; b=ACcDbUWbn2c3sEyCGlBvWIKk871R02euzZaXYG8EfJLabF1P544IKFTobNSbyGg/A6yiyaJTLoQ+jl2D4yexmo8msPxpWkNgOuLjepQOgmEgrjbrqpQhR+uBZFb9/NqxgZuDcL634KqKxXUEEmkU3za1a7o5jJklmFKeiDpny8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719241; c=relaxed/simple;
	bh=bJDbtUbL+y5wg/waQs7Lp8AQgTgkl1/W9/LG9VfOOh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IA62i/4Z2snKMOozHVVLGNTszWImmuLoQKHu2D7MvokgIgwb7I51wLBtvIND4ayMWwMTXkCqK5bpfY3Gt6B0XRcC2N7w9Jc/bBeNocWtxhCIhu3odxkQYmTZBzhuCqbMDyNcZCYgs2uFMwIHD1P9eoasWrFMLpl/6trAGUpSnkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijxzbX00; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso47503a12.1;
        Tue, 18 Jun 2024 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719238; x=1719324038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKqBqiUFuc0JpR2mqQXDoqJZzafqiedaqDrYiJZ4fmQ=;
        b=ijxzbX00F2r/4e5WRJ1I3xQnFsdGawIiCzG/CE9jaUsncskBryo3TbYVeQqd80H+HX
         iADOmj2g9bNJWvPR/ySAS6D87bPXLFE8/EUa1NIn26oLSh/JspWVTAidzpAvhrl4e1ZG
         1EcCNJvRz73kLyQZBgEXeZbKvHC85rsR6+gJE534Gv+y0QQFzmjTI07gQTcLhg58eDfP
         b/ttHmNKbny7+Xlpn6p0A8nKvjvegRmZ83Jjumgg9JydvcLoM1rVFK2LQnKw8qMrp0TN
         xU0g7VVAOXMGhfX/dRBxLBJ0l829JvIpWKwvcmQxhUd5cLvHKuTfZmvXfqgRjH1l4+Cy
         WbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719238; x=1719324038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKqBqiUFuc0JpR2mqQXDoqJZzafqiedaqDrYiJZ4fmQ=;
        b=BuWpZvNpwYneXTs1G/cLBU5myVTVWnZiTvMMOmoj25ae8/IzP2QtFOnQR4i9RiJ26y
         xOuW2iDFfnq6LmUKepNdGXQ/5MG0hNrtA0jSLEZc/5vtn5nIDkSj2sngsgvFy0p1n9Ys
         Go0b3x1JK5kndnkVFpGrpembCWYwzzlOvkXrswuZKHrS/GxO0VXJHq3qm/1cbqGaKcRJ
         4yQbI27wUTPWBU2CdqgQP9H1U759E7jEy0RT7FMHaLq9lZzfDHoKdx359hMK/8vNAFZC
         UdZ3GiIS4YwmZE7Iv6pARQQJMrz5eLbIkLBrMNoVSIr+jMQakAhio4pNwnejArS61NGa
         P4RA==
X-Forwarded-Encrypted: i=1; AJvYcCUSGXksKZsP9y22A8QC1Sy4BTkvgksTgrXQHYL6lFyK7LOSGigQK7isV0u3Oq9eG+J94sI8pOUTC9KnfsCF7RmAQ3DzzanSWn/9kf3+1LYf4E1QGnMJUikk7ib1fnAM5ODNGeTqNqVmtiPcMLtdQkPfL3c1iIETFxp9eISvYbyhvOiBYwzJoRF4Tfp2CpIqZLzTgfgrs33PQNo6L3cCYTXCOfqEjGMtdkBACuTmqHr75LUBEmnL1iZAnWEke6bbuK7X/xpkRpB8DAMNcgXLdZDDfTwP6JMvu9sgwnOldFg0ulP7IrA/W4LcEQdrcVGgqFW/TyvuiuahKzZiE+9bdWEUzMSjJzxWpzsmzz7sopG7C0UIR06Q+IrHw2eT6FlNFvpfCfiG132A20BT9Yqk1mkEjSnqz7GC
X-Gm-Message-State: AOJu0Yx14QdjWHjLcvJXSM+lDxscaKcDW/DTIoMovfTwPfAQfysoFJqt
	USdf8F5a8G3pGn/WSwYbS54xY52RpRGn5W/XdcWIi64FTv/WcfP9
X-Google-Smtp-Source: AGHT+IHj0NVO2LbmqVwPKLiM4o8xwGtgHAaztxBmavCHO3e8YhM7E9p3r0tm0tYI9onhxvxtZXb41w==
X-Received: by 2002:a50:c34e:0:b0:57d:61a:7f20 with SMTP id 4fb4d7f45d1cf-57d061a7f8cmr36144a12.3.1718719237717;
        Tue, 18 Jun 2024 07:00:37 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.07.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:00:37 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:56 +0300
Subject: [PATCH v3 22/23] arm64: dts: qcom: starqltechn: fix usb regulator
 mistake
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-22-e3f6662017ac@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719185; l=1140;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=bJDbtUbL+y5wg/waQs7Lp8AQgTgkl1/W9/LG9VfOOh4=;
 b=vQvnoeSWgPz4eSKFu+g3ROb/3wWMV5zcWLBJBEbi09PSN9t4bbEHIOEE3tV5BtVu/RZcsInhL
 2HFncvbDEwDAvdoxgn+AsxypoVxKaQ9PVyDF809mOr1KJqn/aQULMnK
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
index 578798704577..bad154b1e894 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -126,8 +126,6 @@ vdda_pll_cc_ebi23:
 		vdda_sp_sensor:
 		vdda_ufs1_core:
 		vdda_ufs2_core:
-		vdda_usb1_ss_core:
-		vdda_usb2_ss_core:
 		vreg_l1a_0p875: ldo1 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
@@ -148,6 +146,7 @@ vreg_l3a_1p0: ldo3 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vdda_usb1_ss_core:
 		vdd_wcss_cx:
 		vdd_wcss_mx:
 		vdda_wcss_pll:

-- 
2.39.2


