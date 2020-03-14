Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA321858EC
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Mar 2020 03:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgCOCY7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 14 Mar 2020 22:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgCOCYN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:13 -0400
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65AA920770;
        Sat, 14 Mar 2020 11:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584185730;
        bh=coba9sPlVQlvtDyTnDgcgDbX0FGnfY7UH9T3w2NckRk=;
        h=From:To:Cc:Subject:Date:From;
        b=IHo9UHfgRAZndP5626xncCmMrGNzq2y+l8gtNe7gPnI02TVheNnld8vdjBcxriTDI
         M2SJzpOZCB19uEP/8ffnfke2PZfQgUEchLaOCdRGgX7O9NuV4iofCXktWefIcoL9zy
         sn1T7+L/ilxpKdQW8xsv0quXzPgeE9eqiVtDo1ZI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] pwm: meson: Fix confusing indentation
Date:   Sat, 14 Mar 2020 12:35:24 +0100
Message-Id: <20200314113524.23031-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Fix indentation of return block.  Smatch warning:
    drivers/pwm/pwm-meson.c:139 meson_pwm_request() warn: inconsistent indenting

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pwm/pwm-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 6245bbdb6e6c..8cf9129caa39 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -136,7 +136,7 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 			dev_err(dev, "failed to set parent %s for %s: %d\n",
 				__clk_get_name(channel->clk_parent),
 				__clk_get_name(channel->clk), err);
-				return err;
+			return err;
 		}
 	}
 
-- 
2.17.1

