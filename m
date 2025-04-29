Return-Path: <linux-pwm+bounces-5755-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C67AA0641
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195541B65716
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7829AB11;
	Tue, 29 Apr 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZzGgjUQY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965D294A0E
	for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916720; cv=none; b=kUzekhX4BC/uCYn7l0DB3367zQlk+CxbJarTtthjgf8HzpYfRT40WjtOSjm7EfJ/suD7eggdMEAOrych9PN3ZwQALCBtGcdOGOKSdz8y6PZyFlYJnnuiG3mT1WBeBDfuInNTrfv687mz/VcCy/2od22SEtY+U+ruXxEJFMpWhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916720; c=relaxed/simple;
	bh=J4NuNn/tXwp9sQqsV0iWm0NCqyaD25RTgEa4ZmPkOGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJSmlpMJRzajQzV5EtmklYFt2WQhBWQceerrSNjiG9AYK9i2NnSL6Jie9iLSJTi++o49CZC+GRd0c1nFlNe1lasBQEZ9rURMe3u5fmcPQkBRK8inbDyd4keqPc1KgkIizMm940ViLuC8zhGL1ICVOTXmYqQhZc6zKOnxCEeK+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZzGgjUQY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-afc857702d1so5434153a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745916718; x=1746521518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYS2eMiVk4Xt0bu0VrX3eSLEVjDrDZlAzYja2cax6VM=;
        b=ZzGgjUQY3y3vkvtk2HzH8Hr4ifpoWSqrrAZuOikmiTGWOYF5etJ59xWyUKvnp+7vUN
         jrgLgkecHgM/86ycXKNdwnxSarYT765PHV8jG10t4o/3RoqmPAIwg07b88EN7tIw4eq2
         MOpVyLv0ulJY7XKbsHN4KhZE9rKZJPMLAirz+uCZ3ohUSA+XBnfWAz6egRwjPQ0lbEJL
         JoSXLxYYI0Hgr8uLOdzO4XQxpcsn7N4f2CVq6dkr36PQfXBAadDuMQKZAp6ChwpL/NYd
         jmyoxVjCTrFha8Z4IGmUSku3Vt9NXYjA3OfHvjTNlci/4atLTZSTH7/KMSzjHXeyxkWC
         Tz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916718; x=1746521518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYS2eMiVk4Xt0bu0VrX3eSLEVjDrDZlAzYja2cax6VM=;
        b=CVYZdeIf3UkayQBrXjKbNJUVHpNWVOaXzGEBtjPFvgTyik2pFrnNTXMtoWeomI5YLl
         Yn5DlNeAC8OmNLY360zfHfTPk8vZlzTmSlvx6AuuG+S9HNiwsmhFaKJ9EfDJe3AaOQiZ
         YO2b8K0i1Gf42OD3WY573yYoE6a84+iI0z+g7PvhjqolEnz0I0dDh6noWG6GA1o7A1i3
         rDfjZ4GfvZIG2sVwAqJ54PqLBi2Q7Z2c1Q8VPku/attcJq9wFi4WcMlwRhwstoat0EDn
         CTjbKSMer5VTtkAnGOMZaOFhiNJ+5UzwfdNOrD3WPl327dmM4TplEqZGaFa3f5x9xICA
         WpEw==
X-Forwarded-Encrypted: i=1; AJvYcCUYtDkd+E6jHLgm0nFtWeQbG4Pj4H006LPeUeN/y/dOczgR0XCosbqXxJl8t+LZzdF3Axo5M28V4/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+B/Els3mt41djYYKnqj2wP+FbNhCybQ+/jMa81eg2rLdbIwf
	NF+610IFnWmqsKZQrZjHZ75Ll4YqmbDzghGADb/WO3mdbsU7lutpJK0amafXlE0=
X-Gm-Gg: ASbGncuWBcVfAuC81XJXs6DzmcoChzpfq5QQ5GCALXnMZSlEEUc12gMV6ofpBMSWe/S
	VNmXHgHvgm0XwfdSTnNuQMjVAFZuvjN82hx8UtjMzp/Dc8VMcYfDZGZO9s17krYHLtVRtFH5h2h
	D3GOSNLKApagIBLb/f2LgG30VIwyzxS8yCBuBmEacJ1iP7R3IEXbEVrj4uZhrrkbQs8Zde3Y1Pl
	1j8evN+tkJ4mDl8U0OUIjxF26QKUakzcji3hV5lVEQ62LbCA27IZ+b1HNbU5e12R5WYqSBBtqGJ
	S1VGXMmoiMoOZ+qiQjim3YVVvxlq4eTEpPEbsKGBSOpZGWCOPLL5TvxYVjW+rqccNL+jXF4Rmfy
	WqMfI+l3SMQcUqfw=
X-Google-Smtp-Source: AGHT+IFY1/NJQY1EBeDwxCimqA2xJLyNhndajPdetd6CnjlEWVopEm9ixDmG0zsCZTOnJTyyL/yb/g==
X-Received: by 2002:a05:6a21:3a41:b0:1fa:995a:5004 with SMTP id adf61e73a8af0-2095aa9a073mr3324411637.26.1745916718351;
        Tue, 29 Apr 2025 01:51:58 -0700 (PDT)
Received: from localhost.localdomain (210-61-187-174.hinet-ip.hinet.net. [210.61.187.174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f8597e0bsm8550119a12.44.2025.04.29.01.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:51:57 -0700 (PDT)
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
	duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	guodong@riscstar.com
Subject: [PATCH v3 4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
Date: Tue, 29 Apr 2025 16:50:46 +0800
Message-ID: <20250429085048.1310409-5-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429085048.1310409-1-guodong@riscstar.com>
References: <20250429085048.1310409-1-guodong@riscstar.com>
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
v3: No change
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


