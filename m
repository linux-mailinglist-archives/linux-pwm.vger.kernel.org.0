Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2410844E
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2019 18:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKXRaB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Nov 2019 12:30:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34043 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfKXRaB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 Nov 2019 12:30:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so14725908wrr.1;
        Sun, 24 Nov 2019 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGgPipfEFZWFwRwOJjgrASaTd0TQYkmoA4Tjo4oBFUc=;
        b=vND+AQHeVrhINFZ4UDVHu58t/f+qBqUvbP7TqVB3/0goOOJCe8I2oR7GT1/p+RN5/E
         WxN2vQ9j0KfPfEYNuAPQT+kTxt6FE2XTlFQJLoH+FYwMyzX7bffYruhqjklwBb+arxjw
         KIW7ED5yJnXpGr5l3MX8b9v7xm4I4iwMtm1tw24mY4FoIk2ezPzNJ8s65Kz8iHRBcflm
         QbD/DCVmTfkob2TTDwsGfi4dBcoq7TOi2vwYgu1aO5sp1OaHiz15B62BK/PMVugLz15K
         zHo/qk/WgWPiG3Yc10JGL153B/mda+vShSnfzFKOOer5XG0NPWcq4+trXvs8yP/6UfmY
         jc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGgPipfEFZWFwRwOJjgrASaTd0TQYkmoA4Tjo4oBFUc=;
        b=UNl5T52rE61L6C2zRUmczgO5wlSNSw6JxWtliHkmfW/WVUgtCajaRIafbzFFRfpQNB
         yLDe7ycu05A0SrxH4EmXLf7/a7RDr66QWFUn38uYYylY+QNBthcm1Tq7IcFRATbxUhzC
         fE5X9/Wo8wE0tCG2fn89oG6DoWiM0xITGzK+QDMA66Jzdbw3mrJuWNVz0xOqepWBzebL
         necMO382KU1EmIoY9Z+PTMcqPyQcOX7o10aTc7vNXG8JxKM8JFSITvAs6s3zgHYNRNNF
         LngAOvpENbsik0bTD6Xo4fbxpybCpzqOf0Ss+aNw7O8DBPYC2hBayC5dgy+gwoQT1AzO
         h2Tw==
X-Gm-Message-State: APjAAAXnh02LVYlBX4MqIS824Ed1erLxJ221lPHI3f9iwQlsyTrPBiOA
        Jz4pQ1pWHXzSr7Zo8+dWfVU=
X-Google-Smtp-Source: APXvYqzCaeqjuWWepuHVZDNLDDp3b8VLbgpBzaodvuX34Rg653xyvG74z8MdFcuL0oOfDoO2AS4FHQ==
X-Received: by 2002:a5d:5484:: with SMTP id h4mr25794215wrv.136.1574616598780;
        Sun, 24 Nov 2019 09:29:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id n13sm5537275wmi.25.2019.11.24.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 09:29:57 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v9 0/6] Add support for H6 PWM
Date:   Sun, 24 Nov 2019 18:29:02 +0100
Message-Id: <20191124172908.10804-1-peron.clem@gmail.com>
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

Changes in v9:
 - print error code in error message
 - no capital letter to keep coherency

Changes in v8:
 - Display error return code
 - split commit
 - bypass is false if unsupported
 - return instead of goto

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
  pwm: sun4i: Always calculate params when applying new parameters

Jernej Skrabec (4):
  pwm: sun4i: Add an optional probe for reset line
  pwm: sun4i: Add an optional probe for bus clock
  pwm: sun4i: Add support to output source clock directly
  pwm: sun4i: Add support for H6 PWM

 drivers/pwm/pwm-sun4i.c | 187 +++++++++++++++++++++++++++++++++-------
 1 file changed, 156 insertions(+), 31 deletions(-)

-- 
2.20.1

