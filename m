Return-Path: <linux-pwm+bounces-3097-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9496D7F7
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461221C23808
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C119AD9B;
	Thu,  5 Sep 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoT+znXm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E919AA68;
	Thu,  5 Sep 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538235; cv=none; b=Qmi8ZpJY3E+inlt9kHH1NPSEY6qBhBS0HlZTX9RqQ2Zi20E+K1Y4CNFxyIkTtnoamdC4jypuIpF4cnV7go98FtmeMNwgxp1s9tOzXqB/nInTRKy2gfJ2BlB5yF2eCizpyFcW54HqtowvTTwoRnnzYJBzQSTBDhRzqhD/JkkpvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538235; c=relaxed/simple;
	bh=55EhFMuf3rX520ZB+Jq/JvrzpSdYero5M2/yLftdFvQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BPEJPGYVIcLit1vIdbKJI//7iKfdFJ3aegUbjdsOwUWBSNY2q7lozx8p7FXdW3MTYChPIa7k7fowcmZOnjDjvjhap00/Vel+lvMzZbWg4fDIkQzv4VgUpBsnlrq11P16yO6Tv3KEmhHLMbfbgJrQJd1TOH6OnA9aq16EnpnZ/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoT+znXm; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2705d31a35cso481949fac.0;
        Thu, 05 Sep 2024 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538233; x=1726143033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RwhX/0NxaxgXVwmXW6hND45TWsNukqVDswt5JLO8uU=;
        b=CoT+znXmfdYVirly9vpK3w4mrhv3JB/vMKaRIdrRizUH8XpEC9pSP4Xad6vS+ubMZm
         I+FWvam6tJ60gLG+W3OfA6/p8moVwLD8+zdz5Wgqn6CWLxbS/K3Zae2ni1LBbjBJNR0F
         eZSUbe8cFo95FpTec22g/cnzl69bFKjfug2047fblfAD9t4Sx2JWZF3qIQ6P13BsKB6f
         6sF+YwU1GRncAZpXAy/nZbGIp9ep6ncBO9jjD9zQEuH5AvGhg2fepxmDaNXLfs4U+Tej
         /D5oQwjTbzODO3A51xbTiNniA8fHSJ4GxSzlVKf4WCWwgHy5hPrC9fnZ8xCOjhAleKfB
         I4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538233; x=1726143033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RwhX/0NxaxgXVwmXW6hND45TWsNukqVDswt5JLO8uU=;
        b=BE+LhIS2BIyA2/bwyhtT4lelFToXW+qvDcpDIbpBFKrIeJyD5BJTFvDz4Mj8X6T4Gk
         K6N2aRouSk5vj/nNgCXEfgFdlMtiQhBx6XdYtPfeiOCrhpzII3GaNLol6bJOKBPZRYLD
         6FxhDDeiVz39TaKFpq48XrUH5PH4Z2iQy+svXMlXEZ8TmI6NuB+SjUMofVIkRZCzD+p6
         XvRWO9+56FpqmubuHHOC7Md0g5JY2WN26h4V5B6XZ6oBaKpxnlanN/ZJCYyGc891f3zP
         T4jO72wdlVqJ00kDOsowXHUgExYCQRinrkqc6OayHmuHHFEOC6/2j/VUkDzbaYZpKhVr
         h+jw==
X-Forwarded-Encrypted: i=1; AJvYcCU3ApVJIfhUn9m75+Vkvk5hGm3WhnOJEgga81z7HXqGwoKXVrFAr2wMziKUAqPRtp8vyHFTZ2SvfzghYzPx@vger.kernel.org, AJvYcCUtUszYYqYd/KkkLeYF3/yvG2WsWNfrOS6jkT7L7pBceDUG0KSh92HPhXDj9XICcwzsFZPjcZ3hCWme@vger.kernel.org, AJvYcCVgSBWosnIAUEY75kQqUr0/8xVvoDsSYyx1+IXQ/LseYKVJfsvQaoT0bitE2hNPh66VvIwPBxOGMP0c@vger.kernel.org
X-Gm-Message-State: AOJu0YxlyhRvG3rt39LI5+j+/XmRk94FVpwXB0wE4kXioGGZq98tucwX
	c1U983rQ320+Y04rvy/oHE4vc55tVnzn522vOfufiBzaMzx83zqy/HXkzJiq
X-Google-Smtp-Source: AGHT+IGxtEkwnH6QBvHzbe/QGSRFYjVvranECxxZCASniIhEomIoOolLxioXFT8Y1BEE0sPlOwdT1A==
X-Received: by 2002:a05:6871:8c15:b0:277:d7f1:db53 with SMTP id 586e51a60fabf-277d7f1ded8mr12689185fac.17.1725538232564;
        Thu, 05 Sep 2024 05:10:32 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-277abb62c95sm3977069fac.23.2024.09.05.05.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:10:32 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: pwm: sophgo: add bindings for sg2042
Date: Thu,  5 Sep 2024 20:10:25 +0800
Message-Id: <6e5fb37472b916cb9d9abfbe3bea702d8d0d9737.1725536870.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725536870.git.unicorn_wang@outlook.com>
References: <cover.1725536870.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add binding document for sophgo,sg2042-pwm.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
new file mode 100644
index 000000000000..10212694dd41
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
@@ -0,0 +1,52 @@
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
+description: |
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
+    # See pwm.yaml in this directory for a description of the cells format.
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
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


