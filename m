Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2816E100161
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 10:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfKRJhp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 04:37:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41068 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfKRJhp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 04:37:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so17114261wrj.8;
        Mon, 18 Nov 2019 01:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4Tb0ttRFw3t9sd1seO7iOyRmoHtxz8QiDipOLgYhfk=;
        b=FmvVPxyz08Mlj9wlduT6LqMYYoow9iMU/3r91mZeSctNWMvPocJs0gi4Wbv6VQRbJq
         0yZ8L+WlEbsQNvNDOSjl6zY8wE6yVLgpNE0wpTEDoQk3KsN6wpHjwYRyzhBmxCPQLByK
         SYZlG9zAM1tWQ0DwN40kXtQMYfGhIa95qzNH+C5d7Y0h5KZyL3/wVb6YjkiHe4yvNz87
         C71Lqiuwx6ho3IoMjZ0SIk97dDv1gIO3rwO80MOgp4lXyb4rhP1Q+6mzmuNGfKaSacO3
         SnSQ5gSWP/wYu/9wFex2cY4Rstd6jtcbBsCiizOgKUvkqsJzB8RQgk1M45SgwpU2cWVD
         a+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4Tb0ttRFw3t9sd1seO7iOyRmoHtxz8QiDipOLgYhfk=;
        b=DdXsprCsLW666s/Wnwe7ZCdUmNoQvYiJyuosN2pLwuscCWtGPGoLbq84iSuGLMUJYh
         EIZJnupt2oUWMY5YEFpaIKFVdJyStreOfgQ7KszrCfvxnSE68AsOm4206EUsvVuwiS00
         8CVo8HxI8ZhTDorwUJyn7zwsu4syZR4Q8ClkPVY7gHNnrjRb+UJ0hrri92UJZvrwAMdu
         H6F0Ak2Nup1/+Rig5f/NQW42Ssj1ccyQopwZsXa8k2yy0CXI4EZWYROPP4LIs/t9WbFH
         1f+Ee88Sg2mG9E3bqpxsWB1VHZIS4arKMpPtAVfvfa6Yjil8FFHb8moG5rS2g+gYPUTJ
         bNzg==
X-Gm-Message-State: APjAAAWO/S9ZQbNp7UQZaAAQIeUCjpxip5DGaVuE71TFIRfBmyBwzMKZ
        OHtvUXmtQGc6P/9lo7+he20=
X-Google-Smtp-Source: APXvYqzRNbzUzZKuGwQfxwmU1oQitUxKl4bqL0I3wGCiiaEg2GGL/i9UBvMgZ1g7TiPtHWPMnDD/+g==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr28757517wrp.5.1574069862352;
        Mon, 18 Nov 2019 01:37:42 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id w10sm19006687wmd.26.2019.11.18.01.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:37:41 -0800 (PST)
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
Subject: [PATCH v5 0/8] Add support for H6 PWM
Date:   Mon, 18 Nov 2019 10:37:19 +0100
Message-Id: <20191118093727.21899-1-peron.clem@gmail.com>
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
  pwm: sun4i: Prefer "mod" clock to unamed
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

