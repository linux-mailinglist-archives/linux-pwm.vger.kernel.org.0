Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C996E4F77CC
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Apr 2022 09:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbiDGHla (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 7 Apr 2022 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbiDGHl0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Apr 2022 03:41:26 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389193A183;
        Thu,  7 Apr 2022 00:39:16 -0700 (PDT)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1649316786;
        bh=m7FmN16Crg0ON5yyzvdf4vfS/4Bi4srvHiA53HG7nKk=;
        h=From:To:Cc:Subject;
        b=iLlrC08FQrZURBEXBxuxsctKfPsLtw0NEAQSnysya9hcol1eaWwF/0EsVZrxAddhl
         YZWuJJ/ATMTy5RX4XuCpGSdgvu9YG00u47DuFZKwUbAPq4ROe++cR8qA/3HrAfkPp0
         1KuYHvFUs1a90SZW3262zHZZMfzG0g58nFm+Ktg/cQl6rFyQzziX4ftgF5yaQh+LiI
         kWvDCDSMUf2GxRRLggp4Co/g/BPke4orZUC4e9rRRG+YsC2EXIHzD+wxkdYiCOaJvl
         RKSmHXdj4ET4rJwyv70ft7AYnS2vplDmnH6xfthdlhzSsIjTd69k6/cnvLcnBaQtZx
         OIYK51m+CaHFg==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: [PATCH v8 0/3 RESEND] Multicolor PWM LED support
Date:   Thu,  7 Apr 2022 09:32:22 +0200
Message-Id: <20220407073225.71605-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

