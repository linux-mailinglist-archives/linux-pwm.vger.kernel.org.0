Return-Path: <linux-pwm+bounces-7141-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C23E8B310E9
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 09:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C447AF413
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 07:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70F21FF3C;
	Fri, 22 Aug 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWx5WuLT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F52E2E426A
	for <linux-pwm@vger.kernel.org>; Fri, 22 Aug 2025 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849457; cv=none; b=OZiHwKZoqgHl3eM6O9rTrAlqz1npfmIX94r/7mWFV5kJrN1lsqvXJGIvA0RbtIFqRuYmwxT5oqQQGLbh9Brsjs2J5RlkGTD7MTJeY4jJHptYgVW+CnTbVlF2ggdq44jbJUfWo+WzgJZskieLstpoM3s4rQ2yKqn0zUGZpaRivcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849457; c=relaxed/simple;
	bh=x0j2EQXRqyvt7rxVFdqIAdXw7ahQ63q4FEnvUznWpfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlZQ2YVvHURAARwZ6PSMJCiqAn4omJM4cZV7cIMZhH6deGLYrmC0kbmS9qDgMkF2pr0bdBxxeBuqXdjewm4Hus/JGDuLkIT5uuw58Y8NfGvr6P/GuWs65ZHVGH+fHE/GlfYRZo4uAMvAVWWpLcUlPykduVOxswQYTgfMdTaovPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iWx5WuLT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61c20df01a9so54029a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 22 Aug 2025 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755849453; x=1756454253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXvOq0WDJymydEahTOESPI/du0vd8E1f2zWurTAGrWI=;
        b=iWx5WuLTAslghWVzmMEDitbiEePS2oZb2B7sBa9U54Q2a5ynckGllRhPCWJ5zHI3Q6
         igwG+8LC1AT/ZR8Osp2CdKcKV76iEtmLb9o5VSTuOmxZ7uem6NRUyoI/4Ln5axfnrq+b
         EAu38IDtW31Ygk1D6SwUSjbbB7LqQSscNf+HRS2gVXf/07e6TXbfAvgUOoj7xmL6eWCw
         ep91k29H1pK2KkBf251HnGdP8J4EqAZWEjPTM3Cx9j4dSoKF2S2GA7xrbph5lHIBqICV
         BG5dVWycd6FGAHPhY53n4pVWiyVR6wxU0qjhun0cQeEUOSZx8NLpw1hbEVvwre8URJcj
         fzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755849453; x=1756454253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXvOq0WDJymydEahTOESPI/du0vd8E1f2zWurTAGrWI=;
        b=WyO44BJYrK3cTxrlcx6iXNN1/EV971fJhKwnJVgzGOS70qrLAtEppE/PjHtbI3fU1q
         Ggtf9F2C42FqEGJR2R9CyJxw6zLjJx7jCpUykC9BtMMtrhUk54N+O60XjUZrRAORtrXm
         sl/VO/weeLQT9vZSy2Ln1/Da20Axcv5frGf/EqyyJeJ+dLsES7uSL7aNClSgNX6Hr1Yj
         ixlriHN159H8Avx2mxg7OczAnGEcNCtwQZUJuwrcKEuLx4GHkUoWny6kAGvp1qlmOUMt
         FGX/jLksYjET7En4Ex+p5JzF1roqrVnXfSHlNmoaD5CxekgXSXFTXnEJSgY1aL93skXU
         nJhg==
X-Forwarded-Encrypted: i=1; AJvYcCVssKFqHnsl7abl8M5Q83sQpOTMC/WQsAyiX/7Lqli+/3BqdryuvJdayfFRQxRXV366Ip7cxC9+vEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUFUk8d8YiltDLaiB8b7MVMywnNiaNnM1u/6Pg+t2ePaQf6T30
	h6fxzERzlL3PUZjG57dCLsfMzOA0PEHrLxAwoBDSeh8fJC+gXeOoHmUq75kh9JUU7Rs=
X-Gm-Gg: ASbGncsPo9gEF4fQpWMqs2ypXM+o1z9L9JrbFQzIFvozQCuNrp8SIf1+y/tpGSA3UeW
	ZhRSvwIzXxe4lkciACty8NAoHAXAJc1I1JjATjNK1UYgAj6zq02qGQ6Zp8OaTq23UURevr68J+J
	t9mUft1d/8ge6zu6FvRA8FDdxYgyx/WynjIYqjvXj2YKY6a3JN/RuSzfwpT75Qnm0pZJ32Q+XFe
	/AYjTUUFwRVC97UxZM5/zRymMXAKIFKn7WvBbdDFo62om090FoyH4HYPzxCVYP37gOIULvgVK5F
	9JOQNjaodWyoGNyfP1nvN9d04wWc+SNup/ilCEom3YaiJmaRUiuylRJMK9fOVHhCjzgLC8Jqgb7
	/QgYaQ/uEHJnTAxFy6Fkx5k5f7gIGIIHHhg==
