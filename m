Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229D022E2DF
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 00:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGZWBG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 18:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGZWBF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Jul 2020 18:01:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084FCC0619D2;
        Sun, 26 Jul 2020 15:01:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so8006226pfm.4;
        Sun, 26 Jul 2020 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=IH0/M9cS+3g6rCHfpAc3E+ozfsl0ujXw3IEZMoSmSuc=;
        b=fv/jVEkqGug6NcQ26s5BuYgfJXu+99POQrTnOfq7QLG6YYH0CR6uNsSo3l4Fu/d3UW
         HDxgYovtHTZ46Bi1UPELjqKA8KJRmpG7xgQSde+QFzae8yw3QfdPY+Bo+pUD+QfSptVO
         pl96OVY0UiTQeoCecQa80CtzNmEo+Me9eCQFpvzbGqKUii+qLcSW/sAFuQqDvyNV5Itc
         3hAjPD0NcYoX/DqrO/vx33EKHA33cMBGlw+wZ6sgJRRnHsnyMYzhjQwgIKt3Utyi6LpF
         8GtmGDdWxjuse30s/KZou2XFRQ/OPGb3Vo3WVmG8oxPx4fplBllkEaDdq9OLuN3D6hhU
         VAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=IH0/M9cS+3g6rCHfpAc3E+ozfsl0ujXw3IEZMoSmSuc=;
        b=kCmbdjHFO3XEqrTM9vLVlm2Q23LhyJF1VtM07HThKqUtMgwwWoFXz1JDwCDs/4JawV
         fejK0P22k1M90COZw6yJU5q1i6SnD79flQVcDw+fW9BVTeW6TpL56kA57T8iaLZ9AQzK
         RaelwQiMRRvNpdBsAHoCfaKQK/7R7uQZ6VA8l34DVy4m99dWZ48suo/JR1xFpxV68wTm
         ka9luWchYTKuDA81sMgpr+MuapDNGA1q1DDYEpRy4BcenEyvLnz+xb71dBx82BZxEaGA
         IB5OnqZkmQl03YknZNXGrmAugz9i6QxNGyI8weuKurYSky67x8wIuwoZZy2CGnc7sCEE
         BQGw==
X-Gm-Message-State: AOAM531M+7lI/p6CfFvPSfvCo/UmGq0iAIJNXw+vd2s2E7A2EhkK6Qqu
        6vb9vcJSRqoBdAJ9IlGsw8Y=
X-Google-Smtp-Source: ABdhPJxK+KLnxE1VXpQBalut239v/Xr/XnBEZtTrYOvBZFFDLBJsO1U5ZU73IJb3vmKjVwSkWOfZ/g==
X-Received: by 2002:a65:6786:: with SMTP id e6mr16518480pgr.395.1595800863683;
        Sun, 26 Jul 2020 15:01:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7sm12171373pgw.85.2020.07.26.15.01.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 15:01:02 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v3 0/6] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
Date:   Sun, 26 Jul 2020 15:00:55 -0700
Message-Id: <20200726220101.29059-1-linux@roeck-us.net>
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

----------------------------------------------------------------
Guenter Roeck (6):
      iio: cros_ec: Accept -EOPNOTSUPP as 'not supported' error code
      cros_ec_lightbar: Accept more error codes from cros_ec_cmd_xfer_status
      platform/chrome: cros_ec_sysfs: Report range of error codes from EC
      pwm: cros-ec: Accept more error codes from cros_ec_cmd_xfer_status
      platform/input: cros_ec: Replace -ENOTSUPP with -ENOPROTOOPT
      platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes

 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  2 +-
 drivers/input/keyboard/cros_ec_keyb.c              |  2 +-
 drivers/platform/chrome/cros_ec_lightbar.c         | 10 ++---
 drivers/platform/chrome/cros_ec_proto.c            | 52 +++++++++++++++++-----
 drivers/platform/chrome/cros_ec_sysfs.c            | 24 ++++------
 drivers/pwm/pwm-cros-ec.c                          | 21 ++++++---
 6 files changed, 71 insertions(+), 40 deletions(-)
