Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32282B0A3F
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 17:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgKLQjz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 11:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgKLQjy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 11:39:54 -0500
X-Greylist: delayed 109 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Nov 2020 08:39:54 PST
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E05FC0613D1;
        Thu, 12 Nov 2020 08:39:54 -0800 (PST)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id CEE40C7D0FD;
        Thu, 12 Nov 2020 17:39:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1605199192;
        bh=vfy6iH8njtY0puGVd8sfT1IejW8lXGG1Yz4/aftKfdA=;
        h=From:To:Cc:Subject:Date:From;
        b=Ac6FsiCRs/g3dyb5vtVFP7+61HHzwXWRVmJXyuzabPtaWf/mPdtu37iVruQQoauWJ
         8oMGK7O6j4NQy7LYr2lBEYf10us8d4Tcdr30/MWrepfWVhMPOU193R7brJiruhTa53
         xc0M8/UakYksHXvCoNabVAauOBnxdHzXpxKqMb5Y=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH] dt-bindings: pwm: pca9685: add staggered-outputs property
Date:   Thu, 12 Nov 2020 17:39:31 +0100
Message-Id: <20201112163931.204243-1-clemens.gruber@pqgruber.com>
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

