Return-Path: <linux-pwm+bounces-8308-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODaFG9g9vWmJ8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8308-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:30:16 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B692DA424
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B2531F587A
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309C53B2FD6;
	Fri, 20 Mar 2026 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="MkJ+us5f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qR/bJGoA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3843B27F6;
	Fri, 20 Mar 2026 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009439; cv=none; b=fLkbgnIRX99+llbBTPBE502ydi7r/HR/7H4wF6x2RjVadEPuWh8Vbd/WRwjNYDtorlLDGf05J0CSKpjHKHH517abo5Z+zX9ksxw4CVtZwFh+dn4n9duxln4WTWKiqL+jVQ1qY4vhPy/DbrAo7FbbvZEXknz9pyQ5Bn31kD2D1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009439; c=relaxed/simple;
	bh=v2xZ/o4130Fs4T+7HHpgURWNh/mGREoPITTKg0hJOGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2N+nObxEZ4+OPWWdfvhJTvD+teX253Vf6UT3GaYjJKNW7Slo13uvlB+Jnqsd/BXkTe2GVdn0HE6+kjOAoXqoijMP6sreQP0URRffSnxeW2zEv3cl3HgLPCHfmQXCelQNtporv9tM2AiboOzyJhIkvh/qBZX3EdKMPO9WeFvPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=MkJ+us5f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qR/bJGoA; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 719E213800DD;
	Fri, 20 Mar 2026 08:23:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 20 Mar 2026 08:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774009435;
	 x=1774016635; bh=iRAlkPBzWHCim0SzWvbdCQ+AFihtYJ6X4hS3MBA76Z0=; b=
	MkJ+us5fUm9c+k+NGzBR6dOXN1nrvDv5huc3hYfFzu/0dnsp/HzO5HXqkI270tvA
	lk5+VvdTsLRDFQIZGeLfGmQOjLx72VMck1iSJmNkmIOOy4l1B6VsA4S8K4OBe4hj
	yuFO3PuDCF3+GH/oWDKYLrti3cHAVGYnG4vvLRJ8yie60ILT+BrKHYUA4uODKh6r
	Uueg2N5eMO0Z2SqbgO4MRlCEDoHLbn2jD5zTLwmjrtICKFZsCPiQkiFj+AFVGVbP
	RjYSVVmNXbrsf1N/Gri/G9pFGypYIqlabj5k7QSWkhJfu51X2yLMHqeWbxBfnoX7
	63OL2QULfgi+j1KC1prrpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774009435; x=
	1774016635; bh=iRAlkPBzWHCim0SzWvbdCQ+AFihtYJ6X4hS3MBA76Z0=; b=q
	R/bJGoAxcIsEFFks2kblPtEikYfAi5cuV1AS+40ogU/+mbv2K7FeMOsWJlA2jGtd
	cB9LVN4TSXs/ZXfY79NbeaYHoNbsDUn4XuUbG/pZzgkEyF/Ez6YcdSzjeM0Mvlpd
	b+S09kWU33AOlFUzekLjC+zXZOyG+MnDme5K9NK2lHfVpwhGiZ6orbIRVX5x8KU2
	Ce/ubMIgq3eJsPmh590Skrzr6Ybf+QME24pC6Lo4jqCzadwRprGCASD7oMdhOxRm
	H58ysImDt4ISrHY9iLp7YZBhPE31ic/QS9aM7vna8+Qe/qb65yrQ0eLeSJQfVJuL
	VTbV337xENMmqyvIw1TZQ==
X-ME-Sender: <xms:Wzy9aYvrrsTnYQhjDiTAV9H9WM2xiaKi_cvxilquhaldNbumxhe2AQ>
    <xme:Wzy9aQc9GQZ5L6qiS1HOqCDqcDoavESzrNLxMw2niwcefgkdBq_VL96W0irNyNjme
    bHK5HX1QTcdqDIYKVnCcMO0yomqS-NGpx13IluQpLVyV5wp8_mxskE>
