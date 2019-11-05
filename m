Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1871EFE16
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 14:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbfKENPE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 08:15:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38329 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388710AbfKENPE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 08:15:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so15909105wmk.3;
        Tue, 05 Nov 2019 05:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hB9idhMU92erzOjHPvAXZpJsyvC0oNhoJYwou0xdu0U=;
        b=qp3ErZHJAeyuOjgXLsXiclttDh1bu5NEu4gH06hfC1IiApD6xVTSozILPEpnfN8wl/
         tPL03+8UuumFL0+ztAuQefhcHjbl2w05mugCn88UOR+iv7n2gAWsvIaxnxyNWSB83Wvo
         /q37kvvkPk85TjljzbfqLFrJQkl3+gVbUAgHldjh9mhWKnZN62oWLQ+KhUAR0Rx2FPwJ
         k04cjIAyJBJssoAJsKYuENbrq+/HHC7ssiy+aL1YHwjWlDPReFAUtw22/X0Xu1Fzg1/g
         bQs8hEUavRZ3cUKucaqtFU7Gfr0zWdKm0Ejt7VjDb7EJEzcGc0Tv//kJH277DeCLZ9lR
         HzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hB9idhMU92erzOjHPvAXZpJsyvC0oNhoJYwou0xdu0U=;
        b=cRNed3CMqQiEyPkhm7fhnEFUq865tksbasU8EOKKPE/kdxSpbjK8j76ugTgtfL+b9I
         wjo0l8HHeF51ilran1GdPS1CYk9tZxqtDGS0+WfE6Ub497rw+g33MCyhmaDr6CVPeGpc
         TezTUYqkh3WVU1s+Cxe5LBU1EFm2ZS/4EHvKqFi673Y2U3XcjhQntWDNxw0/FzMQjRT1
         4JVKKUzsIi5kwX74kUpy1qZOkr+6fQSdcPDGzAD3pZV9xhXh9+8Ay4sIcVnNEyzECRTv
         aat/urcqgjaJCsH+nKoJ3VZnVuykl3uY8Z15pOfbj3yF8fYcBbigOi2yKvFO4+WXOaF8
         K4XA==
X-Gm-Message-State: APjAAAU6UHOyZ58+iGdM65prJupzTqJBj+oUMrx8FWexMvbuwnefBr1Q
        qZ5VAr0bLzdoFq1L3VzENkY=
X-Google-Smtp-Source: APXvYqwhThzYPU8gc+woRw9eFxl7hLqV3HWnaePcB1PbrFUfvPY/cSrHYTH4eVBp5kVN6u0SN9ZXNg==
X-Received: by 2002:a1c:cc16:: with SMTP id h22mr4454762wmb.51.1572959701254;
        Tue, 05 Nov 2019 05:15:01 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id a6sm13549920wmj.1.2019.11.05.05.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:15:00 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 0/7] Add support for H6 PWM
Date:   Tue,  5 Nov 2019 14:14:49 +0100
Message-Id: <20191105131456.32400-1-peron.clem@gmail.com>
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

 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  47 +++++++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   4 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 ++
 drivers/pwm/pwm-sun4i.c                       | 125 +++++++++++++++++-
 4 files changed, 181 insertions(+), 5 deletions(-)

-- 
2.20.1

