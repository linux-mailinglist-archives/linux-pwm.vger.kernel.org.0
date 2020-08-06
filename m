Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E3023DCA5
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 18:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgHFQys (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 12:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgHFQuN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 12:50:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5FCC0086AF;
        Thu,  6 Aug 2020 08:33:10 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so27722716pls.9;
        Thu, 06 Aug 2020 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=TA50xo6IgAS3A5s1Mvlt9oYR8AHuJvVW3cujvShV5qo=;
        b=ilW+et5q4do3rnqHcfn4dodyp8p68vxF5XtEr6dtTGJsgefedL8UWq/Qlo6mg7h0Bn
         w9t2OaShgDXkK1V00XT1XfxNrjwmYMzLZjFAZrmzuDeBA3Qso3G1e1gGmzAzhBnEiZ7C
         yqFU+1fx0IJC/n0S8QJ+kriZ+rqPJNchtbWuvjFs0DgxS+YwDDJvfQvf/M7FLCVYwQVy
         QTUqoozqDWKjgo0OLVREsUejwa11NW3t5yQiuQa5zCPxswr5vfqky1jR38opkgbKad2a
         RSmoCqPzvqHnwBwFeYjjf2WKJuHFobbRHoTY+b1DiCV1tDKzLfzTFPTTdq3f7gfT6Fkc
         EQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=TA50xo6IgAS3A5s1Mvlt9oYR8AHuJvVW3cujvShV5qo=;
        b=FNR+nhfmzDmTzpOEwySjjZ18E3djLKIXMXgnbMRvswtGoBAaJVj6A6Z3Maiv0VspLj
         HGa5KR32OVRKiBzefGFWPB1StTKwprfYCfgQe1WdHsXuq5RqCj6n53KqaappUoysoqIE
         QJT1eN5ea0zcHgZseXQbQwgyxZYUqIa0DnBew9MhRdQKgelij3buQIvxoK35E9dxmudr
         OdVxnjxnIdxdhZQoV3ib+Rtk2SK4UgEcWTKfPL++wI/4FXhVMtQYCF2TQ3hrGPah2Wwb
         LgTP52dmQfR4l3gasSuCGf99VsllzvO/HQPqPO2dlhNHtr4lDHQds3jxTnLLViJh5wta
         WjAg==
X-Gm-Message-State: AOAM5333cAA/92O/vePkHiLiP2Xqa3Sdl9rucvymaI42r8Rw60rkFQG7
        UeETo221CuialjtFwketwtQ=
X-Google-Smtp-Source: ABdhPJwbyxgGfTHFyyc9OLeOYww6J9oVuKfCR/uomTBYf69xrCEOZb9n7VvxlE4wCUtF5IWu/Bpf0w==
X-Received: by 2002:a17:90a:d56:: with SMTP id 22mr9080012pju.58.1596727990104;
        Thu, 06 Aug 2020 08:33:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 2sm4783536pfv.27.2020.08.06.08.33.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 08:33:09 -0700 (PDT)
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
Date:   Thu,  6 Aug 2020 08:33:01 -0700
Message-Id: <20200806153308.204605-1-linux@roeck-us.net>
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
