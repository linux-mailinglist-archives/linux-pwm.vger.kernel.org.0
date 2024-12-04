Return-Path: <linux-pwm+bounces-4218-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9219E31F4
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 04:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FA7285B1E
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 03:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82E5FB95;
	Wed,  4 Dec 2024 03:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8t4QURl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4225771;
	Wed,  4 Dec 2024 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282193; cv=none; b=G+pF4pG4rcOpC8/cd4xlS4vzBNVPeTmb0d6oo8W9Ia5plFF/dyMz626CBHhO/fm/1Hx8/y58dH32t4TIfBLiggVkFByKzVUQZG0FGhjp1FqE9ZltnF5B5rJKFLpbFarCAPONCH65/iMaBEscyA5XQ7q8tJ4GxKrqVpAKBlinEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282193; c=relaxed/simple;
	bh=3p4yGURKRybyWYfqJv7wifGGEWBo97x5AmEQOI4GZSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcKjX5R4ts9CNkRHG/hjsy+jpte7LiofBcGTN8+X6qEzqs7jIcJIaQOCe73DfmG48hAVtn2uzsF29flgMCq1xfACxcm80djPIERtNp5cbhv07a1aD/kKYwkWX4h8QUWzpDNdLPzOLGikzIoBYlUTeFGhdr8ALBaJ/3G8BViJi48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8t4QURl; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29654932226so272222fac.0;
        Tue, 03 Dec 2024 19:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733282191; x=1733886991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kROaOIt5szJgAa68Sy5g7p0dogkgu9Z3CSKDjRWOQKY=;
        b=J8t4QURlw3CW2HQBf92CZ9VP1iljm09CyplRyFH5jjdZVqt/B1IpoESTvi1AXH2sPI
         ZEVaVRoCSnilo4bWrlXCv0rZLxluVj0YRyBxhGQJBJtLYKZLxYCbYUYzvmCyDsjObuLD
         062UEEmU18jymcZJYdrZPAmBVM1BJDm5hx7RXOEF+RskTBf6Pp50ywFv5i2g2KkcE16N
         s4AOB6Qm/+MhvfdpSTOCHr9nIn+4Y/0RRRVUQgubGyDmiXlG5sQ4D1ummRJKbYy8nd8F
         lbLz49GpfQQQAq6lPKIAfeQYWXsUeYHm8F0VEFPoioiD6Kllt0sZzrWqU8nM5n2eXqqB
         ih9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733282191; x=1733886991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kROaOIt5szJgAa68Sy5g7p0dogkgu9Z3CSKDjRWOQKY=;
        b=fZN4qSFPpLhozs5Av9Sp8tV4niNUMxaJRstbvNfGraztfGnht/0IoangN5fjCFOMCL
         W2rntA1Rk1Ha0DqBaHkJEygztlV8WDhX8x1uN/hh9c3f/o2iH5TNP9AASmpTUefm/DBZ
         u2rgB/yDSJ59bRYe3E4kx7GqdOKd6eARRkAZzYDA+qQ9WA0YRvSvJzpj/6DIk21WCQmF
         EUhpWNhpHcsb/2I/7LsS7c3T8uPZifZUHyGuCko7bM/+rIFQzgR8Hg21jmxbX6M/G7rn
         7tCSdJaF2yzsAG0tOC5+EEFiK+JnjgqTfChN3cAaKplhcO47tpGqHTK954Fw9zBCN9M3
         aWQg==
X-Forwarded-Encrypted: i=1; AJvYcCUAOaq9ksG6g5rMlTKgHX+r+X88bnf7ZU27rQIISxU09jaVGqu0oYZyWM9h1qOmEJQlHb7CeaMYVrlwxaAM@vger.kernel.org, AJvYcCWaukMKjEAJz442AHuVR1nhJwKpDckzps9OrM8CkfS06G852Nb2BzAYq4DHi3niBTBwzpakUfmOGlUB@vger.kernel.org, AJvYcCWz+qeoFrPdTi1mQnE/W3rzmi4lOyOPwFTSdM6hctEsrc/wmrFu+xcHoJ7WtwGKopwJeiAGDu5SDd8e@vger.kernel.org
X-Gm-Message-State: AOJu0YylbffO/iKwi+fnwApGe6Hwh0zdm9mPoGLBmkqATH5RVTnkXGE/
	6dZbA4Y0dM54F4KMbTM4VYHwG8qCXi5lhxhPQeviXbSFo92hazG99rDIqhjBRxg=
X-Gm-Gg: ASbGncvr8BeuPWzyBc1Iu8PrT6wXkdCSMVal2j6bTpXYUb67pjmvPMH4sK5hvYOBuqc
	g48l0h7c0ToH0WhjANXlke9OU0S7dGfYT2b5pD55E1N/vG/iFdWP8KJKb84+US6YE3U+rAjHVmh
	xyztxJLOMB8iFq/gsGQSSXEkeNhrUxJPWLwBfGDzBpouGqA54iXWFJLd+tgn3HGEu+CLzVX4Onz
	yB0NLDsFeOWaQa0VMB5RnVS8nIjUKRi4aoQxT4NEZ//bW6IB7K7gALB4el8
X-Google-Smtp-Source: AGHT+IHY5LjkclYMi3XMIUv3pdnbphLNp1wA4vpon3cxectbEX98rvxmO78DG4oypv59/M909N6rlQ==
X-Received: by 2002:a05:6870:55ce:b0:29e:7629:1466 with SMTP id 586e51a60fabf-29e76296df1mr5314546fac.7.1733282191529;
        Tue, 03 Dec 2024 19:16:31 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d8691ae5asm2425786a34.12.2024.12.03.19.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:16:30 -0800 (PST)
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
Subject: [PATCH v6 1/3] dt-bindings: pwm: sophgo: add PWM controller for SG2042
Date: Wed,  4 Dec 2024 11:16:22 +0800
Message-Id: <673f314d78ab467399afc02b96ac730149f19587.1733281657.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733281657.git.unicorn_wang@outlook.com>
References: <cover.1733281657.git.unicorn_wang@outlook.com>
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
 .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
new file mode 100644
index 000000000000..5dea41fa4c44
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
@@ -0,0 +1,58 @@
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
+  resets:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/sophgo,sg2042-reset.h>
+
+    pwm@7f006000 {
+        compatible = "sophgo,sg2042-pwm";
+        reg = <0x7f006000 0x1000>;
+        #pwm-cells = <2>;
+        clocks = <&clock 67>;
+        clock-names = "apb";
+        resets = <&rstgen RST_PWM>;
+    };
-- 
2.34.1


