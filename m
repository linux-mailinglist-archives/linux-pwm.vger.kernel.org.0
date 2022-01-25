Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C064D49B0AA
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 10:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiAYJpM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 04:45:12 -0500
Received: from mail.schwermer.no ([49.12.228.226]:54038 "EHLO
        mail.schwermer.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573867AbiAYJej (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jan 2022 04:34:39 -0500
X-Greylist: delayed 669 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 04:34:23 EST
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1643102592;
        bh=UPIEjwpG8b9H+ydQhiaNdP/fk/iMS04+pE1EIuzjXBI=;
        h=From:To:Cc:Subject;
        b=fkleATCGg1CQLVO4S3Z9N8vwQe/goIUrKffLF1vULijFI1MiQUk4Af9Pq0aCDZx+t
         XamFRdQRkNWAMfMdOm9561OsEoyYLHZgUAPh+O8qSPw3KcZO0mVmLObi5cuOViUYWZ
         jCVX797bvp4yqrFYigyEEvTOvaMLabqf1cXmo8S2MpAKNACqU2id2CH/ayUVOFNg4E
         NtWYP90f/bROmRs0uJFORtz+fBh7Yq/bS8F/xPSMXTin79uwGy7514nJrEjHQswYGW
         fJZrKq72WNNab+SaCdd2fG2SdAEePTQ0135AJEGKkymfcDhdtPTsX/qnIQ2W4jGjh/
         +q4JlNnolqgmg==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
Subject: [RFC PATCH 0/2] Multicolor PWM LED support
Date:   Tue, 25 Jan 2022 10:22:37 +0100
Message-Id: <20220125092239.2006333-1-sven@svenschwermer.de>
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

 .../bindings/leds/leds-pwm-multicolor.yaml    |  73 +++++++
 drivers/leds/Kconfig                          |   8 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-pwm-multicolor.c            | 184 ++++++++++++++++++
 4 files changed, 266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
 create mode 100644 drivers/leds/leds-pwm-multicolor.c

-- 
2.35.0

