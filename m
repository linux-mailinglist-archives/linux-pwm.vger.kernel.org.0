Return-Path: <linux-pwm+bounces-4220-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE169E31FD
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 04:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696B0B2387A
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD316F30F;
	Wed,  4 Dec 2024 03:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3FLKNNj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69A1426C;
	Wed,  4 Dec 2024 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282275; cv=none; b=grei9tTU8/3rfq0z7+z2ZtGGldIb18pAuXXyPappb/L8mTG1rC08xI5yQxEIyxaIYkOgQGqIlEa0RziXROsnve5jb6nDjJ97qq19ur4OtQQqQewX5+S8GXe9KVCu0S0kBvgGo/+x64R6v2D0X9KaLHFczDBvyFldgHmHoYjbwkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282275; c=relaxed/simple;
	bh=swUtvmj1uQ/WdN93F3TdVYHb+jFbWwNVPYIeRB7sz1o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rzj7zzM3mrl0wFk+G60ZAleihYe7tEIKiuNp6CK+Uym5Nh7Lcnb6Rlpq30iVeBqIMSsNZ53e3bt8f8OOomNTs7yWuMhRYisVjoKI+8nEiCOvl0+9P3UUy4NdhAQtjbYtdn890RjEfPMb7hK+R+unveMhdD5Fav92YGPAchMIC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3FLKNNj; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29645a83b1bso3561883fac.1;
        Tue, 03 Dec 2024 19:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733282273; x=1733887073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mixRlBZnAzl6+RGD+SnJtrTgxRDsBgCOJYnL66Xe1tk=;
        b=S3FLKNNjuLzydtkJ1DH7ordfHnLDN13EnvLeMBpv/OmIoKoBKY8d96+cyLABSoR1yv
         BtG4a5+X8hAvaVH3lc3aWFtjMz4qAAGZz0y7pT2amHFD3JYWBU804svzWYHyHlCylNN7
         DNZtFtK2lhvESE3Sq0Bt60VDt3BRMKPwx1YGA3ZUsq390zq2TTkqjSueBAtYAf52kem7
         CqgERanfHPApy5Wrd2cjN5bfYOw2eSoMfjZmuHarOPMFE1CZQP5dKlQNcXaeN0k8lrT8
         rEu4muYg1/i2Bho1YON7eHv9buvINP/w1l3oGSz6SKTdEnFLz53a1i6MxXbrCROJfDBH
         7R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733282273; x=1733887073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mixRlBZnAzl6+RGD+SnJtrTgxRDsBgCOJYnL66Xe1tk=;
        b=vC/SDzLFcJl4yhsqWWH/0kdsEbECXwU/pKiaml8AwZ+zT1j5WgssdOWpghg2TBNqOQ
         pTgt0JNLZoTk4Of+l+2jRgyvWic8gWgRfJYa9F40P+tVBBYekRwq+sc4IXF8Yikb+UQn
         Rk3fm96KHQHSd5/d1hPS9HwaHPQLl066MsTw7hhaWMawtWOxihA3KdnrvrEB8IKFNSCp
         6diUX3m8pR0EOlQSxddt8iAAHTej9RUesv25oy/nlNCH3ynnPfNQh4NnQOopfrBGbbIy
         83jjAdNT6FIqjssTr7u/0Vss6GfsK6c0H41mXcF5/q/Hlfjh37dMJt1c8Pa/WTOZALiT
         zDSg==
X-Forwarded-Encrypted: i=1; AJvYcCUa+f86T3a4KnYiEC1dEWdlE4uhIJPhpaM86qCWShi97L7m+a9q7XNM9zaeS/4GX26xXc/T+iVtmrZS@vger.kernel.org, AJvYcCWj/YRDdviK7ZppAojniZm2WNNkfQbfiv3QLd+bR9jqPk5er6aEH+Ut36/ETK8lPj4kq5ttDUeVczt+@vger.kernel.org, AJvYcCXyyHMYl0IUVXgWzpLJ8zVC6aIoOA2IixSF2pUWUAcJKZ5hBZLqc8dFH33y+oUG5P3jx/xyZt2el0h1bqwr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm8xXllFVplPQQmpVna3YkRHUqMEUQzu5XWbZElkHUeqGN5res
	37oiPSg+WOFX296gh2h2FswfI+P9zuT3G3C9ji22rIBDc6/+gD76
X-Gm-Gg: ASbGncvuHuBdeD1MBeo2Z6hcILAgWfOFP0a+LCR9jE2dMr4yNa2pI7+JMltXMkWzpZ7
	O+UZ5ZKrPB2X8PHpGzgDCTM9ASKSbK1MbunzFNxBxqow+APjmmloN9dPN1JnX9n/+uYTen8nYV5
	tAmughEMSIItKpulZUqjg3B+H/oiUVsiE0jLAMkKD9EyPUYJ3bA53LP2XzCGwN+Y1cZtWiJQfuT
	WufP+ctG44mdlzI/k9Q+tcY2oplpfUpl/D4yQCcIAHqRcoWKFBa7GwAzwMb
X-Google-Smtp-Source: AGHT+IGAAZq0BZqx+M5fXCuGO93303qiSaJYO7mY7gecCr/3SuC0Sy1KChSb3UAIulwKdXP909PnVg==
X-Received: by 2002:a05:6870:3d8d:b0:29e:3eff:dea with SMTP id 586e51a60fabf-29e9b08c0ebmr1787227fac.8.1733282273522;
        Tue, 03 Dec 2024 19:17:53 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de8f31cefsm4185404fac.2.2024.12.03.19.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:17:52 -0800 (PST)
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
Subject: [PATCH v6 3/3] riscv: sophgo: dts: add pwm controller for SG2042 SoC
Date: Wed,  4 Dec 2024 11:17:45 +0800
Message-Id: <f40dcaa5d931a5c2e5e9dee0c602edd5f778050f.1733281657.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733281657.git.unicorn_wang@outlook.com>
References: <cover.1733281657.git.unicorn_wang@outlook.com>
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
index e62ac51ac55a..77dd65d79946 100644
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


