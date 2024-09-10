Return-Path: <linux-pwm+bounces-3179-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5359726FB
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 04:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57911F24A1A
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 02:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A6513C9B3;
	Tue, 10 Sep 2024 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcZ8s1Oi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C5A81E;
	Tue, 10 Sep 2024 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934099; cv=none; b=PCunEKMBUpvEEC4MeJ1+LzKWU0Wh9hN8K/rKO6i30PxVPfzXqnSvxC5dL3k9RgoigaPijQ208fNuarba21VU6RKylKCHEXbgCEEXQ5S3m7f7g2pJxH1gHKyWfEqkYxP7wtCj45IhrvZLgGpZA58+rAYckKIWuVCFX33rug3oZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934099; c=relaxed/simple;
	bh=2babzPnAQlxLfuTrsLFEKBg3rrRN+wOi9aMa9e08msg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVLVQul/kvsHDmmaXIH4uSYL+en2k6ivryn2b4fP54xtsyP7cZuWyXrmnjo/FIQXcthRw191PIbt9IBA4MgGHy1g35FiLq2gEKqjM6DsTg6jgTqHEeHpoc2xnDhQh+ATvQoaMbrYPWQlM3Oc7nxTVJESUsrDBN+q1qB3iPAmtD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcZ8s1Oi; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e1ba05bf73so1480143eaf.3;
        Mon, 09 Sep 2024 19:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725934097; x=1726538897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BI30WVVFXk39PBBMlPlqzRH+DTqK3h2z+UCMnQv1Ops=;
        b=gcZ8s1Oi24uHnKkj1KNQ5JCyaBIQddPAD0SiWTJ51bGmQmUJ7diRvUfX7DEl/FdO2i
         mJMh1xzb+hdcPZ2u3YsV60aZpgmI/GSws51vdYHINyKDasszD+izKpJfu2E8MWoSU6LE
         dCbVUiJoTXeieAknjPK87+yKaTHzKHSo50Jz9NNiY7pxVpld5d9AzSGCr8/0Py1snAOp
         cb1oxxvVbH6nmvm4RXg+KqMktlUsXB5qWdNB0gLUhuKmD34ZluTR6Kyx79bySXO7Tcqr
         cVFyv9DBWp3iww8qc7jmp8k4USmHWfkzhzpRN8oAximihVRALmnRsXoftCIu2Ac6OOoE
         gOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725934097; x=1726538897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI30WVVFXk39PBBMlPlqzRH+DTqK3h2z+UCMnQv1Ops=;
        b=OQ/7RrsSk9Jfv7TE6QWesjvyDp+A/oRg/pKvdF8nrz6FyuQ7cSLnKOaRaMtkEkQJBf
         VRYyHPIEUR0nK8BXQ7WdVP7edLF6swC0hzSqURsnf9XqEXIDVJ5cAYDgyEjCM1GEXMRx
         5aCSJ8JMpb2IC3qIIEFh5X11mlNZ/qN4sgxQvctIViKd/eY4ld9y7nkGQf1EeRWeGVRF
         uWWWKRkP+GFQAeuQlOnRRSSdGiMBY34cO8EKdAnicLPDAipMKMpgXtzqinvtmMUzHJKJ
         vUnVpZG7TxeRpabwU++naOUsMOwSlqSkPrle+FYyw6DpYZqlDKpQNEwxsYGLccltNP1L
         zETQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBR/qspY+QNU1N0VQN29p8et1mMN7oX27bE0NEN1r5bmmkXC6c1jCrhQIt+KMI/yJ8ruPmViPGChwAi4iK@vger.kernel.org, AJvYcCUIasJLAvzcGr3isoHcqose1IiFBMufU1mRQnWLBG/e1Uwy+6CdG4A4F9FzkLxKmipuok696hVDHX53@vger.kernel.org, AJvYcCUi3bFJUskCW4A00MZDjwmimhTKq2PFIi0hnRWuWedIhi/Z4f4asFyCaJ1Pu8hg4Es0R6HISPx8m/VS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hp8HRUI8ae5v+o3p+oKpHBTrTSlkUQSfCp1dTq3GkWDAS99p
	rd+flh/7t3toc/dy+4N8WIPtKyTx3hqW97hdu1EamoiLO6fbXYfRpvpBVFDuW6Q=
X-Google-Smtp-Source: AGHT+IGFLWDdr/KERlkpx8BuwbDh6erVc7wsCpO7c1sCwII502DRfQ2scgY32Y/Ts3V/PR3030bhNw==
X-Received: by 2002:a05:6830:3c08:b0:710:f76b:350b with SMTP id 46e09a7af769-710f76b35b2mr307494a34.5.1725934097103;
        Mon, 09 Sep 2024 19:08:17 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710f40989a7sm380982a34.59.2024.09.09.19.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:08:16 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: pwm: sophgo: add PWM controller for SG2042
Date: Tue, 10 Sep 2024 10:08:10 +0800
Message-Id: <c2b237b5b2430b0715c9c3dee043d30fe5216e2e.1725931796.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725931796.git.unicorn_wang@outlook.com>
References: <cover.1725931796.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Sophgo SG2042 contains a PWM controller, which has 4 channels and
can generate PWM waveforms output.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
new file mode 100644
index 000000000000..fe89719ed9dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/sophgo,sg2042-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 PWM controller
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  This controller contains 4 channels which can generate PWM waveforms.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: sophgo,sg2042-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@7f006000 {
+        compatible = "sophgo,sg2042-pwm";
+        reg = <0x7f006000 0x1000>;
+        #pwm-cells = <2>;
+        clocks = <&clock 67>;
+        clock-names = "apb";
+    };
-- 
2.34.1


