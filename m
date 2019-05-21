Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1912540E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2019 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfEUPed (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 May 2019 11:34:33 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53046 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfEUPec (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 May 2019 11:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1558452870; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1uLHEYfm2MaCZL+xp+gtMA1Xdx3bCFRckCGaONwiCo=;
        b=KgOTtr8EYmmWlvv4fx0Zzc4thPL8acdjdh8BqSRqduDJvKs2jTbX7eLnuOH7YgZcssVHw6
        jBTaJ8Q2nHoIVQPem92KZ/g6PYgNYrlUbykFWzcOBfzFQ0xURuxUiCWdJ5/8Cf6ywfn44m
        HPzgaAQfBJ0htRTDKMWc8ySYJe421Rw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/5] pwm: jz4740: Remove unused devicetree compatible strings
Date:   Tue, 21 May 2019 17:34:12 +0200
Message-Id: <20190521153415.14703-2-paul@crapouillou.net>
In-Reply-To: <20190521153415.14703-1-paul@crapouillou.net>
References: <20190521153415.14703-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Right now none of the Ingenic-based boards probe this driver from
devicetree. This driver defined three compatible strings for the exact
same behaviour. Before these strings are used, we can remove two of
them.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index a7b134af5e04..c274136613c8 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -193,8 +193,6 @@ static int jz4740_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_pwm_dt_ids[] = {
 	{ .compatible = "ingenic,jz4740-pwm", },
-	{ .compatible = "ingenic,jz4770-pwm", },
-	{ .compatible = "ingenic,jz4780-pwm", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
-- 
2.21.0.593.g511ec345e18

