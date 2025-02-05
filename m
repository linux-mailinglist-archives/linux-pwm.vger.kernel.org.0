Return-Path: <linux-pwm+bounces-4786-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83FCA2981A
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8A0188613B
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D92B1FC0ED;
	Wed,  5 Feb 2025 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uIIcFEgF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864881FC111
	for <linux-pwm@vger.kernel.org>; Wed,  5 Feb 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778070; cv=none; b=P0iMvCjJul3rm1yI6acE/K7Na1SXnJAW6arqbgj3ddAOCDd7SXkmELvRlSBvEmXtcfu6wTquW0T3/pvq8Nz35ylV7qfXRTFMCst70i7AEkSUj/QwVpc+lptDNLYJzm3LSYKNoytftxPBkRrWz0x6tBkQhNGH6zo+82ENeOsYvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778070; c=relaxed/simple;
	bh=iBU9OUHxDFRwrkGtwor16WU4NZhH5SNhALBCHkrsTmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t64EdxfliAbI3ScPVTv9Y4ov662QF6Aq3qkdumVf/v7YNKPXdfCOqct1qiSjjjtUkfG00GwW2ypd8sSShv66+MF8Cov+n9vuThPWj3lA+ZSVMPAg72lHmutZTXTlGuzENvecgPslZ+zOkXmQqbVePx6xiQS6pQM4/l5ay8OHK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uIIcFEgF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab6fb2940d4so218742266b.1
        for <linux-pwm@vger.kernel.org>; Wed, 05 Feb 2025 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738778067; x=1739382867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0qvYmPCyPNFC5gLGw5pr5m26K+35wbL4YftBfSGxVs=;
        b=uIIcFEgFdnUkUnVH/GXRU7BL1sSHu1S8pSu4W414j6zqHqJR4XiHHlRrGYITZF6RZ4
         XFlXTcDggO1DPyVQn2Z/aZPecYlG6ZGdrrcC6a8fzgJYAeGn0qCNQAbRdwySVrx5tBfc
         5nSk3zAHt34cdrhoJBDDR028eO8eXPkQWB5n2nhPfD5r1s4zgezPpPBVMzWNjVgaH3qW
         CRFa4EFzyuDgEjnjfC3w++pn7WkK3ytQwmHVKAXrYifKaVWZP8NAYpLqU0uvGnOrSCN7
         RGFo9JTaRFciQxsik0yO85HFUjDZcK1W7WXnCHJQI1QKXii6PuNO+J9ghVVTIeQaAwXe
         hzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738778067; x=1739382867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0qvYmPCyPNFC5gLGw5pr5m26K+35wbL4YftBfSGxVs=;
        b=le76ljfxCJkX06NZbLvlscqp1NhZW99gVciDEgwe0Zl8ih9QxxXkrOa8DoMU3GmF3U
         hYNzjr5/TlmjZBaz7nlebkjLJQQkaKTfiw7NbFfvB/DRChYl/QgI4gd3mHHuSECOorA6
         6f02CLnkSXyEtY0uuaPJal5ynWpCIxg0Ar8/6Q2Nnnh4TApZIPsECjy9KjoVopDoCVNv
         ShRUAQ7Nx+MmTG8zh9k3aljwWZRlSgi4t3PFEHR0Lb9Jyhx/L1UuT29bVxmm7GnUbmjo
         /sB26M+PDLzBt14eoMqrpZIpuZsTwXqV17bQq1he4y2TYbo1v5F+f08yIJc+V2qOl2LR
         Xmog==
X-Forwarded-Encrypted: i=1; AJvYcCU3Gidk8SmgAymsiuWhOfxNVfjubEx9/GklMY/h9OGAqeuuw4lQ+nPDvxr7h6oY+yuUt5qEZUPGQDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEUs3LAJMMfCXTpPOsm5hLxVbpAXfwRGPUQOnuA8abs+cPf2B
	Dy5Jf+6vkfZW8SwNblimO0gICJwlSifIsrZ0LNvT57Kagpb0rmmc0ADffzumgO8=
X-Gm-Gg: ASbGnct+yEXZe2JKCV4Iw5hp8LAG5TO7ORVsTirofZ1fDBMXQzgn10Il/6VCNVAFyCY
	PxVbsWkObCNet59GXXOMI5/nN+HO5Qx5Bi4ukjISggLPDXGPDJJqqAK01tP/Ca9S3DKzGnAtR3v
	0tp5haGNpI+ZOYstJOnEdchWaqvXKHw3viHhQXgbTPTFL6O0D8BuVG7T5/nGUvsxUqF6IWTMNbo
	8akS5mKGybc0x96jPdBabxm0F44SfOhT9KSpncAQEPecExfMYt1NtGK7TMOBNbNvUiyUnBfOqfj
	m6TqxGBT4yRHBBGs3nHRVMuC/sLsT6dE4b9rm76HwTkLpMuH2SKpD75f0Q==
X-Google-Smtp-Source: AGHT+IF92wMPufEGt9cvnv832yheronJqrKc1D31ugycDeyrAicJl2GAOxWT42IXWDLHshxUJkJSnQ==
X-Received: by 2002:a17:907:7b9f:b0:ab6:ef92:c238 with SMTP id a640c23a62f3a-ab76e9876bdmr31149666b.20.1738778066758;
        Wed, 05 Feb 2025 09:54:26 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5b5ebsm1131303866b.181.2025.02.05.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:54:26 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: =?UTF-8?q?Herv=C3=A9=20Codina?= <herve.codina@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: pxa: Use #pwm-cells = <3> for marvell,pxa-pwm devices
