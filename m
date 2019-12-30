Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99FE12D276
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Dec 2019 18:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfL3RV0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Dec 2019 12:21:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfL3RV0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Dec 2019 12:21:26 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2393420718;
        Mon, 30 Dec 2019 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726486;
        bh=16Vm2+4bOHtwFPrZ/Vs4bLTz4LXA5yWYbJqpA0iY+e8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ga+N7QV2jpHzzuMqRwqfmYcncnpQgMfPYcpoG9EdfkQ6s37hUOof4OYzE08ndjlWv
         aktqnm77s9ZkoefUY3VIVMFVfWZ5zriRi45vTDGWQkFHNQDKDuFtBub2CBw7vPzvUS
         RKfsShogNTWooDzeVgbJkAuU0lk/y4Jq0m8wN8jE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] pwm: Fix minor Kconfig whitespace issues
Date:   Mon, 30 Dec 2019 18:21:12 +0100
Message-Id: <20191230172113.17222-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Remove double whitespace after "config" keyword.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pwm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index bd21655c37a6..c865d688f6b4 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -490,7 +490,7 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
-config  PWM_TIECAP
+config PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3
 	help
@@ -499,7 +499,7 @@ config  PWM_TIECAP
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tiecap.
 
-config  PWM_TIEHRPWM
+config PWM_TIEHRPWM
 	tristate "EHRPWM PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3
 	help
-- 
2.17.1

