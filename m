Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE821F0DF8
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Jun 2020 20:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgFGSZb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 7 Jun 2020 14:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgFGSZa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 7 Jun 2020 14:25:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8639BC08C5C3;
        Sun,  7 Jun 2020 11:25:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l10so14987592wrr.10;
        Sun, 07 Jun 2020 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+cLX/NnGzJYg90E/xhKujobggud5wPVVPibcJ6xCyk=;
        b=CnAiG0SB6E0/ZROKSViLS2a1XaqiyVVah6t9iYnSiDlAzWtvygSOwHJ8hjdsj2IKoj
         fJtJ2+70Nn+sddHhrQyi3UuFeUq1Ed3nsNw+vsCFMI6zdJr0QqN50f1Ui3nSeWi5CohZ
         upCXEuXvcUVXXURw9x5t0VeSvqm1FstSrgCPV8jJ0m6Z2oNaq9Iv/3GjkiyJJUz4m30O
         XaBEpON81I+sv9CFmv+DlwDcX9M3nCS1/4P2S6ettsAf2RpaTMv/X7iII/ESG+iixxfU
         9V+TbFRQE4NCcpwvhN/ASEdnXzFInd3pk7kYzJ+6VnZsIn0PBGLlxaMgcvf9lgi3CIPK
         Gblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+cLX/NnGzJYg90E/xhKujobggud5wPVVPibcJ6xCyk=;
        b=CAAPXlrb745ZGHkOzWxfQ1KIeWCFve9VxYE9NgyZA0ufK22+EUGv/cw/TfKL2hAfbe
         FLjJtXx0pChYHkbEQUSzz5/U1iBdhS/6NqkEg297+/hzKBRIrAbdV1X57dIXWQK3ncdK
         Iwldngg5DV4GhdVRanaDnZvKhpH27n3e1hebiJc8dMeerxc64WdjkNdM6eiGmk0r3xMk
         ADqT0l8XE0vc6bRR01jnkj6C9JIlL+K4QvmEqH3S1tSDH4Kv5F4ui/+WSEDZBCFL3jIV
         QoWQ18Xd1iiVo9mVbQebBRxpKo/+8T8kdHylB52788fm9nZhz0UVsGniHIkQcp2GQhy0
         tPhQ==
X-Gm-Message-State: AOAM533+wnI/OD1rrWPk0MzOVuhEW/Ot9AreBf76Qc+rSAqp0rrloahf
        WGUXZTAZbW/iwHPmTjmAsgA=
X-Google-Smtp-Source: ABdhPJxuG1xVrWalOyExAuJvVq0meSH+XP8QM+JM2FHl/hEkH5Me8/1+7EL9Jn1r762JzXdGKeqeDQ==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr19108400wrq.140.1591554328104;
        Sun, 07 Jun 2020 11:25:28 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id h18sm20434981wru.7.2020.06.07.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:25:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/2] dt-bindings: hwmon: Add SFR NB6 sensor binding
Date:   Sun,  7 Jun 2020 20:25:23 +0200
Message-Id: <20200607182524.3221837-2-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607182524.3221837-1-noltari@gmail.com>
References: <20200607182524.3221837-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SFR NeufBox 6 is equipped with an I2C connected chip to monitor voltage,
temperature and other stats. It also has PWM LEDs that can be manually
controlled or set to specific hardware monitoring modes.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 .../bindings/hwmon/sfr,neufbox6.yaml          | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sfr,neufbox6.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/sfr,neufbox6.yaml b/Documentation/devicetree/bindings/hwmon/sfr,neufbox6.yaml
new file mode 100644
index 000000000000..418180e30a66
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sfr,neufbox6.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/sfr,neufbox6.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SFR NeufBox 6 Sensor
+
+maintainers:
+  - Álvaro Fernández Rojas <noltari@gmail.com>
+
+description: |
+  SFR NeufBox 6 is equipped with an I2C connected chip to monitor voltage,
+  temperature and other stats. It also has PWM LEDs that can be manually
+  controlled or set to specific hardware monitoring modes.
+
+properties:
+  compatible:
+    const: sfr,nb6_hwmon
+
+  reg:
+    description: I2C address
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm: hwmon@60 {
+      compatible = "sfr,nb6_hwmon";
+      reg = <0x60>;
+    };
+
+    pwm-leds {
+      compatible = "pwm-leds";
+
+      service1_red {
+        label = "neufbox-6-foxconn-r0:red:service1";
+        pwms = <&pwm 0 31>;
+        max-brightness = <31>;
+      };
+
+      service2_red {
+        label = "neufbox-6-foxconn-r0:red:service2";
+        pwms = <&pwm 1 31>;
+        max-brightness = <31>;
+      };
+
+      service3_red {
+        label = "neufbox-6-foxconn-r0:red:service3";
+        pwms = <&pwm 2 31>;
+        max-brightness = <31>;
+      };
+
+      service1_green {
+        label = "neufbox-6-foxconn-r0:green:service1";
+        pwms = <&pwm 3 31>;
+        max-brightness = <31>;
+        default-state = "on";
+      };
+
+      service2_green {
+        label = "neufbox-6-foxconn-r0:green:service2";
+        pwms = <&pwm 4 31>;
+        max-brightness = <31>;
+      };
+
+      service3_green {
+        label = "neufbox-6-foxconn-r0:green:service3";
+        pwms = <&pwm 5 31>;
+        max-brightness = <31>;
+      };
+
+      wan_white {
+        label = "neufbox-6-foxconn-r0:white:wan";
+        pwms = <&pwm 6 31>;
+        max-brightness = <31>;
+      };
+
+      voip_white {
+        label = "neufbox-6-foxconn-r0:white:voip";
+        pwms = <&pwm 7 31>;
+        max-brightness = <31>;
+      };
+
+      wlan_white {
+        label = "neufbox-6-foxconn-r0:white:wlan";
+        pwms = <&pwm 8 31>;
+        max-brightness = <31>;
+      };
+    };
+...
-- 
2.26.2

