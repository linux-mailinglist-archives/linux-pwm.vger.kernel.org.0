Return-Path: <linux-pwm+bounces-5873-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85802AB0F8C
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0AE1BA6A7A
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28A28DB75;
	Fri,  9 May 2025 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MGmkz65/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009D28C86D;
	Fri,  9 May 2025 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784100; cv=none; b=N3rtcXOY77gJ0OhWNL5YXGgZ/lx+YV+9rOC0ptjDFYL3Htcx6bP0HOhDzh96v4C9qmq/EcS0hDj1yTVqXpEv8TQEWNnPFJDbVcjGRMO3LzhIgpP83DsAkopER6IuO/1YTU5tE8GRjQ+G1BnB4bjHE+ajaqL3ue5+cwotJrUjmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784100; c=relaxed/simple;
	bh=3Y7urHrDcMsShDzzKS9027LjLcYYST43VDFp9u4aHhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JsE3+gv2LIAULOZeaUSaySV6FGA7iYq7TNKj8jeLRc6vFdKA0RFBKgQ9yNWW2Xh9sjoOT91Li5P5E5JN8nb39+zLDmqDWDbGjxmMh5fxlO5cET98cPrB1Xz3BSzyho8R+w2nNi94lbFlewwVHg/abwa/ofHUtNfUMGtCte5vS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MGmkz65/; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A1C943448;
	Fri,  9 May 2025 09:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746784090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Uiw/EB+b68hKRkmTIlz9T6r09YtVb3+5GeHNAAKvMY=;
	b=MGmkz65/653aZbFbh3k1AZr3YCfK4Juz3MtKClqOdKgj2J6lfBCG3ZGcuOFgVr733h4K6U
	YLc+Zc+p3F0VrVVZVpNGPCQpPAa2UTdUtRdRsANnKw9Qimnc0cEanX0mG8HxyvBhUSPV5k
	gTqykviM9qLSeDaR1F0ObX6RgOD2t1Y25F/sr7sUXGM1YWDsmAlkgduFSpcTZ1IMWtGIH6
	Yhz+9i5a2wNuILrGSuPAg1QTzbtcCJfQDr/UdJRNtiYnxBDHnksk+LhFwpWR+qRX2nyf8+
	NLRaqt0RP2r/pMBn+52qfYGMHzXJo8rc8Zg4LnA3mC0xj3Sui7WKVkrW76mAtA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Fri, 09 May 2025 11:45:43 +0200
Subject: [PATCH v8 1/2] dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800
 series SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pwm_sophgo-v8-1-cfaebeb8ee17@bootlin.com>
References: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
In-Reply-To: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepvfhhohhmrghsuceuohhnnhgvfhhilhhlvgcuoehthhhomhgrshdrsghonhhnvghfihhllhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthedtueegleffgfdvjeeljeelheehjeffffevkedtveefgeegieelffeujeegleenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedvrgdtudemtggsudegmeekfeeltgemjegttddtmegrgegujeemfegvlegvmegvkeeftdemsgefvggtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemkeeflegtmeejtgdttdemrgegugejmeefvgelvgemvgekfedtmegsfegvtgdphhgvlhhopegludelvddrudeikedruddrudefngdpmhgrihhlfhhrohhmpehthhhomhgrshdrsghonhhnvghfihhllhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehinhhotghhihgrmhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdgsohhnnhgvfhhilhhlvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepqhhiuhhjihhnghgsrghordgulhhmuhesghhmrghilhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: thomas.bonnefille@bootlin.com

From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>

Add devicetree binding to describe the PWM for Sophgo CV1800 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b5b819d780f10163631ec14a20bfaa5ea46fe868
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/sophgo,cv1800-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800 PWM controller
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+description:
+  The chip provides a set of four independent PWM channel outputs.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm0: pwm@3060000 {
+        compatible = "sophgo,cv1800-pwm";
+        reg = <0x3060000 0x1000>;
+        clocks = <&clk 60>;
+        #pwm-cells = <3>;
+    };

-- 
2.49.0


