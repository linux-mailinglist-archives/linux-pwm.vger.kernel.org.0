Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8E378ED4
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhEJNcE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345911AbhEJMZ5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 08:25:57 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E0C06138A
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 05:18:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:f937:4595:45ff:bcbf])
        by baptiste.telenet-ops.be with bizsmtp
        id 30Je250094jQ7kl010JexR; Mon, 10 May 2021 14:18:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lg4rt-004QlC-K0; Mon, 10 May 2021 14:18:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lg4rs-00HQPg-TJ; Mon, 10 May 2021 14:18:36 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] dt-bindings: renesas,tpu: Improve and json-schema conversion
Date:   Mon, 10 May 2021 14:18:33 +0200
Message-Id: <cover.1620648868.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

	Hi all,

There are two different device tree bindings defined for the Renesas
Timer Pulse Unit:
  - one for using the TPU as a PWM controller (used on ARM), already
    using json-schema, and
  - a second one for using the TPU as a clock source (used on H8/300).
The first has already been converted to json-schema.

This series improves the former, and converts the latter to json-schema.
As both bindings using "renesas,tpu", both bindings are marked with the
appropriate "select" logic, to check for the presence respectively
absence of the "#pwm-cells" property.

Changes compared to v1:
  - Keep additionalProperties, as pwm.yaml doesn't add any other
    properties,
  - Drop unneeded "'#pwm-cells': true" from "select" section in
    renesas,tpu-pwm.yaml,
  - Add Reviewed-by.

Thanks for your comments!

Geert Uytterhoeven (2):
  dt-bindings: pwm: renesas,tpu-pwm: Improve json-schema
  dt-bindings: timer: renesas,tpu: Convert to json-schema

 .../bindings/pwm/renesas,tpu-pwm.yaml         | 26 +++++++++
 .../devicetree/bindings/timer/renesas,tpu.txt | 21 -------
 .../bindings/timer/renesas,tpu.yaml           | 56 +++++++++++++++++++
 3 files changed, 82 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.yaml

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
