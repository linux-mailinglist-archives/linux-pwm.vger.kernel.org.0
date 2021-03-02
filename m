Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A760932B505
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Mar 2021 07:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhCCFzm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Mar 2021 00:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446785AbhCBMk4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Mar 2021 07:40:56 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E8EC061225;
        Tue,  2 Mar 2021 04:40:30 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d11so11953678plo.8;
        Tue, 02 Mar 2021 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qhkq6ZVcFSkgquOTN6392bAr78oIYtqIjK8IaKcASCU=;
        b=glkkuPuWN6uFklXx46KOFJlIY8j0NJqskfrZbLsFWQz3DHGeyAj4fktfGkhQ/PCvKc
         QL36F/2CNGFlhMxi86i8PNu7DSWQ7yPjGIBe7CyXgjsdoxe6OqWrxxoLATyy9GvjUTBH
         2bXm0xsbDXJ3bWciU0GPIM1mVllKGBlMXD0DzzZlvlTCy/2JYHVZ6Rm736sJD0ED+Wq0
         PEMcH9DHoN5KnEoHk2DPThZC94Oc1P1Tsn16Y8N7PMKkvm+keQvy1Hlp3jjMjJ45fnah
         WGRWQkQ+4FDY4qVKWryU0NgZt2/E1aHELue12txVpLMzDKVrwgkk4GgG6iChvm1G3a/8
         8LGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qhkq6ZVcFSkgquOTN6392bAr78oIYtqIjK8IaKcASCU=;
        b=belTmGWzHDNr36vH29GiB4tscGldMVtCrdE3/Fzp1XiqgwNsQXHz2zE1hr20P/tfPF
         VFfpBSfbN7oN4X2qp3zetGwx29Nnn16Q7M2rZoGPoPPlazyQWPxg21+ty6BspcIYcqUZ
         Iyg9ZE97UeZbCwtz+pOlw3oqPHkmMrz4GmAzi5pS/9NncIWyDmOrV2JGQ0uxX2LhQX44
         vYQfuOomhzsIRW+AmUy8S/6Jb8v6m9xHVC4aTV6f6fo97nAThlm47AZarguBDR7OACJS
         uYnGJI+fPwLUmsbvkWfSE6sXEbnpbLew/DEzJ2AbUiQtZWYJAYmA2SB0d1+M4n3S5phj
         e0Zw==
X-Gm-Message-State: AOAM533wvJC0UrMojK8Tpf5AG9T2yVNvYznZ5YqsOaMvih30FOzL5624
        sfJ59Eg2/Mkk2C3tY6gPVanAAuvs7Q==
X-Google-Smtp-Source: ABdhPJyBnHF0jEsF94l88b3zqhL5nSTi0rtSz3EAiVfaCdKkLH9nzDBJSg2ZUd50SCQLDTIDXt4ZTA==
X-Received: by 2002:a17:90a:aa0d:: with SMTP id k13mr4474267pjq.210.1614688830525;
        Tue, 02 Mar 2021 04:40:30 -0800 (PST)
Received: from INTERNET-129.allwinnertech.com ([223.197.233.48])
        by smtp.gmail.com with ESMTPSA id n10sm19778341pgk.91.2021.03.02.04.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 04:40:29 -0800 (PST)
From:   Ban Tao <fengzheng923@gmail.com>
X-Google-Original-From: Ban Tao
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ban Tao <fengzheng923@gmail.com>
Subject: [PATCH v3 2/2] pwm: sun8i-v536: document device tree bindings
Date:   Tue,  2 Mar 2021 20:40:23 +0800
Message-Id: <20210302124023.1923-1-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Ban Tao <fengzheng923@gmail.com>

This adds binding documentation for sun8i-v536 SoC PWM driver.

Signed-off-by: Ban Tao <fengzheng923@gmail.com>
---
 .../bindings/pwm/pwm-sun8i-v536.txt           | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i-v536.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i-v536.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i-v536.txt
new file mode 100644
index 000000000000..ab3f4fe0560a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i-v536.txt
@@ -0,0 +1,24 @@
+Allwinner sun8i-v536 SoC PWM controller
+
+Required properties:
+ - compatible: should be "allwinner,<name>-pwm"
+   "allwinner,sun8i-v833-pwm"
+   "allwinner,sun8i-v536-pwm"
+   "allwinner,sun50i-r818-pwm"
+   "allwinner,sun50i-a133-pwm"
+   "allwinner,sun50i-r329-pwm"
+ - reg: physical base address and length of the controller's registers
+ - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+   the cells format.
+ - clocks: From common clock binding, handle to the parent clock.
+ - resets: From reset clock binding, handle to the parent clock.
+
+Example:
+
+	pwm: pwm@300a0000 {
+		compatible = "allwinner,sun50i-r818-pwm";
+		reg = <0x0300a000 0x3ff>;
+		clocks = <&ccu CLK_BUS_PWM>;
+		resets = <&ccu RST_BUS_PWM>;
+		#pwm-cells = <3>;
+	};
-- 
2.29.0

