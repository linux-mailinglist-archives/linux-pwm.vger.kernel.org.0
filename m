Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F103E40EFAA
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Sep 2021 04:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbhIQChQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Sep 2021 22:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243135AbhIQCgX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Sep 2021 22:36:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3089F6124F;
        Fri, 17 Sep 2021 02:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631846102;
        bh=V4+4fuchadtuptq/x/at9MpE0EbqUI1gLCg/TTB86Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJbyDvADABI7auRSJSZEnI1bszSDsWBcd4ke3uDwNE/qlUj2AchTAuGF2JPy38iLG
         0lZ5XJ59fW+yotB0zwlZeo4RhsimHUCPwDSTIYmr/VDb4ScttJSq1ayeN2DORRltTW
         Eh18TnKQOTQfEAeDh6Zy5yFQkkkgZiraE62nmW4JGRVgcRUjAOxzVdMUfVeRdkQSKC
         SEgqSFupuCXH864+9edWVTQS9Jyci4gbJDK9ML3E7gl6DaI4py2kjzITUJFJAs59WL
         rzJbK3I9dFf32ASgMMxPkI5NqeeHV++Aox21F4vS7U3Z95ueP3U0WJ/iSfRybYWrER
         tK4oc4sk0YB5g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, fabrice.gasnier@foss.st.com,
        lee.jones@linaro.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 3/4] pwm: stm32-lp: Don't modify HW state in .remove() callback
Date:   Thu, 16 Sep 2021 22:34:56 -0400
Message-Id: <20210917023457.816816-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917023457.816816-1-sashal@kernel.org>
References: <20210917023457.816816-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit d44084c93427bb0a9261432db1a8ca76a42d805e ]

A consumer is expected to disable a PWM before calling pwm_put(). And if
they didn't there is hopefully a good reason (or the consumer needs
fixing). Also if disabling an enabled PWM was the right thing to do,
this should better be done in the framework instead of in each low level
driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-stm32-lp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 28e1f6413476..e92a14007422 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -224,8 +224,6 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 {
 	struct stm32_pwm_lp *priv = platform_get_drvdata(pdev);
 
-	pwm_disable(&priv->chip.pwms[0]);
-
 	return pwmchip_remove(&priv->chip);
 }
 
-- 
2.30.2

