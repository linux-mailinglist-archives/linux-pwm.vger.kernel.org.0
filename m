Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786E33BFEE
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 01:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390716AbfFJXhp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Jun 2019 19:37:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45579 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390666AbfFJXho (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Jun 2019 19:37:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so3864056plb.12
        for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2019 16:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwvhwkI8F4zvLVsJwAGnKk3UZTvA+WVT+qCBY1uqWqg=;
        b=hijO8nHj6AanoC+to/aLESdGAjYajAq/Wwo6ROP8Jh065ysj+O/VWUY+CjGk1QGNLO
         Nzjj4CGR7IV5n0DZhEvJ8T9VttRm3HNbJ8f655p8CVolKCbEHYeRHF0Q7pT55hBt7oMM
         UA5ufOa5wv1gkQHsFvqsinxJo7kP1Tysa/l1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwvhwkI8F4zvLVsJwAGnKk3UZTvA+WVT+qCBY1uqWqg=;
        b=iN1uybs3/lsPNAjGiqeRT26m4IzqI7U80oYlcyedKck3U8+5SKt2ZpuNhdHKLk3s66
         Il4oQeCktSBjQbr7Oho036o6BXRGKVLuw/7pgWZrIpRzdSY6Xl8jD5mYVxw24OvnNsb/
         bjnaX3eSxiuKn06RIB78JGL9/i/7l8vElQaOY2tqFYS5Qpi8d1efna3VXeGMuvBCKT7O
         HbsSpqTPa7/GPzSDESAzepp07Qeq75nGnJ6pfiiUFHJf6j8QEDfBGAv32vfE+ZvgIONb
         ZKh/ifIjjhDDq6aTo9/wgvKjSEmDpzup9nRRr0UxwufMmajJ8z+WxPtmPVamX3Rbzfbf
         g8vQ==
X-Gm-Message-State: APjAAAXZskED4hyrcOdUdepdmH5zwq3HSoto4EIcw3TYTA43S6SFf8Dr
        4SycqF7AeB5NUDERjWE9HMXuOQ==
X-Google-Smtp-Source: APXvYqxzuWk+HHUFs0uzAZUj3UB9CiltN6z/LVO8neBboHeE9VutR2V17/0JmmVYiipinsqCD9j37w==
X-Received: by 2002:a17:902:7581:: with SMTP id j1mr72670630pll.23.1560209864163;
        Mon, 10 Jun 2019 16:37:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q144sm8898518pfc.103.2019.06.10.16.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:37:43 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness' property
Date:   Mon, 10 Jun 2019 16:37:38 -0700
Message-Id: <20190610233739.29477-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add an optional 'max-brightness' property, which is used to specify
the number of brightness levels (max-brightness + 1) when the node
has no 'brightness-levels' table.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
index 64fa2fbd98c9..98f4ba626054 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
@@ -27,6 +27,9 @@ Optional properties:
                             resolution pwm duty cycle can be used without
                             having to list out every possible value in the
                             brightness-level array.
+  - max-brightness: Maximum brightness value. Used to specify the number of
+                    brightness levels (max-brightness + 1) when the node
+                    has no 'brightness-levels' table.
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 [1]: Documentation/devicetree/bindings/gpio/gpio.txt
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

