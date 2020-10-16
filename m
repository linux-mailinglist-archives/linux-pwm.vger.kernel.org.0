Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449BE290822
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409928AbgJPPQG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 11:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409922AbgJPPQF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Oct 2020 11:16:05 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E042421527;
        Fri, 16 Oct 2020 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602861365;
        bh=ZNqFmplGF+HoZpw43kx78OXMBxOE5jqA44+gcKFChzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMKBvWgxOCb51Q+85aMg77uWLV4bucW1dzY1dHxYurD8hklxOp0h/mkmHZ52b06Ap
         Tc14UQIQXekWEtKXVQAVl8E7AtraxMPajzAD1voE0RD2j87CkGBYasl19GZe8X0IdE
         x1MVuN5eCuvNDqQac5jI919qipQcoCk5z5PFjbnE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Jeongtae Park <jtp.park@samsung.com>
Subject: [PATCH 3/4] MAINTAINERS: remove Jeongtae Park from Samsung MFC entry
Date:   Fri, 16 Oct 2020 17:15:27 +0200
Message-Id: <20201016151528.7553-3-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016151528.7553-1-krzk@kernel.org>
References: <20201016151528.7553-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Jeongtae Park has not been active on LKML:
https://lore.kernel.org/lkml/?q=f%3A%22Jeongtae+Park%22

Remove him from the Samsung S5P MFC driver entry.

Cc: Jeongtae Park <jtp.park@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37329c6258f9..6457737a859e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2428,7 +2428,6 @@ S:	Maintained
 F:	drivers/media/platform/s5p-jpeg/
 
 ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
-M:	Jeongtae Park <jtp.park@samsung.com>
 M:	Andrzej Hajda <a.hajda@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org
 L:	linux-media@vger.kernel.org
-- 
2.25.1

