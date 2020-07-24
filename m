Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2224D22D0FF
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 23:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgGXViT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 17:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgGXViQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 17:38:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA8CC0619D3;
        Fri, 24 Jul 2020 14:38:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so9426933wml.3;
        Fri, 24 Jul 2020 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ReKmclkzMgHNKBI6RqYqYVQYyFJjoWSotqdq4uIKtoE=;
        b=mpqSkSnYjFcYbJ/x8AazjJWIotT3BhXnRzP62t9pCzUr4B9pezdidFvPAwQ+spFliD
         IRvuMxKoZ7yNYYZswYH2fUw066PaQfbHxxupPtAuhQYw4oy7CLWdAK4EdLB3WdYUe1E/
         XzB2o5hzpk54Onyd9mRH+rmOm2cZfcitQg8HRe+5sNyNDB8u33PPQSmhSik+Cg8FX0J+
         ske3jylRBwkcvhp3/TXE/nFkNQ74B+dFLi1Eo2cOe4wkCfDJQYoApkfEwmD6d7kLp+os
         uWG75sTe/g6Hc/+veHd8lpTraV/K8ZAPKNb/KHp2x/EYCOZYHbaz2xY7rfpFbHfiAfSP
         Ft8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ReKmclkzMgHNKBI6RqYqYVQYyFJjoWSotqdq4uIKtoE=;
        b=pTrc3tUxrvC7Pu8vJE448xKiIKAazD8p/DtGgCnpKG1q0GNzR+pra5D0m1vgKpBv8B
         F21nSJQO+cQF4hQg2MZn8TjZbmLEZAUMthomC4lSxkrSK6/ebTecgjOpqIiv9pq4R4XT
         nZ9VWg+7pIgFREc44bH+n7WKomRo+JnYMpVrVusHVFD4wzVkyLpkTJq9Sg6NXzL7ancP
         Ty9vw1HMjY9wV+p/oT5F/6+sg5Yhir5DMJoXiiLZlM17/Q5RsdqKpWd3zo835dCoS+0E
         HJ/ekXtwZfA8LxoMM/nuGRW3agbjpMYM/P7wohpNlA26j6vJxZYy3FaFb0WS/firuO4X
         0xRA==
X-Gm-Message-State: AOAM533Cn3N5GrDsvrhfThNDnROqFTfxfW55U0n2l7A8K19utI5Hp1bH
        aK07976vbhS43zbe8VvLZcM=
X-Google-Smtp-Source: ABdhPJzzQWyK+zNKP7xb2Ee4+QUwe4rDpfpja+3+LhXpS2/kO8WQmJ7le56laq3odE8ul2hb68YTrw==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr9893645wma.7.1595626694422;
        Fri, 24 Jul 2020 14:38:14 -0700 (PDT)
Received: from TimeMachine.localdomain (bband-dyn34.178-41-255.t-com.sk. [178.41.255.34])
        by smtp.googlemail.com with ESMTPSA id 129sm8853400wmd.48.2020.07.24.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:38:13 -0700 (PDT)
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
Subject: [PATCH RFC 6/6] Documentation: Add binding for pwm-qti-lpg
Date:   Fri, 24 Jul 2020 23:36:56 +0200
Message-Id: <20200724213659.273599-7-martin.botka1@gmail.com>
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

