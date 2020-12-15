Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6497A2DB5E3
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Dec 2020 22:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgLOV3s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Dec 2020 16:29:48 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:54830 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730147AbgLOV3s (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Dec 2020 16:29:48 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id E8BA2C727E6;
        Tue, 15 Dec 2020 22:28:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1608067736;
        bh=SuRgUbmM3WsZ//QTtGwNoF7K88+t82tTtJm/pM9SDgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3+mnwXmomz5fPSVOTyVDgkesmWUhkNSAl59P00J2hsT3cxJX5nOx3iwc1aZUDTWw
         /iGFrJ9o5FHJ7CtpYk1i9+YmzW49+Rj02zJgrdQOliAfsVZcwYqsIgzd0GokYEUJaz
         tyrrLZyG3G1BtIA0qylK0nXn2KlKqqev4eQ61mwQ=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v5 6/7] dt-bindings: pwm: pca9685: Add nxp,staggered-outputs property
Date:   Tue, 15 Dec 2020 22:22:27 +0100
Message-Id: <20201215212228.185517-6-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pca9685 driver supports a new nxp,staggered-outputs property for
reduced current surges and EMI. This adds documentation for the new DT
property.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
index f21b55c95738..fafe954369dc 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
@@ -12,6 +12,8 @@ Optional properties:
   - invert (bool): boolean to enable inverted logic
   - open-drain (bool): boolean to configure outputs with open-drain structure;
 		       if omitted use totem-pole structure
+  - nxp,staggered-outputs (bool): boolean to enable staggered output ON times to
+				  minimize current surges and EMI
 
 Example:
 
-- 
2.29.2

