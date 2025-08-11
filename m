Return-Path: <linux-pwm+bounces-7011-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C91FB218A8
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B371881789
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97312E5B21;
	Mon, 11 Aug 2025 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfGXPWqX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A62E5B02;
	Mon, 11 Aug 2025 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952495; cv=none; b=XGOG5fJCTFisVpVrDuI1mVqrAe4bADbW9F5lukj8nJ/cb4+ExL1ppEtbWvH1/2UBX+Ay0+BIU08bsRUuP5wHxGymuzBNgNtY/em27E6VUW5k5WqUDLTMckIZAZupEiANLgUU+7EsirykSiEcqRQssmrGV5KqLJnNjIjTbZarDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952495; c=relaxed/simple;
	bh=Rnl8w+SH/nw2JPdcQ0erKjjymCdj0uvkgeVYoBTMisA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEcCUKxxlwnDO92eq5JI1hytLNPoxZgwmDR8m00h9H6yDJWsKUu+Q/+gjs7u81Vhiu3XVPQzYtHBskUYoCNJn7XEbDyxkIBXXdsAafqKolPk7Az15kXjPHeMtRAWQGNWnL27SOkNpb9bSdRXxD3h6Ax5lZLBdiFkuxxHKyhI8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfGXPWqX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a119dbc62so616445e9.3;
        Mon, 11 Aug 2025 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952492; x=1755557292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT6KB9uJF//5o0bC4Hfp3voC6koE6Q4zGOMWpbC4QzA=;
        b=JfGXPWqXZXF4ZP793wC7QBDMl4n1tSq5V3DmH0qRIu3pWOuIK4QYc04cg2XIMgRiKu
         6B3FzvXHD4zOFUAApYZsOWAhYLBnbN1PqVbRFcrctYQY1tMp59X7VN3jmC/h+8fMpopj
         YxDXRMhJNS99fdanCNAhEDDIZMU3y6wOzGDLWhUUNAxgt2f4ubHkAPmmi4OyRhdBE5bg
         gCpWqyzdkP11WwFpL69g/PciyFKvaas+nRePUkTtqhEckYk0ACf9mTGgGuwdHwRfAzwb
         eMoYWn9k8UPIq1RncRWwU8dujWedytyZdBKSrml7SrLAtzwu9m1ls6jgCUgHYEE9/BwR
         G1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952492; x=1755557292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT6KB9uJF//5o0bC4Hfp3voC6koE6Q4zGOMWpbC4QzA=;
        b=drahr0hK9W6x7OQHBCilKdxNBduQmO8Vzz2FBrNx0VLTwrW7cSGMPLqZralEEh8SyI
         KTUO8GuQeIAmGm81vke+AC8hWgMDOhwYjnPpFEgx/8CdR2BDyYLK1pBiUL6Z6OCWrtNF
         Fokgs77Ef4kP2O9BO4hgdVZ4TFzSc7q+ACXjbAg452deNPod3SmJ4IdzINp/CyQz4v00
         5M3ofcSZTxSLByttlWhWrZiXq42tmqJWh7yP84AO0t/KpxifnbnONoxTY+MhrdLtNFI2
         9fO2wTX0nni4rL1WG3KghYMiopq1CWlXtXpbcnuX/iYqaqOks7Auh9u/zUcdW1wYLdbY
         4Y7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUezu4ixb1qTsmPoCRoTPibHVpeX3EIACCdxpyC/LsDh94S/2QPxcPRLlGU1NoTsrky9StdR/MfGAvf@vger.kernel.org, AJvYcCVCe4oDfRc4qkjC+o4LMQi2AgqlCrFptindAlH0E9K4dDg9JOmsJXcTMmX6VRxIRENWIEO+QVO4xpeaSbE=@vger.kernel.org, AJvYcCVZhAlVwL1ZUyG84sIDmfkebtNwiKIAgUEufabVA42l5B2OMRcby5TzOZtDIwsAXJuR1hVOqFOzdr5kssE=@vger.kernel.org, AJvYcCVbXh00TWef9QKH0C5Hbrb0qornuNBdE+5T9R7OzIKQwdF3keQlC25Umn/HbKoCQlIC08UfR62hsIqa@vger.kernel.org, AJvYcCVmg/6sEaVl2BQQRQWJK4XxcT7iPolbohWSCOrbkZh1PhxfNWbGtdrKmWZ2eRxjsR8yOgWv/1SSANKS@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFZa/fnuQc2eYCIGGXXNFwNe50nUiIYmjVxLLVkd2td6Cr2w5
	2WeRoXKjUfTGva1HYQ4bNu4K3GSKxZyz2mJ8hGOet1IxBxifb4nl9HeRV6Yapcs=
