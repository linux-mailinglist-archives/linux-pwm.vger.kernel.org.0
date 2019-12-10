Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B494118F40
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Dec 2019 18:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfLJRr3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Dec 2019 12:47:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42364 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfLJRr2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Dec 2019 12:47:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so21080199wrf.9;
        Tue, 10 Dec 2019 09:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pB5aeFO1410E6SGmKnOdXbn7rGZMrphLj2vjpPn/Q54=;
        b=tZLox4/DcbVLjr0GuKmEUZ40aNSAzAUtXPNsdWDCbuh/YucUzlcc3IO9PvmIXMJrwT
         KInAl4ad0Xe1fZrHkiU98FAJCxGyMhGD+vv5Cn/3E5cC8BML1uGijPRDCYIA1p8GMu8K
         mQLsTGnCnRAow9YGWhSDdbXybSYxkyiibX9TOBXC/s4mjNX4JzuBQ1uG65w6jPdGBMIB
         DGwqFkiCMaZc/iQCqAs8xblVQgkP4h5bt5BSv76IGx8OW0aXyXsiP/B9e/9eKCJMesbH
         pKx6nSMO4ihtGy7UlpzVcgyOq/OTaESIt/Qp0AROW4eCHHXaEJgoDFefn4e8ybgFfTGf
         5TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pB5aeFO1410E6SGmKnOdXbn7rGZMrphLj2vjpPn/Q54=;
        b=S6jYYqJXezJThjic7STyjNznDPyx/gG1iL0YKhVLcf5sWrw6DD06Sn8WcIhrf3ars5
         Xp9G3kMz+mv+/452vBYUI1HRGK9A1XxPoe/4Cnw4sV6QIO8dmxKwox2XAYkqJTLeAYl6
         AkIqyQp+Z2VlQPFFONvEiBJWPaXjpasltINsw5vG9rfeOl2warZZyCr/QveiIOZ87508
         5Ns5WzsTMC3fRww+4i3umVaCZnrvGVLODqQSYOj1o5PKTa6vDjgNuKILX7ptI+er9NdG
         DYbKdWb3P/8qPR9zUm8nwTxT+tyFAGFS190yEc13G2cwgoXetkHGJqDtYY3uE59XF0Xf
         uVRg==
X-Gm-Message-State: APjAAAWEC0XFhCF/B3XYJwIyc8VLyr/ewO9MO+xqxPihozpsb0WUGOI6
        2iFBSUeu25mCaThzzMZya8Q=
X-Google-Smtp-Source: APXvYqz/yJP6QpGzZqSAc9mGuduUlZcsBSpQ40KMnzjM4er7cgiFR/7ZbB/7mnLGr6iMRnmun5xyEA==
X-Received: by 2002:adf:f990:: with SMTP id f16mr4772626wrr.185.1576000046349;
        Tue, 10 Dec 2019 09:47:26 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id s8sm3966040wrt.57.2019.12.10.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 09:47:25 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>, Maxime Ripard <maxime@cerno.tech>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] dt-bindings: pwm: allwinner: Fix missing header in H6 example
Date:   Tue, 10 Dec 2019 18:47:10 +0100
Message-Id: <20191210174710.10649-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Latest linux-next doesn't build due to the following error:

Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.example.dts:35.37-38
syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.example.dt.yaml]
Error 1

This is due to missing header in the device-tree yaml example.

Fix this by adding the missing headers.

Fixes: 4ee929b3f08e ("dt-bindings: pwm: allwinner: Add H6 PWM description")
Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index a7dc19fc347a..fab89f052450 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -93,6 +93,9 @@ examples:
     };
 
   - |
+    #include <dt-bindings/clock/sun50i-h6-ccu.h>
+    #include <dt-bindings/reset/sun50i-h6-ccu.h>
+
     pwm@300a000 {
       compatible = "allwinner,sun50i-h6-pwm";
       reg = <0x0300a000 0x400>;
-- 
2.20.1

