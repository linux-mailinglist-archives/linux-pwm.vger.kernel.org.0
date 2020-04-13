Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB871A6638
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2020 14:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgDMMPb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Apr 2020 08:15:31 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52860 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgDMMP2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Apr 2020 08:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586780126; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=LmSdrv7+fVVwo5Lzew1t4N2yKOWFOzfy5ZCScCQ07L8=;
        b=i0/Q4DURI7xbnmcXdWEJUIjDL59khGFrUo1C/kC8g20kX1eG2FfCGPrsfCQudDzHf/sXb7
        YkmHSsRQ6tTcvgCeJKM4mQoVqRVfLo8lLh1gA69XdfhgovVgXXZFjT8upmF2+ESWkEvAkP
        Wqy1mJdjKRszhpmhBex2pJ13eeq/Row=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] pwm: jz4740: Drop dependency on MACH_INGENIC
Date:   Mon, 13 Apr 2020 14:14:43 +0200
Message-Id: <20200413121445.72996-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Depending on MACH_INGENIC prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index eebbc917ac97..7814e5b2cad7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -234,7 +234,7 @@ config PWM_IMX_TPM
 
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
-	depends on MACH_INGENIC
+	depends on MIPS
 	depends on COMMON_CLK
 	select MFD_SYSCON
 	help
-- 
2.25.1

