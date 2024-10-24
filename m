Return-Path: <linux-pwm+bounces-3798-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDF59ADD61
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 09:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EB01C21710
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 07:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B21B18B494;
	Thu, 24 Oct 2024 07:15:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A9189BB0;
	Thu, 24 Oct 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754156; cv=none; b=IRorLllE6SkFUD6x4xuSqdOPObaLKFcu2zbfRKm2Fb6DoLao4Z3QsDz2bJw6Tr6nSV0SFQ4wd+0+y7B64fyq4GWALREiqyGL6N6ExkzOJxEDH2TSud7l7Z9WvZXKLvvb6ZQ3S87d9g2NqI5l42FkMba4Zi9ajBfieEYjr2/cAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754156; c=relaxed/simple;
	bh=Je127OCFXyUqe0CKrY1MU+acy6SPlGuFU4zUPri07Zk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlmBF7MH/jSJc2/hlrXUEB8BJ9/y6lE613GPNGsX9gbpjLhZQm4Otg5SD+/ii7aYTBYDbXvCRQZICTHMgxDee2gYT3ELI/chr/dw3pTb3WuT3vjF+lP5z6yAu53/jsqKOkOQZ6seb8AI8PkDexXDzz/DDHJvLz5b2yJtJm4JBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 24 Oct
 2024 15:15:48 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 24 Oct 2024 15:15:48 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ukleinek@kernel.org>,
	<billy_tsai@aspeedtech.com>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v1 1/2] hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
Date: Thu, 24 Oct 2024 15:15:47 +0800
Message-ID: <20241024071548.3370363-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add an option to support #pwm-cells up to 4. The additional cell is used
to enable the WDT reset feature, which is specific to the ASPEED PWM
controller.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Change-Id: Iefcc9622ac3dc684441d3e77aeb53c00f2ce4097
---
 .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
index 9e5ed901ae54..0cc92ce29ece 100644
--- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
@@ -31,7 +31,11 @@ properties:
     maxItems: 1
 
   "#pwm-cells":
-    const: 3
+    enum: [3, 4]
+    description: |
+      The value should be 4 to enable the WDT reload feature, which will change the duty cycle to
+      a preprogrammed value after WDT/EXTRST#.
+      The range for the fourth cell value supported by this binding is 0 to 255.
 
 patternProperties:
   "^fan-[0-9]+$":
@@ -69,3 +73,22 @@ examples:
         pwms = <&pwm_tach 1 40000 0>;
       };
     };
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    pwm_tach: pwm-tach-controller@1e610000 {
+      compatible = "aspeed,ast2600-pwm-tach";
+      reg = <0x1e610000 0x100>;
+      clocks = <&syscon ASPEED_CLK_AHB>;
+      resets = <&syscon ASPEED_RESET_PWM>;
+      #pwm-cells = <4>;
+
+      fan-0 {
+        tach-ch = /bits/ 8 <0x0>;
+        pwms = <&pwm_tach 0 40000 0 128>;
+      };
+
+      fan-1 {
+        tach-ch = /bits/ 8 <0x1 0x2>;
+        pwms = <&pwm_tach 1 40000 0 160>;
+      };
+    };
-- 
2.25.1