X-Gm-Gg: ASbGncuuGJopF0WOqiRfrMegHrtZzFMjG8ewG1ZBi0gJabkvX59C4SXGVhTsH+Kxdq0
	7cbZ+mw/Dlbwe+b/ahglBl2OnN8Am4L1aYpqMuaqJLQD+lphzvkB6JCL4UqshDMar9gUqAMMg96
	Wn6JKdxpId8WWzHqvpqEMPEfY9FKPNB8xDLo5AUkBkB4rvxLD26s/rYOdUrCAFCzV+xbuptqiqO
	8zXR3vWeMhSvpI2cPDrouFd4ED2UpzEkEsSNtRudY3VAioly5MBJBgSAlPlz1DrsUpb0Y99JlwL
	m6B+lNM2uTz4losmbDii6LANcDQlj33TdhtzfM34BJ+/GxAZAgnwr9cf9m2U/DJtjI1+xdLR8Hf
	F1qb/SpRr+2Ea3oNTMOLhKoE0dOmdghCbkj0jrDcdWnfWN5Q=
X-Google-Smtp-Source: AGHT+IHSUvjaOxpxyHgfhBPXvrEkDymvmVygZVJlOSlOLyegdLA9SLK1euLwWDPUYQlWYfE7iVwAdg==
X-Received: by 2002:a05:6000:2483:b0:3b7:95ae:2b10 with SMTP id ffacd0b85a97d-3b910fd12dcmr1198407f8f.23.1754952491720;
        Mon, 11 Aug 2025 15:48:11 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:9b35:8c56:5611:71e6:ca77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm343678175e9.2.2025.08.11.15.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:48:11 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: peter.ujfalusi@gmail.com,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	tiwai@suse.com,
	conor+dt@kernel.org,
	lee@kernel.org,
	ukleinek@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH 6/8] pwm: dt-bindings: ti,twl-pwmled: convert to DT schema
Date: Tue, 12 Aug 2025 00:47:37 +0200
Message-Id: <20250811224739.53869-7-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy TXT binding for the TWL-family PWMLED controller
to the modern YAML DT schema format. This adds formal validation
and improves documentation by inheriting from the base pwm schema.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt | 17 -------
 .../bindings/pwm/ti,twl-pwmled.yaml           | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.yaml

diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
deleted file mode 100644
index 31ca1b032..000000000
--- a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Texas Instruments TWL series PWM drivers connected to LED terminals
-
-Supported PWMs:
-On TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
-On TWL6030 series: LED PWM (mainly used as charging indicator LED)
-
-Required properties:
-- compatible: "ti,twl4030-pwmled" or "ti,twl6030-pwmled"
-- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Example:
-
-twl_pwmled: pwmled {
-	compatible = "ti,twl6030-pwmled";
-	#pwm-cells = <2>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.yaml b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.yaml
new file mode 100644
index 000000000..411cc4c8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/ti,twl-pwmled.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030/TWL6030 family PWM LED controller
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description: |
+  Bindings for the following PWM controllers :
+    TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
+    TWL6030 series: LED PWM (mainly used as charging indicator LED)
+
+allOf:
+  - $ref: /schemas/pwm/pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,twl4030-pwmled
+      - ti,twl6030-pwmled
+
+  '#pwm-cells':
+    const: 2
+
+required:
+  - compatible
+  - '#pwm-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm {
+        compatible = "ti,twl4030-pwmled";
+        #pwm-cells = <2>;
+    };
+
+  - |
+    pwm {
+        compatible = "ti,twl6030-pwmled";
+        #pwm-cells = <2>;
+    };
-- 
2.39.5


