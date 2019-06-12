Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB5A43080
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 21:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbfFLT7d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35821 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388521AbfFLT7c (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so7784922wml.0;
        Wed, 12 Jun 2019 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSCXfO4SZrHlREdSSaw8mmXbrGugYj3k3dCGPOAQii8=;
        b=b5yvmRACWpqZ/mN/ykGbaGobmJoGlHZekESdaJ+IMrlyyO486QMrsD9N2cimWIO4dG
         Kq+tWdh2lksKWf5OOkGBv8kWpJtVTyYTxgO5jkGDcfD3zruKUO/v+Y6hTLzpMZ3sD4jI
         3eIvzVe7KE5gFjV57z7PQ53N9aaJRubZLPgVENh/O079qENraDUMbkWeMnLZRCAZSlaR
         i7AJIZ5lJc/a+FysvG/zS0quCQKlZfchyH4/9CiNF4EhIELK80/GqmMomPJAqhSxAStJ
         RQYLZpsXBIEW2BTaYaj6aAbYNDwTNRxCkc8ke5VpzvkcTKKZKlmlEkfMAl+jm/1+vjPs
         UE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSCXfO4SZrHlREdSSaw8mmXbrGugYj3k3dCGPOAQii8=;
        b=rFvNQtoup7LzYQd4RO4J4AM4jEeVUE31PInxbXmCxOawcCRjk8zAjizePxQ7BD2ryN
         nuZUwcMk1VV9atT9DxsfSaongnGFaHEqqgFciVwIZaibAKaPxr3sJDECr2lWJcz+bl0L
         gsEcbMx+kBFosXMWIrOtbsZkSpR8WbX6EKA4JqlwaDf1Kj2Bk7g3ylxk0yKp1rtIMe2Q
         6FtgslkkLm/AvChXZhhI7lq1EIRXs51uqfNDEJ2XvpwRUf+fFHnHVYwN9o/UnEH2nKTt
         0qmujLbYIoycFf++YHMSVO6q5EkPdVMkhdYtGgIx4CBuqqD9DDURaiVQA8qWSVQAkS6+
         oZsQ==
X-Gm-Message-State: APjAAAW+pi6ycrnIpO5RiISG+W/FBcCZOq7MlgZLTxijW3JmiQZTij+G
        sOLt7wpOu81vF3D9sMhUfVA=
X-Google-Smtp-Source: APXvYqxx6WQ0Q2TthI9hcw9mcaNNk72tal9lYxSvbzj/rzuhF1Bm90n0CNI5eUROu1nDamDovAo5Tw==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26mr601629wma.105.1560369569855;
        Wed, 12 Jun 2019 12:59:29 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:28 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 00/14] pwm-meson: cleanups and improvements
Date:   Wed, 12 Jun 2019 21:58:57 +0200
Message-Id: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
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

Changes since v2 at [5]:
- fix the SoC name in the documentation patch (#14). The link points
  to the S912 datasheet so we shouldn't call it the "S922X datasheet".
  Spotted by Chris Moore (thank you!)
- add the link to the S922X datasheet in the documentation patch (#14)
  because that SoC generation contains an updated version of the IP
  block with hardware support for "inversion" and "constant mode"
- put my Signed-off-by after all Reviewed-by/Acked-by to indicate that
  I was the one who put the R-b/A-b there (spotted by Uwe - thank you)
- added Uwe's Reviewed-by to three patches (thank you!)


[0] https://sigrok.org/wiki/PulseView
[1] https://abload.de/img/old-algormjs9.png
[2] https://abload.de/img/new-algo4ckjo.png
[3] https://patchwork.kernel.org/patch/10951319/
[4] https://patchwork.kernel.org/cover/10961073/
[5] https://patchwork.kernel.org/cover/10983279/


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

 drivers/pwm/pwm-meson.c | 327 +++++++++++++++++++++-------------------
 1 file changed, 173 insertions(+), 154 deletions(-)

-- 
2.22.0

