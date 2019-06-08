Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C109B3A0F8
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfFHSGg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:06:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40670 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfFHSGg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so5211164wre.7;
        Sat, 08 Jun 2019 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuUE0MVJ4EiDj/R4+UJN1pSKA+Jns9ufEuzEwI3ecfc=;
        b=NMBwiOLIzdn0IuBMvEJo7m9mr0pup/SZfwc+LTYFylMBWek4k8fb/5oanI2zRZVyVG
         ++6Ci7cqfziSdlIXVJ1lmsoWd7srcHkQSeidh17/m0biXfhKzc0ZzkzLNvLvKwbGAlt0
         pp+Q0rCjF9NGdNpsTMu8Aq3JW9wW20otUvjOozfWEbLVFHJ93N5iBe+iJvc0XSvqXsua
         cmJUDYo90rhfxOM1kisxWWpywnzVeJfanShGdBuJP5tweH+Wr5xj9Vbholo7DgBQosov
         oF/iANPXLGa0UGR2SSArlAedGXOI6Z6dZanjTU5xEgCttjydEeHf7NneO3yZRRNetn/z
         ERBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuUE0MVJ4EiDj/R4+UJN1pSKA+Jns9ufEuzEwI3ecfc=;
        b=i8p+PruyRP0T4c5fObsD9ZzPprZ94W/DAc9deBNJJugEZ5GwAXngUmhVP/ECq19mlj
         VZgyfaLKU9owrldnEzpA8YIpIMgQvXQwhMM9PtQ3sKdnqbg0Kl8o5eGDZmOIRHAprowo
         uBVmvNvnUh3XP5IzAamX+D6JNHsluwt+d0JBj33kqwgps71zM8O6wzvC2wva6v5bT7hQ
         Mp64X90ju6uv6fpYN8U1xUBQQcVUeTFOj/9DfT20SV58lk3EINekHd4E8197o8my+1EL
         6kh/Gx+5X/Obmy5cnjoXyd/0yiRJQUJ3WgiSwV7bL2xUMFX3YJgufoVUVXn35dSig5FW
         lChA==
X-Gm-Message-State: APjAAAXm9bJ7TphI72PCaPUtWzlvaJeS970C1XxgCwuAp/2KNckn3buF
        SFQTX8FqsCefcuynpxZvF+g=
X-Google-Smtp-Source: APXvYqy3O37+yFg/dRFn1re7VJBCjQhw131ukejmKTFgVlkkAI9DNI/H+HB3d7RDWFCQTx4maYTgYg==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr22980982wro.162.1560017193772;
        Sat, 08 Jun 2019 11:06:33 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 00/14] pwm-meson: cleanups and improvements
Date:   Sat,  8 Jun 2019 20:06:12 +0200
Message-Id: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series consists of various cleanups and improvements for the
pwm-meson driver.

Patches 1 to 6 are small code cleanups with the goal of making the code
easier to read.

Patches 7 to 9 are reworking the way the per-channel settings are
accessed. This is a first preparation step for adding full support to
meson_pwm_get_state() in the pwm-meson driver. Patch 7 makes struct
meson_pwm_channel accessible from struct meson_pwm because
meson_pwm_get_state() cannot use pwm_get_chip_data(). Patch 8 removes
redundant switch/case statements and ensures that we don't have to
add another redundant one for the upcoming full meson_pwm_get_state()
implementation. Patch 9 gets rid of meson_pwm_add_channels() and moves
the pwm_set_chip_data() call to meson_pwm_request() (like all other PWM
drivers do - except two).

Patch 10 is based on a suggestion by Uwe to simplify the calculation of
the values which the PWM IP requires. The nice benefit of this is that
we have an easier calculation which we can do "in reverse" for the
meson_pwm_get_state() (which calculates nanoseconds from the hardware
values).

Patch 11 implements reading the period and duty cycle in the
meson_pwm_get_state() callback.

Patch 12 removes some internal caching which we don't need anymore now
meson_pwm_get_state() is fully implemented. The PWM core now takes care
of not calling pwm_ops.apply() if "nothing has changed".

Patch 13 adds support for PWM_POLARITY_INVERSED when disabling the
output as suggested by Uwe.

Patch 14 completes this series by adding some documentation to the
driver. Thanks to Neil for summarizing how the hardware works
internally.

Due to the changed PWM calculation in patch 10 I have verified that
we don't break any existing boards. The patch itself contains two
examples which show that the new calculation improves precision. I
made screenshots of the measurements in pulseview [0] for the second
case ("PWM LED on Khadas VIM"):
- old algorithm: [1]
- old algorithm: [2]

Dependencies:
This series applies on top of Neil's patch "pwm: pwm-meson: update with
SPDX Licence identifier" [3]

Changes since v1 at [4]:
- fixed MESON_NUM_PWM vs MESON_NUM_PWMS typo in patch #7
- add another example to patch #10 where the pre_div has changed with
  the new calculation. the generated PWM signal is still the same as
  measuring shows
- added Neil's Reviewed-by's and Uwe's Acked-by (thank you!)


[0] https://sigrok.org/wiki/PulseView
[1] https://abload.de/img/old-algormjs9.png
[2] https://abload.de/img/new-algo4ckjo.png
[3] https://patchwork.kernel.org/patch/10951319/
[4] https://patchwork.kernel.org/cover/10961073/


Martin Blumenstingl (14):
  pwm: meson: unify the parameter list of meson_pwm_{enable,disable}
  pwm: meson: use devm_clk_get_optional() to get the input clock
  pwm: meson: use GENMASK and FIELD_PREP for the lo and hi values
  pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
  pwm: meson: don't duplicate the polarity internally
  pwm: meson: pass struct pwm_device to meson_pwm_calc()
  pwm: meson: add the meson_pwm_channel data to struct meson_pwm
  pwm: meson: add the per-channel register offsets and bits in a struct
  pwm: meson: move pwm_set_chip_data() to meson_pwm_request()
  pwm: meson: simplify the calculation of the pre-divider and count
  pwm: meson: read the full hardware state in meson_pwm_get_state()
  pwm: meson: don't cache struct pwm_state internally
  pwm: meson: add support PWM_POLARITY_INVERSED when disabling
  pwm: meson: add documentation to the driver

 drivers/pwm/pwm-meson.c | 323 +++++++++++++++++++++-------------------
 1 file changed, 169 insertions(+), 154 deletions(-)

-- 
2.21.0

