Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0557E3910B
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2019 17:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfFGPoX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Jun 2019 11:44:23 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48106 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbfFGPoX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Jun 2019 11:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559922261; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l329DP1GfA38eo6DdQH0nQW+XiEWJyha3rFEqKnEL0M=;
        b=JyiNHuW3+rSmpaKuvF8pzpvpHzdcA2Oz9GNsN2z0xriNmM1nMlhD0ypF12iiZNJ6BjZ9zI
        XM9Ju4bBknk1zuX9WLu3ytKOT9AZqGY+nVdEsNFzrW3dEUn7fVlOjAMlty/M6lysM3qG0z
        WEHMOAwQAmtJIHTN9kh2gBc5tIIS4l4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/6] pwm: jz4740: Drop dependency on MACH_INGENIC
Date:   Fri,  7 Jun 2019 17:44:08 +0200
Message-Id: <20190607154410.10633-5-paul@crapouillou.net>
In-Reply-To: <20190607154410.10633-1-paul@crapouillou.net>
References: <20190607154410.10633-1-paul@crapouillou.net>
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

Notes:
    v2: Rebase on v5.2-rc3

 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index dff5a93f7daa..26d484e22838 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -224,7 +224,7 @@ config PWM_IMX_TPM
 
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
-	depends on MACH_INGENIC
+	depends on MIPS
 	help
 	  Generic PWM framework driver for Ingenic JZ47xx based
 	  machines.
-- 
2.21.0.593.g511ec345e18

