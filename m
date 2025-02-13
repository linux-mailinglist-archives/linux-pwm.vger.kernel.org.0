Return-Path: <linux-pwm+bounces-4877-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86565A33B70
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2025 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63A73A4CA3
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2025 09:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DB8211712;
	Thu, 13 Feb 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQLL/MzJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6F21148B;
	Thu, 13 Feb 2025 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439675; cv=none; b=MWt2kbYeS8k5k6JP7gRg7eOMIznZu5m0YphUm1WHg6tFHmFSxIiIcdZDiAhpntqzA/0IFJi47RQkYEyf6tfZpoGAFBh0XQ1NWcaCqHwecdiq0lXR0AyO5EMb6ROZljVCbTc4zvVPnn8AKN4U+F0svnxEaoXhShw8Q01A0TBjTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439675; c=relaxed/simple;
	bh=BHjvuHtxcGbYTJxuDTg/fs/1zRBNwMIIEfEqMmhl7qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVqagJFD5g1rvry+16P3EZEtIVSpZttv1rCgcmVQouEsA73OmcKtCUg3FzJLGkAAaJn2uSWgceuj8JQscCMuQjgSHqDiAGUMHXu9oPz7FxhzFzo3SVdz6VKH7TwtgOx3hkQXj2QiXKh37Kvz9AU+/xzDmLsw5TXZsUlTrz9gcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQLL/MzJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5451d1d56a7so738198e87.0;
        Thu, 13 Feb 2025 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739439671; x=1740044471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYYMYkxftkNwTdyqS8CRT4NccxOq5tlDjvnPZc99yTM=;
        b=NQLL/MzJvnRr0uOfpjLksWEst1PwfbumlXH7KFX2BSH2vcLguLQ2ZmPSVOWz69X4HF
         ySfD+l5UDUfv3/Z3RXPZP7aD2ZtSC8KFW0OoFUHFS50v3JMyF7FS51xMGTXYNYcYpOL3
         B2rZHrZ7prqLji19WGx4+SWbgDfEeOO01WUgqWN3TF87tfP5jykaAMJ3cFvNpmd/J4GD
         zcQWYBEWt0K0t0Nw/VNs4a7PgnLNJdgWr0g/Mw7YyHvm5Sm2WAbMyhkpuO6HgVixSR6C
         8W3zwzBPy7LmIB8bu3RONRlOQopHtJemrX+7fvgthLBSOj3QJNRKtGcgTtTBtMMU8BSO
         S7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739439671; x=1740044471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYYMYkxftkNwTdyqS8CRT4NccxOq5tlDjvnPZc99yTM=;
        b=oymqbpseLzj/PO/t66yL5Tl26gTyyzWAK9D8cVhT2JZd+ErOebZlGJo3RMkec4UJ1Q
         bpPMysmj6zlug6L5TfEceGOcXVehjSL6N6SM/6Dn59s3Uzp9ndoYc4zl1IpyBEahTjTe
         BmzUlbcZ60XtkoawbeuViOBYI175FCiVcTUp3rg7p54LxigZ7yg8WQVTfkhFxVHGVYrm
         OGknPPMswXG1iwXoOvRpME+HpvxjmB6rG7cvNc0qWHH9hsOXj9TnUakm2DEju7WNpnDE
         tIwcydIDrHsERe2C6xbOgGsCQvUfe+99+wP0qCChlVoeJrQJ9Zch1oJEH14PUfaM9z1C
         oMwA==
X-Forwarded-Encrypted: i=1; AJvYcCUPqxq99TYIi9y2XCVts47q/FVmjt2RHjBSVpjX85qcXy1QfL1awgkSJ7s4Yt2ssRXSaN7/NAYIVjmN@vger.kernel.org, AJvYcCWRaatzD1L9DMI+u6n3uWiISrMn68RZ9/iZ53cD5KqQfu+8H3nCfjNkyOiryoai1GTG6JhEVOT2K32A@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nEdCyOwzsc92Fl3JhOxhhwvOYRXlVLGf1utshgZPPgYxsTmG
	iBwcnVuSGbzvd7pIVEGIZ7lqeteHJzzlsh7vzLhBVBWF9K7gIWta6VpRPJ2Iys9X
X-Gm-Gg: ASbGncvCLi9s1C6Kn/CreJvLkHKdi98s331gghlCLLpNHC+42AKPR5JjE+xZHx6zfVB
	VwyD7T8FQmmAD1uTcYd/VBLZ7WX840ZJ++5+NYro3UNX2Oa5c8OswJRqPEHEBSVdn6Sk8dO46mi
	aDMkzx3Xn6saQE0QEfwmcHjcgHWtY3So3lQ/VYfT0Ih8LraVaaBWrHgRLjcs+ChKCVAq4uacfOO
	uZo2SVQk6bRBMcR0EPE9V5S8Nbj4fCU7Tsrh+6cnhUSfSbkUxgDZ4YYnpe43S5WZmR5KcwEgk5L
	nbFtLzZ7iQN3VVr1jRkcS4kXIgyiLWs=
X-Google-Smtp-Source: AGHT+IEU1Xe2lAmPO6iNBTAj5sggwrT8IjsKe7vRboIZMPv0WTY0Zwji2mjdrlZbGMkJm2gu+P6b7Q==
X-Received: by 2002:a05:6512:3d1b:b0:545:8f7:8596 with SMTP id 2adb3069b0e04-5451e5080e4mr706332e87.17.1739439671065;
        Thu, 13 Feb 2025 01:41:11 -0800 (PST)
Received: from localhost.localdomain ([178.176.176.188])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10cae7sm119518e87.183.2025.02.13.01.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:41:10 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v11 3/3] riscv: dts: allwinner: d1: Add pwm node
Date: Thu, 13 Feb 2025 12:40:14 +0300
Message-Id: <20250213094018.134081-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213094018.134081-1-privatesub2@gmail.com>
References: <20250213094018.134081-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

D1 and T113s contain a pwm controller with 8 channels.
This controller is supported by the sun20i-pwm driver.

Add a device tree node for it.

Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index e4175adb028d..2c26cb8b2b07 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -145,6 +145,18 @@ uart3_pb_pins: uart3-pb-pins {
 			};
 		};
 
+		pwm: pwm@2000c00 {
+			compatible = "allwinner,sun20i-d1-pwm";
+			reg = <0x02000c00 0x400>;
+			clocks = <&ccu CLK_BUS_PWM>,
+				 <&dcxo>,
+				 <&ccu CLK_APB0>;
+			clock-names = "bus", "hosc", "apb";
+			resets = <&ccu RST_BUS_PWM>;
+			status = "disabled";
+			#pwm-cells = <0x3>;
+		};
+
 		ccu: clock-controller@2001000 {
 			compatible = "allwinner,sun20i-d1-ccu";
 			reg = <0x2001000 0x1000>;
-- 
2.25.1


