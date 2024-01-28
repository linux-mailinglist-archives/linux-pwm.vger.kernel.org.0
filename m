Return-Path: <linux-pwm+bounces-1107-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB9F83F83E
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jan 2024 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9C2B20B1C
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jan 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7582556D;
	Sun, 28 Jan 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="G5Ffn++2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E196A2D044;
	Sun, 28 Jan 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706459834; cv=none; b=DWJkQCybid1UZsVbgthTtIJDlGG5czB6RqA4Cr+VehUA7RTroeRklM/CC/keDZmglbaDiKa+HXqMmSSpiNlL7cuYl5zvyYRqLSwTukYW745y1HtrM8QAFDwnyNoKkfemwg2w8maqQR1vBAAyuYLyodBUaqDKyCAd/e9ptNQbuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706459834; c=relaxed/simple;
	bh=Ihy1J+LUc+2GJw3RCT0rs0IzXK/mLNSR9w2VXqtpDaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRYSP+7LrK/4B7KRcmdTMSVu2k26y7HhBiJgxvfcYO1/bcZDJciCrWGjGhdfMVsW7mIfwtlGDq45MxEIhFG4GW5xF4ZWuhEHF8hyRJmd0CTW8nIW/lqetvJOgqAVMHkO+MxNuL1xRkIBm7pG6tsYBUBwvZr9jEperRtA5szV10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=G5Ffn++2; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706459822; x=1707064622; i=wahrenst@gmx.net;
	bh=Ihy1J+LUc+2GJw3RCT0rs0IzXK/mLNSR9w2VXqtpDaw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=G5Ffn++2wdpHi2cu/xMU951pz2mA1dz2KhEYtsSOQjDjDpEsxXEQrXukbab5EHiG
	 l8e87E4DL0vEgPfDZPbRYYhk77eeZt91eG+vZJsEGXFFyjjvQAx45WIYQ14n/ohDm
	 cbS3sY0WHSBsMYDHCiacttPLU5FLtx7KMEL0vXIobpUISE8UutOIk+IdV7wVkKOPC
	 0Q9mimFlVdnvn2rOybWebNmqiCEWvhZwFeqm7O4kQK8BcEHLAZr6Xr/XMJktFiCHJ
	 GUxLoVAv+il4pkYpwAdx0ncMcqRp13bmX9iPre6gXkIya/NcXLifiuWEllVHoJ/L6
	 uSzVchIpwX68DGOpyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFzr-1rKXtb2nQb-00AGHd; Sun, 28
 Jan 2024 17:37:02 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: andy.shevchenko@gmail.com,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Nicola Di Lieto <nicola.dilieto@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 1/2] dt-bindings: pwm: Add pwm-gpio
Date: Sun, 28 Jan 2024 17:36:29 +0100
Message-Id: <20240128163630.104725-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128163630.104725-1-wahrenst@gmx.net>
References: <20240128163630.104725-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IRoKT6Ns/GQ5OUzdwWJbbs1OLQ9UK66Xs5hrBWMHEsnTpXEPd0A
 O/fnUwkrW2zpYUzoWKe950nei6l2rUybADJfzF6oAyvrGj/pScExQRKJtqpNaFqjqcSllqD
 Gb2ykXuqFZuz4NlK5LD9HrCHKOQqembG/1O8LP2XrO1AyPbMBmTrtNzu/HWvIUJiSmmyYPj
 TZ9N/+UrnMbSkB50aC+Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wXkJwjL85SI=;UcZhokDW8e/MRlAS3oyPoU34k/n
 hKY8GGBZ5DTsEHIhyAcWSOQkD76Tu0UAa4C5rvGc6do+TvomsZHaLWOJ8jL5ePrhZ4IXm6kqv
 53+DbpSdMTsivUEr/7GZVpal9c8SKLmba/vkN2ARIXSPef7UJcMmC5losFWXztvG6hDnhauxf
 VIjj0SvpK5BNfOxcGH+mf6C+WaNdISUmvvN2Y3voJnSvVrB24lphVVM5/74bt7XT4huSH+vJ4
 nyyxKWH1f6xjpAruF9/T/r1RPQlppJGa075zDgRTfgdRD6ZoEeCWl+Se50m/00OUDAG7Luuld
 qUrJxcwjgpUue0KghPtDDNRgx0+q66yF29v5h6ieMZo7U84+b0Zll6kRfQict5DvxLI5K/5gO
 QArXeJk3ZyDoovXjgjiSsClewZrjWn4CMbDcNYcq4pWfDLjzpmnYX8LrNtE/QfxG7EUpRnONr
 i5AHJYKpJi5ICVW+iArDqL3g1UoIwhu4SXDSrv6HjQ/LiSUN+xi09qMqOhOcpswWm4DBL2XbQ
 1Zt9exLGvsJg9+leOo0sDbEwtReR8k7k5SA2hrr1lWm5KXx3k5O05WSV6s8XxygbxKseSZ25x
 wWG2pSZKl2WzAwpnoqpUNsi37Z7INstnYkmE3F5GS4I6hXyp0Z/Aos6jQMOWr6U0pIFxO8cgf
 UokPiT1UTCFQm3pM683lJCzHV/iRgTKy0+q1YoOsVTvdDjTt3hnKfXlTlZFJBbabM2xWqMWlx
 MDoZBJ60rPXWX9Pn383TJvw9Zh/O8CYV7PTDaOQdFE8mus1680+ZvH1ikVGrkUN6hxyJGIc14
 S+epxoX6yYr3EjCFzaQJmV2cuH79uae0wZ/pYm82mzkqVV41/m0r6ZT91Mq5S2726yJaUmatX
 OXMTkb1sl30CyWubh+jaykV3Q0EzzOQbtGS76K3mxaO90k8NnVi5f2E3WfZRz6fsiRi6Jl1Mt
 ndpuvBi61/rxd1vD5mwtrkeRG2g=

From: Nicola Di Lieto <nicola.dilieto@gmail.com>

Add bindings for the pwm-gpio driver.

Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 .../devicetree/bindings/pwm/pwm-gpio.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml b/Documen=
tation/devicetree/bindings/pwm/pwm-gpio.yaml
new file mode 100644
index 000000000000..4932484563f9
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic software PWM for modulating GPIOs
+
+maintainers:
+  - Stefan Wahren <wahrenst@gmx.net>
+
+properties:
+  "#pwm-cells":
+    description: |
+      It should be 3. See pwm.yaml in this directory for a
+      description of the cells format.
+    const: 3
+
+  compatible:
+    const: pwm-gpio
+
+  gpios:
+    description:
+      GPIO to be modulated
+    maxItems: 1
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    pwm0 {
+        #pwm-cells =3D <3>;
+        compatible =3D "pwm-gpio";
+        gpios =3D <&gpio 1 GPIO_ACTIVE_HIGH>;
+    };
=2D-
2.34.1


