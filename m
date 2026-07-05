Return-Path: <linux-pwm+bounces-9568-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9M41OPNZSmqnBgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9568-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 15:19:47 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EE470A12D
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 15:19:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cyberchaos.dev header.s=mail header.b=p+YYKy9U;
	dmarc=pass (policy=reject) header.from=cyberchaos.dev;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9568-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9568-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43EF230230D0
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3B380FDB;
	Sun,  5 Jul 2026 13:17:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC041384CEB;
	Sun,  5 Jul 2026 13:17:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257464; cv=none; b=Tw+RPQrjA4FJdLqMsw74QufAACLWPWhVXZYV+kVETF/VMPG+aksWmkGuIqoOOoxdoqHbKmcHETRZbweUwyCl0/yxV/RWDkkgg5SiaUcer3DE50L6Lj+lVwUbL/7RdGwfJRufW4giccoP+P8PAwjLciRgqpwgE6iFRjWCFz1AocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257464; c=relaxed/simple;
	bh=EcwSOFdw/YVJUzt1TvflT0AKkSxY87LFW5cNn+2hzU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0JGWwK6srEit8SZZObEKPsfK1d7CEelJhQDbP2adYAKB6tFl2D20QRA13Nrp6j8rb8OJclQLfdh8Xwj/ykFX4AlU38G0HXWVq9sKZVYSmGxjYfjH/wifDJAWHvnvVVoJIOdxTgIDf0gAIsK4bcNg3cw7xsakWhIRvvDStz8GFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=p+YYKy9U; arc=none smtp.client-ip=195.39.247.168
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783257458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qApKfeJbKXvI659keIopaLZKnU5Pak0u7nZgqO36vOE=;
	b=p+YYKy9UApkpMzoy8zgWAPd0gdljgZXtSvAqVsoiOAqn+vJk05QaqRpx2H0Qz9b/iOOXfj
	V2q2hi7VbWY1ShYluYtrYNe7rVJzYOHa+fBMem1XWGuFDUpJgbjxpGo01KZuYOBHcBao7T
	qFAnihBL/6lwSbxebMMCj7EPqBdA9K0=