X-ME-Received: <xmr:Wzy9aaaYz2iRoKJ9xPVqSzIoSVaMo3qIkRYE8G18LBFogAR1i07rnaOgBnxw5kQ6dryKV1Puz6qd7_O0aOlPehpgcnsMWyvum2Ei5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhhitghhrggvlhdrrhgvvghvvghstdejjeesghhmrghilhdrtghomhdprhgtph
    htthhopehlihhnuhhsfieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvrghlsehg
    ohhmphgrrdguvghvpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrg
    guvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhivdgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Wzy9aY002s9FaP1Q3sQAG-Ulbf7fAfk28ghlxp5Molow8luz3zAq0g>
    <xmx:Wzy9aTo0DJPrvH9oavdCsNSXBcetEaMODaucxURRRll3yS5TznvP4g>
    <xmx:Wzy9aZyHOF1gkwvBmX5u7w8TYFntilZRSkwjor-Fo069vzJ35MjrVg>
    <xmx:Wzy9acAxAu8_stHG8ELeXovCloxWSUFCbicX_gSh8j3PayTERMPlVQ>
    <xmx:Wzy9aTTOqhSwCQWeZzbLO87q374HHX0oU1XmDIq4YUCoGDMhv97K_kRy>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:23:54 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Mar 2026 13:23:27 +0100
Subject: [PATCH 9/9] arm64: dts: apple: Initial t8122 (M3) device trees
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-apple-m3-initial-devicetrees-v1-9-5842e1e393a8@jannau.net>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=53921; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=v2xZ/o4130Fs4T+7HHpgURWNh/mGREoPITTKg0hJOGA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsy9Nh7SoWmVHZ/3/lu6Ovyz8qyp8o6izvnrNMMVNVYs3
 5l64PShjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABNxUWVk+Dr/YPn+XVXHg5//
 LDX61HOpdssU600r2xaqeMaUhQa3r2RkWMo7UynJ4m54xcKFawKvvWWOsrV8uGn75oObHvq17Kx
 Q5QEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8308-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,jannau.net,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7B692DA424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add minimal device trees for all t8122 based devices. The devices are
- iMac (24-inch, M3, 2023)
- MacBook Air (13-inch, M3, 2024)
- MacBook Air (15-inch, M3, 2024)
- MacBook Pro (14-inch, M3, 2023)

The device trees have a minimal set of devices limited to CPU cores,
interrupt controller, power states, watchdog, serial, pin controller,
i2c and the boot framebuffer.
The device trees for the notebooks add a PWM controller for the keyboard
LED illumination.
The iMacs and the 14-inch device trees add the i2c based Apple cd321x
USB Type-C port controller.

Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/Makefile             |    5 +
 arch/arm64/boot/dts/apple/t8122-j433.dts       |   19 +
 arch/arm64/boot/dts/apple/t8122-j434.dts       |   19 +
 arch/arm64/boot/dts/apple/t8122-j504.dts       |   37 +
 arch/arm64/boot/dts/apple/t8122-j613.dts       |   35 +
 arch/arm64/boot/dts/apple/t8122-j615.dts       |   35 +
 arch/arm64/boot/dts/apple/t8122-jxxx.dtsi      |   48 +
 arch/arm64/boot/dts/apple/t8122-pmgr.dtsi      | 1149 ++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8122-usbpd-i2c.dtsi |   32 +
 arch/arm64/boot/dts/apple/t8122.dtsi           |  444 +++++++++
 10 files changed, 1823 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 4eebcd85c90fcf0f358b0b32debf2475f6dbbf2c..6fc3349a58428f77731af8dc630f37a2d213ec21 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -91,3 +91,8 @@ dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j415.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j493.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8122-j433.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8122-j434.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8122-j504.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8122-j613.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8122-j615.dtb
