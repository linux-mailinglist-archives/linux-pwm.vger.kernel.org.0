Return-Path: <linux-pwm+bounces-3862-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A454B9AFC1D
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 10:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F781C20DA7
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3791C82F4;
	Fri, 25 Oct 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnpMC4X8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419F1CFEB1;
	Fri, 25 Oct 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843682; cv=none; b=iBfNRS0QSdGnP2FHB58G9aAjf65aJfGiq7hpG3dvkBFFtkFyHKVPakTjuRd4shjRTDnDFSQOEnT4o4IOjNtaVg1ebMrKDGyZNVBASm3o+QzBiTDU2BgQ7mJU3w+OmAQTYVZe7+58GIwDl8pwM1j8enFu1gQtAo+2IwEkrBnmDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843682; c=relaxed/simple;
	bh=O8pyvZDag9iaANQFXZ/6mrX2jzrwvBo2OjNwZJ++M5M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leN6mo3j/gydK3bSpm0s1Esi7k2mUrB2JsX8eycWvyb3Cx1tzACMFOR+94WlkN6/GI1zmVp5gYRQ73CGEAq/IgIIyO7qdliE64BfyoKJMbpX6Ynmr8ztno6nIN2qr/wH/eBtwhS+tgR66HZPy25V6qsaKs5vutFHrv7u+ORC5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnpMC4X8; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7093997dffdso722873a34.2;
        Fri, 25 Oct 2024 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729843680; x=1730448480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rN5eVpbvHpbGL4WpynMeSKENdrHYe60OqvDbvd5Xiq4=;
        b=JnpMC4X8Zo+mJvC94C/wBFBnWIV/P1Q6LCRK4WlGmWRTJLiE82oJXUAzTsGbNCGNwn
         UkuG9Fs3r4RKKm8n2pZhLqkBgvtdjSo+rcyocV279lbihgZXpVjjUS0II+qiT8y1Musq
         sCrPDYXnJpWOIWyEP4XI7M+gSGcQTmfd8BB82K8hr0O9xiLJxRwC/JlQiZ5ps95hWsYL
         1M7eEOddA/GHdaPztcmSsStPuN9jnva86RnV2Pu6vD7k5X1yR2Z52A0xM+2RusKNMtJ7
         1kd4/jl1BUzZknT0+i9+uxEHJFa7vy4zxEq6zju+LpDGkFOjt8kGJHsGZfSbCS5rnsDb
         KBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843680; x=1730448480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rN5eVpbvHpbGL4WpynMeSKENdrHYe60OqvDbvd5Xiq4=;
        b=YK9LNcqeGhw3iaWoi1UuLsnLfiBgKMNb1jpXamfpkpVoZeud1XAg4+cAEo0IQPA7X5
         6ujI77pZ8Ee1S5nMDsSW7Eo1nBxmMWJgP0MZnBD7N2bG/lAcUwKvVHEdZd09Fx5zcfGF
         q7T0L1iecCFR+iCvzYF5X5dYaNysWJMYeXrfRV0rRPzJIKd6b4R150L047y7gNJaYEPH
         nIDchng/AD9QIbaoKI27TXhRp6ixCu5XadgVdBjgHThSHn+GT2igZ8xi4HK3mllTiDuL
         5xrO/sYJwJGxOe5OmSxckZQ5a3G5rgoVgv+Beuc6HCGqLRHNzzVBT1FJiCQaoC9F31ii
         FYZw==
X-Forwarded-Encrypted: i=1; AJvYcCW7Af8Jxgvg9kXhPpM0fvRA5t5t1mGmED4qFzcBjw+erkWFOjp/nUHSNwyEPVFTmhUon5FuiLAV8ZEtY754@vger.kernel.org, AJvYcCWrL4Jo05Oy8c1oVXfjewD2r8NjyvSM50dh4GZXxJS0YmYXNnAGrVGbJigpYYqouifWcdstJvpu6585@vger.kernel.org, AJvYcCXbB/HotLUOMNgX4nTxsaUzb7BIx+MqPDIiE5Egf3Me3Fk5+UllU1+D7kKozRe5zrXGGl2nA6g1jkkf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfrc8jjfgkQraJh3KQUgVHrYt0v/VOo4s5ZaRzNCpZF2EdsKLF
	ZBf1yOWIL8UWA1PDIfQIu4HDclq/NXIstp1+cSLK7uDkpj++qmCq
X-Google-Smtp-Source: AGHT+IE+aA1kZV0Gkelsvo6Wh/wBlEOQ5MwEkYl2tGn0oofv0qQbf+/aSQ5fFXMTaUtSRKeXwOxgcg==
X-Received: by 2002:a05:6830:6f01:b0:718:10ce:c6a7 with SMTP id 46e09a7af769-7184b348e49mr7419539a34.30.1729843679811;
        Fri, 25 Oct 2024 01:07:59 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec1859b627sm160231eaf.18.2024.10.25.01.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:07:58 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Subject: [PATCH v5 3/3] riscv: sophgo: dts: add pwm controller for SG2042 SoC
Date: Fri, 25 Oct 2024 16:07:51 +0800
Message-Id: <f3a0748a6c59ba3ee8090a9092040a63823affca.1729843087.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729843087.git.unicorn_wang@outlook.com>
References: <cover.1729843087.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

SG2042 has one PWM controller, which has 4 pwm output channels.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 4e5fa6591623..cc33115fcd8c 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -165,6 +165,15 @@ port2a: gpio-controller@0 {
 			};
 		};
 
+		pwm: pwm@703000c000 {
+			compatible = "sophgo,sg2042-pwm";
+			reg = <0x70 0x3000c000 0x0 0x20>;
+			#pwm-cells = <2>;
+			clocks = <&clkgen GATE_CLK_APB_PWM>;
+			clock-names = "apb";
+			resets = <&rstgen RST_PWM>;
+		};
+
 		pllclk: clock-controller@70300100c0 {
 			compatible = "sophgo,sg2042-pll";
 			reg = <0x70 0x300100c0 0x0 0x40>;
-- 
2.34.1


