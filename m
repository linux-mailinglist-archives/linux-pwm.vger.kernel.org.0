Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622BE4C1C77
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Feb 2022 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbiBWTqp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Feb 2022 14:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiBWTqp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Feb 2022 14:46:45 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAC94B1F6;
        Wed, 23 Feb 2022 11:46:16 -0800 (PST)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1645645573;
        bh=m7FmN16Crg0ON5yyzvdf4vfS/4Bi4srvHiA53HG7nKk=;
        h=From:To:Cc:Subject;
        b=jDw+wZIqJZuSyJY0PH8m7wL0OrTN+BLXEotDQtpa5VfdDQIpksiE3FzUhIVtiGrOY
         4Dtjl6OE2dTcveV6eYjO+RapB+Gn6Creyx2u39MSOycZ6DaU+ab05aGRzw/EwGhfBv
         RF/GDwHx+Vol266NopSgA/xz8P5dZFgES5NtLBgliIBsRLKwHstUJyZ0ssMRa6kE/U
         nzf3L4QKK7uy7yZ2K/6SO4N2iY7if/hq8INIjuMh1cQGjjDO0X3c10BoMG4Lzmo9W0
         wZ0ziBaAu1eL41FxIv1rGSQeop2KdUT1DfcYg+qqUkPwHGHWN38cphlsdB2AcZBWPM
         GbAAKHLxhVbwg==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: [PATCH v8 0/3] Multicolor PWM LED support
Date:   Wed, 23 Feb 2022 20:45:38 +0100
Message-Id: <20220223194541.826572-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

Hi,

I believe this patch series is ready for merging.

Pavel, please let me know if you need more to get this merged.

Best regards,
Sven

Sven Schwermer (3):
  dt-bindings: leds: Optional multi-led unit address
  dt-bindings: leds: Add multicolor PWM LED bindings
  leds: Add PWM multicolor driver

 .../bindings/leds/leds-class-multicolor.yaml  |   2 +-
 .../bindings/leds/leds-pwm-multicolor.yaml    |  79 ++++++++
 drivers/leds/Kconfig                          |  11 ++
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-pwm-multicolor.c            | 186 ++++++++++++++++++
 5 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
 create mode 100644 drivers/leds/leds-pwm-multicolor.c

-- 
2.35.1

