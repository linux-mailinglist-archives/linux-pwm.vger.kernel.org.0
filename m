Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AC2530EF5
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 15:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiEWLF0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 07:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiEWLFZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 07:05:25 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623E917E33;
        Mon, 23 May 2022 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653303924; x=1684839924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sk/80/Sl50K9hqjUsn7T7l2+JB5Ia4zwoTorhGI3IzQ=;
  b=apmiIeDSZv6p99ahHBq/1sE2QqFMJI9HHIBpa/M2Yw9gxovDpHkD5OvE
   jEyudfl537Qs0C25ve/6I2YF7/jWA8vlC34Bkm2j5FHG0ARVDD9H4Hd+z
   7vmLaVbW2bMthp77rnrRRjj65yUPkDVEbqwQaPl3vQDcn0nxzhDP7i3dO
   d413bOEEArLOjkXrvG8ap4l+UZ6hQTdGENqsnnOf663oJpVAii1rC6Imc
   cYj6FwiCuMbJagZIl2aaclB8XlTcPT96trViiUUVxq7nu/FkbRM5mpXBK
   S1dH8kvnZc5ZriuY+MSvn8LZFL/6A6HgARW4CQ2iV262yL8GS9GucGQ5G
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031364"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 May 2022 13:05:18 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 23 May 2022 13:05:18 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 23 May 2022 13:05:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653303918; x=1684839918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sk/80/Sl50K9hqjUsn7T7l2+JB5Ia4zwoTorhGI3IzQ=;
  b=ctc9sPIbDC590oP/qimInVX5vrBvVwQc8e//tOYD/KSoNN2+YNcIkJIA
   q62yAO3py8Vgkzw3gch/yDSggenfKC5ByfPKme/w2ey6EKUzR1/WhiTPn
   SxXFEt7YEJXHD7SDI2pxGVvVv10WgWjO1TKtwu5z5dS5C+eqzbbdLTYP2
   LEj/5RvJgvrvom+QknZ2krBEfx8CN39Sry92kWCw432QE9iUDHi3nz0Dv
   L+6PLS6PBFAAAZKtBJxbbv4p+87hQ1BFE4+iXDULMkyWwiDDPi3C3keb6
   a6/KG986qyd1yxeVoPGibU2FG3QTlA9ZkPX8HsheGI88fGCKckE4BEhZt
   w==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031363"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 May 2022 13:05:18 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 015B5280070;
        Mon, 23 May 2022 13:05:17 +0200 (CEST)
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
Subject: [PATCH v4 0/6] hwmon: pwm-fan: switch regulator dynamically
Date:   Mon, 23 May 2022 13:05:07 +0200
Message-Id: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_CSS_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello everyone,

this is a new version for supporting switching off the pwm-fan regulator.
pwm1_enable was reworked to supported the modes Guneter suggested, while
keeping the previous behavior. This also resulted in reordering and refactoring
the commits even more.

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

Alexander Stein (6):
  hwmon: pwm-fan: Refactor fan power on/off
  hwmon: pwm-fan: Simplify enable/disable check
  hwmon: pwm-fan: Add dedicated power switch function
  hwmon: pwm-fan: split __set_pwm into locked/unlocked functions
  hwmon: pwm-fan: Switch regulator dynamically
  hwmon: pwm-fan: Remove internal duplicated pwm_state

 Documentation/hwmon/pwm-fan.rst |  12 ++
 drivers/hwmon/pwm-fan.c         | 330 +++++++++++++++++++++++---------
 2 files changed, 255 insertions(+), 87 deletions(-)

-- 
2.25.1

