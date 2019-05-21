Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE725402
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2019 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfEUPef (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 May 2019 11:34:35 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53114 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfEUPee (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 May 2019 11:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1558452872; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFZyLEs/qmTn735r3wlcWHDBNnaaVDYzj29ACWMk9mA=;
        b=ds6mrmfGnstp+rSASyj5LgqD7EV+hIqlgFID0sPUtcQREAhhnd5TA/MB2qlM5u5jQTcPHC
        vnNvOUYpEOLiJly8AtrHDxGEUU+Qz14bnpnE60Ww4QktOg9nwHCkyZ09jhD+IDHH0SRj0y
        QC6J7cXJ1fHh3Xd29WZ2IQfXf9YRDA0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/5] pwm: jz4740: Drop dependency on MACH_INGENIC
Date:   Tue, 21 May 2019 17:34:14 +0200
Message-Id: <20190521153415.14703-4-paul@crapouillou.net>
In-Reply-To: <20190521153415.14703-1-paul@crapouillou.net>
References: <20190521153415.14703-1-paul@crapouillou.net>
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
index 1311b54089be..1dfdf2cd533a 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -223,7 +223,7 @@ config PWM_IMX_TPM
 
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
-	depends on MACH_INGENIC
+	depends on MIPS
 	help
 	  Generic PWM framework driver for Ingenic JZ47xx based
 	  machines.
-- 
2.21.0.593.g511ec345e18

