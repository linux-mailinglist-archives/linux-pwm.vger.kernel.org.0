Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6830223DC8D
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgHFQxe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgHFQuu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 12:50:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1994C0086AD;
        Thu,  6 Aug 2020 08:32:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so3007121pjb.2;
        Thu, 06 Aug 2020 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=TA50xo6IgAS3A5s1Mvlt9oYR8AHuJvVW3cujvShV5qo=;
        b=AF76D/rBG8KAyZp1De3suMFBK6mnuxEvXmyhdAehl49Q0sq7qWHM9e3yYvbR8gfDtj
         BrtGeThHmyP29/lyc21TwqLBWzgMJEFyfnbeWWuiyt/Nvg2wiha8yIr04qU8aFKQC4RV
         d0BZ8HXsRJSpYL1QjZy1H1HJJsRuGwykKvFMsuC8b9RD3Jc2ThYvTCaAZsVy3+Yl3ENP
         8C1NCaVfp0yxiSJ/Rlm9kSBKHBfP+raHoq5cBTjZ7UEDI9r/uQah/NMFeHEMmmMNqk8b
         OXa+INZ2ENgVF/Ow+dNPZZEHQhbPKB/5ueyO9JpzUPMHPOMYwJ39x7vlFuhQP8R2GtNz
         Em6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=TA50xo6IgAS3A5s1Mvlt9oYR8AHuJvVW3cujvShV5qo=;
        b=ATgnz02f9/MhOP2YqZZh0NGYO8dFjM5TTqgl36nr12Gc6F+eqZtWgIqeGH+m507yYN
         7b0FUhPTkLAmRf3qlvmDx715iWrPtXuWtYkqsN3IiuDG/0SDGYvol6ks0RFL55pZwuWj
         an5z2qaXZ93usBnBStsKeUPncZwtnIna3w3So/pxK73yCLUgH5AntSL2UrU34SPvtltS
         uFnKbcQZ5DATTGkWSqqPNYbDfcly1kTIbX3urI/YwItM8dYLGfgaz4rSRQPrtCAImpX2
         Z4jvetVV2KK6YEXhld5lswAcz3WqQtI2R3REfeobhkaW0Hklt/h8j+3hYtK625fNfLm5
         t23Q==
X-Gm-Message-State: AOAM532qeqhzUy/NfS65/WY4mhqpnqQMO/9ayxqTG5IeHyIXLPcBiQ1s
        PnuUuKCBE0WVoTAxw6+tbCQ=
X-Google-Smtp-Source: ABdhPJzELnDpP7L4kB4ehiFjawnYmMEaF+rejP80WmAuYNwcvNXiUwZgXEiCwBOh/AutXRzar4/2zA==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr8567502ple.260.1596727970094;
        Thu, 06 Aug 2020 08:32:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h19sm3576741pjv.41.2020.08.06.08.32.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 08:32:49 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
Date:   Thu,  6 Aug 2020 08:32:41 -0700
Message-Id: <20200806153248.204310-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The EC reports a variety of error codes. Most of those, with the exception
of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
error code gets lost. In cros_ec_cmd_xfer_status(), convert all EC errors
to Linux error codes to report a more meaningful error to the caller to aid
debugging.

To prepare for this change, handle error codes other than -EPROTO for all
callers of cros_ec_cmd_xfer_status(). Specifically, no longer assume that
-EPROTO reflects an error from the EC and all other error codes reflect a
transfer error.

v2: Add patches 1/4 to 3/4 to handle callers of cros_ec_cmd_xfer_status()
v3: Add patches 4/6 and 5/6 to handle additional callers of
	cros_ec_cmd_xfer_status()
    Use -ENOPROTOOPT for EC_RES_INVALID_VERSION
    Implement function to convert error codes
v4: Add coments describing the functionality of cros_ec_num_pwms().
    Add patch 7/7 to clean up cros_ec_num_pwms() after the new error code
    support has been implemented.
    Rebased series to v5.8.

----------------------------------------------------------------
Guenter Roeck (7):
      iio: cros_ec: Accept -EOPNOTSUPP as 'not supported' error code
      cros_ec_lightbar: Accept more error codes from cros_ec_cmd_xfer_status
      platform/chrome: cros_ec_sysfs: Report range of error codes from EC
      pwm: cros-ec: Accept more error codes from cros_ec_cmd_xfer_status
      platform/input: cros_ec: Replace -ENOTSUPP with -ENOPROTOOPT
      platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
      pwm: cros-ec: Simplify EC error handling

 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  2 +-
 drivers/input/keyboard/cros_ec_keyb.c              |  2 +-
 drivers/platform/chrome/cros_ec_lightbar.c         | 10 ++---
 drivers/platform/chrome/cros_ec_proto.c            | 52 +++++++++++++++++-----
 drivers/platform/chrome/cros_ec_sysfs.c            | 24 ++++------
 drivers/pwm/pwm-cros-ec.c                          | 37 +++++++--------
 6 files changed, 74 insertions(+), 53 deletions(-)
