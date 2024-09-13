Return-Path: <linux-pwm+bounces-3254-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA1978440
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB5FB26504
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8883189F29;
	Fri, 13 Sep 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEYJ1wXF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91354647;
	Fri, 13 Sep 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240154; cv=none; b=GsUp6hyEXBcokfCfqJAgBcSHtzZZQCzj73bxkM+UrgDPWwF+nRwieycUwvJPsEagVqNDB8WBweuVrPDrnz1iOq0e23xaAck5/T+0PV2Z/XHEjRzFaEjMW9llb8LNf5zWSYB0FdxftTZ91mzhRAxHHX3Nuj+1AA5eReYQy2PFfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240154; c=relaxed/simple;
	bh=o9Qd/8JMpOJPQYcP3TU2sS+epu62uYpYthXa4YYQCgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cM3n0356CNWUOcfs1bgEnfJfxZzvUakWzyMEi23tKwvXSCuM0UM3x9KSnQ8GyX3QV4nJEvqNSYfNyin64+F0hli2Y1bJFIA12HniFQg2s7W+Cp37I2+wfZ8FD1z8OC8JvkO0PyCxdGR56wx5awun98gXHObmouuAZbHdGs7lTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEYJ1wXF; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso31099701fa.0;
        Fri, 13 Sep 2024 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240151; x=1726844951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqCw/4kHuYfS+tegSJD+cV90aIl+wTusfRyt9G+zPuk=;
        b=ZEYJ1wXFUxdl3fXh6VxMD8/ucZuctN+A/jEq3IsT/BHvlHaxoxOXcBu7c7YNT2yMOr
         XKM8AfkYudKj4upLVTK7Mf3rtHko8GroW4wGhx/dgnPVG1g4soZ3FJ1lNw7uTBOzVdOt
         4hyjMiQLUkiXV/qBC9Gu9VNNHl2qFuSQEWF0uTb9ZkMivdBBkOjLdE2286ZbsRFd0C21
         CRoYheZDZCQo2ZtY5RwdXtFna4nyWRkAZj+uVUrDD3+yw1skCQUiSmmxu87rqYKLB0QJ
         +RP5JaORAvuhP4RFAAxQoNE+21wBxy/QVYZvsdDE0dItYVpis7hV7OlLAd4d7z1tCaSO
         01ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240151; x=1726844951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqCw/4kHuYfS+tegSJD+cV90aIl+wTusfRyt9G+zPuk=;
        b=G8hrOKfUh7tKlRJw2qO/N2PBXZ9bF9BYFV/B2yq8dcshFb1gfXH5217VN9GNDNckpL
         LEyKw89d2JDwWuRVrdLxI4UbL2XM82Stl301RMvaBtdBQpZdXHk+qTD15EKcHNs2z98z
         oe4JK20Ri1CsDid0a1blD7wwtP+yDRbWqne9j10LXs/JVnMReLFvBChavcBecaR3qEPK
         uNAt6fGJUIQwdek6NitKWovPh1wJXMTsPfW8X7rc5Q37QyPKYTaPm1If7HbXNlQW2T+o
         yZ80lslNP1hXWGWwoUm5mRjqdXVVngOgTNpBqrcBkzPfqErC+/v71nSB6rdFUDKcZD/w
         4IEg==
X-Forwarded-Encrypted: i=1; AJvYcCUV/D/djQPB+q5edLRj9MIyUNHY/TxV+mJ89DbtTYnjJ2IAmBR+ByxLT9OKI82PRvpaTrpIsLzE7/LnLZHbbQ==@vger.kernel.org, AJvYcCUa0d460KDL5oSL04F9C+1USn35MOQzXXmwJYOl0UIYilW1TOaniPAEz+geimwJH43SirR22ikUKfLy@vger.kernel.org, AJvYcCUe3Cy9uOBjP5QVf6WQDL5OEE5nXcH2/Gq25T+rKe3FqS1p1cfIj+VvXQ6vAepuTsN0FRpErsSvw+AWDw==@vger.kernel.org, AJvYcCUfTvgBzM1t45h+azer4JpimECl81B73GSjN/3OgdPj+1+xqf2GYPnKWKtqvAwmQgSPmyBqejfvAVh5@vger.kernel.org, AJvYcCVC07gJ8ORuv5/6oQRGZgDvoVT5qVRFhQTY4070iHfJ+D8yv6mcXKmB2SshFObNu3TZmoBDfzW1NjGQg7LRxqqoetI=@vger.kernel.org, AJvYcCVeIu5xJMNnbHWyElbd9uG909m5uDtMiag8ZN+LEiKjcIlZw1EdPwU1wE3JW6FEJS3wUaAHnCmfpUVg1JY=@vger.kernel.org, AJvYcCVpdVqFo2T5LVTeCrVLA2hlLQCcWuQ0UTR6YfO5GkVutFT7if4yulEUGK8+kaGpLOdl0FIAplwhC7ss+Jul@vger.kernel.org, AJvYcCWH88PIgs+RKVzV05NXUmJhU52l4/+4f/FzYviOMtEhFGQgPqn5R/hkuX9Xi7r+ERdM3ysdjl5+RdoW@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqIwSHrP8L7bqMiz2m4B60NSBbj3h5etL1kmTO1sIgHIVGNg5
	fwMaPbAXl6e/qQD8MAIJc1TTNv0I8lbY0dJulv3yP8v5HFvrNTYiO7OZ6Q==
X-Google-Smtp-Source: AGHT+IG1Q7xjN4CCu4u9SogSo32R938De4uTV77FDjfykgt4K+bzKzlFr+lhvVtVxKIfcKXPkEja+Q==
X-Received: by 2002:a2e:1311:0:b0:2f3:ed34:41c9 with SMTP id 38308e7fff4ca-2f787f32dc2mr31568371fa.37.1726240150365;
        Fri, 13 Sep 2024 08:09:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:09 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:04 +0300
Subject: [PATCH v4 21/27] arm64: dts: qcom: starqltechn: add gpio keys
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-21-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=1745;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=o9Qd/8JMpOJPQYcP3TU2sS+epu62uYpYthXa4YYQCgY=;
 b=Gc/pkDKuxyPTs3pg3UWl6auHuVwfoE4b3u1agqq5dHZFsSc4ONRWz+4NC93OHSJAhu/oPayI+
 RcHdt2uTR0FAbMdall9kokXqK0okx2IEy8ANaIXU7dyWkzVKYBe1gYG
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add support for phone buttons.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 5948b401165c..a3bd5231569d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -7,9 +7,11 @@
 
 /dts-v1/;
 
+#include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
+#include "pm8998.dtsi"
 
 / {
 	chassis-type = "handset";
@@ -69,6 +71,25 @@ memory@a1300000 {
 			pmsg-size = <0x40000>;
 		};
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		key-vol-up {
+			label = "volume_up";
+			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+
+		key-wink {
+			label = "key_wink";
+			gpios = <&pm8998_gpios 19 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+			debounce-interval = <15>;
+		};
+	};
 };
 
 
@@ -417,6 +438,21 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&pm8998_gpios {
+	chg_int_default: chg-int-default-state {
+		pins = "gpio11";
+		function = "normal";
+		input-enable;
+		bias-disable;
+		power-source = <0>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <27 4>, /* SPI (eSE - embedded Secure Element) */
 			       <85 4>; /* SPI (fingerprint reader) */

-- 
2.39.2


