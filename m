Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC66355970
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346560AbhDFQny (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346562AbhDFQnv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 12:43:51 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD1C061756;
        Tue,  6 Apr 2021 09:43:43 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 3ADEEC6AEEE;
        Tue,  6 Apr 2021 18:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617727422;
        bh=YBVJEd4u8lXZ2VS38cZjFNDqDt6p6/zLjW/nqtuCXBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEkplOgdRYf1MjYWcSAvqpiTRHJ9/EoealVw801SqqT770q/pyWXJKboBIwLhHnZ9
         klLrmVvtoRKmRYi39sFGXqBYfWtXxDdhyHDrbtGmt7bsx4TyeBTnY+m/UvVbrTsA5E
         W1frFFSmT57BFbNiJDyLUoGeiI67i5JZ79QS0dDo=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v7 4/8] dt-bindings: pwm: Support new PWM_STAGGERING_ALLOWED flag
Date:   Tue,  6 Apr 2021 18:41:36 +0200
Message-Id: <20210406164140.81423-4-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the flag and corresponding documentation for the new PWM staggering
mode feature.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
 include/dt-bindings/pwm/pwm.h                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 084886bd721e..11d539302398 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -46,6 +46,7 @@ period in nanoseconds.
 Optionally, the pwm-specifier can encode a number of flags (defined in
 <dt-bindings/pwm/pwm.h>) in a third cell:
 - PWM_POLARITY_INVERTED: invert the PWM signal polarity
+- PWM_STAGGERING_ALLOWED: allow delayed ON-time for improved EMI
 
 Example with optional PWM specifier for inverse polarity
 
diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index ab9a077e3c7d..51d67dec1aad 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -11,5 +11,6 @@
 #define _DT_BINDINGS_PWM_PWM_H
 
 #define PWM_POLARITY_INVERTED			(1 << 0)
+#define PWM_STAGGERING_ALLOWED			(1 << 1)
 
 #endif
-- 
2.31.1