Date: Sun, 05 Jul 2026 15:17:29 +0200
Subject: [PATCH 10/10] arm64: dts: apple: Add minimal t8132 (M4) device
 trees
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-apple-m4-initial-devicetrees-v1-10-e5655ee56523@cyberchaos.dev>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Hector Martin <marcan@marcan.st>, 
 Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyberchaos.dev,reject];
	R_DKIM_ALLOW(-0.20)[cyberchaos.dev:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9568-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lpieralisi@kernel.org,m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:marcan@marcan.st,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:yureka@cyberchaos.dev,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yureka@cyberchaos.dev,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yureka@cyberchaos.dev,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[cyberchaos.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyberchaos.dev:from_mime,cyberchaos.dev:email,cyberchaos.dev:mid,cyberchaos.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73EE470A12D

Added device trees for the following devices:
- apple,j604 - MacBook Pro (14-inch, M4, 2024)
- apple,j623 - iMac (24-inch, 2x USB-C, M4, 2024)
- apple,j624 - iMac (24-inch, 4x USB-C, M4, 2024)
- apple,j713 - MacBook Air (13-inch, M4, 2025)
- apple,j715 - MacBook Air (15-inch, M4, 2025)
- apple,j773g - Mac mini (M4, 2024)

The device trees have a minimal set of devices limited to CPU cores,
interrupt controller, power states, watchdog, serial, pin controller,
i2c and framebuffer.
The device trees for the notebooks add a PWM controller for the keyboard
LED illumination.

Using the macOS 26.6b3 iBoot/firmware, the Mac mini reliably boots on a
single core using the stock kernel.
Booting with smp requires avoiding the wfi and wfit instructions
in the idle loop and `delay()` respectively, since those instructions
cause a loss of architectural state on the secondary cores, and even
then boot is unreliable.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/Makefile        |    6 +
 arch/arm64/boot/dts/apple/t8132-j604.dts  |   35 +
 arch/arm64/boot/dts/apple/t8132-j623.dts  |   18 +
 arch/arm64/boot/dts/apple/t8132-j624.dts  |   18 +
 arch/arm64/boot/dts/apple/t8132-j713.dts  |   35 +
 arch/arm64/boot/dts/apple/t8132-j715.dts  |   35 +
 arch/arm64/boot/dts/apple/t8132-j773g.dts |   25 +
 arch/arm64/boot/dts/apple/t8132-jxxx.dtsi |   48 ++
 arch/arm64/boot/dts/apple/t8132-pmgr.dtsi | 1125 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8132.dtsi      |  440 +++++++++++
 10 files changed, 1785 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 6fc3349a5842..181bd0e28965 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -1,4 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_APPLE) += t8132-j604.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8132-j623.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8132-j624.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8132-j713.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8132-j715.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8132-j773g.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j71.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j73.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j85m.dtb
diff --git a/arch/arm64/boot/dts/apple/t8132-j604.dts b/arch/arm64/boot/dts/apple/t8132-j604.dts
new file mode 100644
index 000000000000..c4be915cb33a
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8132-j604.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Pro (14-inch, M4, 2024)
+ *
+ * target-type: J604
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8132.dtsi"
+#include "t8132-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "apple,j604", "apple,t8132", "apple,arm-platform";
+	model = "Apple MacBook Pro (14-inch, M4, 2024)";
+
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm1 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
+};
+
+&fpwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8132-j623.dts b/arch/arm64/boot/dts/apple/t8132-j623.dts
new file mode 100644
index 000000000000..508e26056022
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8132-j623.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iMac (24-inch, 2x USB-C, M4, 2024)
+ *
+ * target-type: J623
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8132.dtsi"
+#include "t8132-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j623", "apple,t8132", "apple,arm-platform";
+	model = "Apple iMac (24-inch, 2x USB-C, M4, 2024)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8132-j624.dts b/arch/arm64/boot/dts/apple/t8132-j624.dts
new file mode 100644
index 000000000000..84bdd8e343eb
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8132-j624.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iMac (24-inch, 4x USB-C, M4, 2024)
+ *
+ * target-type: J624
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8132.dtsi"
+#include "t8132-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j624", "apple,t8132", "apple,arm-platform";
+	model = "Apple iMac (24-inch, 4x USB-C, M4, 2024)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8132-j713.dts b/arch/arm64/boot/dts/apple/t8132-j713.dts
new file mode 100644
index 000000000000..b1f779c37d5f
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8132-j713.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Air (13-inch, M4, 2025)
+ *
+ * target-type: J713
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8132.dtsi"
+#include "t8132-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "apple,j713", "apple,t8132", "apple,arm-platform";
+	model = "Apple MacBook Air (13-inch, M4, 2024)";
+
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm1 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
+};
+
+&fpwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8132-j715.dts b/arch/arm64/boot/dts/apple/t8132-j715.dts
new file mode 100644
index 000000000000..2672914ea76c
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8132-j715.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Air (15-inch, M4, 2025)
+ *
+ * target-type: J715
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8132.dtsi"
+#include "t8132-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "apple,j715", "apple,t8132", "apple,arm-platform";
+	model = "Apple MacBook Air (15-inch, M4, 2025)";
+
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm1 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
+};
+
+&fpwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8132-j773g.dts b/arch/arm64/boot/dts/apple/t8132-j773g.dts
new file mode 100644
index 000000000000..eb2157f8e428
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8132-j773g.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple Mac mini (M4, 2024)
+ *
+ * target-type: J773g
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8132.dtsi"
+#include "t8132-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j773g", "apple,t8132", "apple,arm-platform";
+	model = "Apple Mac mini (M4, 2024)";
+};
+
+/*
+ * Keep the power-domains used for the HDMI port on.
+ */
+&framebuffer0 {
+	power-domains = <&ps_dispext0_cpu>, <&ps_dptx_phy>;
+};
diff --git a/arch/arm64/boot/dts/apple/t8132-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8132-jxxx.dtsi
new file mode 100644
index 000000000000..2a18f5cace09
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8132-jxxx.dtsi
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple M4 Mac mini, MacBook Air/Pro, iMac 24" (M4, 2024/2025)
+ *
+ * This file contains parts common to all Apple M4 devices using the t8132.
+ *
+ * target-type: J604, J623, J624, J713, J715, J773g
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/ {
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			power-domains = <&ps_disp_cpu>, <&ps_dptx_phy>;
+			/* Format properties will be added by loader */
+			status = "disabled";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		/* To be filled by loader */
+	};
+
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0x8 0 0x2 0>; /* To be filled by loader */
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8132-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8132-pmgr.dtsi
new file mode 100644
index 000000000000..00a09687de24
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8132-pmgr.dtsi
@@ -0,0 +1,1125 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple T8132 "M4" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&pmgr {
+	ps_msg: power-controller@108 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msg";
+	};
+
+	ps_aic: power-controller@110 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_dwi: power-controller@118 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@120 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_pmc: power-controller@138 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmc";
+	};
+
+	ps_pms_fpwm0: power-controller@140 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm0";
+	};
+
+	ps_pms_fpwm1: power-controller@148 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm1";
+	};
+
+	ps_pms_fpwm2: power-controller@150 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm2";
+	};
+
+	ps_pms_fpwm3: power-controller@158 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm3";
+	};
+
+	ps_pms_fpwm4: power-controller@160 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm4";
+	};
+
+	ps_pms_c1ppt: power-controller@168 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_c1ppt";
+	};
+
+	ps_soc_rc: power-controller@170 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_rc";
+	};
+
+	ps_soc_dpe: power-controller@178 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_dpe";
+		apple,always-on;
+	};
+
+	ps_pmgr_soc_ocla: power-controller@180 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmgr_soc_ocla";
+	};
+
+	ps_ap_tmm: power-controller@1b8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ap_tmm";
+	};
+
+	ps_dispext0_sys: power-controller@1d8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext0_sys";
+	};
+
+	ps_dispext0_fe: power-controller@1e0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext0_fe";
+		power-domains = <&ps_dispext0_sys>;
+	};
+
+	ps_dispext0_cpu: power-controller@1e8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext0_cpu";
+		power-domains = <&ps_dispext0_fe>;
+		apple,min-state = <4>;
+	};
+
+	ps_scodec: power-controller@228 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "scodec";
+	};
+
+	ps_scodec_streaming: power-controller@230 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "scodec_streaming";
+		power-domains = <&ps_scodec>;
+	};
+
+	ps_disp_sys: power-controller@240 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_sys";
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_disp_fe: power-controller@248 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_fe";
+		power-domains = <&ps_disp_sys>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_gfx: power-controller@250 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_sio_cpu: power-controller@268 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_cpu";
+	};
+
+	ps_fpwm0: power-controller@270 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm0";
+	};
+
+	ps_fpwm1: power-controller@278 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm1";
+	};
+
+	ps_fpwm2: power-controller@280 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm2";
+	};
+
+	ps_i2c0: power-controller@288 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+	};
+
+	ps_i2c1: power-controller@290 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+	};
+
+	ps_i2c2: power-controller@298 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+	};
+
+	ps_i2c3: power-controller@2a0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+	};
+
+	ps_i2c4: power-controller@2a8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c4";
+	};
+
+	ps_i2c5: power-controller@2b0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c5";
+	};
+
+	ps_i2c6: power-controller@2b8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c6";
+	};
+
+	ps_i2c7: power-controller@2c0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c7";
+	};
+
+	ps_i2c8: power-controller@2c8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c8";
+	};
+
+	ps_spi_p: power-controller@2d0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi_p";
+		apple,always-on;
+	};
+
+	ps_uart_p: power-controller@2d8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_p";
+		apple,always-on;
+	};
+
+	ps_dpa_p: power-controller@2e0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa_p";
+		apple,always-on;
+	};
+
+	ps_aes: power-controller@2e8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes";
+	};
+
+	ps_spi0: power-controller@2f0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_afiaft: power-controller@300 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "afiaft";
+	};
+
+	ps_venc_sys: power-controller@308 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_sys";
+	};
+
+	ps_spi1: power-controller@370 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x370 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_atc0_common: power-controller@378 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x378 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_common";
+	};
+
+	ps_spi2: power-controller@380 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x380 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi3: power-controller@388 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x388 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi4: power-controller@390 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x390 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi4";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_trace_fab: power-controller@398 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x398 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "trace_fab";
+	};
+
+	ps_atc0_pcie: power-controller@3a0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_pcie";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_atc0_cio: power-controller@3a8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_atc0_cio_pcie: power-controller@3b0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio_pcie";
+		power-domains = <&ps_atc0_cio>;
+	};
+
+	ps_spi5: power-controller@3b8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi5";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_qspi: power-controller@3c0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "qspi";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_dptx_phy: power-controller@3c8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dptx_phy";
+	};
+
+	ps_uart_n: power-controller@3d0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_n";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart0: power-controller@3d8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart1: power-controller@3e0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart2: power-controller@3e8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart3: power-controller@3f0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart4: power-controller@3f8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart5: power-controller@400 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart6: power-controller@408 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x408 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_dpa0: power-controller@410 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x410 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa0";
+		power-domains = <&ps_dpa_p>;
+	};
+
+	ps_dpa1: power-controller@418 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x418 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa1";
+		power-domains = <&ps_dpa_p>;
+	};
+
+	ps_atc0_cio_usb: power-controller@420 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x420 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio_usb";
+		power-domains = <&ps_atc0_cio>;
+	};
+
+	ps_atc1_common: power-controller@428 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x428 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_common";
+	};
+
+	ps_atc1_pcie: power-controller@430 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x430 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_pcie";
+		power-domains = <&ps_atc1_common>;
+	};
+
+	ps_atc1_cio: power-controller@438 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x438 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio";
+		power-domains = <&ps_atc1_common>;
+	};
+
+	ps_atc1_cio_pcie: power-controller@440 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x440 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio_pcie";
+		power-domains = <&ps_atc1_cio>;
+	};
+
+	ps_atc1_cio_usb: power-controller@448 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x448 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio_usb";
+		power-domains = <&ps_atc1_cio>;
+	};
+
+	ps_atc2_common: power-controller@450 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x450 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_common";
+	};
+
+	ps_atc2_pcie: power-controller@458 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x458 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_pcie";
+		power-domains = <&ps_atc2_common>;
+	};
+
+	ps_atc2_cio: power-controller@460 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x460 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_cio";
+		power-domains = <&ps_atc2_common>;
+	};
+
+	ps_atc2_cio_pcie: power-controller@468 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x468 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_cio_pcie";
+		power-domains = <&ps_atc2_cio>;
+	};
+
+	ps_dpa2: power-controller@470 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x470 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa2";
+		power-domains = <&ps_dpa_p>;
+	};
+
+	ps_atc2_cio_usb: power-controller@478 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x478 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_cio_usb";
+		power-domains = <&ps_atc2_cio>;
+	};
+
+	ps_atc3_common: power-controller@480 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x480 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_common";
+	};
+
+	ps_pmp: power-controller@488 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x488 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmp";
+		apple,always-on;
+	};
+
+	ps_pms_sram: power-controller@490 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x490 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_sram";
+		apple,always-on;
+	};
+
+	ps_atc3_pcie: power-controller@498 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x498 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_pcie";
+		power-domains = <&ps_atc3_common>;
+	};
+
+	ps_atc3_cio: power-controller@4a0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_cio";
+		power-domains = <&ps_atc3_common>;
+	};
+
+	ps_dpa3: power-controller@4a8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa3";
+		power-domains = <&ps_dpa_p>;
+	};
+
+	ps_atc3_cio_pcie: power-controller@4b0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_cio_pcie";
+		power-domains = <&ps_atc3_cio>;
+	};
+
+	ps_atc3_cio_usb: power-controller@4b8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_cio_usb";
+		power-domains = <&ps_atc3_cio>;
+	};
+
+	ps_dpa4: power-controller@4c0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa4";
+		power-domains = <&ps_dpa_p>;
+	};
+
+	ps_apcie_gp: power-controller@4d0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_gp";
+	};
+
+	ps_apcie_sys_gp: power-controller@4d8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_sys_gp";
+		power-domains = <&ps_apcie_gp>;
+	};
+
+	ps_dispext1_sys: power-controller@4e0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext1_sys";
+	};
+
+	ps_dispext1_fe: power-controller@4e8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext1_fe";
+		power-domains = <&ps_dispext1_sys>;
+	};
+
+	ps_dispext1_cpu: power-controller@4f0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext1_cpu";
+		power-domains = <&ps_dispext1_fe>;
+	};
+
+	ps_ans: power-controller@538 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x538 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans";
+	};
+
+	ps_apcie_st: power-controller@540 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x540 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_st";
+		power-domains = <&ps_ans>;
+	};
+
+	ps_apcie_sys_st: power-controller@548 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x548 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_sys_st";
+		power-domains = <&ps_ans>, <&ps_apcie_st>;
+	};
+
+	ps_apcie_phy_sw: power-controller@550 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x550 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_phy_sw";
+		power-domains = <&ps_apcie_sys_st>, <&ps_apcie_sys_gp>;
+	};
+
+	ps_msr: power-controller@560 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x560 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+	};
+
+	ps_msr_ase_core: power-controller@568 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x568 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr_ase_core";
+		power-domains = <&ps_msr>;
+	};
+
+	ps_ane_sys: power-controller@570 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x570 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_sys";
+	};
+
+	ps_jpg: power-controller@578 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x578 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+	};
+
+	ps_avd_sys: power-controller@580 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x580 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "avd_sys";
+	};
+
+	ps_sep: power-controller@c00 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc00 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on;
+	};
+
+	ps_venc_dma: power-controller@8000 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_dma";
+		power-domains = <&ps_venc_sys>;
+	};
+
+	ps_venc_pipe4: power-controller@8008 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe4";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_pipe5: power-controller@8010 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe5";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_me0: power-controller@8018 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me0";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_me1: power-controller@8020 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me1";
+		power-domains = <&ps_venc_me0>;
+	};
+
+	ps_ane_mpm: power-controller@c000 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_mpm";
+		power-domains = <&ps_ane_sys>;
+	};
+
+	ps_ane_cpu: power-controller@c008 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_cpu";
+		power-domains = <&ps_ane_sys>;
+	};
+
+	ps_ane_td: power-controller@c010 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_td";
+		power-domains = <&ps_ane_sys>;
+	};
+
+	ps_ane_base: power-controller@c018 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_base";
+		power-domains = <&ps_ane_td>;
+	};
+
+	ps_disp_cpu: power-controller@10000 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x10000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_cpu";
+		power-domains = <&ps_disp_fe>;
+		apple,min-state = <4>;
+	};
+};
+
+&pmgr_mini {
+	ps_debug_gated: power-controller@0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_gated";
+		apple,always-on;
+	};
+
+	ps_nub_spmi0: power-controller@58 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x58 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi0";
+		apple,always-on;
+	};
+
+	ps_nub_spmi1: power-controller@60 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x60 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi1";
+		apple,always-on;
+	};
+
+	ps_nub_spmi_a0: power-controller@68 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x68 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi_a0";
+		apple,always-on;
+	};
+
+	ps_nub_spmi_a1: power-controller@70 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x70 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi_a1";
+		apple,always-on;
+	};
+
+	ps_nub_spi0: power-controller@80 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x80 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spi0";
+		apple,always-on;
+	};
+
+	ps_nub_ocla: power-controller@88 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x88 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_ocla";
+		apple,always-on;
+	};
+
+	ps_nub_gpio: power-controller@90 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x90 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_gpio";
+		apple,always-on;
+	};
+
+	ps_nub_sram: power-controller@a0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_sram";
+		apple,always-on;
+	};
+
+	ps_debug_switch: power-controller@a8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_switch";
+		apple,always-on;
+	};
+
+	ps_atc0_usb_aon: power-controller@b0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xb0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb_aon";
+	};
+
+	ps_atc1_usb_aon: power-controller@b8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xb8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_usb_aon";
+	};
+
+	ps_atc0_usb: power-controller@c0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb";
+		power-domains = <&ps_atc0_common>, <&ps_atc0_usb_aon>;
+	};
+
+	ps_atc1_usb: power-controller@c8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_usb";
+		power-domains = <&ps_atc1_common>, <&ps_atc1_usb_aon>;
+	};
+
+	ps_atc2_usb_aon: power-controller@d0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xd0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_usb_aon";
+	};
+
+	ps_atc3_usb_aon: power-controller@d8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xd8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_usb_aon";
+	};
+
+	ps_atc2_usb: power-controller@e0 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xe0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_usb";
+		power-domains = <&ps_atc2_common>, <&ps_atc2_usb_aon>;
+	};
+
+	ps_atc3_usb: power-controller@e8 {
+		compatible = "apple,t8132-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xe8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_usb";
+		power-domains = <&ps_atc3_common>, <&ps_atc3_usb_aon>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8132.dtsi b/arch/arm64/boot/dts/apple/t8132.dtsi
new file mode 100644
index 000000000000..715980b5c7de
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8132.dtsi
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T8132 "M4" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+
+/ {
+	compatible = "apple,t8132", "apple,arm-platform";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_e0>;
+				};
+				core1 {
+					cpu = <&cpu_e1>;
+				};
+				core2 {
+					cpu = <&cpu_e2>;
+				};
+				core3 {
+					cpu = <&cpu_e3>;
+				};
+				core4 {
+					cpu = <&cpu_e4>;
+				};
+				core5 {
+					cpu = <&cpu_e5>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_p0>;
+				};
+				core1 {
+					cpu = <&cpu_p1>;
+				};
+				core2 {
+					cpu = <&cpu_p2>;
+				};
+				core3 {
+					cpu = <&cpu_p3>;
+				};
+			};
+		};
+
+		cpu_e0: cpu@0 {
+			compatible = "apple,donan-e";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e1: cpu@1 {
+			compatible = "apple,donan-e";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e2: cpu@2 {
+			compatible = "apple,donan-e";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e3: cpu@3 {
+			compatible = "apple,donan-e";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e4: cpu@4 {
+			compatible = "apple,donan-e";
+			device_type = "cpu";
+			reg = <0x0 0x4>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e5: cpu@5 {
+			compatible = "apple,donan-e";
+			device_type = "cpu";
+			reg = <0x0 0x5>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_p0: cpu@10100 {
+			compatible = "apple,donan-p";
+			device_type = "cpu";
+			reg = <0x0 0x10100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_1>;
+		};
+
+		cpu_p1: cpu@10101 {
+			compatible = "apple,donan-p";
+			device_type = "cpu";
+			reg = <0x0 0x10101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_1>;
+		};
+
+		cpu_p2: cpu@10102 {
+			compatible = "apple,donan-p";
+			device_type = "cpu";
+			reg = <0x0 0x10102>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_1>;
+		};
+
+		cpu_p3: cpu@10103 {
+			compatible = "apple,donan-p";
+			device_type = "cpu";
+			reg = <0x0 0x10103>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_1>;
+		};
+
+		l2_cache_0: l2-cache-0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x400000>;
+		};
+
+		l2_cache_1: l2-cache-1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x1000000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt", "hyp-phys", "hyp-virt";
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+		             <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>,
+		             <AIC_FIQ AIC_TMR_HV_PHYS IRQ_TYPE_LEVEL_HIGH>,
+		             <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clkref";
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges;
+		nonposted-mmio;
+
+		pmgr: power-management@380700000 {
+			compatible = "apple,t8132-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x3 0x80700000 0 0x14000>;
+			/* child nodes are added in t8132-pmgr.dtsi */
+		};
+
+		aic: interrupt-controller@381180000 {
+			compatible = "apple,t8132-aic3", "apple,t8122-aic3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x00000003 0x81000000 0x00000000 0x1cc000>,
+			      <0x00000003 0x81040000 0x00000000 0x4000>;
+			reg-names = "core", "event";
+			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu_e0 &cpu_e1 &cpu_e2 &cpu_e3 &cpu_e4 &cpu_e5>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu_p0 &cpu_p1 &cpu_p2 &cpu_p3>;
+				};
+			};
+		};
+
+		pmgr_mini: power-management@388280000 {
+			compatible = "apple,t8132-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x3 0x88280000 0 0x4000>;
+			/* child nodes are added in t8132-pmgr.dtsi */
+		};
+
+		wdt: watchdog@3882b0000 {
+			compatible = "apple,t8132-wdt", "apple,t8103-wdt";
+			reg = <0x3 0x882b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 507 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_nub: pinctrl@3881f0000 {
+			compatible = "apple,t8132-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x3 0x881f0000 0x0 0x4000>;
+			power-domains = <&ps_nub_gpio>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_nub 0 0 32>;
+			apple,npins = <32>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 499 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 500 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 501 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 502 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 503 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 504 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 505 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_smc: pinctrl@38c820000 {
+			compatible = "apple,t8132-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x3 0x8c820000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_smc 0 0 18>;
+			apple,npins = <18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 552 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 553 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 554 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 555 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 556 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 557 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 558 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_aop: pinctrl@390824000 {
+			compatible = "apple,t8132-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x3 0x90824000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aop 0 0 57>;
+			apple,npins = <57>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 423 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 424 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 425 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 426 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 427 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 428 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 429 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_ap: pinctrl@39a000000 {
+			compatible = "apple,t8132-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x3 0x9a000000 0x0 0x100000>;
+			power-domains = <&ps_gpio>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 224>;
+			apple,npins = <224>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 303 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 304 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 305 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 306 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 307 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 308 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 309 IRQ_TYPE_LEVEL_HIGH>;
+
+			i2c0_pins: i2c0-pins {
+				pinmux = <APPLE_PINMUX(104, 1)>,
+				         <APPLE_PINMUX(103, 1)>;
+			};
+
+			i2c1_pins: i2c1-pins {
+				pinmux = <APPLE_PINMUX(106, 1)>,
+				         <APPLE_PINMUX(105, 1)>;
+			};
+
+			i2c2_pins: i2c2-pins {
+				pinmux = <APPLE_PINMUX(44, 1)>,
+				         <APPLE_PINMUX(43, 1)>;
+			};
+
+			i2c3_pins: i2c3-pins {
+				pinmux = <APPLE_PINMUX(42, 1)>,
+				         <APPLE_PINMUX(41, 1)>;
+			};
+
+			i2c4_pins: i2c4-pins {
+				pinmux = <APPLE_PINMUX(108, 1)>,
+				         <APPLE_PINMUX(107, 1)>;
+			};
+		};
+
+		i2c0: i2c@3ad010000 {
+			compatible = "apple,t8132-i2c", "apple,t8103-i2c";
+			reg = <0x3 0xad010000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1062 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c0_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@3ad014000 {
+			compatible = "apple,t8132-i2c", "apple,t8103-i2c";
+			reg = <0x3 0xad014000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1063 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c1_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@3ad018000 {
+			compatible = "apple,t8132-i2c", "apple,t8103-i2c";
+			reg = <0x3 0xad018000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1064 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c2_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c2>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@3ad01c000 {
+			compatible = "apple,t8132-i2c", "apple,t8103-i2c";
+			reg = <0x3 0xad01c000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1065 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c3_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c3>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@3ad020000 {
+			compatible = "apple,t8132-i2c", "apple,t8103-i2c";
+			reg = <0x3 0xad020000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1066 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c4_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c4>;
+			status = "disabled";
+		};
+
+		fpwm1: pwm@3ad044000 {
+			compatible = "apple,t8132-fpwm", "apple,s5l-fpwm";
+			reg = <0x3 0xad044000 0x0 0x4000>;
+			power-domains = <&ps_fpwm1>;
+			clocks = <&clkref>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		serial0: serial@3ad200000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3 0xad200000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1046 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
+			status = "disabled";
+		};
+	};
+};
+
+#include "t8132-pmgr.dtsi"

-- 
2.54.0


