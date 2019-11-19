Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E35E102B12
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2019 18:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfKSRxa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Nov 2019 12:53:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33733 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKSRx2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Nov 2019 12:53:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so3079718wmb.0;
        Tue, 19 Nov 2019 09:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rUwtSzPXTRcEUR7weY+64klnEjLlQGMUJOj+eZFoLpY=;
        b=WV2YmFq/1NqnLUrXwSeECTAhQndtc/FQ1Y0TJjLJTP7V6IATxEkFqu00exfnnXxb2/
         FG2PXwM2VCS7uY4/x8vz+mLEWUcGXFYGyL2b8nQNpgGz6ASMB3i8iQRHbDlBYvsn9iPh
         QCq3PzuReqaaJ/XbzM3GSSTIfw5X1UdXJF/hVjlGXMLPC0SYpSJWKLT6dG3bJ7GJzv47
         BTVDycl+qCcQ+n4yXOstNBOnDFAcC7X+Ny+nMnltQ2eztdjKkUKC0zgUprp6fOX2+59n
         i79L9CLOX0Pe+guZrPO1JpdFTLyMAN7v6QYssv0A/9+QRKz28Et7lJHQy2SaFi3lLLHn
         aszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rUwtSzPXTRcEUR7weY+64klnEjLlQGMUJOj+eZFoLpY=;
        b=Y6sTVf/8AvbhxVFNzltCmzH3yuSZt1loKcRcLRgHtcOIbSQjMjndI+Uqcd1O0mwvTl
         55X47iWzBdZITRN9ElMLoqX81Y8luP4qZjPFDPLV/TF77T/CnS6dNbzoTlaghjKSMSuf
         AxeaXHNkD6prWI4Mtj79FwBI1BSW5hm2eyv1BpZIgW34Z96Bo8z6ROTUYk+zDnLGFV32
         /LciyX3G9NWzF0628wM20+w2xxhPIc56S8KlIGSUB4qNGVCNkDspepH+pQsjVdqCJ/Ax
         ZWw7TtuwpXKAWlld1Ug2deEGzSD/cF/8V8KpVzKQoxfYxssRE3WCDcnO7YZM1BJxh1pi
         g7ZA==
X-Gm-Message-State: APjAAAXIGWbbGMkRzJASfkcrunl+1+2ijAFQRoOySfFSx9F2pxqHrsyz
        tyBzDB5cPX5rNM767OoQGCM=
X-Google-Smtp-Source: APXvYqwRygRbzbAUfcVeS+0wJOvcRhwtVsXt8DZUDn5OP2ZJRPfaOEWt3fbHlAVyMzU6EfJZg5G/Iw==
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr7624417wmi.40.1574186004594;
        Tue, 19 Nov 2019 09:53:24 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id l13sm3772618wmh.12.2019.11.19.09.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 09:53:23 -0800 (PST)
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
Subject: [PATCH v7 0/8] Add support for H6 PWM
Date:   Tue, 19 Nov 2019 18:53:11 +0100
Message-Id: <20191119175319.16561-1-peron.clem@gmail.com>
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

Changes in v7:
 - Fix indent in Yaml bindings

Changes in v6:
 - Update git commit log
 - Distinguish error message 

Changes in v5:
 - Move bypass calculation to pwm_calculate
 - Split mod_clock fallback from bus_clk probe    
 - Update comment
 - Move my SoB after acked-by/reviewed-by

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

Clément Péron (2):
  pwm: sun4i: Prefer "mod" clock to unnamed
  [DO NOT MERGE] arm64: allwinner: h6: enable Beelink GS1 PWM

Jernej Skrabec (6):
  dt-bindings: pwm: allwinner: Add H6 PWM description
  pwm: sun4i: Add an optional probe for reset line
  pwm: sun4i: Add an optional probe for bus clock
  pwm: sun4i: Add support to output source clock directly
  pwm: sun4i: Add support for H6 PWM
  arm64: dts: allwinner: h6: Add PWM node

 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  48 +++++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   4 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 +
 drivers/pwm/pwm-sun4i.c                       | 185 +++++++++++++++---
 4 files changed, 215 insertions(+), 32 deletions(-)

-- 
2.20.1

