Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7346B49B764
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 16:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbiAYPPL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 10:15:11 -0500
Received: from mail.schwermer.no ([49.12.228.226]:55532 "EHLO
        mail.schwermer.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581762AbiAYPNJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jan 2022 10:13:09 -0500
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1643123560;
        bh=jM8o6eM64PjURR0dUNF3xHtDmhDJyXpH8YKgGvCyKyA=;
        h=From:To:Cc:Subject;
        b=MdoSkdqo1OcmJOtay8dx8WFtFari6GCxFeKJJ8Qi5DevpDXmEfltxhYTA2y757XsH
         WUsgs26GQK95nswaWDEyAJmvMx4OuzSHQ9aVDq1+xZlL/vvnE2zohBohfOmn8919g0
         +0BWAVTe7QaEYyQpxCrBgwtmZ+9EE7goMB7kRP+m/YS4B/PyapzHTUT//zDQKlYv81
         Sk85na8T/XCeNQZyInW2pP7wQ9u1pTs66q52nCIKzyRieFb37v9wkZ8xy7Uod+yzCh
         05fP8KwhRjlnhB6E+/Bo8uruPAlXE6q+1UNkvRVdlv+SGhpCLNZJIQpJ4uAa9GBq7R
         Zso3K5euMaNlA==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, post@lespocky.de
Subject: [RFC PATCH v2 0/2] Multicolor PWM LED support
Date:   Tue, 25 Jan 2022 16:12:24 +0100
Message-Id: <20220125151226.31049-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

Hi,

As previously discussed [1] on the linux-leds list I am missing
multicolor PWM LED support. In the mean time I have put together a
working prototype for such a driver. This is my first Linux driver
so I'm hoping for some feedback. Here are some questions that came up
while putting this thing together:

  1. Currently, the max-brightness property is expected as a property to
     the multi-led node. That seems consistent with the existing
     multicolor class code, but I'm wondering whether it would make
     sense to have a max-brigthness for the individual LEDs as well?
  2. The current multi-led node definition calls for a node index which
     would in turn require the reg property to be set within the node.
     In this context, that doesn't seem to make sense. Should this
     requirement be lifted from leds-class-multicolor.yaml?
  3. I'm not currently reusing any leds-pwm code because there aren't
     too many overlaps. Does anyone have suggestions what could be
     factored out into a common source file?

I would appreciate if anyone would test this code. It runs on my
i.MX6ULL-based hardware.

Best regards,
Sven

[1]: https://www.spinics.net/lists/linux-leds/msg19988.html

Sven Schwermer (2):
  dt-bindings: leds: Add multicolor PWM LED bindings
  leds: Add PWM multicolor driver

 .../bindings/leds/leds-pwm-multicolor.yaml    |  76 ++++++++
 drivers/leds/Kconfig                          |   8 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-pwm-multicolor.c            | 184 ++++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
 create mode 100644 drivers/leds/leds-pwm-multicolor.c

Interdiff against v1:
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
index 8552a5498bdd..b82b26f2e140 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -14,7 +14,8 @@ description: |
   LED using the multicolor LED class.
 
 properties:
-  compatible: pwm-leds-multicolor
+  compatible:
+    const: pwm-leds-multicolor
 
 patternProperties:
   '^multi-led@[0-9a-f]$':
@@ -34,10 +35,12 @@ patternProperties:
           color:
             $ref: common.yaml#/properties/color
 
+        required:
+          - pwms
+          - color
+
 required:
   - compatible
-  - pwms
-  - color
 
 additionalProperties: false
 
-- 
2.35.0

