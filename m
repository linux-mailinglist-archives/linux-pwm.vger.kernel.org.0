Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD761884E0
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 14:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgCQNLM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 09:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgCQNK4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 09:10:56 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C3620770;
        Tue, 17 Mar 2020 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584450656;
        bh=YcuIoVrIQeXiuSD1j/Q1Lk0qQ1T1L/MGqpKL3q2kgPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcuEk5UvdTtgQPs7Io6jULVaHJVkCLU/zHbTq0oqrBwW/D/cKjSEoWtWxd+YhhLXk
         B/FevolAtqO81SIqhZ/F73qyB/NPiLuKpSDQYQvO3t/qwbmLe/qamZUUhl28qWmSS2
         8K5MJOGjJDqxW7WdgLywez4tn8tuWN4jpAQhG/3M=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEBzh-0006S5-Kz; Tue, 17 Mar 2020 14:10:53 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Peled <bpeled@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 05/12] docs: dt: fix references to ap806-system-controller.txt
Date:   Tue, 17 Mar 2020 14:10:44 +0100
Message-Id: <cf60ef88712e4f46f4e4bf40b2c646451d921827.1584450500.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584450500.git.mchehab+huawei@kernel.org>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

ap806-system-controller.txt was renamed to ap80x-system-controller.txt.

Update its references accordingly.

Fixes: 2537831bbc19 ("dt-bindings: ap80x: replace AP806 with AP80x")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt        | 2 +-
 Documentation/devicetree/bindings/thermal/armada-thermal.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
index 2e097b57f170..0fc6700ed800 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
@@ -14,7 +14,7 @@ Required properties:
 
     "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
     SoCs (either from AP or CP), see
-    Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+    Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
     for specific details about the offset property.
 
 - reg: Address and length of the register set for the device. Only one
diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index f3b441100890..b0bee7e42038 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Note: these bindings are deprecated for AP806/CP110 and should instead
 follow the rules described in:
-Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
 
 - reg: Device's register space.
-- 
2.24.1