Add documentation for pwm-qti-lpg

Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
Signed-off-by: Martin Botka <martin.botka1@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-qti-lpg.txt   | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-qti-lpg.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-qti-lpg.txt b/Documentation/devicetree/bindings/pwm/pwm-qti-lpg.txt
new file mode 100644
index 000000000000..df2810626da4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-qti-lpg.txt
@@ -0,0 +1,163 @@
+Qualcomm Technologies, Inc. LPG driver specific bindings
+
+This binding document describes the properties of LPG (Light Pulse Generator)
+device module in Qualcomm Technologies, Inc. PMIC chips.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: Must be "qcom,pwm-lpg".
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Register base for LPG and LUT modules.
+
+- reg-names:
+	Usage: required
+	Value type: <string>
+	Definition: The name of the register defined in the reg property.
+		      It must have "lpg-base", "lut-base" is optional but
+		      it's required if any LPG channels support LUT mode.
+
+- #pwm-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: The number of cells in "pwms" property specified in
+		      PWM user nodes. It should be 2. The first cell is
+		      the PWM channel ID indexed from 0, and the second
+		      cell is the PWM default period in nanoseconds.
+
+- qcom,num-lpg-channels:
+	Usage: required
+	Value type: <u32>
+	Definition: The number of the consecutive LPG/PWM channels in the chip.
+
+- qcom,lut-patterns:
+	Usage: optional
+	Value type: <prop-encoded-array>
+	Definition: Duty ratios in percentages for LPG working at LUT mode.
+		      These duty ratios will be translated into PWM values
+		      and stored in LUT module. The LUT module has resource
+		      to store 47 PWM values at max and shared for all LPG
+		      channels. This property is required if any LPG channels
+		      support LUT mode.
+
+- qcom,sync-channel-ids:
+	Usage: optional
+	Value type: <prop-encoded-array>
+	Definition: The hardware IDs of the LPG channel that required be
+		      grouped together. These channels will share the same LUT
+		      ramping configuration so that they will be enabled with a
+		      synchronized pattern. If the LUT ramping configuration
+		      differs for the channels grouped for synchronization,
+		      configuration of the first channel will be applied for
+		      all others.
+
+Subnode is optional if LUT mode is not required, it's required if any LPG
+channels expected to be supported in LUT mode.
+
+Subnode properties:
+Subnodes for each LPG channel (lpg@X) can be defined if any of the following
+parameters needs to be configured for that channel.
+
+- qcom,lpg-chan-id:
+	Usage: required
+	Value type: <u32>
+	Definition: The LPG channel's hardware ID indexed from 1. Allowed
+		      range is 1 - 8. Maximum value depends on the number of
+		      channels supported on PMIC.
+
+- qcom,ramp-step-ms:
+	Usage: required
+	Value type: <u32>
+	Definition: The step duration in milliseconds for LPG staying at each
+		      duty specified in the LUT pattern. Allowed range is
+		      1 - 511.
+
+- qcom,ramp-high-index:
+	Usage: required
+	Value type: <u32>
+	Definition: The high index of the LUT pattern where LPG ends up
+		      ramping to. Allowed range is 1 - 47.
+
+- qcom,ramp-low-index:
+	Usage: required
+	Value type: <u32>
+	Definition: The low index of the LUT pattern from where LPG begins
+		      ramping from. Allowed range is 0 - 46.
+
+- qcom,ramp-from-low-to-high:
+	Usage: optional
+	Value type: <empty>
+	Definition: The flag to specify the LPG ramping direction. The ramping
+		      direction is from low index to high index of the LUT
+		      pattern if it's specified.
+
+- qcom,ramp-pattern-repeat:
+	Usage: optional
+	Value type: <empty>
+	Definition: The flag to specify if LPG would be ramping with the LUT
+		      pattern repeatedly.
+
+- qcom,ramp-toggle:
+	Usage: optional
+	Value type: <empty>
+	Definition: The flag to specify if LPG would toggle the LUT pattern
+		      in ramping. If toggling enabled, LPG would return to the
+		      low index when high index is reached, or return to the high
+		      index when low index is reached.
+
+- qcom,ramp-pause-hi-count:
+	Usage: optional
+	Value type: <u32>
+	Definition: The step count that LPG stop the output when it ramped up
+		      to the high index of the LUT.
+
+- qcom,ramp-pause-lo-count:
+	Usage: optional
+	Value type: <u32>
+	Definition: The step count that LPG stop the output when it ramped up
+		      to the low index of the LUT.
+Example:
+
+	pmi8998_lpg: lpg@b100 {
+		compatible = "qcom,pwm-lpg";
+		reg = <0xb100 0x600>, <0xb000 0x100>;
+		reg-names = "lpg-base", "lut-base";
+		qcom,num-lpg-channels = <6>;
+		#pwm-cells = <2>;
+		qcom,lut-patterns = <0 14 28 42 56 70 84 100
+					100 84 70 56 42 28 14 0>;
+		qcom,sync-channel-ids = <3 4 5>;
+		lpg@3 {
+			qcom,lpg-chan-id = <3>;
+			qcom,ramp-step-ms = <200>;
+			qcom,ramp-pause-hi-count = <10>;
+			qcom,ramp-pause-lo-count = <10>;
+			qcom,ramp-low-index = <0>;
+			qcom,ramp-high-index = <15>;
+			qcom,ramp-from-low-to-high;
+			qcom,ramp-pattern-repeat;
+		};
+		lpg@4 {
+			qcom,lpg-chan-id = <4>;
+			qcom,ramp-step-ms = <200>;
+			qcom,ramp-pause-hi-count = <10>;
+			qcom,ramp-pause-lo-count = <10>;
+			qcom,ramp-low-index = <0>;
+			qcom,ramp-high-index = <15>;
+			qcom,ramp-from-low-to-high;
+			qcom,ramp-pattern-repeat;
+		};
+		lpg@5 {
+			qcom,lpg-chan-id = <5>;
+			qcom,ramp-step-ms = <200>;
+			qcom,ramp-pause-hi-count = <10>;
+			qcom,ramp-pause-lo-count = <10>;
+			qcom,ramp-low-index = <0>;
+			qcom,ramp-high-index = <15>;
+			qcom,ramp-from-low-to-high;
+			qcom,ramp-pattern-repeat;
+		};
+	};
-- 
2.27.0

