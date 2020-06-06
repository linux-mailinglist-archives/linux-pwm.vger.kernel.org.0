Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1401F0899
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jun 2020 22:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgFFU03 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 6 Jun 2020 16:26:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25208 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728906AbgFFU02 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 6 Jun 2020 16:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591475187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYaFESd6VxwpoNNiHY/1pHClEA8Pw/V+7HZeIA9iDaU=;
        b=JBpiY0ppXJKqybsFi9vYjfZZK+LhWflV3relxFxv2xUx9fVZuX6OWMlWQlUxtC1ogN5LXk
        e17nNSLB+2CLxX+A2uB1oYEsKcpgnOOTGYD9omrlAheUEcM2jjURXju6o0JdasK+1thJn6
        XPx+qGCymkpvxZmRGmqK1tIcZ4vfu9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-uYtqJm-lO4-ZZsPCYXSaGQ-1; Sat, 06 Jun 2020 16:26:24 -0400
X-MC-Unique: uYtqJm-lO4-ZZsPCYXSaGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 197C0107ACCA;
        Sat,  6 Jun 2020 20:26:22 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C3BB5C557;
        Sat,  6 Jun 2020 20:26:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 06/16] pwm: lpss: Add debug prints, test patch for moving i915 to atomic PWM
Date:   Sat,  6 Jun 2020 22:25:51 +0200
Message-Id: <20200606202601.48410-7-hdegoede@redhat.com>
In-Reply-To: <20200606202601.48410-1-hdegoede@redhat.com>
References: <20200606202601.48410-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add debug prints, test patch for moving i915 to atomic PWM.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 2cb0e2a9c08c..c1f8e6da0cd7 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -119,6 +119,8 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 		ctrl |= PWM_ENABLE;
 
 	if (orig_ctrl != ctrl) {
+		dev_err(pwm->chip->dev, "prepare 0x%08x -> 0x%08lx\n",
+			orig_ctrl, ctrl | PWM_SW_UPDATE);
 		pwm_lpss_write(pwm, ctrl);
 		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
 	}
@@ -126,8 +128,15 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 
 static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
 {
-	if (cond)
-		pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
+	if (cond) {
+		u32 orig_ctrl, ctrl;
+
+		orig_ctrl = ctrl = pwm_lpss_read(pwm);
+		ctrl |= PWM_ENABLE;
+		dev_err(pwm->chip->dev, "enable 0x%08x -> 0x%08x\n",
+			orig_ctrl, ctrl);
+		pwm_lpss_write(pwm, ctrl);
+	}
 }
 
 static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -200,6 +209,9 @@ static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->enabled = !!(ctrl & PWM_ENABLE);
 
 	pm_runtime_put(chip->dev);
+
+	dev_err(pwm->chip->dev, "initial state 0x%08x period %d duty_cycle %d enabled %d\n",
+		ctrl, state->period, state->duty_cycle, state->enabled);
 }
 
 static const struct pwm_ops pwm_lpss_ops = {
-- 
2.26.2

