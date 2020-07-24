Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D36122D0FC
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 23:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgGXViN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 17:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgGXViK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 17:38:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54448C0619D3;
        Fri, 24 Jul 2020 14:38:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so9517771wrw.1;
        Fri, 24 Jul 2020 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VT49qRulOHDWkC6UcILON7TozSHKPFp73aeRpY/WPVA=;
        b=pcUGbbG6/ODlTFDncEJaT9pltfDZftrHp8kc1Ege/cf+PLl/PQzqbRFdZYpIC1MFY8
         Wz1r6C/6ZTCKMB3hnwfB/oz3okqqy+YJZqLDgs/pLxqe2Rk1sTT1iRrNT4L64os7eI8j
         6k2zBgXPxsCA2TjX1Nixgv+VUTToCM+1qCZijcoEEWpURzhkIWQPznE+si4FOJPPYpS+
         5MKyu+Y5NlLqV10y0EpC5ot0uPPoIy3OUGi5B9Fx7TviMJovrO9hnNmZKjQnbPYpi3xO
         kwyRYCB9HPd5reup9yOYx4adYnaiaLB3KyajUxie39Xx8qTLL/IpuDFLzVjTElpx/cYb
         sh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VT49qRulOHDWkC6UcILON7TozSHKPFp73aeRpY/WPVA=;
        b=lzCLh7FOu7yO0OLsPNXFjaUNgXs8XjFN2Cb1Qv3fQUANnSejNQsFz8YbPEPOvT+gyv
         CiuZiIDxGxjnvBQAoh1HMdKZBKo98Oq4pyFB8Cv/rycHjNjvk9hMoZoY0kQpUt4dG7FR
         J5JPrs4rl6jhsi7uwgNLAu2yVw2Iprt1Ll7KF+Zk3gB2t//NAt9EwlU2uepVJDl9DEpl
         XhbvlPiz3iX89GYZNAlK7LCB9R0N89QbVuPzCGExjhYR5iJcYUU4D/C12ROAhX+fSCEK
         rCXPRx/zMgI3SH72fokQ13279cVc+m+vKJPW0DkI+2PHONEzqhUdGnKsm0ugLDlAJbDM
         H1OQ==
X-Gm-Message-State: AOAM530NNFUkQoNXg4dSVLnhpdR6+9kMUQAnZmrCHLaPsezv1dSzYeTV
        Z1FU3/HFQuxtfooLPzux/Mw=
X-Google-Smtp-Source: ABdhPJzmcMTadRNOtBp5GgByvZIPG+kSZU9jQNK6qpMZ10vGs8awa2lKtDehckqiShsPK0BcBIkymQ==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr10550925wrq.189.1595626688970;
        Fri, 24 Jul 2020 14:38:08 -0700 (PDT)
Received: from TimeMachine.localdomain (bband-dyn34.178-41-255.t-com.sk. [178.41.255.34])
        by smtp.googlemail.com with ESMTPSA id 129sm8853400wmd.48.2020.07.24.14.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:38:08 -0700 (PDT)
From:   Martin Botka <martin.botka1@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Martin Botka <martin.botka1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH RFC 5/6] Documentation: Add binding for qti-tri-led
Date:   Fri, 24 Jul 2020 23:36:55 +0200
Message-Id: <20200724213659.273599-6-martin.botka1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724213659.273599-1-martin.botka1@gmail.com>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Fenglin Wu <fenglinw@codeaurora.org>

Add documentation for qti-tri-led

Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
Signed-off-by: Martin Botka <martin.botka1@gmail.com>
---
 .../bindings/leds/leds-qti-tri-led.txt        | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-qti-tri-led.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-qti-tri-led.txt b/Documentation/devicetree/bindings/leds/leds-qti-tri-led.txt
new file mode 100644
index 000000000000..e179f4222739
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-qti-tri-led.txt
@@ -0,0 +1,72 @@
+Qualcomm Technologies, Inc. TRI_LED driver specific bindings
+
+This binding document describes the properties of TRI_LED module in
+Qualcomm Technologies, Inc. PMIC chips.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: Must be "qcom,tri-led".
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Register base of the TRI_LED module and length.
+
+- nvmem-names:
+	Usage: optional
+	Value type: <string>
+	Definition: Nvmem device name for SDAM to do PBS trigger. It must be
+		defined as "pbs_sdam". This is required only for HR_LEDs.
+
+- nvmem:
+	Usage: optional
+	Value type: <phandle>
+	Definition: Phandle of the nvmem device name to access SDAM to do PBS
+		trigger. This is required only for HR_LEDs.
+
+Properties for child nodes:
+- pwms:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: The PWM device (phandle) used for controlling LED.
+
+- led-sources:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: see Documentation/devicetree/bindings/leds/common.txt;
+		Device current output identifiers are: 0 - LED1_EN,
+		1 - LED2_EN, 2 - LED3_EN.
+
+- label:
+	Usage: optional
+	Value type: <string>
+	Definition: see Documentation/devicetree/bindings/leds/common.txt;
+
+- linux,default-trigger:
+	Usage: optional
+	Value_type: <string>
+	Definition: see Documentation/devicetree/bindings/leds/common.txt;
+
+Example:
+
+	pmi8998_rgb: tri-led@d000{
+		compatible = "qcom,tri-led";
+		reg = <0xd000 0x100>;
+
+		red {
+			label = "red";
+			pwms = <&pmi8998_lpg 4 1000000>;
+			led-sources = <0>;
+		};
+		green {
+			label = "green";
+			pwms = <&pmi8998_lpg 3 1000000>;
+			led-sources = <1>;
+		};
+		blue {
+			label = "blue";
+			pwms = <&pmi8998_lpg 2 1000000>;
+			led-sources = <2>;
+		};
+	};
-- 
2.27.0

