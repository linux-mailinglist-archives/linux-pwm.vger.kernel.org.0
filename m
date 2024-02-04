Return-Path: <linux-pwm+bounces-1198-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474F284910B
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 23:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F51C1C2205B
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A82C69E;
	Sun,  4 Feb 2024 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="PjppKstQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052C2C684;
	Sun,  4 Feb 2024 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084558; cv=none; b=lJKByz/VCemMx9GJoFs8k57XhOwOcIcsPbauH2NJjNgl1bqBMdstER159MYfHh6VRgXCv4lzbYVrL16IQHCzKU6GSVtxGjh7CHLg45qeudMMjoP++Iek9PelIhB54Y0G51ElelCfh+OeJDnO4XsgfadTbqbCGzHv+j+nhAKUtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084558; c=relaxed/simple;
	bh=4+PK6WpYDK9FgJCPw+Uj84yqhair+UmondquLYSgJYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5T7iHB3T/xprSn+DPu7MeTXFvBuJNVEv7mvlzN7Ig2LZk1Or4WRM0cctY/JRWafzYqtroddytJb+459T35RSkgnKUXXTxMY4efNVl1k4RgOxVSXYF4EaNtln4xiUmhirmm9I/IkVZCRt1UeYUhY2ISoBN/lj29uxphyhg9VoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=PjppKstQ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707084546; x=1707689346; i=wahrenst@gmx.net;
	bh=4+PK6WpYDK9FgJCPw+Uj84yqhair+UmondquLYSgJYo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=PjppKstQ0vzmsZmeocP14uKdgRAraM1xhJC0/QfgxyP7JZ5jIQTkf2yVzJNyurFO
	 Y3B9jbKOfxz7mMb1cyoTJp9LPlLuaQpkvJUpOS7S5RrKI2430gwodKtpB3sZ4b4RL
	 dlQg122h1bNbUlSo1iHjDUxanKplAlyAJuXSLPIwMoJ1pNEJs87m4Nv/1YDLRMmxF
	 iJtNiwwHMpv6OO0Udc88f4t1KTn732jzaMan3gzLkwGVeo6wDzWiei+Dpi6wKpMiH
	 YTHXz0dxyh9YKX37pk8dc0yjgbCthj8hGN5r+zQ9u6B9jNtIPSlmkCQaDmFby2nhk
	 N/I4dC9SM6nCHyerbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1qxxx52jzN-00ZdIt; Sun, 04
 Feb 2024 23:09:06 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: andy.shevchenko@gmail.com,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>,
	Sean Young <sean@mess.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Nicola Di Lieto <nicola.dilieto@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 1/2] dt-bindings: pwm: Add pwm-gpio
Date: Sun,  4 Feb 2024 23:08:50 +0100
Message-Id: <20240204220851.4783-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220851.4783-1-wahrenst@gmx.net>
References: <20240204220851.4783-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JOr6kjGTIYYIHWSud2FNDOWtCPlxm0cZYqQIWK1nRHbMIBulDd2
 yWXJZmtdSEcVWJIOPc3OiGZbaz9m0Vx3AworpD06FNb53DYfM48pEn0IfZN4YRp4IfzVMM+
 nROvSJ3wSCFJv9lTm4K3SOzptb97n0yRxtXtyseSFzNxmSxerOkLg4blUlD07FFlwcxMYhM
 trmvBKeJ5HKowYzwjrRzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CLJiQ5N552c=;/oM+HLbzwO1XYsW/bL4ykSvizTX
 BUUn42JK76lvLIujeTe7yO/zOLjEbxjuE+P3uAU1Q3HKy5Un30MJk/q1Wc4C17fBkjarcBKMQ
 BXF3jhIbhWCvVyRxIX6bpkt1mba5XsN1b0Rd5VMCfJ9T82KcG7REYp3+M3O1402pB9rBvQdG5
 492F3B706MFSn4bpkJj03u35m6h5aFYTHqLjfVYjLIy25jIl+iQFU7EaYf+/ImJsA7TJLZe16
 WIaEAiwfaFEw0H48jfpdLMDr2/zvKEjaAyWOBB4qlQsKEU2Qst4CjOXCxaM6U7GAgv7upHqbz
 6iQcDQNrDHkbG55oR3R6uxYyT989wR20a638KVQaka1p6aL4ysNBM3AXBAO1nOXoXnIQV4naS
 qulbmYE21xbwcj8xUZu01NrpYQVjFCac+Hi6K58Rkxl7FsG7LDbcv5DfLgz7ERWGU9cZNcDwU
 1G/7cMAFfDLnyupkLCcT7vTE4411Ey8kvUT1g5NfMjpQv7YiDIKXaVHwn+uhBmdyVaQxigBrE
 Oh0w7bvusGSLMEgDQeaLIXMxjXQslajGaDBSzj08WKEuMmMvZmmXW4wGRttw7HeXcU3l3RCUI
 wC5ui4BA8G2tw97ZgbiBkmAYW9tyk+ff4CoEcPOxxmsTmr09P4NNwDB6I5XMMiGCdcn957sgI
 qom236JztOewX/qkkcR/FrhEeelF6L5DTYcEn8DlvKANUafDoCatHN956k/WiC4sfsTE/uJRY
 J6xjlVO5guj0+xWm6fC7ly8hX7KIORFlnEF5yJZOmVB8nXcJwnqdxBr5nnArXHFo8B7Ek/V/d
 5n8f98M/FMbBuIaFlUcaz6mhD92iBFydM9Ey8fQGFQ2Wg=

From: Nicola Di Lieto <nicola.dilieto@gmail.com>

Add bindings for PWM modulated by GPIO.

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
index 000000000000..1a1281e0fbd7
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
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: pwm-gpio
+
+  "#pwm-cells":
+    const: 3
+
+  gpios:
+    description:
+      GPIO to be modulated
+    maxItems: 1
+
+required:
+  - compatible
+  - "#pwm-cells"
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    pwm {
+        #pwm-cells =3D <3>;
+        compatible =3D "pwm-gpio";
+        gpios =3D <&gpio 1 GPIO_ACTIVE_HIGH>;
+    };
=2D-
2.34.1


