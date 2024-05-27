Return-Path: <linux-pwm+bounces-2246-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5197D8CFEF4
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 13:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D917B1F22A95
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022C152DE7;
	Mon, 27 May 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JA5WzdPd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14941527B5;
	Mon, 27 May 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809394; cv=none; b=UYP3uCS9V8D+Oo6AeKKPfNjOuYX7mBmX+ww/BwSKzgZ03g0svEqoiH9hzfd4HoTdlr8RSdEvlZM+0BIW6/YFRsU6g4RzwEUPBEYumjfvkerkn7GWytqSrumr5X70GHb4WOG5FsxGMGeK+9GFTPIFszGzpLmFJIM8i1Z4bfQiWVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809394; c=relaxed/simple;
	bh=5q4sLsvl8DhHx82ft8skw0Am0GEFO/lk+YlRXiyiRfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4wUpV9qG4EJbOQilG4vg+9srkY3JFC7MrfsI+e0rqmFgevSLkmdFVr8AhX9Zgw7HLm7SuTk1nk7KTlH3P4LoGnQSJtRYIji4mV1vsNPep+MU88186zua5JNKCliK+5u7SWYokw084iQ9qFVyJotJ4yRMhIGDnCaImXEnIFDvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=JA5WzdPd; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1716809381; x=1717414181; i=wahrenst@gmx.net;
	bh=WOE8pWcqchiygSIAwwph1Gl4Mt2my+SbletTL9W/sE8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JA5WzdPdIZeEM190yuurwafkcb3L2FkL0QwTQO4iVLKsL6MjQhLSDOWZed84/m0I
	 AfR1XPwJFjbj+BXH5xGlrvfA9kyyaDfhFXPR0jSOlcPLx9X/a5NJt+YgzBLdES3jk
	 y6oIZDxjdJlmesAtTIQPNMXzHqoU+1i6FI0d6IphFgzQJgq5bQqMPI7YU6B8HGOzN
	 xpS54qqPnbK+2wn21gtf6rZzSMgPVVItSzzVwZ+DMBFw3NFXsJqC4Xpv42eVCs2p9
	 notoV6An6Ywf+0s/X72OdvLnzQ/CKWgZRgzDHUsbCGW0j8Ji7aBn9EZVWHc6OlF72
	 45L7dbwge1JlDVP9mQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1rvneE0sYx-00LoKn; Mon, 27
 May 2024 13:29:41 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: andy.shevchenko@gmail.com,
	Philip Howard <phil@gadgetoid.com>,
	Sean Young <sean@mess.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Nicola Di Lieto <nicola.dilieto@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V5 1/2] dt-bindings: pwm: Add pwm-gpio
Date: Mon, 27 May 2024 13:28:56 +0200
Message-Id: <20240527112857.90554-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527112857.90554-1-wahrenst@gmx.net>
References: <20240527112857.90554-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HmJEtShl/UpyW1fKF6OIsniWwly0adh0bLR5FjFgHogN5Z9O8mK
 XBXdNOAy0d5RMAfU+6NN7l0ROlLj2JndwM1Z3ekSqK2IFAYGHo4fRZ+wX5zum6B8Wmc/PGC
 F0PfC2UAq+SMgUDGKo7d9y4Kgt4jIxv0nQtCFA9ma/snLovVGxWkbyMAPfPU4oJb+GScojc
 3S0+2RMKSXO8t0vB+nkYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ffnsRhJmnDI=;itprOn9KP7BEmCDNQ9qRqXyOjMD
 wmy2hxJrVJckk5RpGS9giCdDYN/ohQnhODbLPjZjFUh1Sn8fgI19wtfxWSkslmYDGqKNHPi3U
 dwq9UL6uk7sAPKMeU74TJoCcCrSHE5hLa7587G9wMyOtudUiGg4i6gZldD6cGg8ImY2pbrgR2
 g2x8lx5hfzKCPl7JFI7Fl/hXVJipYC5zYyzrOXe7Byt9aNF/8ldPnyGGeYBf8bl/dnFgA56YP
 Za77IDgoWWkx/oMDcwEPbpLjd05mlAPAnMPwA0PjuByjgLbWTPCljTTvbZYYXSbT9wJF/zl3w
 0Ei9hDpFgDaYsBb8C13TG12G31jzKMhcQx2kJ9oeMqIEqPi5pnMmrx6vpO4ro3Q7aWoDG2aqo
 jRe5LLYOxDcf08+j/+JwQ61aAcnd9/eAvMEKEiUGczyvhATeZe9DvBvS08KEgH6X4v5NuYAJ+
 cIeN0GHzL7+EZGxRz/YHk5mN3LDs8wWpjEIg+s70eYxIF6apHz7IszPyOllc1dZCsHIyEg2eB
 MUvlBYwm1xjDyqrfZCSk9Mi10iukw/mZLL1vnYZQDtKTuegdKApRNT9q5IMDh6nadafUcK/vy
 GJmh5NWBWz46CUc0XIvaOrxbtaano0bPh57Vo9IKDIOAJmsFnMUmCbWjnrZtbwZfKMOQNPoxW
 oWl053RBXgdO6lDfwffwZnAZUSxjQaAJC+G4FjfJDU0JzGdMefj4o8brY9VzwCO7fJJZGsNtX
 KOjYq6NPep/LN4edbs82mPfOna5VLvWSBCU2S1Fn5dw1AskBDa/gF9/R8YQQfqzyHx9xoawgQ
 6+k1C29xw0YcorFkj5QIFCJwSOnqERUFi4/oMLtX3umHw=

From: Nicola Di Lieto <nicola.dilieto@gmail.com>

Add bindings for PWM modulated by GPIO.

Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


