Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A062E39113
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2019 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfFGP4a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Jun 2019 11:56:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48150 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731066AbfFGPoZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Jun 2019 11:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559922263; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lyfxz9ZFMEgaN/ge8mu7C3B/fHgwTl4wfi0Crw5xZyg=;
        b=B+SxfZQvKKJ0G1xakg+RrSsSTb/IaRp/FPOPYpUXf1ALKKrVlVTXNIDrAEuHM3eha0k/YQ
        JkRvV4F6FcbXZQMJcMRSNKaMzrwsll7F138nPI6CSCc9wQNW6nmD9Geq15Dys4lcj40a11
        xHG9sSsvEgF6iiN8Y0YpQ7BUDfA/xAY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/6] pwm: jz4740: Use __init_or_module and __exit for .probe and .remove
Date:   Fri,  7 Jun 2019 17:44:10 +0200
Message-Id: <20190607154410.10633-7-paul@crapouillou.net>
In-Reply-To: <20190607154410.10633-1-paul@crapouillou.net>
References: <20190607154410.10633-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 drivers/pwm/pwm-jz4740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index f901e8a0d33d..1b5077825721 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -145,7 +145,7 @@ static const struct pwm_ops jz4740_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
-static int jz4740_pwm_probe(struct platform_device *pdev)
+static int __init_or_module jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct jz4740_pwm_chip *jz4740;
 
@@ -169,7 +169,7 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	return pwmchip_add(&jz4740->chip);
 }
 
-static int jz4740_pwm_remove(struct platform_device *pdev)
+static int __exit jz4740_pwm_remove(struct platform_device *pdev)
 {
 	struct jz4740_pwm_chip *jz4740 = platform_get_drvdata(pdev);
 
-- 
2.21.0.593.g511ec345e18

