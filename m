Return-Path: <linux-pwm+bounces-3600-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B405E99A15B
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 12:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5571F248C7
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ECF215F58;
	Fri, 11 Oct 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbNhtuMr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD2212D39;
	Fri, 11 Oct 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642541; cv=none; b=blzZo6MB5pq6cQlqO6RAFRxGhIDBKzvzJXLalQ3H5DBxmly+auDHXlZav7mOdmtRoYR7WbejezM8F1LeUNw1E0BH3RSGJ7j4rlV4MPPlrYkjL8IjXw/nHvfv7dwjRjsrk359olC2rJ1pSyYcLUqusXY7u55QL8SiTXiruUx1ewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642541; c=relaxed/simple;
	bh=BHjvuHtxcGbYTJxuDTg/fs/1zRBNwMIIEfEqMmhl7qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAbI+7dN5ZW2nFw87WHTKaTL2embmvrhS9+PqlMq2eRAOT7XASVOCQxndd+MjArFTFuJrnifazDpKPaFWN3d5XY7w52drIr11WKU6FxLp1haRm8VL7TumC6fozJCd6iBk0SQ3GQp3uaKEhR5/a9LxMOdhdN7lOzsMarQSLYMn34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbNhtuMr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53995380bb3so2600416e87.1;
        Fri, 11 Oct 2024 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728642537; x=1729247337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYYMYkxftkNwTdyqS8CRT4NccxOq5tlDjvnPZc99yTM=;
        b=mbNhtuMrxQSnKTot+NT5QNZ7riExtb/YwKxBXOISDkBDwFX1dpgVSnIr5gKXkPz4NH
         iHTkiRFjbGQXqsKk9qweqFD2yPM8JVkmlb5qnaSuTt5cfqYj3QHEWXzNlpy/vV/un7dE
         qrYokfWWTyaUBDFHDugx/jd7pUZW2Jb5kSlQkT/VvU0WMO4Mex9eLxOr3Vb9FckbqqJ6
         F9Wi5F9mpSn4bvcXKCwwOUTk2AOjzgCoabCsQ89cvci022NBR12EcW2G9hYfeiP/yUtE
         tt/c8lc1iJHC90HLRyHi5ulTS9LcOOsSouCOjV/jhET6XBYQzWZ3PTv8VhUktJ5WwwXI
         V7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642537; x=1729247337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYYMYkxftkNwTdyqS8CRT4NccxOq5tlDjvnPZc99yTM=;
        b=knsyjqJTd/B1WkRbT1YG7CyGeAZqd+CI2Jv14tLb2+aGiOWkLjdekjKasNQDjeD51L
         Vu0S7RLSozuFikzamfuljCLJ0cgUmD6IMr+cMBsc5hlBKP1zXyLv/0Vu0s1rMb2imUKG
         4ZN9pKYwa1NAqqGypAwI9gb74UVh3IFPINYtqxXS1Jk2XkOdYEmSvYrGMgTS/68W0FRO
         4p2qY9BJXX6eqUty5RRYSVcQ6cIaKhKyXgEK0yKHodmBC+xBUD8W7Z9Lf1E3kg8XyZdE
         CXcvTVGH6Dz0s/8mxchxul6J44N3w0mttM1Ev1MxtiqXaAu8bGCH/UHxNwz++WAwSP6K
         wzAw==
X-Forwarded-Encrypted: i=1; AJvYcCUe4AK5bR/yfGY46K4vCLZFC3PzoUadg8XSfguwfLmCd/MiOSIBWvphw+9Lww3kN5Y5ZX3zaG2OSNha@vger.kernel.org, AJvYcCV6fDXO1RbWVOrwvrWs8ebUyikTZC2RRj55usKw7rOrUwu43Y4gDL+vCzF5pkbOc3wZ4/MbbAgAdHAk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcuk/TI8hIb5l7vX4wWDyg9nEz6nYQDbqPpRH6FPG5CQnyAfq4
	YKBkDJ+F1gJptNf/BmpUQu4+IHUU4Rp6X6Xnf9AWecR8smfjezsObBSVH49jA3gN
X-Google-Smtp-Source: AGHT+IH/0iVsIqjE53CKqC3QuGl88A222SHl1NC8BOnNKbuokjEWuS32AA0HurhU3gBV0qhEcwHfLg==
X-Received: by 2002:ac2:51cd:0:b0:539:e333:181f with SMTP id 2adb3069b0e04-539e3331a00mr162073e87.10.1728642537233;
        Fri, 11 Oct 2024 03:28:57 -0700 (PDT)
Received: from localhost.localdomain ([188.162.200.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8f1003sm552534e87.233.2024.10.11.03.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:28:56 -0700 (PDT)
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
Subject: [PATCH v10 3/3] riscv: dts: allwinner: d1: Add pwm node
Date: Fri, 11 Oct 2024 13:27:34 +0300
Message-Id: <20241011102751.153248-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011102751.153248-1-privatesub2@gmail.com>
References: <20241011102751.153248-1-privatesub2@gmail.com>
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


