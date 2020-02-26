Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BB1700A3
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 15:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBZOAK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 09:00:10 -0500
Received: from mx1.tq-group.com ([62.157.118.193]:54865 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbgBZOAK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Feb 2020 09:00:10 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2020 09:00:10 EST
IronPort-SDR: NoHTmXF7OPsSM64RgzKJfYsKu6u5yJk9JrK5e27hWb7/oHVoGI1rzjI+vvS/iBXt2UuycE8pmw
 iLtKWvg6HL7JmxotpQ23aFoLHQw1gQ8b8aaarpEq30+0CLsQWSGNde9F6cWjjygNjDMS486AR8
 PvCzykd2iRC0F0Cz75GQCbNUzWUJ2QsaYOsx6KAp3vpMbhN6tGYpHlmlPFrqYsKs4Qe0gdEBKZ
 OjYmUOI3BK77UHHT7iks1wMITRtcgGoJYa7DlJC8ka+BU6xPAuh80SvgZvi/hdAayklOHC3blq
 bAI=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11120522"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Feb 2020 14:53:01 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Feb 2020 14:53:01 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Feb 2020 14:53:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1582725181; x=1614261181;
  h=from:to:cc:subject:date:message-id;
  bh=ADeNmlQQz72Eo2Cr7Fb7beMzpsaJivTmWRGwQL9Jh2U=;
  b=eTS74HdJrs0fD0l5c2s3ySODoTEw0Wn1ing/x1/fHvU5oMDKayqM+Vzc
   TYkjGNtmUH+Xy2C6jSAnB111p4cAoM2MdMQ+hMaBztm0JFBTRi2gOncog
   txYVCzGYq1S3zGRblr9GIj0zQ7I0wSJZ81quAhgLI7qU59GYUV0VOsWQ8
   jss9FER6gjYyRk+XQcXtMEWiLbb7laGWBS1mP3DJIGA5rnImgfQ/ZU587
   7g/hVjvolARy+52w3bR1Y/4PMhAyM+OYMUvQvOniEc+02uA/Qtxs/YMSJ
   yk8QiJmyMxw1tdB5NQSRo7MXPHi+VN01H4FuAUkmsltrL18r17YbpLI6l
   A==;
IronPort-SDR: KcHs2IJtWkqLaGm13nJsPY5nilMfQOsfBp88f3vMT6jVKDWpLM8PMPMDXTOo5HzvHbMvR0iN01
 HyaBYrZl17ZNUCuICYkO17BaVU11jm+Vni3SZWFip305rHyIMgQUGLMlTYpbMU9sR/U9A9SeIF
 lkrpgpvpT+SHcDosD1qAFQMaV0nGt2Dhgf1uEsuGHOCacDqY7Te1jI4RM5cl78ul9ZEezFrpTM
 0DfiWAKz9uyh1avoiD4oq7YvJ/UsIZ8BNznnu7O3vNYstYGXrot3CsEKTCOopwHYfqCvRH6Lbo
 xjo=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11120521"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Feb 2020 14:53:01 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 178FB280065;
        Wed, 26 Feb 2020 14:53:08 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Date:   Wed, 26 Feb 2020 14:52:26 +0100
Message-Id: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

duty_cycle was only set, never read.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/pwm/pwm-pca9685.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index b07bdca3d510..19ac97108a64 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -69,7 +69,6 @@
 struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
-	int duty_ns;
 	int period_ns;
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
@@ -272,8 +271,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	pca->duty_ns = duty_ns;
-
 	if (duty_ns < 1) {
 		if (pwm->hwpwm >= PCA9685_MAXCHAN)
 			reg = PCA9685_ALL_LED_OFF_H;
@@ -449,7 +446,6 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 			ret);
 		return ret;
 	}
-	pca->duty_ns = 0;
 	pca->period_ns = PCA9685_DEFAULT_PERIOD;
 
 	i2c_set_clientdata(client, pca);
-- 
2.17.1

