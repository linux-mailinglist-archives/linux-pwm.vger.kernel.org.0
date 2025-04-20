Return-Path: <linux-pwm+bounces-5593-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6DEA946EE
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 09:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12601897228
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 07:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771D71C3308;
	Sun, 20 Apr 2025 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="aDPCDiKf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39D1A23A4
	for <linux-pwm@vger.kernel.org>; Sun, 20 Apr 2025 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132738; cv=none; b=THEvsayuAMCvhLh6uztzslnNcCTXVXhthPQN9z5x85f6l4ABUZRKdGok2VYVNXmtFM+ufGfT5xiNpAjhD/VnhRxDxaGbY5QMxS2glLCr53Wfx9Vnbbl2GuyAQScibZkdYToWfY+q4YMB5E1jf4wEBVZmm/Vq9kOf98azVfRBY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132738; c=relaxed/simple;
	bh=ihM64sX2+hs/Hqt+UK2WTdRWQIa8EuuoOdmKBDR0058=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9Q9A60pM7xzAi8KrCbf6TNA5KyRHhytKIxc6OHcz5RlLRNqoyp/KCTy4uMXBNaMeXfj3pya+onfNVWAC5VIg63F7jprNT2Y7rVUpuByX+rCuLzDD6h7EzdhXjuVELx02ygm2N7fFUhPNi32/2NgPASZ80kXIyHDksoOeF2ZWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=aDPCDiKf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399838db7fso2950099b3a.0
        for <linux-pwm@vger.kernel.org>; Sun, 20 Apr 2025 00:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745132736; x=1745737536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmOqJQRui7bzs7fivZ3106VDf78wzGBoncjdDrfzqjQ=;
        b=aDPCDiKfzbgCwi9kA3ho3DtTYH2HwJpsBUs/opBqfIWbiGZF1CiQXDoi5tySFg8m6e
         zcgO8RwMeOZeg/mU1SkpIMJOqt0Cm/BC5rTBSjo0rS1JUV9UNDAWGAOBIwhijY0KL4rH
         ozbxK+vHbidK5H4vdgAA2krr+//t3pbckyissq0bYE8GqzHUFhi6yFcUgzv1dtGf97/l
         nbALG0zQlL2hxLOaVf3dyU7UXJ/ORNELy026YVDqnqHe8EAstOaYBztZqxUuZlKHoiHh
         51QipLP2AhLg+FPjXj+wNXYJK8swNOQ4OyPOW15XukIT+MwSfDObV2JuSiHdUS0BtfsS
         CgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745132736; x=1745737536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmOqJQRui7bzs7fivZ3106VDf78wzGBoncjdDrfzqjQ=;
        b=wWIURnCpdK6ImxuJCmc6F9u6xiR15+uDdqhsGt7iCHU00+pqKVI+q/NO8dcmkZG1BV
         2VP6l+xDJDu6mcXJaDAfYfrVtStjExwDCLzyVckjU7DF5zjeSWWQVg2XJHnipVK5xLsh
         8SXTU4I+d66+R8NhAfI3L+kPFOrhijtFxwOTT6JRg6kVbbNsvldcjN5MYW/zDB9vy0gl
         ZQU2u2Uso6OHgUGem5vrijXiov0/8PofyDiNuPdVGdmWi8v0pqMhClG5tTSEWSzjXVM4
         sYndFg/4nWrYmS82s6+/79W+W1OlAHIT/bh0D2kw3km/TIWsojp0VzdmQvVw4FpranpD
         bSPw==
X-Forwarded-Encrypted: i=1; AJvYcCUIAPMRutz1VmHqtrdhM5LpFdtr+7Qamtcxb0/xnMNiIbsEmPxsbmRqpeN+lbzQQshwWR7pJ6DQ9t8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4v8a/tsGRmgDGrgFsDBY3stTu5+Me9EU+uixWbo20Z6sOMst
	wzFqRgS9oCCVAonPoOuURuSj9y/HYQmHC6afYyq26uyNBWcqtA04z+cDxIyvoLw=
X-Gm-Gg: ASbGncuptZDuDiZqVsDMZeG/jUOC118dDq/0krj7zg11JR+LCHeUGS4teVAjKUYpbF9
	ZBeqTNDIN5DS/QtD4Q+TjvO9j7EKbyJr1KVuQSiHKdWeHU5Zv4s4ASI2noC+XJIv5E8QcdBFTCV
	QFlBzvkf+UBBols6aFLcA68nKLPnyPULDdPxlgi8bY1rwcLDQHoD6wEmoRZvdU1rQoU8U/gddIN
	/HUqNA7narua6AxmjFiDF60y9jD9SLX4Uhp7NadNklX7RDSOWqoHBwLRWX40XTYhd0vDDZ9L1YR
	MZ1K2OMWHif/UOyTrdgweXxX22+0mZ/8T1ageQHS
X-Google-Smtp-Source: AGHT+IHFuVLoWyEV69AHMEphs3R/4V0RmqgjZGMtJgQzyiUWElzohukYn3f3PlJSmIVrROFiyThGIw==
X-Received: by 2002:a05:6a21:3388:b0:1f3:34a4:bf01 with SMTP id adf61e73a8af0-203c9600f8amr11912750637.17.1745132736128;
        Sun, 20 Apr 2025 00:05:36 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::40b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db12743afsm3742626a12.16.2025.04.20.00.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 00:05:35 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	heylenay@4d2.org,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	guodong@riscstar.com
Subject: [PATCH v2 4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
Date: Sun, 20 Apr 2025 15:02:49 +0800
Message-ID: <20250420070251.378950-5-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420070251.378950-1-guodong@riscstar.com>
References: <20250420070251.378950-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the option 1 (hence the name pwm14_1) pinctrl
configuration for PWM14 on the SpacemiT K1 SoC.

PWM14 option 1 is used for PWM-based backlight control on MIPI displays.
This configuration is present on all existing K1 development boards,
such as the Banana Pi BPI-F3 and the Milk-V Jupiter.

For reference, a more complete list of PWM0-PWM19 pinctrl configurations
including all options can be found in [1].

Note: Since the corresponding functionality for other pins is not yet
in use or ready for upstreaming, this patch includes only the pwm14_1
setting.

[1] https://lore.kernel.org/all/20250411131423.3802611-7-guodong@riscstar.com/

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: Discard pwm0-pwm19 pinctrl configurations, and adds only pwm14_1_cfg

arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 283663647a86..195eb8874f3c 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -20,4 +20,11 @@ uart0-2-pins {
 			drive-strength = <32>;
 		};
 	};
+	pwm14_1_cfg: pwm14-1-cfg {
+		pwm14-1-pins {
+			pinmux = <K1_PADCONF(44, 4)>;
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
 };
-- 
2.43.0


