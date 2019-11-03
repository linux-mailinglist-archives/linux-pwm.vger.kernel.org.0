Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF752ED498
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2019 21:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfKCUdt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Nov 2019 15:33:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34079 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfKCUds (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 Nov 2019 15:33:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so12955452wrw.1;
        Sun, 03 Nov 2019 12:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ml4/ldXuaRQFs9xTSFQLPpar7FuQY3/SbLZ03W92l0I=;
        b=m2CnugqT3ACAYmgD1Cjtv8ShPg2gnHMeL6ADrw+IxJXZnXvs+2YvxvraUH+x+ChuPw
         cD9xXN/XJOv4kSDXQ5A2dC+a/MpxBWnGYZvtmycVaMj7HtzNIQpNKdWlBcHRYBo7V6Is
         qscC1rtUfdz8citmpet4A1MxLR6PAgnXYG7uxtJOoQqcP+pD6L7XEZe0XOiVMgEjpapl
         zn4sDcEMULw9v+M2tBEFGkZGYFg1VhhYCLzDOUNxYMT25/XLf4/5q5VI+NeyoK+8CCMa
         IbEO1BoYBJpkYYbTPtZkeYa6o6GK6tmmFn5wm6W20NSV2VVLjxoVuz+x9lClnSUqlzCo
         zlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ml4/ldXuaRQFs9xTSFQLPpar7FuQY3/SbLZ03W92l0I=;
        b=ZyT+JjMepllH+furZ3z39PnDYhak5npGFFK2JtdCHt6ZT1335547NvwbBAbAvOZqK6
         scCGMR6Qh49ye0ogV+KwrnCcnXiUzlUdKVIFws1G/SHQ5hZokwKA4XnbikpzTJUSLmwB
         yyAusMBCuD0R96MN5w3ao8vMCjaRLR8e4+Rx+R3foBavFMU0/IvHSERodUwLsvJWSQQL
         jBsJYJ9pOsc1tdD76zwJF/lj6B542H7TD9fDKELqVcsuswIGjyrsZCWohbR/Q9DRmUIM
         uVigzUXL9LMYP7F66o0CAmtbWmeQEMYweMOo0UPK4rM4Eh5GI2K/BFlPP5W7xfRCI6Sv
         ZajQ==
X-Gm-Message-State: APjAAAVMWsey8Z+iEqhPKci++qocxqshJTxFhyzcoIdF6MutYcs9qQH1
        Ug4GCDR/UILN3OI4eeDj1n65YDjTI+s=
X-Google-Smtp-Source: APXvYqx+wOrdNP6iaYemu5Ag6rWAskgEk1/DDlhAjLULO3ca3go6P9wmGnBOY6scWrhWi34887aI3Q==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr20834900wrr.103.1572813225276;
        Sun, 03 Nov 2019 12:33:45 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id x16sm13644026wrp.91.2019.11.03.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:33:44 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 0/7] Add support for H6 PWM
Date:   Sun,  3 Nov 2019 21:33:27 +0100
Message-Id: <20191103203334.10539-1-peron.clem@gmail.com>
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

 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  45 ++++++-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   4 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 ++
 drivers/pwm/pwm-sun4i.c                       | 116 +++++++++++++++++-
 4 files changed, 171 insertions(+), 4 deletions(-)

-- 
2.20.1