Date: Wed,  5 Feb 2025 18:54:02 +0100
Message-ID:  <9722b7efc8b9dfeac6ded6302e026f538cde9518.1738777221.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
References: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4037; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=iBU9OUHxDFRwrkGtwor16WU4NZhH5SNhALBCHkrsTmA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBno6W/v2o83YpyNGfd1Rl33qRbjwDiFw+kiB5NO 7QJ/ueiAxWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6OlvwAKCRCPgPtYfRL+ TjimCACv1XnU/EyqtKVJ7VMA0V++XPrQAxgKrYl92evq7HhjlahPkqlzO6fTqUUSkmZOicDP2Et RrsaWMsd7hA1yIZ4GJotAhKIDXOnQ1Ujol08cJVsdgqQmLxWeWf7rqq4POxE7kjegWSbPk9EhNW ewx4DQPY9PYODSmPoRzpDODC7nC+v/hotdTSCdYG/i1P8F+sx7TB953LdLlHnTHuA1ge7R/WLhq u56rGSqjyR2N1aZ5OLDCpRtjO4EcBvqdLlU139QbhlFTU+qcg4YpaMOgX9RfvQUktJ3XIg8G4AS 59lL5JfYfzr6qGEPQUgpPBssvXuddxVMYc8bKSvOEcpWP3PE
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

For consistency with most other pwm bindings, also use 3 cells for
phandles to PWM devices.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 arch/arm/boot/dts/intel/pxa/pxa25x.dtsi                   | 4 ++--
 arch/arm/boot/dts/intel/pxa/pxa27x.dtsi                   | 8 ++++----
 .../arm/boot/dts/intel/pxa/pxa300-raumfeld-controller.dts | 2 +-
 arch/arm/boot/dts/intel/pxa/pxa3xx.dtsi                   | 8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/intel/pxa/pxa25x.dtsi b/arch/arm/boot/dts/intel/pxa/pxa25x.dtsi
index 5f8300e356ad..d25065caeebc 100644
--- a/arch/arm/boot/dts/intel/pxa/pxa25x.dtsi
+++ b/arch/arm/boot/dts/intel/pxa/pxa25x.dtsi
@@ -67,14 +67,14 @@ gpio: gpio@40e00000 {
 		pwm0: pwm@40b00000 {
 			compatible = "marvell,pxa250-pwm";
 			reg = <0x40b00000 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <3>;
 			clocks = <&clks CLK_PWM0>;
 		};
 
 		pwm1: pwm@40b00010 {
 			compatible = "marvell,pxa250-pwm";
 			reg = <0x40b00010 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <3>;
 			clocks = <&clks CLK_PWM1>;
 		};
 
diff --git a/arch/arm/boot/dts/intel/pxa/pxa27x.dtsi b/arch/arm/boot/dts/intel/pxa/pxa27x.dtsi
index a2cbfb3be609..ed07b65cc362 100644
--- a/arch/arm/boot/dts/intel/pxa/pxa27x.dtsi
+++ b/arch/arm/boot/dts/intel/pxa/pxa27x.dtsi
@@ -49,28 +49,28 @@ usb0: usb@4c000000 {
 		pwm0: pwm@40b00000 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40b00000 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <3>;
 			clocks = <&clks CLK_PWM0>;
 		};
 
 		pwm1: pwm@40b00010 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40b00010 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <3>;
 			clocks = <&clks CLK_PWM1>;
 		};
 
 		pwm2: pwm@40c00000 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40c00000 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <3>;
 			clocks = <&clks CLK_PWM0>;
 		};
 
 		pwm3: pwm@40c00010 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40c00010 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <3>;
 			clocks = <&clks CLK_PWM1>;
 		};
 
diff --git a/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-controller.dts b/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-controller.dts
index 12b15945ac6d..9094ec422577 100644
--- a/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-controller.dts
+++ b/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-controller.dts
@@ -56,7 +56,7 @@ backlight-controller-pwm {
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pins>;
-		pwms = <&pwm0 10000>;
+		pwms = <&pwm0 0 10000 0>;
 		power-supply = <&reg_vbatt>;
 		status = "disabled";
 
diff --git a/arch/arm/boot/dts/intel/pxa/pxa3xx.dtsi b/arch/arm/boot/dts/intel/pxa/pxa3xx.dtsi
index f9c216f91865..4e69b4da0ba6 100644
--- a/arch/arm/boot/dts/intel/pxa/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/intel/pxa/pxa3xx.dtsi
@@ -224,7 +224,7 @@ usb0: usb@4c000000 {
 		pwm0: pwm@40b00000 {
 			compatible = "marvell,pxa270-pwm";
 			reg = <0x40b00000 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <3>;
 			clocks = <&clks CLK_PWM0>;
 			status = "disabled";
 		};
@@ -232,7 +232,7 @@ pwm0: pwm@40b00000 {
 		pwm1: pwm@40b00010 {
 			compatible = "marvell,pxa270-pwm";
 			reg = <0x40b00010 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <3>;
 			clocks = <&clks CLK_PWM1>;
 			status = "disabled";
 		};
@@ -240,7 +240,7 @@ pwm1: pwm@40b00010 {
 		pwm2: pwm@40c00000 {
 			compatible = "marvell,pxa270-pwm";
 			reg = <0x40c00000 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <3>;
 			clocks = <&clks CLK_PWM0>;
 			status = "disabled";
 		};
@@ -248,7 +248,7 @@ pwm2: pwm@40c00000 {
 		pwm3: pwm@40c00010 {
 			compatible = "marvell,pxa270-pwm";
 			reg = <0x40c00010 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <3>;
 			clocks = <&clks CLK_PWM1>;
 			status = "disabled";
 		};
-- 
2.47.1