X-Google-Smtp-Source: AGHT+IHAfwxJieXRqNAC4E/jPz9pCyUBG2KPd9gNolTqqry4bihuNop6WHp+vaYNcJgpxRXSZfhW6w==
X-Received: by 2002:a05:6402:2714:b0:61a:34c2:58c2 with SMTP id 4fb4d7f45d1cf-61c1b3c8aa9mr786406a12.2.1755849452760;
        Fri, 22 Aug 2025 00:57:32 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c25709d66sm197196a12.22.2025.08.22.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:57:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Michael Walle <mwalle@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jean Delvare <jdelvare@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Cheng-Yi Chiang <cychiang@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathew McBride <matt@traverse.com.au>
Subject: [PATCH v2] dt-bindings: mfd: Move embedded controllers to own directory
Date: Fri, 22 Aug 2025 09:57:13 +0200
Message-ID: <20250822075712.27314-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11465; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=x0j2EQXRqyvt7rxVFdqIAdXw7ahQ63q4FEnvUznWpfY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqCLYC7FUAFD9qCGlqJnlBxpbt50g8PbOa+l9M
 NreIM7mVGCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKgi2AAKCRDBN2bmhouD
 17nZD/0WwWQbLXAduO94hhdip6gvnEFCKdZQRALnWyof1QUZFB9t8NgXrPsWvOUtfGM+9UJd/cw
 PoGktP7MAH4fUgWw64i0ZEp+gbYqfT5EQYbW5yJX+k974ImWaS10DMuCeJbuIFzO45vRbivrgwJ
 L8H6pNDJq9yzx2PWuh60O59CNcOJ/dtCDi1sd2X+HZsGvgAzBpecjMA5/1fQDOC4BAm+DoRKpdG
 0tbnoO1lDeyPwJ0JC2eCV1BlqMf5jdK+mGuwjwmivYYztUdEoL5dr/F8z/Aliw962+J3NHvcvbC
 xbpPa/fFAz38dADypYTaIydz/WlHz9EfuIqkZKA/S8pVLzW2HIBoZ/En4i9OZbkrIC1YRnurI8i
 66aEasQAtZSnlDGxtBfdyEDd4Ph7VOFL7xKlAdLuGvak6P6eBEx+lBPWV5o7oQvf3HMqmmisBWf
 XFFuSUEkYassRF46J7si7c6thwg8u6/B6qEIO7egCiW2WjPjkBm651TafCF/IjySIoPMY0eg4CL
 v0C+kqxM7AenLSpDOxy1wMw5K6faJLKRjBUpQm3IkgaD84LS0qANc02VWvfPMzoxY2YpYe9Sq95
 cEoj/vK9qke/JFDIztGSpT8Q06VaR/Y1RFRq2TtpR9XfReWS94nMp8z1A09h3D/dX/jFzlljNdI OBEr0pNkAcS8t3A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Move ChromeOS Embedded Controller, Gateworks System Controller and
Kontron sl28cpld Board Management Controller to new subdirectory
"embedded-controller" matching their purpose.  MFD is coming from Linux
and does not really fit the actual purpose of this hardware.

Rename Gateworks GSC filename to match compatible, as preferred for
bindings.

Acked-by: Michael Walle <mwalle@kernel.org> # for sl28cpld
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Cc: Mathew McBride <matt@traverse.com.au>

Lee,
Can you take it via MFD?

Changes in v2:
1. Correct remaining paths in other schemas ($ref and descriptions)
---
 .../bindings/{mfd => embedded-controller}/google,cros-ec.yaml | 2 +-
 .../gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml}    | 2 +-
 .../{mfd => embedded-controller}/kontron,sl28cpld.yaml        | 2 +-
 .../devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml       | 2 +-
 .../devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml     | 2 +-
 .../bindings/interrupt-controller/kontron,sl28cpld-intc.yaml  | 2 +-
 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml | 2 +-
 .../devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml         | 2 +-
 Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml     | 4 ++--
 .../devicetree/bindings/sound/google,cros-ec-codec.yaml       | 2 +-
 .../devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml    | 2 +-
 MAINTAINERS                                                   | 4 ++--
 12 files changed, 14 insertions(+), 14 deletions(-)
 rename Documentation/devicetree/bindings/{mfd => embedded-controller}/google,cros-ec.yaml (99%)
 rename Documentation/devicetree/bindings/{mfd/gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml} (98%)
 rename Documentation/devicetree/bindings/{mfd => embedded-controller}/kontron,sl28cpld.yaml (97%)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
