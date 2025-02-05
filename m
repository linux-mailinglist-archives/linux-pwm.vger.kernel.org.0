Return-Path: <linux-pwm+bounces-4769-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B43A284CD
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 08:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A892D167286
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 07:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA372221D90;
	Wed,  5 Feb 2025 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeAsW1p1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514721773E;
	Wed,  5 Feb 2025 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738905; cv=none; b=bw4V4Ysgg4C1EiAAODA30wgPeuZiVcTJCJJ7HMA0JnwI1b1Vh5MOJ8p/7DdcsH9DCWHVwt9x7MZ/j8MibtDSW6ui+0fM8fuXsA6VUpQwU1hYAspvs8LKVnevhQRAifQIDTLRlnudUadnOqytcec7cdbb0gcCScayV6DgR1mgaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738905; c=relaxed/simple;
	bh=yxW7QMaAB0nuL2yZCjk4W1zhHXFyqyCXjnl61MZJ/hI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tPtaqyhNqXeygQzXUUn7uO4cSv+8en7PVVXxNziuCG9mNfYs3LxQ7Cmron7jd0Qw5xuszutk1w2a8AEyPSrXdJv0iS657YwRNdTW24EkqHvjilJb6lQprVrtCa8m6CklEcHYLOcS/jZkR/OfArD++WO7Qro+TTev+QcACoSGDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeAsW1p1; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eb9a0a2089so4126212b6e.1;
        Tue, 04 Feb 2025 23:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738738903; x=1739343703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VetlIju5pkNjg/WmtiNabYY/80QVE5zZqTlQOK48sTE=;
        b=jeAsW1p1tUzTybDtLaLpfcBriUdjO2oP24xtG1DmSLiXPJu9Ss8CuUHjPXNwYnF1kx
         LwRCvOHg076FoL5ipfzYYOSeNayn12snRLKuy895LxtD8eYOe7KP+GHPhd63SMyYQTMU
         cVb2LLUhSFYU/gOx2yYri75xmEFqegChkEgrh1DyAqF33mjCiAzKACncS/AdJdTuSJ0D
         DkzcAqfrjxN7dbwz6ydeXetWj5qSnVfrhYEuckVHZQn8KxgQn+Bjp8EkSt76kRHepDmS
         XOfVKZOR723Ym9M+3GknmNdNA1lZNt98V5GZdmSy7su7VBSykC5J1dtcCGgEWJ8YEhKa
         cH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738738903; x=1739343703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VetlIju5pkNjg/WmtiNabYY/80QVE5zZqTlQOK48sTE=;
        b=wjb1RA1joZNPKqzZ/4WKDXU6jjYxWht4N6rCwPShPxFybnKRHwf4KZtv+LpSWmZt60
         su5x0GKJiI6NGDa0+ub9KyqDyeAMXZHxqWYvgwAL1TxNneSTTQ1TdJ0hWgYd+0ol3BbP
         jw+sHJ+hLJxqn2kTWD7NdsBLfTpLtbS1N2iH6TivGSsDG007T4Otw5Sbm7Ut+1aUqfrv
         TEAvHrxsyjpHQbVE0phK70h7Mz/nbqc23p/1Md8r66S4JF61GCqkaFM5CuDW2IU58pnx
         jBP9PC3+45lbImZrRg8o11diIRFz9ya+r/xPENUyfCbqGckqKtvqLySasbOZZbdBfwmg
         PmYg==
X-Forwarded-Encrypted: i=1; AJvYcCWXb8zJeuyBb/DqMGOCWmE05uSUlBAhx0vh0VvPH1JS+Q3ScLrjn+JKtW8AVaBIzj19JIIN/3PMEFvv@vger.kernel.org, AJvYcCX2YdqQ0vcTkmpdquh2iHDXI6FU28w3GVOczGeySmJFU29MZTuEtEvkZrMA966dDS7b/e26HSEYvBA5O+F0@vger.kernel.org, AJvYcCXHcMQM/wU4i9/F4DzN6S7czu7AoqIsM7m2K+CJQumQyvQkkGZ4AmDK4oIJKAZSMB3n0HYSKFC7LxoU@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJnH9/Lj/NIrSeb15ikwkuyKgNrueGSgog/qIG2+ErIbk2qew
	tWKVr2C6SXTvQGDVXtuPhJ6+cUMxuhAeX0GofVNsjdGD8B64QKVt
X-Gm-Gg: ASbGncvrHFyC+IHCGDmsgCi+Q+spNaVHwPun+n3PwWqKNlSTl5HOXdY24XZgk0yAHFR
	QJKGUqgZgitY1TcUTCdPuQZcvMXlFU4D5iBKlH8yM8hW8NQMYvEJEI5Qd8tWb+P8FdHSLHFRlFo
	2IoPfDS0RcUyRfdy8NCR1xgjNDs+c88pDzxcga2DByX3tg/jMS2m1Lnm5hO5Gs4nsJ2WOigEm8s
	yHgNZGh0Jbr3iVOGyHR/K0KElBSyrUlo14YPU7o+MfV/xbsAGZXKn15tGInk+bHSnyGoxU+iBLr
	jE8w48sl3TZLAys83gGJbYtlvQ==
X-Google-Smtp-Source: AGHT+IHsN/LcSCw5m80/mGufauWzvwto1G8RpGC+M5RvbFWxlmw2NwUKjbpX1R3EQj/I7XUX3H7gJw==
X-Received: by 2002:a05:6808:3c8a:b0:3eb:638d:5e28 with SMTP id 5614622812f47-3f37c0e5a0bmr1104846b6e.4.1738738903247;
        Tue, 04 Feb 2025 23:01:43 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33367f6c6sm3441313b6e.42.2025.02.04.23.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 23:01:42 -0800 (PST)
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
Subject: [PATCH v7 3/3] riscv: sophgo: dts: add pwm controller for SG2042 SoC
Date: Wed,  5 Feb 2025 15:01:34 +0800
Message-Id: <f376e16c0ee0cdac51bb91421d78defc0601627a.1738737617.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1738737617.git.unicorn_wang@outlook.com>
References: <cover.1738737617.git.unicorn_wang@outlook.com>
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
index e62ac51ac55a..4449c762d663 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -165,6 +165,15 @@ port2a: gpio-controller@0 {
 			};
 		};
 
+		pwm: pwm@703000c000 {
+			compatible = "sophgo,sg2042-pwm";
+			reg = <0x70 0x3000c000 0x0 0x20>;
+			#pwm-cells = <3>;
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


