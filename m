Return-Path: <linux-pwm+bounces-3666-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2921899FD0A
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 02:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27541F2482A
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 00:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519026FC5;
	Wed, 16 Oct 2024 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx1sGEat"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F474A1B;
	Wed, 16 Oct 2024 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037973; cv=none; b=N0vi4Q9du5dSFVdrydm0YgUlpuuKtDgnHot4fHy936oqzmCP2e59QVlcg6CrTtTpvZSnhC2NOv4zRhoHHhQkBt6XjqTD4exi0eXBlvJrcA2o4RTBpWcTO/J/rFO/LbFOatlk+difNELzfeCznBmx+9pN4p2sBuvrBWEutMruJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037973; c=relaxed/simple;
	bh=K6wTO0XXcUltPS1eFJkf7vAFnY2/gPwEUzXU3Ct6GMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ia6Jg/Y5YskVnGySZaDqP2mQ+yJGYyGxQXuuYgoJd3Sc2DuHY3Yth8MTiykH0rIYdzMQTy1+P6BekRv5w+KPlWxAOob2qECusvJb7IM4I2/vytQft7B9JQskAI3rbWm5fLNm8h0RktafgPsRRgRAoDG65HhTuocZ5fjmv0y3oL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx1sGEat; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7180120a78dso698121a34.1;
        Tue, 15 Oct 2024 17:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729037971; x=1729642771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlWzcYJ31J9Ws/z9sFG6bpzdTEyI/n4+1H05qgKO0vE=;
        b=Wx1sGEatzVVW3avGE9TlYkQTcezX8SRIQ8Hisp1QuBfCaIrqaBMNZfnifY2UgOwVVC
         Nwo0E8ldWSTjCnOPg9uG0CqpJgCVUgONgXUmPAW9cS7cq1NOncPfLZq1LIxcodRwZlb9
         2ZoGnIVKA0pAwpVRy0WCtandRO3DFeBQL0bAENTl8LTVLKTfPa9Pvnziw2no26mL5ts6
         pxaM2D27oZNDy+pCpkiEMymVTvlHyc1knBx8U17gM1ZuGO9RA9t4ldBI3t5Y5HpPNOo7
         evsSG1x+d4yVUp6UACf2LLLQdhzVBsWMJVynFjkm+tmxCEeidImqOEZW5fs8tbEY1ucB
         kPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729037971; x=1729642771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlWzcYJ31J9Ws/z9sFG6bpzdTEyI/n4+1H05qgKO0vE=;
        b=rfEAARsMJ/B4LP79m2tozSWgXKddrJDmcjl08ocjoXoBbBIEBw56EKKpkltgZxTHMq
         He+rJ1GOMsvdfArRIjED5GOQj2qcX9YDskcYK/2GbhUfn43Uc5ijVN1rmgFMmnF2qLNa
         hF1ALtoW8jHb4XodC7xT65Exf0NNNQAsYjA53r1GkNVM3pGtoPWgfm7HvaGZE4A8fmLF
         SvHRxo0L+zekkHonKqF6saL4QlCzjrTQTrP/sP2IBxaf94btCZ4Jgiy5wwA+dagfFk5T
         BHvP+GGU5H8c1HgAhv7/lzpgA982O4u6vLedHbUeRd/1a2zJ+904cTtax07VF89HWj+l
         mB3w==
X-Forwarded-Encrypted: i=1; AJvYcCWKrdfkTbYSnsk3WD1xsTApNRB2qkKFvP/ZsXuGnRvY7EUdXJWPYNM6UNt9m7JQckKy9I6m+gOE8B4o@vger.kernel.org, AJvYcCXJ8MnvYeotFlEXiWLPvBV+qPwiMSzZBbZvW3a99945L4nEKivmFduFpwaA1VVWA49V3nH1rGbvh2Dt@vger.kernel.org, AJvYcCXNGM2Jp50dDq6MT7+9HXWuioZEZhllbxXeZRv76387KY36CMkxsxhUvYVmI6qx2JeVM1dNlUA6/RL1rO4/@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhYFz4UswwYKZLEeIFJQww6IUDKNzRrlLHjm0joI5mNkGY9J1
	lI/g21BDzIercA+A8fZetVNCaufWqowXiBL524orJkTSj+beudEC
X-Google-Smtp-Source: AGHT+IFw8zlbKDtvNmVePRwavyGsAfAi2KYxPiUFzfeRVIsRw9ZlHlAgw/BduzdJ6EYOR/iAMn5T9Q==
X-Received: by 2002:a05:6830:4119:b0:715:4e38:a1ad with SMTP id 46e09a7af769-717d653fc85mr14661117a34.21.1729037970597;
        Tue, 15 Oct 2024 17:19:30 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-717fb8e40a0sm594829a34.16.2024.10.15.17.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 17:19:30 -0700 (PDT)
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
Subject: [PATCH v4 1/3] dt-bindings: pwm: sophgo: add PWM controller for SG2042
Date: Wed, 16 Oct 2024 08:19:22 +0800
Message-Id: <fec7163144d7f7b615695b5fd22a182ed7f1e7e9.1729037302.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729037302.git.unicorn_wang@outlook.com>
References: <cover.1729037302.git.unicorn_wang@outlook.com>
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


