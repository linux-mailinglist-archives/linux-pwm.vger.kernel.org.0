Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD51353E0
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2020 08:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgAIHtE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jan 2020 02:49:04 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.221]:42444 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728184AbgAIHtE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jan 2020 02:49:04 -0500
X-Greylist: delayed 1405 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 02:49:03 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 8130E20E06
        for <linux-pwm@vger.kernel.org>; Thu,  9 Jan 2020 01:25:37 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pSCHiuv6sqNtvpSCHiY3RY; Thu, 09 Jan 2020 01:25:37 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZGG68xB9srENApCLFB8NBnGMr0wtGwoST9dYSScyw8w=; b=vsIYH0hOFBwj3BrTLB197B7YcA
        odvWXuI6yOFwAjN1MJe0rVsNO2bhblFxE3WStAwNRx8A64wf9TJ9nOybBO5gAVrVRsbxBne6Xlj5Z
        Uy1l+oJV/RVZ2VRWFsTfZ7RoQmnGq8jUydHva4wPLcQqm1qs96Xx+oZd/aRmT6affDu9TwIWCmaer
        TLbAP/hzYKR3xnnF7iJTNQXduRZtVRLb0ynGN0gQ36zqc4v1D9T6PhpnmExJL5FJ9V3CfvanfpBY/
        1WjphPt9wY4aJb8Jr/VGBh7cIQRuZ+7g9YY0aERYlU5ufwEe1IIfCfTnQaK0If1y9dv5vFOAhDD5f
        K1QCN5Xw==;
Received: from [189.152.215.240] (port=37182 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ipSCF-000871-Le; Thu, 09 Jan 2020 01:25:36 -0600
Date:   Thu, 9 Jan 2020 01:27:35 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200109072735.GA22886@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.215.240
X-Source-L: No
X-Exim-ID: 1ipSCF-000871-Le
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.215.240]:37182
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in sun4i_pwm_probe().

The proper pointers to be passed as arguments are pwm->clk and pwm->bus_clk.

This bug was detected with the help of Coccinelle.

Fixes: b8d74644f34a ("pwm: sun4i: Prefer "mod" clock to unnamed")
Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pwm/pwm-sun4i.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1afd41ebd3fd..a805c347ee84 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -423,7 +423,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	 */
 	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
 	if (IS_ERR(pwm->clk)) {
-		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+		if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "get mod clock failed %pe\n",
 				pwm->clk);
 		return PTR_ERR(pwm->clk);
@@ -432,7 +432,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (!pwm->clk) {
 		pwm->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(pwm->clk)) {
-			if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+			if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
 				dev_err(&pdev->dev, "get unnamed clock failed %pe\n",
 					pwm->clk);
 			return PTR_ERR(pwm->clk);
@@ -441,7 +441,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
 	if (IS_ERR(pwm->bus_clk)) {
-		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+		if (PTR_ERR(pwm->bus_clk) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "get bus clock failed %pe\n",
 				pwm->bus_clk);
 		return PTR_ERR(pwm->bus_clk);
-- 
2.23.0

