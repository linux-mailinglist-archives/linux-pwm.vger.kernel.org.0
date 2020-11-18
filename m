Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8802B834C
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgKRRpj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 12:45:39 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:53858 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgKRRpi (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Nov 2020 12:45:38 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id B5153C6866D;
        Wed, 18 Nov 2020 18:45:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1605721536;
        bh=vfy6iH8njtY0puGVd8sfT1IejW8lXGG1Yz4/aftKfdA=;
        h=From:To:Cc:Subject:Date:From;
        b=uTd5U6zLiXwYzx+zry2j4cevcaZXoQS4LEYOwtWPAbok8oIOgNpk0zqMN82S6cN9r
         +Sf5obKvljuNdMBxfPd5+bFs8puGT79ehO8eNObpD4WB7ALyTaRVNRQXSCkRWPVKCW
         YPZNSHEEpyEwsyYEFQ/DEywRn3RtslAHX7iwWb2g=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH] dt-bindings: pwm: pca9685: Add staggered-outputs property
Date:   Wed, 18 Nov 2020 18:45:15 +0100
Message-Id: <20201118174515.278067-1-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pca9685 driver supports a new staggered-outputs property for reduced
current surges and EMI. This adds documentation for the new DT property.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
index f21b55c95738..911bbb65984e 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
@@ -12,6 +12,8 @@ Optional properties:
   - invert (bool): boolean to enable inverted logic
   - open-drain (bool): boolean to configure outputs with open-drain structure;
 		       if omitted use totem-pole structure
+  - staggered-outputs (bool): boolean to enable staggered output ON times to
+			      minimize current surges and EMI
 
 Example:
 
-- 
2.29.2

