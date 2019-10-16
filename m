Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B368BD8EEA
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392598AbfJPLGN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 07:06:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34176 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbfJPLGN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:06:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id j11so27549158wrp.1
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SctoXZXMTWMcfDaJGPRRERJhsy9k0np9nwBe9LnY3E=;
        b=WQyUAxeU7Jjo8i+J1ZteY+hKwpe/7zuBan5j21vAZyFEosrTczwfs9qjGMPunP68GR
         zHCxJ+wYZNLqStkc4HVqmqOEZzxglm19sRfEg7QtEPdo1pRh6s2r2h0tJdDonF2ti+2K
         u9eZAV/eb0qLqPRhd0bWgZSJEAt62Hjce9C3bFcK3czMSooj5L2m8SO8CMYXFPnyZxmp
         2X3FvK+Mb+TVDDdgas7dbK3hp0Ak9X/wurIq5tXZ3ockOT5n3nDb8FZnjiJVERDauSDa
         kJ3nwFm/rx1P9wjOTdIFFyTsue5lo516zLYMooSuOXXcFkdBQr/+Dc3zWyknyVUyofze
         6SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SctoXZXMTWMcfDaJGPRRERJhsy9k0np9nwBe9LnY3E=;
        b=UmF+hC+7MhizKki/VMgiHsunJ6sNk8KWahNv7TFJ3TJfj22ZOZLjl3rbf9SdzIzVcZ
         fm1dofbZFMnPmuRle/oIC5I5SByBUMjuQLSDARzPMIX2fJuExG0eddWiZUjt4WhNxMrq
         +QVzxsyzVsRge0KeZcTUmsZaFWO9YXwgmi/ZnLG8Jj58lejOrPlEd+T1MOj2LRfqQrsC
         Ojtoa+ErS5KEPETAUvjemgVrzIaGa9bwMUX1T6SIiaZ4rXEfimRyYDzpOW97knTVipab
         zZrvRXqENm6ThJwf4q12Y/N2GOTTGO3q9kCRReKRiHIIrdFNVamO09nxkU8ci3fFul/I
         etBA==
X-Gm-Message-State: APjAAAUHh6/i8AY2j1RB1Lj59AMGKf9MRkJ4vfMSbYUx+E0yEn5FXMEp
        LiS6FBrmeUxefttKxe58rcs=
X-Google-Smtp-Source: APXvYqzNDS8nPVpl/fPpKFFQCXSkpF/eINhsijEledejUcr/9GuB9HOaL4gta4mJlPnrDk6nQcw8JA==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr2201844wrw.10.1571223970921;
        Wed, 16 Oct 2019 04:06:10 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id n3sm18747504wrr.50.2019.10.16.04.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 04:06:09 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 3/3] pwm: stm32: Validate breakinput data from DT
Date:   Wed, 16 Oct 2019 13:06:01 +0200
Message-Id: <20191016110601.1765415-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016110601.1765415-1-thierry.reding@gmail.com>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Both index and level can only be either 0 or 1 and the filter value is
limited to values between (and including) 0 and 15. Validate that the
device tree node contains values that are within these ranges.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index db1d675b45fb..7ff48c14fae8 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -530,6 +530,7 @@ static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
 				       struct device_node *np)
 {
 	int nb, ret, array_size;
+	unsigned int i;
 
 	nb = of_property_count_elems_of_size(np, "st,breakinput",
 					     sizeof(struct stm32_breakinput));
@@ -551,6 +552,13 @@ static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
 	if (ret)
 		return ret;
 
+	for (i = 0; i < priv->num_breakinputs; i++) {
+		if (priv->breakinputs[i].index > 1 ||
+		    priv->breakinputs[i].level > 1 ||
+		    priv->breakinputs[i].filter > 15)
+			return -EINVAL;
+	}
+
 	return stm32_pwm_apply_breakinputs(priv);
 }
 
-- 
2.23.0