diff --git a/arch/arm64/boot/dts/apple/t8122-j433.dts b/arch/arm64/boot/dts/apple/t8122-j433.dts
new file mode 100644
index 0000000000000000000000000000000000000000..34205d173a9bd1844e17d7ec4acf705f6bb146a0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8122-j433.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iMac (24-inch, 2x USB-C, M3, 2023)
+ *
+ * target-type: J433
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8122.dtsi"
+#include "t8122-usbpd-i2c.dtsi"
+#include "t8122-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j433", "apple,t8122", "apple,arm-platform";
+	model = "Apple iMac (24-inch, 2x USB-C, M3, 2023)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8122-j434.dts b/arch/arm64/boot/dts/apple/t8122-j434.dts
new file mode 100644
index 0000000000000000000000000000000000000000..ead5afd77efbc6394f1bbe0531bc1be6d319ad4f
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8122-j434.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iMac (24-inch, 4x USB-C, M3, 2023)
+ *
+ * target-type: J434
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8122.dtsi"
+#include "t8122-usbpd-i2c.dtsi"
+#include "t8122-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j434", "apple,t8122", "apple,arm-platform";
+	model = "Apple iMac (24-inch, 4x USB-C, M3, 2023)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8122-j504.dts b/arch/arm64/boot/dts/apple/t8122-j504.dts
new file mode 100644
index 0000000000000000000000000000000000000000..464491b55b019cc1facfaa0f89a3d08049347113
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8122-j504.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Pro (14-inch, M3, 2023)
+ *
+ * target-type: J504
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8122.dtsi"
+#include "t8122-usbpd-i2c.dtsi"
+#include "t8122-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "apple,j504", "apple,t8122", "apple,arm-platform";
+	model = "Apple MacBook Pro (14-inch, M3, 2023)";
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
+
diff --git a/arch/arm64/boot/dts/apple/t8122-j613.dts b/arch/arm64/boot/dts/apple/t8122-j613.dts
new file mode 100644
index 0000000000000000000000000000000000000000..51894ea705e765c06092d06996153150a0632d80
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8122-j613.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Air (13-inch, M3, 2024)
+ *
+ * target-type: J613
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8122.dtsi"
+#include "t8122-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "apple,j613", "apple,t8122", "apple,arm-platform";
+	model = "Apple MacBook Air (13-inch, M3, 2024)";
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
diff --git a/arch/arm64/boot/dts/apple/t8122-j615.dts b/arch/arm64/boot/dts/apple/t8122-j615.dts
new file mode 100644
index 0000000000000000000000000000000000000000..2a1970c1bc90c0979adca601cbbdaf3c8b2b7d07
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8122-j615.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Air (15-inch, M3, 2024)
+ *
+ * target-type: J615
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8122.dtsi"
+#include "t8122-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "apple,j615", "apple,t8122", "apple,arm-platform";
+	model = "Apple MacBook Air (15-inch, M3, 2024)";
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
diff --git a/arch/arm64/boot/dts/apple/t8122-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8122-jxxx.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..dd85f0c9fb1e111c18bb8d88e3446adbef587214
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8122-jxxx.dtsi
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple M3 MacBook Air/Pro and iMac (M3, 2023/2024)
+ *
+ * This file contains parts common to all Apple M3 devices using the t8122.
+ *
+ * target-type: J433, J434, J504, J613, J615
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
+			power-domains = <&ps_disp_cpu>, <&ps_dptx_ext_phy>;
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
diff --git a/arch/arm64/boot/dts/apple/t8122-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8122-pmgr.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..64093792e0adebabf6e0900d5b03631ecca00d9e
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8122-pmgr.dtsi
@@ -0,0 +1,1149 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple T8122 "M3" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&pmgr {
+	ps_sbr: power-controller@100 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sbr";
+		apple,always-on; /* Core device */
+	};
+
+	ps_msg: power-controller@108 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msg";
+	};
+
+	ps_aic: power-controller@110 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_dwi: power-controller@118 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@120 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_pms_busif: power-controller@128 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_busif";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pms: power-controller@130 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pms_fpwm0: power-controller@138 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm0";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_pms_fpwm1: power-controller@140 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm1";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_pms_fpwm2: power-controller@148 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm2";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_pms_fpwm3: power-controller@150 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm3";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_pms_fpwm4: power-controller@158 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm4";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_pms_c1ppt: power-controller@160 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_c1ppt";
+	};
+
+	ps_soc_rc: power-controller@168 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_rc";
+	};
+
+	ps_soc_dpe: power-controller@170 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_dpe";
+		apple,always-on;
+	};
+
+	ps_pmgr_soc_ocla: power-controller@178 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmgr_soc_ocla";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_ispsens0: power-controller@180 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens0";
+	};
+
+	ps_ispsens1: power-controller@188 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens1";
+	};
+
+	ps_ispsens2: power-controller@190 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens2";
+	};
+
+	ps_ispsens3: power-controller@198 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens3";
+	};
+
+	ps_aft0: power-controller@1a8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aft0";
+	};
+
+	ps_ioa0: power-controller@1b0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ioa0";
+		apple,always-on;
+	};
+
+	ps_ap_tmm: power-controller@1b8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ap_tmm";
+	};
+
+	ps_disp_sys: power-controller@1d8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_sys";
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_gfx: power-controller@1e0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_isp_sys: power-controller@1e8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sys";
+	};
+
+	ps_avd_sys: power-controller@1f0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "avd_sys";
+	};
+
+	ps_jpg: power-controller@200 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+	};
+
+	ps_disp_fe: power-controller@208 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_fe";
+		power-domains = <&ps_disp_sys>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_sio_cpu: power-controller@210 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_cpu";
+	};
+
+	ps_fpwm0: power-controller@218 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm0";
+	};
+
+	ps_fpwm1: power-controller@220 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm1";
+	};
+
+	ps_fpwm2: power-controller@228 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm2";
+	};
+
+	ps_i2c0: power-controller@230 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+	};
+
+	ps_i2c1: power-controller@238 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+	};
+
+	ps_i2c2: power-controller@240 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+	};
+
+	ps_i2c3: power-controller@248 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+	};
+
+	ps_i2c4: power-controller@250 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c4";
+	};
+
+	ps_i2c5: power-controller@258 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c5";
+	};
+
+	ps_i2c6: power-controller@260 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c6";
+	};
+
+	ps_i2c7: power-controller@268 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c7";
+	};
+
+	ps_i2c8: power-controller@270 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c8";
+	};
+
+	ps_spi_p: power-controller@278 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi_p";
+	};
+
+	ps_uart_p: power-controller@280 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_p";
+	};
+
+	ps_audio_p: power-controller@288 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "audio_p";
+	};
+
+	ps_aes: power-controller@290 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes";
+	};
+
+	ps_spi0: power-controller@298 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi1: power-controller@2a0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi2: power-controller@2a8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi3: power-controller@2b0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi4: power-controller@2b8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi4";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi5: power-controller@2c0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi5";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_qspi: power-controller@2c8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "qspi";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_uart_n: power-controller@2d0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_n";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart0: power-controller@2d8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart1: power-controller@2e0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart2: power-controller@2e8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart3: power-controller@2f0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart4: power-controller@2f8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart5: power-controller@300 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart6: power-controller@308 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_sio_adma: power-controller@310 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_adma";
+		power-domains = <&ps_fpwm0>;
+	};
+
+	ps_dpa0: power-controller@318 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa0";
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dcs0: power-controller@330 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs0";
+		apple,always-on;
+	};
+
+	ps_dcs2: power-controller@338 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x338 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs2";
+		apple,always-on;
+	};
+
+	ps_dcs1: power-controller@340 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x340 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs1";
+		apple,always-on;
+	};
+
+	ps_dcs3: power-controller@348 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x348 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs3";
+		apple,always-on;
+	};
+
+	ps_dcs4: power-controller@358 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x358 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs4";
+		apple,always-on;
+	};
+
+	ps_dcs5: power-controller@360 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x360 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs5";
+		apple,always-on;
+	};
+
+	ps_dcs6: power-controller@368 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x368 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs6";
+		apple,always-on;
+	};
+
+	ps_dcs7: power-controller@370 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x370 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs7";
+		apple,always-on;
+	};
+
+	ps_dpa1: power-controller@378 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x378 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa1";
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dpa2: power-controller@380 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x380 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa2";
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dpa3: power-controller@388 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x388 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa3";
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dpa4: power-controller@390 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x390 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa4";
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_mca0: power-controller@398 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x398 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_mca1: power-controller@3a0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_mca2: power-controller@3a8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_trace_fab: power-controller@3b0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "trace_fab";
+	};
+
+	ps_mca3: power-controller@3b8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_ioa1: power-controller@3c0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ioa1";
+		apple,always-on;
+	};
+
+	ps_apcie: power-controller@3f0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie";
+	};
+
+	ps_ans: power-controller@3f8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans";
+	};
+
+	ps_atc0_common: power-controller@400 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_common";
+	};
+
+	ps_atc1_common: power-controller@408 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x408 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_common";
+	};
+
+	ps_dispext_sys: power-controller@410 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x410 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext_sys";
+	};
+
+	ps_venc_sys: power-controller@418 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x418 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_sys";
+	};
+
+	ps_scodec: power-controller@420 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x420 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "scodec";
+	};
+
+	ps_msr: power-controller@428 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x428 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_aft0>;
+	};
+
+	ps_dptx_ext_phy: power-controller@430 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x430 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dptx_ext_phy";
+	};
+
+	ps_ane_sys: power-controller@438 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x438 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_sys";
+	};
+
+	ps_apcie_gp: power-controller@440 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x440 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_gp";
+		power-domains = <&ps_apcie>;
+	};
+
+	ps_apcie_st: power-controller@448 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x448 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_st";
+		power-domains = <&ps_ans>, <&ps_apcie>;
+	};
+
+	ps_pmp: power-controller@450 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x450 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmp";
+		apple,always-on;
+	};
+
+	ps_pms_sram: power-controller@458 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x458 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_sram";
+		apple,always-on;
+	};
+
+	ps_atc0_pcie: power-controller@460 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x460 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_pcie";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_atc0_cio: power-controller@468 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x468 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_atc1_pcie: power-controller@470 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x470 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_pcie";
+		power-domains = <&ps_atc1_common>;
+	};
+
+	ps_atc1_cio: power-controller@478 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x478 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio";
+		power-domains = <&ps_atc1_common>;
+	};
+
+	ps_dispext_fe: power-controller@480 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x480 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext_fe";
+		power-domains = <&ps_dispext_sys>;
+	};
+
+	ps_dispext_cpu: power-controller@488 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x488 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext_cpu";
+		power-domains = <&ps_dispext_fe>;
+		apple,min-state = <4>;
+	};
+
+	ps_scodec_stream: power-controller@490 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x490 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "scodec_stream";
+		power-domains = <&ps_scodec>;
+	};
+
+	ps_msr_ase_core: power-controller@498 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x498 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr_ase_core";
+		power-domains = <&ps_msr>;
+	};
+
+	ps_apcie_phy_sw: power-controller@4a0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_phy_sw";
+		power-domains = <&ps_apcie_st>, <&ps_apcie_gp>;
+	};
+
+	ps_atc0_cio_pcie: power-controller@4a8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio_pcie";
+		power-domains = <&ps_atc0_cio>;
+	};
+
+	ps_atc0_cio_usb: power-controller@4b0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio_usb";
+		power-domains = <&ps_atc0_cio>;
+	};
+
+	ps_atc1_cio_pcie: power-controller@4b8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio_pcie";
+		power-domains = <&ps_atc1_cio>;
+	};
+
+	ps_atc1_cio_usb: power-controller@4c0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio_usb";
+		power-domains = <&ps_atc1_cio>;
+	};
+
+	ps_sep: power-controller@c00 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc00 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on;
+	};
+
+	ps_venc_dma: power-controller@8000 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_dma";
+		power-domains = <&ps_venc_sys>;
+	};
+
+	ps_venc_pipe4: power-controller@8008 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe4";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_pipe5: power-controller@8010 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe5";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_me0: power-controller@8018 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me0";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_me1: power-controller@8020 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me1";
+		power-domains = <&ps_venc_me0>;
+	};
+
+	ps_disp_cpu: power-controller@10000 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
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
+
+	ps_debug_gated: power-controller@0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_gated";
+		apple,always-on;
+	};
+
+	ps_nub_spmi0: power-controller@58 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x58 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi0";
+		apple,always-on;
+	};
+
+	ps_nub_spmi1: power-controller@60 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x60 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi1";
+		apple,always-on;
+	};
+
+	ps_nub_spmi2: power-controller@68 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x68 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi2";
+		apple,always-on;
+	};
+
+	ps_nub_spmi_a0: power-controller@70 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x70 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi_a0";
+		apple,always-on;
+	};
+
+	ps_nub_aon: power-controller@78 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x78 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_aon";
+		apple,always-on;
+	};
+
+	ps_nub_spi0: power-controller@80 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x80 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spi0";
+		apple,always-on;
+	};
+
+	ps_nub_ocla: power-controller@88 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x88 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_ocla";
+		apple,always-on;
+	};
+
+	ps_nub_gpio: power-controller@90 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x90 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_gpio";
+		apple,always-on;
+	};
+
+	ps_nub_fabric: power-controller@98 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x98 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_fabric";
+		apple,always-on;
+	};
+
+	ps_nub_sram: power-controller@a0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_sram";
+		apple,always-on;
+	};
+
+	ps_debug_switch: power-controller@a8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_switch";
+		apple,always-on;
+	};
+
+	ps_atc0_usb_aon: power-controller@b0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xb0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb_aon";
+	};
+
+	ps_atc1_usb_aon: power-controller@b8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xb8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_usb_aon";
+	};
+
+	ps_atc0_usb: power-controller@c0 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb";
+		power-domains = <&ps_atc0_usb_aon>, <&ps_atc0_common>;
+	};
+
+	ps_atc1_usb: power-controller@c8 {
+		compatible = "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_usb";
+		power-domains = <&ps_atc1_usb_aon>, <&ps_atc1_common>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8122-usbpd-i2c.dtsi b/arch/arm64/boot/dts/apple/t8122-usbpd-i2c.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..112c5199cabdd42ef44a03aa4872d09b0efcbbb8
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8122-usbpd-i2c.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple M3 MacBook Pro and iMac (M3, 2023) I2C based USB PD controller nodes
+ *
+ * This file contains nodes for t8122 devices using I2C based cd321x USB Type-C
+ * port controllers. The are used in the M3 MacBook Pro and iMacs but not in the
+ * M3 Macbook Airs.
+ *
+ * target-type: J433, J434, J504
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&i2c0 {
+	status = "okay";
+
+	hpm0: usb-pd@38 {
+		compatible = "apple,cd321x";
+		reg = <0x38>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm1: usb-pd@3f {
+		compatible = "apple,cd321x";
+		reg = <0x3f>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8122.dtsi b/arch/arm64/boot/dts/apple/t8122.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..2a042b6fbebcd386b026088ee0386bc26deb1152
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8122.dtsi
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T8122 "M3" SoC
+ *
+ * Other names: H15G
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	compatible = "apple,t8122", "apple,arm-platform";
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
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e1: cpu@1 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e2: cpu@2 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e3: cpu@3 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_p0: cpu@10100 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p1: cpu@10101 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p2: cpu@10102 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10102>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p3: cpu@10103 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10103>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
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
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_HV_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clkref";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges;
+		nonposted-mmio;
+		/* Required to get >32-bit DMA via DARTs */
+		dma-ranges = <0 0 0 0 0xffffffff 0xffffc000>;
+
+		i2c0: i2c@235010000 {
+			compatible = "apple,t8122-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x35010000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 761 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c0_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@235014000 {
+			compatible = "apple,t8122-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x35014000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 762 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c1_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@235018000 {
+			compatible = "apple,t8122-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x35018000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 763 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c2_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c2>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@23501c000 {
+			compatible = "apple,t8122-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x3501c000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 764 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c3_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c3>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@235020000 {
+			compatible = "apple,t8122-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x35020000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 765 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c4_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c4>;
+			status = "disabled";
+		};
+
+		fpwm1: pwm@2a1044000 {
+			compatible = "apple,t8122-fpwm", "apple,s5l-fpwm";
+			reg = <0x2 0xa1044000 0x0 0x4000>;
+			power-domains = <&ps_fpwm1>;
+			clocks = <&clkref>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		serial0: serial@2a1200000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0xa1200000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 757 IRQ_TYPE_LEVEL_HIGH>;
+			/*
+			 * TODO: figure out the clocking properly, there may
+			 * be a third selectable clock.
+			 */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
+			status = "disabled";
+		};
+
+		aic: interrupt-controller@2d1000000 {
+			compatible = "apple,t8122-aic3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x2 0xd1000000 0x0 0x184000>,
+				<0x2 0xd1040000 0x0 0x4>;
+			reg-names = "core", "event";
+			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu_e0 &cpu_e1 &cpu_e2 &cpu_e3>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu_p0 &cpu_p1 &cpu_p2 &cpu_p3>;
+				};
+			};
+		};
+
+		pmgr: power-management@2d0700000 {
+			compatible = "apple,t8122-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2 0xd0700000 0 0x10000>;
+			/* child nodes are added in t8122-pmgr.dtsi */
+		};
+
+		pinctrl_ap: pinctrl@2c7100000 {
+			compatible = "apple,t8122-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x2 0xc7100000 0x0 0x100000>;
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
+			interrupts = <AIC_IRQ 241 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 242 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 243 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 244 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 245 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 247 IRQ_TYPE_LEVEL_HIGH>;
+
+			i2c0_pins: i2c0-pins {
+				pinmux = <APPLE_PINMUX(145, 1)>,
+					 <APPLE_PINMUX(144, 1)>;
+			};
+
+			i2c1_pins: i2c1-pins {
+				pinmux = <APPLE_PINMUX(147, 1)>,
+					 <APPLE_PINMUX(146, 1)>;
+			};
+
+			i2c2_pins: i2c2-pins {
+				pinmux = <APPLE_PINMUX(56, 1)>,
+					 <APPLE_PINMUX(55, 1)>;
+			};
+
+			i2c3_pins: i2c3-pins {
+				pinmux = <APPLE_PINMUX(54, 1)>,
+					 <APPLE_PINMUX(53, 1)>;
+			};
+
+			i2c4_pins: i2c4-pins {
+				pinmux = <APPLE_PINMUX(149, 1)>,
+					 <APPLE_PINMUX(148, 1)>;
+			};
+
+		};
+
+		pinctrl_nub: pinctrl@2e41f0000 {
+			compatible = "apple,t8122-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x2 0xe41f0000 0x0 0x4000>;
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
+			interrupts = <AIC_IRQ 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 426 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 427 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 428 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 429 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 430 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pmgr_mini: power-management@2e4280000 {
+			compatible = "apple,t8122-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2 0xe4280000 0 0x4000>;
+			/* child nodes are added in t8122-pmgr.dtsi */
+		};
+
+		wdt: watchdog@2e42b0000 {
+			compatible = "apple,t8122-wdt", "apple,t8103-wdt";
+			reg = <0x2 0xe42b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 432 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_smc: pinctrl@2ec820000 {
+			compatible = "apple,t8122-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x2 0xec820000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_smc 0 0 18>;
+			apple,npins = <18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 493 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 494 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 495 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 496 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 497 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 498 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 499 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_aop: pinctrl@2f4824000 {
+			compatible = "apple,t8122-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x2 0xf4824000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aop 0 0 54>;
+			apple,npins = <54>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 346 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 348 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 349 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 350 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 351 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 352 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+};
+
+#include "t8122-pmgr.dtsi"

-- 
2.53.0