rename to Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml
index 50f457090066..3ab5737c9a8f 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#
+$id: http://devicetree.org/schemas/embedded-controller/google,cros-ec.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: ChromeOS Embedded Controller
diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
rename to Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
index dc379f3ebf24..82d4b2dadbae 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mfd/gateworks-gsc.yaml#
+$id: http://devicetree.org/schemas/embedded-controller/gw,gsc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Gateworks System Controller
diff --git a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml b/Documentation/devicetree/bindings/embedded-controller/kontron,sl28cpld.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
rename to Documentation/devicetree/bindings/embedded-controller/kontron,sl28cpld.yaml
index 37207a97e06c..0b752f3baaa9 100644
--- a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/kontron,sl28cpld.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
+$id: http://devicetree.org/schemas/embedded-controller/kontron,sl28cpld.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Kontron's sl28cpld board management controller
diff --git a/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
index b032471831e7..02663d67eac7 100644
--- a/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This module is part of the sl28cpld multi-function device. For more
-  details see ../mfd/kontron,sl28cpld.yaml.
+  details see ../embedded-controller/kontron,sl28cpld.yaml.
 
   There are three flavors of the GPIO controller, one full featured
   input/output with interrupt support (kontron,sl28cpld-gpio), one
diff --git a/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
index 010333cb25c0..5803a1770cad 100644
--- a/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
+++ b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This module is part of the sl28cpld multi-function device. For more
-  details see ../mfd/kontron,sl28cpld.yaml.
+  details see ../embedded-controller/kontron,sl28cpld.yaml.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
index e8dfa6507f64..87df07beda59 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This module is part of the sl28cpld multi-function device. For more
-  details see ../mfd/kontron,sl28cpld.yaml.
+  details see ../embedded-controller/kontron,sl28cpld.yaml.
 
   The following interrupts are available. All types and levels are fixed
   and handled by the board management controller.
diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index f7bc84b05a87..8f5a468cfb91 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -14,7 +14,7 @@ description: |
   Google's ChromeOS EC PWM is a simple PWM attached to the Embedded Controller
   (EC) and controlled via a host-command interface.
   An EC PWM node should be only found as a sub-node of the EC node (see
-  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml).
+  Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml).
 
 allOf:
   - $ref: pwm.yaml#
diff --git a/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml b/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
index 981cfec53f37..19a9d2e15a96 100644
--- a/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This module is part of the sl28cpld multi-function device. For more
-  details see ../mfd/kontron,sl28cpld.yaml.
+  details see ../embedded-controller/kontron,sl28cpld.yaml.
 
   The controller supports one PWM channel and supports only four distinct
   frequencies (250Hz, 500Hz, 1kHz, 2kHz).
diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index adc6b3f36fde..179c98b33b4d 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -58,7 +58,7 @@ properties:
     maxItems: 1
 
   cros-ec-rpmsg:
-    $ref: /schemas/mfd/google,cros-ec.yaml
+    $ref: /schemas/embedded-controller/google,cros-ec.yaml
     description:
       This subnode represents the rpmsg device. The properties
       of this node are defined by the individual bindings for
@@ -126,7 +126,7 @@ patternProperties:
         maxItems: 1
 
       cros-ec-rpmsg:
-        $ref: /schemas/mfd/google,cros-ec.yaml
+        $ref: /schemas/embedded-controller/google,cros-ec.yaml
         description:
           This subnode represents the rpmsg device. The properties
           of this node are defined by the individual bindings for
diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
index 1434f4433738..dd51e8c5b8c2 100644
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
@@ -15,7 +15,7 @@ description: |
   Embedded Controller (EC) and is controlled via a host-command
   interface.  An EC codec node should only be found inside the "codecs"
   subnode of a cros-ec node.
-  (see Documentation/devicetree/bindings/mfd/google,cros-ec.yaml).
+  (see Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml).
 
 allOf:
   - $ref: dai-common.yaml#
diff --git a/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
index 179272f74de5..872a8471ef65 100644
--- a/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This module is part of the sl28cpld multi-function device. For more
-  details see ../mfd/kontron,sl28cpld.yaml.
+  details see ../embedded-controller/kontron,sl28cpld.yaml.
 
 allOf:
   - $ref: watchdog.yaml#
diff --git a/MAINTAINERS b/MAINTAINERS
index 7969d09dff17..f3e4c1aa656e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10129,7 +10129,7 @@ F:	drivers/media/i2c/gc2145.c
 GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
 M:	Tim Harvey <tharvey@gateworks.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+F:	Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
 F:	Documentation/hwmon/gsc-hwmon.rst
 F:	drivers/hwmon/gsc-hwmon.c
 F:	drivers/mfd/gateworks-gsc.c
@@ -23177,10 +23177,10 @@ F:	drivers/usb/misc/sisusbvga/
 SL28 CPLD MFD DRIVER
 M:	Michael Walle <mwalle@kernel.org>
 S:	Maintained
+F:	Documentation/devicetree/bindings/embedded-controller/kontron,sl28cpld.yaml
 F:	Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
 F:	Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
-F:	Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
 F:	Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
 F:	Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
 F:	drivers/gpio/gpio-sl28cpld.c
-- 
2.48.1


