Return-Path: <linux-pwm+bounces-3523-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E63993D39
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 05:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5614A2818EB
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 03:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE8C26AE4;
	Tue,  8 Oct 2024 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs2h/kmg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221A224F0;
	Tue,  8 Oct 2024 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356646; cv=none; b=aLSP98TjBRDFdpGxDplkQ/IgwY+Xqau/4i2x6soHCex7Xf6wgQLNMaeD5L/p97OR/zl9JxH7VYSTzgcTkSP9HOlGmCDuH/pmJ74h43wZKnXTLmWQbodEwysxTbnWPS60+k2NFMEOfiO1EJ5M5NrFR210+FnJr84KD4dDeMCjE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356646; c=relaxed/simple;
	bh=K6wTO0XXcUltPS1eFJkf7vAFnY2/gPwEUzXU3Ct6GMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlnCXK2QKcRItEyhm6NMeav/4tEiiV/MsqZiUkQ74sbZKUvM1F7qgU8Wt/FCHIh9sGl01dVw7vXbG2gbkp1w6XeZ9x6SnBapmz7hzytueJNp1vhBpHsAV668hb5bxx7xWEIlZAXXZgd+ST6WJ3qE6ouzJ0VofLfvsNHJ88Se/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs2h/kmg; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71100987d1cso3189737a34.2;
        Mon, 07 Oct 2024 20:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728356644; x=1728961444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlWzcYJ31J9Ws/z9sFG6bpzdTEyI/n4+1H05qgKO0vE=;
        b=Fs2h/kmgd3rDJdynlns57QBpK87mKRHBCWQx2o/FiCtXRQUhPj7QdyP+Mmseh8/7nR
         s2/pzqmyfWlrMhEBIgHmkggjUj/vtEyMe7vZu/9GlHFVmA73r3jZcuqnFnULOwudtKLo
         NG4/xC46dI9Eot7lKXQkX54YvCu5wHXa5NC4TFOtpadRm3yI/l6Yr+N90/bWH3i73on6
         fr5H2EmdUbTmU+JSULZ/GT+755/TCUW3/Cr0BF/4E1iC40nNXd+v9Y5KDlp2o1oQg/a2
         +lExGP0xdHaknL8Wl2FHZb1X/fqLuz3Va+qZx+aZvYX3C5l1dUE7S3ukApIDXxHYXK0y
         azjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356644; x=1728961444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlWzcYJ31J9Ws/z9sFG6bpzdTEyI/n4+1H05qgKO0vE=;
        b=lQybni88VDs+VfBcXmElUUguyi1hLVdWtdPM0SWrGj2sdNFn3Mi1BMuRE4y9HQxnxc
         p6E80+hK5hYg3r7sg2YbWoD0s1KNMjkfcp8TcHAwEmUl4dvmhAMUyrkLvP5w2SnVYinf
         jD6OAlH8V5zckHegFQ7ijJiiQsOTtyZC2Pw470su8N0ThVEdSp9K2wX+0wfPI/T+uliU
         dHVmi4e3ov/U8XTV1b16ljl/uggGbqTSaGHHXPh2yQpqHZTuM3zSHAyrakcFBA5/UUUJ
         AOin4d57p1y8qHuP8w0HsEBhnwE16rPaVYM+Zu3u/ybuAXL3sai+tRWvx2Gt96kE6y/I
         yjPg==
X-Forwarded-Encrypted: i=1; AJvYcCU+6wpAVLdYaCK3/BfuDQXPKCLZm6DwaVeIFpA0se5O701gcvmqYsPoRbaOwR/6TRBGiY3Ho2Ko95Mu@vger.kernel.org, AJvYcCVIdZx6nfEV2wVGTgc0EIg3V+fW6oIK2FcdcGuMXGsaJ63g1+nkGeweepqRJDPVn0PUHvmt/3jhDSUuH7Dj@vger.kernel.org, AJvYcCWds3e+M9DkZVnPKUXgntVSWhnUB4a9jY7gsXmsVXQWFAKoTL+HShNQmvxcnvVjYHTuICd1MwQKXxAC@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFADTGhSrJY2BGVw+GBSIxHh0/8mXow8z8YVda3BYlqjTdUXf
	HrHXBkExG3qfsIAxGxkAJ4yGqzSIPx2yNX6mbmzknw1z+cAI/dQy
X-Google-Smtp-Source: AGHT+IG1ZpRLRDMCNzaG4ln3251H+l6NrmeOXdEcvw8EjEFUlcXPz+rrmFhK4pf1EQHHupmW9XupPw==
X-Received: by 2002:a05:6830:2682:b0:710:edaa:c030 with SMTP id 46e09a7af769-7154e97bbe8mr8716722a34.26.1728356644416;
        Mon, 07 Oct 2024 20:04:04 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71556865db1sm1768505a34.72.2024.10.07.20.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:04:03 -0700 (PDT)
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: pwm: sophgo: add PWM controller for SG2042
Date: Tue,  8 Oct 2024 11:03:54 +0800
Message-Id: <fec7163144d7f7b615695b5fd22a182ed7f1e7e9.1728355974.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728355974.git.unicorn_wang@outlook.com>
References: <cover.1728355974.git.unicorn_wang@outlook.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


