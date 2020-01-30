Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5814E3FB
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jan 2020 21:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgA3Ubx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Jan 2020 15:31:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33524 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgA3Ubx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jan 2020 15:31:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so1789535plb.0
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jan 2020 12:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+0rKLDNQs9w1hNYJYZaKwLvj6vZBP5mJnYXqFucuhM=;
        b=iq8U0whKUir6BtwA+hkEPrARPnboBH0L4GdBB8V5rfVP4JY5aMnYgRrZmiShSuPqvX
         BHaonQ7Zj54ppZIG+cuxcjKa9ODjO6MWeiX4jm9xrda4Qvl33AM7moaTllpENFnGWuzV
         GGY+6lpgCAlmgbbvHnGLrBVN/7YWMNLNTKE2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+0rKLDNQs9w1hNYJYZaKwLvj6vZBP5mJnYXqFucuhM=;
        b=fegBxgJ+Zk5urYZ9AuSKMjDZxW29V59z+dKDEjTRRtRhdxQybg7JOPrbbxQo5M3MTb
         15OSi8h4vCVjAfG3qKPETYheFFXxH3brFT3AW589etMG76lK7RtNx/5JjZ16IvbEk6la
         Nc9Rv9FwvajfpLhpIcmgzC7TX+ffoFDrVpsvbV5ZiNeYwdkOkzwbRi/c4RV1edCsjExA
         ldJi0hHeNFgS8sYulNIuv4YJFPdcKEpTIZNDCaHlAg+Xiz0assBRvZRnQWtL3AaWSeD3
         3hrr1k9OXDDWHvAhCWo+yRXdO8mm/72NeCBxgmJXOwxpTTGvlz/e+7z3ilS3qcaXIXBk
         BBxw==
X-Gm-Message-State: APjAAAWJyAfx3dOc3ShR68cBPacgUzGi4xMldwVHLlfwmMdGyarBNY3T
        TgIkTWxMJapbjQPMX1MYOCQzpg==
X-Google-Smtp-Source: APXvYqywzkMhkKxlKfSDU6MFr6XCU75z4SAPc7PY0WLGJOKTg2UN9bOXzElPAjE3XEpsIBbIRtv9zg==
X-Received: by 2002:a17:902:6508:: with SMTP id b8mr6423357plk.201.1580416310690;
        Thu, 30 Jan 2020 12:31:50 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:31:49 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Evan Green <evgreen@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-input@vger.kernel.org (open list:HID CORE LAYER),
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and
        DRIVERS), linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Raul E Rangel <rrangel@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 00/17] platform/chrome: Replace cros_ec_cmd_xfer_status
Date:   Thu, 30 Jan 2020 12:30:31 -0800
Message-Id: <20200130203106.201894-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Many callers of cros_ec_cmd_xfer_status() use similar setup and cleanup
code, including setting up the cros_ec_command message struct and
copying the received buffer.

This series introduces a replacement function cros_ec_send_cmd_msg() that
performs this setup and teardown, and then updates all call sites that
used xfer_status() to use the new function instead.

The final patch in the series drops cros_ec_cmd_xfer_status() altogether.

Prashant Malani (17):
  platform/chrome: Add EC command msg wrapper
  platform/chrome: chardev: Use send_cmd_msg()
  platform/chrome: proto: Use send_cmd_msg
  platform/chrome: usbpd_logger: Use cmd_send_msg()
  platform/chrome: sensorhub: Use send_cmd_msg()
  platform/chrome: debugfs: Use send_cmd_msg()
  platform/chrome: sysfs: Use send_cmd_msg()
  extcon: cros_ec: Use cros_ec_send_cmd_msg()
  hid: google-hammer: Use cros_ec_send_cmd_msg()
  iio: cros_ec: Use cros_ec_send_cmd_msg()
  ASoC: cros_ec_codec: Use cros_ec_send_cmd_msg()
  power: supply: cros: Use cros_ec_send_cmd_msg()
  pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
  rtc: cros-ec: Use cros_ec_send_cmd_msg()
  media: cros-ec-cec: Use cros_ec_send_cmd_msg()
  i2c: cros-ec-tunnel: Use cros_ec_send_cmd_msg()
  platform/chrome: Drop cros_ec_cmd_xfer_status()

 drivers/extcon/extcon-usbc-cros-ec.c          |  62 ++------
 drivers/hid/hid-google-hammer.c               |  23 +--
 drivers/i2c/busses/i2c-cros-ec-tunnel.c       |  23 ++-
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  43 +++---
 .../media/platform/cros-ec-cec/cros-ec-cec.c  |  39 ++---
 drivers/platform/chrome/cros_ec_chardev.c     |  18 +--
 drivers/platform/chrome/cros_ec_debugfs.c     | 135 ++++++------------
 drivers/platform/chrome/cros_ec_proto.c       |  75 ++++++----
 drivers/platform/chrome/cros_ec_sensorhub.c   |  29 ++--
 drivers/platform/chrome/cros_ec_sysfs.c       | 106 ++++++--------
 drivers/platform/chrome/cros_usbpd_logger.c   |  13 +-
 drivers/power/supply/cros_usbpd-charger.c     |  63 ++------
 drivers/pwm/pwm-cros-ec.c                     |  27 ++--
 drivers/rtc/rtc-cros-ec.c                     |  27 ++--
 include/linux/platform_data/cros_ec_proto.h   |   6 +-
 sound/soc/codecs/cros_ec_codec.c              |  71 +++------
 16 files changed, 276 insertions(+), 484 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

