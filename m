Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151C3F425E
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 09:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfKHIpa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 03:45:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46172 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfKHIpa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Nov 2019 03:45:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so5994192wrs.13;
        Fri, 08 Nov 2019 00:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UccqdAo7IzTySK8qOn69qu7ZemSz3pumZu0giDZZJwo=;
        b=K10lBDF86jhAbsnP8e8+0nSjnntCeKbSBeQFsQzCp/EA9baVgT/YVAObcTj9cWg0OT
         jx47faUrEInGiWGQSYjuPB6QI1UvstNvXEwPyj8HsAgO1ugv98Md1F8O0MNbsY2MAQ3B
         ZVhEqu8OAgf8TFdPp9AgF9ETBcesWuqTf7tQFxvw7jzP2yaSyotpD/kYm2MUgJdZhCQX
         1AaPnQBpOfOU/CP7Jfm9QJQhZFC6ka0gsgqupVri1pt28ClUX46023aAZJaWyuAhT9EU
         2gpTs5FLkiosRlipaMZLpoRsi2xSVBFXnZUDjyg2jxHi+nWuVRq6wLvz/00itjIdE+6+
         Szyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UccqdAo7IzTySK8qOn69qu7ZemSz3pumZu0giDZZJwo=;
        b=qoFyhpD4R0s9Gb+Xbm+dlX6gH5hk2vBXV3yxRW9RYNAHez5veMssd95vuwVSkTq/Go
         KsStXZl7zV1DAw5tlbwsThzNR69Dm4d4iSlWgMo5cUWeUzCif4/GtxUJzHM7ZFB69uif
         ALeqsqyTBnjRfYJg1YX3km4h7DhNGejJMvYhzE57SLITmuWs5A1n9hI+98wMrrlo7Mw4
         u+aILGh198Ldw/UVqySaOnl6wyAWC/Cm7a3ELCEqLeFhD424+mjqQSoiImeGelU1hj1p
         uMeWxz4VYF3d2YELoJkUX/Q4nPQiRHVf4z7hzpQ8KQw76enHAY6ESzxRHL0kU2qjYszE
         KJmg==
X-Gm-Message-State: APjAAAUMEZ+E3j04GnglN7lDke62jFgTZnSTRQu1qTH5Gg9hXETTWa6k
        RqX/jmumOjM6Gj6ciZf6q0ARRYQZql0=
X-Google-Smtp-Source: APXvYqx/VYVdaEqy/uX0bU25eMMBLjAK414GzcQgZQ89vJt416EBAVbdEQj35KuQhYHS3OeavYucNQ==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr7385835wrp.296.1573202726832;
        Fri, 08 Nov 2019 00:45:26 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id q25sm6662665wra.3.2019.11.08.00.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:45:26 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 0/7] Add support for H6 PWM
Date:   Fri,  8 Nov 2019 09:45:10 +0100
Message-Id: <20191108084517.21617-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

This is a rework of Jernej's previous work[1] taking account all the
previous remarks.

Bindings is still strict but probe in the driver are now optionnals.

If someone could confirm that the PWM is not broken, as my board
doesn't output it.

I didn't add the acked-tags as there are big changes.

Thanks,
Clément

Jernej's cover:
Allwinner H6 SoC has PWM core which is basically the same as that found
in A20, it's just depends on additional bus clock and reset line.

This series adds support for it and extends PWM driver functionality in
a way that it's now possible to bypass whole core and output PWM source
clock directly as a PWM signal. This functionality is needed by AC200
chip, which is bundled in same physical package as H6 SoC, to serve as a
clock source of 24 MHz. AC200 clock input pin is bonded internally to
the second PWM channel.

I would be grateful if anyone can test this patch series for any kind of
regression on other SoCs.

[1]: https://patchwork.kernel.org/cover/11061737/

Changes in v4:
 - item description in correct order and add a blank line
 - use %pe for printing PTR_ERR
 - don't print error when it's an EPROBE_DEFER
 - change output clock bypass formula to match PWM policy

Changes in v3:
 - Documentation update to allow one clock without name
 - Change reset optional to shared
 - If reset probe failed return an error
 - Remove old clock probe
 - Update bypass enabled formula

Changes in v2:
 - Remove allOf in Documentation
 - Add H6 example in Documentation
 - Change clock name from "pwm" to "mod"
 - Change reset quirk to optional probe
 - Change bus_clock quirk to optional probe
 - Add limitation comment about mod_clk_output
 - Add quirk for mod_clk_output
 - Change bypass formula

Clément Péron (1):
  [DO NOT MERGE] arm64: allwinner: h6: enable Beelink GS1 PWM

Jernej Skrabec (6):
  dt-bindings: pwm: allwinner: Add H6 PWM description
  pwm: sun4i: Add an optional probe for reset line
  pwm: sun4i: Add an optional probe for bus clock
  pwm: sun4i: Add support to output source clock directly
  pwm: sun4i: Add support for H6 PWM
  arm64: dts: allwinner: h6: Add PWM node

 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  48 +++++++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   4 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 ++
 drivers/pwm/pwm-sun4i.c                       | 134 +++++++++++++++++-
 4 files changed, 192 insertions(+), 4 deletions(-)

-- 
2.20.1

