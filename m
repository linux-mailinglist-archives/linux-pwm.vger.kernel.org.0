Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9453252A4D5
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 16:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348868AbiEQO2I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348891AbiEQO0l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 10:26:41 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E250642A27;
        Tue, 17 May 2022 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652797600; x=1684333600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mankCJOGPKu8Xonfwp415Ga9O1GdXTSLMS2WtVwqIAY=;
  b=pS3xZM0rLPSjPs26Ury3+fx4+uUo+YJRgKtwFGnKn+3dpiPlAcqRMO9L
   ENJv3XCZ+gUU1/0jwvtpWAFFnTuKxbg8wc+MlKkwV4O5G2ZNm6ivbKeTZ
   S2hfpCjzcZD5zgFZHNdNYcP4/JHCWc/9IRbORxtqpO/DIRfqepkbVP9PA
   xjLTm2evtIV/0mL1Deqrt5sHCIqaBaBVmtYJzvpaaf+GzAgQioCUN2xqa
   gqv7x4MgytGnzYHE3dmdPhHvvs/lD7z710gj//rC/U2/G1WRvwLABUlc/
   TMx7M1IOUYAiDmA2Joqvfjeq7jDvx2uikdXtYYx63mbunrHuKI3TgGMcZ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925930"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 17 May 2022 16:26:25 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 17 May 2022 16:26:26 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 17 May 2022 16:26:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652797585; x=1684333585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mankCJOGPKu8Xonfwp415Ga9O1GdXTSLMS2WtVwqIAY=;
  b=HbyjGxwPNBRChpucPMj+nSy0awJcWWyRq5v03WFpVW0xRfbFFgaHcoiz
   EgzgplgggDGHFXZfhxAHZb9umL3/pM+6W1z0Ys4Mz9FJndr+GFSg8yi/K
   otjWGqGXPbWi9dETZF4TGHXk4uuXb8SUAqv87dRU/L+ONhRg0+toFNh6F
   o/Rsitl/25GavoMhcUanDAiAy9GeaYQW1aWbI2pjLKoV6cnDao+SYhdK4
   HUymFhXlT6U5iTYnkv/M4I9Iq/c0Y6/h7KOuVAVYixryKU9oBBAiB1yZ4
   bLhQbXTA9hGPwYx3wGNDtJzcHvONekhPXyvQwTdGxy6gMR8SawwYcMDgp
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925927"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 May 2022 16:26:25 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id F238D280070;
        Tue, 17 May 2022 16:26:24 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH v3 0/6] hwmon: pwm-fan: switch regulator dynamically
Date:   Tue, 17 May 2022 16:26:14 +0200
Message-Id: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com>
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

this is a new version for supporting switching off the pwm-fan regulator.
This time it is split into several smaller patches for ease of review.
Some organizational changes are inspired/copied by/from pwm_bl.

One big drawback form v2 was that there was no distinction bewteen when
PWM duty == 0:
* keep PWM on inactive level enabled (regulator as well)
* disable PWM and regulator

This is accomplished by using HWMON_PWM_ENABLE attribute. Documentation is
added accordingly.

Best regards,
Alexander

Alexander Stein (6):
  hwmon: pwm-fan: Refactor fan power on/off
  hwmon: pwm-fan: Simplify enable/disable check
  hwmon: pwm-fan: Dynamically switch off regulator if PWM duty is 0
  hwmon: pwm-fan: Remove internal duplicated pwm_state
  hwmon: pwm-fan: Move PWM enable into separate function
  hwmon: pwm-fan: Add hwmon_pwm_enable attribute

 Documentation/hwmon/pwm-fan.rst |  10 ++
 drivers/hwmon/pwm-fan.c         | 263 ++++++++++++++++++++++----------
 2 files changed, 191 insertions(+), 82 deletions(-)

-- 
2.25.1

