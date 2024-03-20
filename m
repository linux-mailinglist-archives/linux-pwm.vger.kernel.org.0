Return-Path: <linux-pwm+bounces-1805-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4506880D56
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Mar 2024 09:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9ACE1C20B65
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Mar 2024 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AC539FF2;
	Wed, 20 Mar 2024 08:43:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from trabant.uid0.hu (trabant.uid0.hu [81.0.124.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C9383A1
	for <linux-pwm@vger.kernel.org>; Wed, 20 Mar 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.0.124.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924181; cv=none; b=tl23Ctox7HEKvkyqFc36YAuCmCbbA5YAOt5iyr2RBavC8DWWsVIwXc5kpo6/YiYZTRvFTsTpBq3WXYciTXvdhWUnUEHE0ximaLN9P/Nv7OC4kc/gJTCYxEyrp4tNZlNz+PlgRL0c24r8hNG1VzGJ+tSphg3hh1aC6a0Fmo5a6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924181; c=relaxed/simple;
	bh=8KyADMS/I7B86zCdHnixHsYVcNp5vR4JkUyDPKt1QL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tAnWEMUi5vah9SfzuUPj6jDUpt1B6/suJ5qAGcziqaiHVKGq3JiTklnjwU/PulT/QlTcraEydKnFddlq0MdYl5w5YrXUVfu9Eh3BB0AcjQ5jAM7XMZqvwiy5ep2lE8t2qFFqcAUnoE1k+OgEY1eM0l1km+vGcmC5jqxEegreWMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uid0.hu; spf=none smtp.mailfrom=trabant.uid0.hu; arc=none smtp.client-ip=81.0.124.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uid0.hu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=trabant.uid0.hu
Received: from wigyori by trabant.uid0.hu with local (Exim 4.92 #3 (Debian))
	id 1rmrRG-000LU2-Gl
	from <wigyori@trabant.uid0.hu>; Wed, 20 Mar 2024 09:36:46 +0100
From: Zoltan HERPAI <wigyori@uid0.hu>
To: u.kleine-koenig@pengutronix.de,
	linux-pwm@vger.kernel.org
Cc: wigyori@uid0.hu
Subject: [PATCH] pwm: img: fix pwm clock lookup
Date: Wed, 20 Mar 2024 09:36:02 +0100
Message-Id: <20240320083602.81592-1-wigyori@uid0.hu>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Zoltan HERPAI <wigyori@trabant.uid0.hu>

22e8e19 has introduced a regression in the imgchip->pwm_clk lookup, whereas
the clock name has also been renamed to "imgchip". This causes the driver
failing to load:

[    0.546905] img-pwm 18101300.pwm: failed to get imgchip clock
[    0.553418] img-pwm: probe of 18101300.pwm failed with error -2

Fix this lookup by reverting the clock name back to "pwm".

Signed-off-by: Zoltan HERPAI <wigyori@uid0.hu>
---
 drivers/pwm/pwm-img.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index d79a96679a26..d6596583ed4e 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -284,9 +284,9 @@ static int img_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(imgchip->sys_clk);
 	}
 
-	imgchip->pwm_clk = devm_clk_get(&pdev->dev, "imgchip");
+	imgchip->pwm_clk = devm_clk_get(&pdev->dev, "pwm");
 	if (IS_ERR(imgchip->pwm_clk)) {
-		dev_err(&pdev->dev, "failed to get imgchip clock\n");
+		dev_err(&pdev->dev, "failed to get pwm clock\n");
 		return PTR_ERR(imgchip->pwm_clk);
 	}
 
-- 
2.20.1


