Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D8E1E406D
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2020 13:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE0Lwt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 May 2020 07:52:49 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40978 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE0Lws (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 May 2020 07:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1590580366; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=IqxIovXkXF5KvrGaQQjnGpCpjH/yZ+vIdz9EwngjN20=;
        b=apPwitTZICXjFI0gnegvuubDiXT1Tva1+gsHNIeDBNM+PL47BcP5kXyvoaoYKq5OGUMhXW
        Q1trQpFgr3M6Hlx7+t1OfZm1lEQLePKLaMiB31v13H+zQyavELxEG1ci6cP+gTMae4Oxwh
        jeoMp/0sDsxloRrVJZ1CA4niqADXoXI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 1/4] pwm: jz4740: Drop dependency on MACH_INGENIC
Date:   Wed, 27 May 2020 13:52:22 +0200
Message-Id: <20200527115225.10069-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Depending on MACH_INGENIC prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch. I don't consider this a fix but an enhancement, since the old
    	behaviour was in place since the driver was born in ~2010, so no Fixes tag.
    v3: Commit message changes (invert Acked-by / Signed-off-by)

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
2.26.2

