Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86225407
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2019 17:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfEUPej (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 May 2019 11:34:39 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53134 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfEUPef (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 May 2019 11:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1558452873; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5rnmkqgorZ2qStNtcY9XklpDpBcCKsevMPL8o+5KJY=;
        b=AopMwRBbY87m2Baoacms8/oX02k+v8wmXORfIljqwE10Kn9/BvhLsP+cChp0n3ABlnAUx6
        9XTU3YQhYL0K23qK94ypQINW2hdSH439on+nN0SJvRKlV9rYk/rcQC7jsL7Ug+msISwtKb
        U1fUdZmtflS65yMVPitoWxBfyK/lirY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/5] pwm: jz4740: Switch to SPDX license identifier
Date:   Tue, 21 May 2019 17:34:15 +0200
Message-Id: <20190521153415.14703-5-paul@crapouillou.net>
In-Reply-To: <20190521153415.14703-1-paul@crapouillou.net>
References: <20190521153415.14703-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use a SPDX license identifier instead of a wall of text.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index e73ee72df09d..138b4f596525 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
  *  JZ4740 platform PWM support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
 
 #include <linux/clk.h>
-- 
2.21.0.593.g511ec345e18

