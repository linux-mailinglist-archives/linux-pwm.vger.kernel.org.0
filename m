Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA495B8BCE
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Sep 2022 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiINPbs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Sep 2022 11:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiINPbr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Sep 2022 11:31:47 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B619C4455F;
        Wed, 14 Sep 2022 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663169506; x=1694705506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tc8r3viZ1THhht9uyUek4ZAite/GHEyNkUji3BY65Oc=;
  b=MZsqRlGwRLAyfQDSewGd/wRmpZ/arQPDcUlu2LATUyopWDi0535TH3qC
   /A2LImcBR2TRx3QThpMl2gVEfAi1wDOOSECAdAM+RTzVrihbVYKcU0zvb
   cAT082AvgURQ+h+oDEjOc4XbkpaxLXFMKyPzibL+t97xICXzJp9yGs/kw
   +yTchCVOq5qNcjC1VAgZ/6lM0sBtgleQT111+RY5W0CqXa+uaDHSm+D5+
   CFFhw1oKBxmPV8r2oSjTTR4VhzLe4JasCEaJDY83bfaSKuIhHH5BSOEPe
   v90CslkkhGvVT+Cv5Nosu6v3C/o9Oz8FrxoUe2+sSljPiOYEigUljV0N8
   w==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26181296"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 14 Sep 2022 17:31:44 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 14 Sep 2022 17:31:44 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 14 Sep 2022 17:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663169504; x=1694705504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tc8r3viZ1THhht9uyUek4ZAite/GHEyNkUji3BY65Oc=;
  b=BohBRBJtClMjPxH3V+5nDbNMBNlmCcAFnJroPUwUzL6lD+DVTyfpJzOy
   QlHjwQdIyqjuR9ptRhHJe/TU9Nsbt6I3e0Ph7BUQTOkKZGTW3mfWGRUMu
   n06SjHu1Ar9AZgm3yxNogpqi17tm8Hjzm+05JUzaOXZZihJAok/K7Vy/i
   3iAefo/fkZluuT3GaysZr3d7+uIhH4ukTt7D+7q9YkNWwQaCDsJ0Kv3tk
   N1BgUFWmpXmz5bZmIrZSD8QpsguzYCqMv7+YDdONCwAppw+Dit7yN96lk
   ryfEGCOQV3oFTbAiVUl61B50eEq/8wLzssoIQJXiLgkNgpRvdyB98i0lu
   w==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26181295"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Sep 2022 17:31:44 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id CA30C280056;
        Wed, 14 Sep 2022 17:31:43 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH v5 0/5] hwmon: pwm-fan: switch regulator dynamically
Date:   Wed, 14 Sep 2022 17:31:32 +0200
Message-Id: <20220914153137.613982-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello everyone,

this is the next version for supporting switching off the pwm-fan regulator.
Review points from Guenter are included.

Changes in v5:
* Added Guenter's R-b to Patch 1 & 4
* Removed useless goto (Patch 2)
* Added error checking when switching off PWM (Patch 2)
* Removed useless branches when switching power (Patch 3)
* Removed useless (temporary) variable (Patch 3)
* Updated Patch 5 to changes of previous patches
* Dropped Patch 6 completly for lack of benefit

Changes in v4:
* Reordered commits so current behavior is the default all the time
* Fixed pwm state bug in Patch 1, this affects the patch context in Patch 2
* Refactor even more code in Patch 3 & 4 for smaller further patches
* Squashed the dynamic regulator switch patch and the sysfs attribute patch
  into one, keeping default behavior.
  Overhaul the patch to support different modes altogether
* Fixed bugs in module removal in pwm1_enable=1
* Moved internal PWM state removal to the end to keep the patch smaller

Best regards,
Alexander

Alexander Stein (5):
  hwmon: pwm-fan: Refactor fan power on/off
  hwmon: pwm-fan: Simplify enable/disable check
  hwmon: pwm-fan: Add dedicated power switch function
  hwmon: pwm-fan: split __set_pwm into locked/unlocked functions
  hwmon: pwm-fan: Switch regulator dynamically

 Documentation/hwmon/pwm-fan.rst |  12 ++
 drivers/hwmon/pwm-fan.c         | 312 +++++++++++++++++++++++---------
 2 files changed, 241 insertions(+), 83 deletions(-)

-- 
2.25.1

