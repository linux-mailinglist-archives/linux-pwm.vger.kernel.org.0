Return-Path: <linux-pwm+bounces-5590-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A23A946E7
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 09:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748333B8105
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 07:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4F81C6FE5;
	Sun, 20 Apr 2025 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ljkXWUDF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6B1C32FF
	for <linux-pwm@vger.kernel.org>; Sun, 20 Apr 2025 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132683; cv=none; b=kXqM1Xpa/lTBzwfkmFq4+3dZk7YUZEWFy9xI2/Ck6rZ+qsyR2x1tX4dGcVGKCtgfdrJ3Ot0fwjKSVjGxxI7uHiI+OpR+XT2mlfXsVZWKpZqaYXTcJJ3VNM61Ia0A2Sl1s8+IBVNpwEvHoYmH6woiyDok1cyNXSxljz74LQTFRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132683; c=relaxed/simple;
	bh=t4jNLYsfRo4vYlN02mWCuLhLvvlCbpD5ApBbAIbVkFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ticc42mhTPLcMRPTWuM5IPY7U5uXBySsStOtqBMu51dbP+8FYx1qWSdrI1Npbmlu4D7C0qQWJRpXdCHdQKOwW3h3132ICbiDUJSZdal582UBtcD4BZ2EU28cJV2CtrMQoQxOk9R/xezPVO+AALPLPR5lsxZE/LxO0GD3jezs+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ljkXWUDF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so3111744b3a.1
        for <linux-pwm@vger.kernel.org>; Sun, 20 Apr 2025 00:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745132679; x=1745737479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEr4zoqSDPSh3q/NPZGQ8bjJudfKjj9SBhXWOyMRmJg=;
        b=ljkXWUDFEOkdT4k8eBQ81mnVqk/Tch1l7gUvwprY7pDij4+6+oR/kPGkp1z6jgsRld
         hPEjKp9Cuh1tIEdaFKz4yESWc0Rsb5hh9Ip/22QJnBv4LjcTcUmWzcMMSR64Pt9ejK6d
         +DNd2BpY4kTB72/Q5i5juua3zMhyEpRitioYAdi0btQ89ti0h6U76yVAMZVvrxDpSqZw
         aZU9wOBs/60p/So6tlN+5Jlr88d2sa0/jZKiYinBDcflcGF6wBCygBWf94sRHv/5cd5G
         6f21e58bD/sTVuBqUf3D4Pivslff4QaOw+tRmcLaVm6Ag8Em3cR1LtuK8hEPBuiMaelq
         ctGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745132679; x=1745737479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEr4zoqSDPSh3q/NPZGQ8bjJudfKjj9SBhXWOyMRmJg=;
        b=VlVlieX5blvgPzeTJk5lj0QwW9xLHiiC+0D7v8frNuPpWCdx1oKBgjysCbELbDfzZm
         8Ls+kj25coWVyoezBXLf9H0FCDEKWRfepVghG3qaMvVjrcg6wPqX4RaiH+8ImhfuhHM5
         RceJg+Epb0c5MRtbd2YTxqZNvh0UKrdNgRCX4nj4c46FKvArWguVE4vdaR+Uqs6adBFI
         nxawzy2bcLjuxeOzjxBD9JXbJQwdCouuDx5VUvjNamFmqxFl477rZ5Ss7suwGHmLhNDT
         ndh4z2LDY9n4h+YvO6NeVRs/GDmZG04fHiWuhTtiIhj9WjXqY+d7t7ZXulk4QQH6HQh6
         boVA==
X-Forwarded-Encrypted: i=1; AJvYcCVcFVeHC+DN7rDFTK9qO0IBGfq5l0dGkLctOphnTV1Zv7I36ZlHCBydRSc/wUe1DmkZ8WnWNQibUT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyevXloPdJgj5SrmufbNXQcbkPc73J7Lex1lATq3mbox/K3Xuyq
	mBX/NUEIwsGOaLV9ZUeUMcDOfvlU/h33ftSBgxP4Z8XGkPg2zQnSVKF+ad8l3nk=
X-Gm-Gg: ASbGncu5dekEEfP3jmwvvlpmt9AscxNKsO9zFmocPcTutemwElZS6lZRlO4g5BmooTD
	Oz84Y7joZkVmY3cdoCLyMaUr5/k0mFZxAmk5W1BLsdPmw1meY8zopCDPc8WijhfUMlPQcXKj8KF
	EKB9YKfsBps7FgoqNXCzgX/JZipylgru0pBVNHznY58qAcya8MyGpiRNeGovh0SVkweM9bHfrjS
	lgERyWvSnu6Vx4sYjGgNdOkCrNOCQtVa1eMlAGREs7UwkUMX4+nIu7wy5udc3YUXnLe2wKHb1ug
	yf8WJpOmlbOdas+fCBdQTYICC6yOnw==
X-Google-Smtp-Source: AGHT+IGtYXVmqBAFmbk7LXbpDxQMyWUw0KBDYgsDqkcEnZhWP8dgPJ0odqZrRswxh/DPQhqrHeH9wA==
X-Received: by 2002:a05:6a20:9f46:b0:1f5:9d5d:bcdd with SMTP id adf61e73a8af0-203cbc056f1mr13712467637.1.1745132679468;
        Sun, 20 Apr 2025 00:04:39 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::40b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db12743afsm3742626a12.16.2025.04.20.00.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 00:04:39 -0700 (PDT)
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
Subject: [PATCH v2 1/6] dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K1 PWM support
Date: Sun, 20 Apr 2025 15:02:46 +0800
Message-ID: <20250420070251.378950-2-guodong@riscstar.com>
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

The SpacemiT K1 SoC reuses the Marvell PXA910-compatible PWM controller
with one notable difference: the addition of a resets property. To make
the device tree pass schema validation (make dtbs_check W=3), this patch
updates the binding to accept spacemit,k1-pwm as a compatible string, when
used in conjunction with the fallback marvell,pxa910-pwm.

Support for the optional resets property is also added, as it is required
by the K1 integration but was not present in the original Marvell bindings.

Since the PWM reset line may be deasserted during the early bootloader
stage, making the resets property optional avoids potential
double-deassertion, which could otherwise cause flickering on displays
that use PWM for backlight control.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: Accept spacemit,k1-pwm as a compatible string, when used in conjunction
    with the fallback marvell,pxa910-pwm

.../bindings/pwm/marvell,pxa-pwm.yaml           | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
index 9ee1946dc2e1..0d97333c7fee 100644
--- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
@@ -14,11 +14,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - marvell,pxa250-pwm
-      - marvell,pxa270-pwm
-      - marvell,pxa168-pwm
-      - marvell,pxa910-pwm
+    oneOf:
+      - enum:
+          - marvell,pxa250-pwm
+          - marvell,pxa270-pwm
+          - marvell,pxa168-pwm
+          - marvell,pxa910-pwm
+      - items:
+          - const: spacemit,k1-pwm
+          - const: marvell,pxa910-pwm
 
   reg:
     # Length should be 0x10
@@ -31,6 +35,9 @@ properties:
   clocks:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.43.0


