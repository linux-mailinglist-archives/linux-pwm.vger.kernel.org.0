Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A7E181CE3
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 16:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgCKPwe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Mar 2020 11:52:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41642 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgCKPwe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 11:52:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id b1so1427073pgm.8;
        Wed, 11 Mar 2020 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YF/1cXUmQGWs9vSHKbzj30xb9Qf0cIfVSbu0+Qxd3G8=;
        b=ssizjqaE8LNQ4GalJXJFUG+g9GGx66za4SuJU32ftKXnpfxnJ9z3wYHQPMB9j89nJr
         /h9mI6bBmUwfVW5vhlNm2aa7cq4hBpPvTdJZvz1WyWIw7QQeCP6GsjGlhSQIZ2Gwygur
         pcUcfos/aVZkG106C/snkGidsvKTOjfCKwkkXZMtHVAhut/UBGqJ3kBYMY9U9sLW24TP
         7y8XB41E4TfRQ/Q8iDIen1UgoyFOGdsJKrGhQinJARq/8BIiJm/uL75S8vksfLtUnFQu
         LtO0pUhlPBD1vE2yDrX+k4JIfD1zuKZT/3c8EkO4E8euUHtuaR9ZYKNynOhzAxBQW+3j
         Siwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YF/1cXUmQGWs9vSHKbzj30xb9Qf0cIfVSbu0+Qxd3G8=;
        b=hT8/jz9qZ8/wDWKPIkmUVcwwYm32BLnWXDBikxYAlIa3o62eLLbphQ23Wg6NqzvZ27
         UN5lTJAWRbs1h9Pwd5HoJsgG6OntzC45ze18qzRbu8SCFNhwvJ9Ewd5Cm/s6jQ/fgtev
         GeTPOGllxyJGhERbSCSQcDK2yjXAdjoprkwPikv5cgjHXabdC61nMw6xoearbYNlYpys
         h8Ng1oDoN0yH1V9NGgce6eoLYKQFxb+HPMRC1kCSPODqHJbz+jbdBMnRO6t1LUHn2hKF
         m1S8lvnESDr2U8nn/uwMAJVZWkYJ6kQQzHCynBxaENA4NZ4HOECfLI1dPPr5Q8TR5NXV
         vE0A==
X-Gm-Message-State: ANhLgQ33+AfM0xxP2Ku0ahR6OQg8ZfcQdMxlMSebY1dO+wWV+8US2naW
        /56cVP4+PsLqU8NlQ0z3rcu5eIrZ
X-Google-Smtp-Source: ADFU+vu0tbtYyRZAcpfr8ob41eF4QASNAVe0pQU7kmdtHAsBLa4Dvm5DERimhttpO/IMJ/0r7on6qQ==
X-Received: by 2002:a62:1b12:: with SMTP id b18mr3538762pfb.258.1583941951979;
        Wed, 11 Mar 2020 08:52:31 -0700 (PDT)
Received: from localhost.localdomain ([106.51.109.105])
        by smtp.gmail.com with ESMTPSA id d13sm5805564pjs.44.2020.03.11.08.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Mar 2020 08:52:31 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        s.trumtrar@pengutronix.de
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH 1/1] pwm: pca9685: use gpio core provided macro GPIO_LINE_DIRECTION_OUT
Date:   Wed, 11 Mar 2020 21:22:20 +0530
Message-Id: <1583941940-17194-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

GPIO core recently added macro to uniformly specify direction
of a GPIO Line, so use it.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/pwm/pwm-pca9685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index b2a9e77..e2bac1e 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -168,7 +168,7 @@ static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
 					  unsigned int offset)
 {
 	/* Always out */
-	return 0;
+	return GPIO_LINE_DIRECTION_OUT;
 }
 
 static int pca9685_pwm_gpio_direction_input(struct gpio_chip *gpio,
-- 
2.7.4

