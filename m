Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E101F105AB4
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 20:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUT7M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 14:59:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34369 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUT7M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 14:59:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id j18so8540092wmk.1;
        Thu, 21 Nov 2019 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEHAUzD9B/6AoeSWvZc7hvkK4ObltWVKU4PeW75EXHE=;
        b=dyoMamB9KK7VtbcqWyXyjklzKJdIjCkkQpwvWp0yExtoeLYWENnSnOdSn7VlI6AUyL
         ewvhFxnmzz12sBDFGACCusAMTa1Urm1YdMOcpLgOV4JsmO7r+ur98dyVpFebrVfuGlih
         Ijf36Sa4DH96Ua46PCr2093urnpq7fZnEROIizpMCurjKu4OnHt8JSsStdBvO8kaqFTE
         jx4LAiPnT1bYzHn/YLMZ30SrB+A9jUtJl7P9F9SpdX4KmYaaz+0o9z86km1uycgGwxsJ
         Y9BJsfvLWmTNUrCdw3jwVT8lDnZiNse2gP3DzGx1Rte/nEYR6fXAVs0WiolaLVe5c8TP
         NDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEHAUzD9B/6AoeSWvZc7hvkK4ObltWVKU4PeW75EXHE=;
        b=DXvJplHnsCNxnZCqJE/wVDQMc/AUmC10tKKneblB4O7Ep86YR2gA0I25+Pv4yOWHdY
         bQj6eMFl0DhOjV0VHcQdD/YkAtyRF9EsbXEIpne68euFtKlrU91CWz5eG3C6yTm4XPd8
         spC1pH9yDRam6GeSjfCQZps6o05s3GVypgc+G5+w/l9uI5Z4x5oP/Wjk5Nkn8Cia288q
         Doh+c0dx7aPsOutil9Igx/EfuT9zMQ6E0V/KdhWBSZRziQbWg9jfH4TXuTJtWCdtzW+N
         HGa9W113lMPr1qmq22Iy3UuKUlrlx5Lv75D0osOEqtEw+fzJ78HvGFBOX5uNUDKOr9gP
         YZxQ==
X-Gm-Message-State: APjAAAUSZfLFmX/oqV0mlqAjUSE0bPNu8PfHVnhTIpnj0EEM6yOgYcWi
        ZzG060WmOC6Xbwo1s2jKcA8=
X-Google-Smtp-Source: APXvYqwf6osdAeqnz19E7fQNOOeiKMEOfYyQ/BPJ4UDiWPrxD5qp/ZuY3M+bkrrRNeUWprmULBS34Q==
X-Received: by 2002:a05:600c:2919:: with SMTP id i25mr12050283wmd.158.1574366349212;
        Thu, 21 Nov 2019 11:59:09 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id l4sm747124wme.4.2019.11.21.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:59:08 -0800 (PST)
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
Subject: [PATCH v8 0/6] Add support for H6 PWM
Date:   Thu, 21 Nov 2019 20:58:56 +0100
Message-Id: <20191121195902.6906-1-peron.clem@gmail.com>
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

