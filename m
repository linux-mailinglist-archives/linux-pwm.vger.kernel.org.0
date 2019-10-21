Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D04DEA2D
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfJUK5o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 06:57:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37205 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfJUK5n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 06:57:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so12290399wmc.2
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrFxWZMLBUPw4bBJ17t4yXM8+YLr11qHLb+Gez/eLcQ=;
        b=fYxmYpF1T5qqcN4Fi0/A7Cp+3Pp1orYg8hUH+xNohtLoKGarPjYGgaBwnweiziuEEE
         5C4k2AY8l3DAZDbcJs4sA79W5bkLXWXOhM3g4ofPUwLM/1Dm09FvwsJYZC4kVG6hWhD1
         mQbTMaTEoZZi+Zho8gQlmgwiTpm9Q0AzdK1D7k1mdu3mrBW+/rx2Ejih0EGRIE78nO5Y
         UugsNntG9yiM3ym0aBRKaXglW8ettbPeuVvIBYmUlOx2NNUEdccCFgSWx5VskUzjV4Jh
         VMejOR9aksef9ZRU+98hdcS1j0Gs0UiFb1gBPmmK6jtTBvQXURXAcMrTX5bhEMOjnvEI
         0AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrFxWZMLBUPw4bBJ17t4yXM8+YLr11qHLb+Gez/eLcQ=;
        b=dK2VC13sBq8Kw0/n+nqXeEXxYZBk3Om8FhWK/s7d7cnzP0pJcTxiWm0zAvFS1jvzdz
         j1J5chTXL0v+xuhZlEMvDEtQJ+21TpcOjC8P9HfeCjBIZQBMuC0gRMlvh/+LT31cvGB0
         QYyzQfI0XTK9o7f59DXa9VyRErzgulISUGaBwgIb0PZ+1UcpM7qKiYhtQflg5HXBisV8
         iwOXwZ6uKLVtNKwR7ZrAz/EpzEn45JK116saYhbHw2t9bZ0YSjGhaaTwB62X9RXNaxy+
         hHdZg1QjAo5aSQUfJ/g/l5mMfgrITqMqtUusiHD5/1iglYWXDM5EBtmbNCZxjvv0j/Re
         sL4g==
X-Gm-Message-State: APjAAAWMEsfzeK4/ovK/yVYcZ8dxN6vUzE39iWmeyLiWUYN4X9qoAE2l
        d/qXYmves+GljISHdRA5AsoeaCkw
X-Google-Smtp-Source: APXvYqwwwOemQ59F8GRQW6hxDezhpbYL/p3oz82AvUyTM01/gjdSdN3rqr+axQruH+oOL7Ywq4LsnQ==
X-Received: by 2002:a7b:c8d9:: with SMTP id f25mr19370051wml.153.1571655461663;
        Mon, 21 Oct 2019 03:57:41 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id 36sm17208081wrp.30.2019.10.21.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:57:40 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH 1/4] pwm: Read initial hardware state at request time
Date:   Mon, 21 Oct 2019 12:57:36 +0200
Message-Id: <20191021105739.1357629-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM core doesn't need to know about the hardware state of a PWM
unless there is a user for it. Defer initial hardware readout until
a PWM is requested.

As a side-effect, this allows the ->get_state() callback to rely on
per-PWM data.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index f877e77d9184..e067873c6cc5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -114,6 +114,9 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		}
 	}
 
+	if (pwm->chip->ops->get_state)
+		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
+
 	set_bit(PWMF_REQUESTED, &pwm->flags);
 	pwm->label = label;
 
@@ -283,9 +286,6 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
 
-		if (chip->ops->get_state)
-			chip->ops->get_state(chip, pwm, &pwm->state);
-
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
 
-- 
2.23.0

