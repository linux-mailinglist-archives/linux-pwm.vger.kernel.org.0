Return-Path: <linux-pwm+bounces-3252-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A5597842B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3E9B25956
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05F417C985;
	Fri, 13 Sep 2024 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQQS/Xxe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387E1741D2;
	Fri, 13 Sep 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240148; cv=none; b=j/9SUxL09fIJA83plvRWAzURCy0UgDqNJR6McYaTx2SxcDuPLWCJS/i+HHfz1Dn8p33QfmobiEWW4bpnlB6ce2Za2Yff7mXjSFNVsYO2teKcAZ+tkb7XFdLBAa1yFeFNarlC+pyTcJG38Hz6t4sRyQZQw+yTwOQmlW4gIi69HLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240148; c=relaxed/simple;
	bh=LXgqSMJKPpptWHRjG5sGV+9Z8Lxj5jA8H20WF+m2cbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzjXhOcic5K1jPcFg8yBfqzk/7qhp3s4exbf1OuGzx2ORZYbVyC2FckdALwUMVvm1b77JPBkEEnJ7iapQW0q2GPzKgPkRLEmdwjSbnWRX64yJwz1HYiHC2PYI82oCgA4WftWlg4HgbOJdK8oaLtra5KCT3suwZrSVb7cy80M7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQQS/Xxe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so5035339a12.1;
        Fri, 13 Sep 2024 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240145; x=1726844945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxV+xEnMJ80gLhFAUliu5RFc0rPgxSLDZdSiAt5SbDY=;
        b=EQQS/Xxelu+FR7SEbvn9S63BGGBOtVO2EsD0ugfH/JIyRLxj5M3Gb2l60xW+Uq38cB
         1EBJlxbPorimkklOJ2dml0k9DpqvQNWtleGGHj4+Q+ovmkIph5RYHCS8E8L1tgPF5XTU
         BvAtcGGbYcuXxGNM+SR+gl1HQ2+YP3LYRHkYwOh058AbbgxCn5JLrkq1XDRXgkv/YyPr
         NNZnbCSYVqQrEytdUY6e4OlGSEvyb/750Pu5oRvxmulwcGvXlBD8n48BaiUYtVwcurnl
         2fJrhKnuz7ftefUazDiTalof6tdPzGbj92t2Uceco4eZFyWgyfh0HpgDnhBC+B/Wso3Y
         YWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240145; x=1726844945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxV+xEnMJ80gLhFAUliu5RFc0rPgxSLDZdSiAt5SbDY=;
        b=btO3In+sthG2C76FWb3Q6pRaaSEFiDYSNp90yMvgiJzP2Vwrk2ZJhOXmdVkb5+1CDm
         bGe8ikF4LNBOGtbdwKnbHT4ww50+8osEkYWmpLFkgGTgT8h7DDiWp3XtiyesgIcpm9Yd
         kt2cvT+PR+tY+ESq/Zc2tTuRts5iGWTkFmFuXPF9xKFQF3dhreZGzigmZUvUr5G9wcpN
         ERUlScvorbA4FRTx+rwtAwGaaIrPQY12a6ZSBJ4pZBGFN7ULKHL0cRE7roTx+OAXSz3Y
         GMtmsw69478nwX8UKKwhbIeSo95o9Igi7KN3a9af9qGQsrbYhhA7D/Z8po+XrYRo8o/6
         bOkA==
X-Forwarded-Encrypted: i=1; AJvYcCUAj+qhojwK5PW6aK1eIVQDYtYCcdt1sORYCBq5ofjXs911kHFPtvK5+YuUJCfcon1xZzf0OtBHWcbexWoHBw==@vger.kernel.org, AJvYcCUENAftURWFA4zm/sme5z3Lze2KPQy7m3ah4jztBYWJSBTOAJBJ1Lh7CPNwii6wsZfo7cUnLdoT8QU5tRRLfSWHBbA=@vger.kernel.org, AJvYcCUG4BdB6qYvZTgMErbrbA3iYvPwGQEkCWkGkhQo9Jjooxn1iVEpmKiBgA8h3t9ZDhcAap6qpgqnsONqYko=@vger.kernel.org, AJvYcCUe01Jrq8t0mz7dzVh45z0x2YyDeNKnesDzA2hbcIUv8/FNrtvw/EHimugR0qzlZhAU4Zhp4XipXYMGpt2k@vger.kernel.org, AJvYcCUqmW0zIXwe2TRASlIo3yMV2IFHqeyjgSIeaPOwwwTmskWxOaBQM0eQgzTJxnISExbQqTecMsc2K3eR@vger.kernel.org, AJvYcCVDhgRfU7xlaxnWje/pio3DeNi392FW7mh95CuqwvKFqIc0ZXeZ2F0KashExvm42GtAVoCzX8GxCU1+gg==@vger.kernel.org, AJvYcCWws/1XFdt0fnaiw/gig92Zqq1hmjDqLAXPOARwLA4aWAp2BPgIp3Oo/+RtTnAMgfFtHoftLoEYE88J@vger.kernel.org, AJvYcCXWRMAeJoGvSx7pOz9vQ/zGYDAJ474fnfQFzHqgQOluBCUXigT1iYQsBmhRO84KzIxVif8X8oIBWiss@vger.kernel.org
X-Gm-Message-State: AOJu0YzdhDemztQ1I6PKj67E71CiourMqtcXFingxrCQqBwRDUJwN2dB
	dyce2FXttD/97yhqnFea/4oBrYARjG9ICRVduHAcPKSCzvUdtqAj8YHNyA==
X-Google-Smtp-Source: AGHT+IE9SU2tpS2E9sl9JrjbS5UqYQlYYcA71JF3FE/gLt/fekYWBC22Y8MK+YXR/Dgfn1wLaGW9/Q==
X-Received: by 2002:a17:907:7fa9:b0:a8d:2281:94d9 with SMTP id a640c23a62f3a-a8ffae028c7mr1249506666b.23.1726240145089;
        Fri, 13 Sep 2024 08:09:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:03 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:02 +0300
Subject: [PATCH v4 19/27] arm64: dts: qcom: starqltechn: refactor node
 order
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-19-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=898;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=LXgqSMJKPpptWHRjG5sGV+9Z8Lxj5jA8H20WF+m2cbs=;
 b=ccx9XcsXSNXZtx3lf9Znb3XeO7LO64xR3paL5EbWRnSV/g9CK+fRNlh33SCZEmc/R6lgJx+Yv
 xyj90eigHrvDNDCg5PpJ/w03ex0PS4D+JyOJ025QSdAmZbS3+VaT2iI
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index f3f2b25883d8..8a0d63bd594b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -382,8 +382,8 @@ &ufs_mem_phy {
 };
 
 &sdhc_2 {
-	pinctrl-names = "default";
 	pinctrl-0 = <&sdc2_clk_state &sdc2_cmd_state &sdc2_data_state &sd_card_det_n_state>;
+	pinctrl-names = "default";
 	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&vreg_l21a_2p95>;
 	vqmmc-supply = <&vddpx_2>;

-- 
2.39.2


