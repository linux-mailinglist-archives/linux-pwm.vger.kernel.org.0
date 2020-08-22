Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5724E832
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHVPJE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 11:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgHVPJD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Aug 2020 11:09:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD59AC061573;
        Sat, 22 Aug 2020 08:09:03 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so2386404pgl.10;
        Sat, 22 Aug 2020 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=IsBEuRUo1D1VfOkGVFKpLZwxuOQKB6UbMiR6vQ0NAHA=;
        b=HT23YsV+CAfOx1K5NfvNUiykOrJzwSCssXaK+JzFaFRGSAFpEgyS3j23xhlOVPQgOy
         r3+PL5XOf/2NefvsCLnDpsChzlmthPtlVERSn4RsX12Mdprr2aLCUSYrR9ZiFjT+IKKM
         nYXw9Q+2zlpWLkFNKEglf2LBs/HB87ADSdlPbzTjOYZwAwd+3NZoWE1iQ1umQaqkGQV2
         CNAYrOBPcVBMObzNvrox6ChtLC4Cl90L03xHHUN/w9+MlRSl52vzPtsa0ifusOjLKAL3
         3MUi3UyYig1Z4TE2oy6fLQsUoID+Z8sFsIEzP2tojUOt1jI85z94V9J5O4KdQ/Ev4KCa
         YepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=IsBEuRUo1D1VfOkGVFKpLZwxuOQKB6UbMiR6vQ0NAHA=;
        b=BtnQI5S/Y5qvQs7bdnddy28XPoeKgLgnJfvF23UquP/ona2QeeYmY+3befGWP+0JfR
         UhTHFpFuLhR3MrUhb99uIjZ5noWfaWeXtxiXc8LhYCLpC/HltBPUGcGg/KzlAgQF5CEr
         9y8//BUxIAQ0k9uTd8e12Ws4YnJKdeNn+zfyZRjf3HFGdEgBaMqMDXEE5J64x8EsUUly
         A6yK0EcdN1lgQhbU8hLJUwW3iVGUp8RkPslHrp/016Q+PB5w/imwArJWYdhjEKn3k+RR
         2N73L9J4fLhxKUhB7gci6x5CdnwjfMRR6LfCUSzswetJ4c1A0nL58Jjnb476cYOqRlc2
         q59g==
X-Gm-Message-State: AOAM533KaHuuWBI+Zy0jFFhiwMhe14vK3lVAQJPu/Vzlol7Qef0jRwLJ
        n1aIn7pU+KDv/visshLc16Y=
X-Google-Smtp-Source: ABdhPJwal4bcpoUHI1whCOze0UQwSQw22dAbS+E1xlIAHuM8DTfvBqvZzBuAXUnVLB2RqPipTnRaug==
X-Received: by 2002:a62:18ce:: with SMTP id 197mr6325913pfy.85.1598108942306;
        Sat, 22 Aug 2020 08:09:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s1sm5491316pgh.47.2020.08.22.08.09.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 08:09:01 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 0/7] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
Date:   Sat, 22 Aug 2020 08:08:50 -0700
Message-Id: <20200822150857.205775-1-linux@roeck-us.net>
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
v5: If there is no error, cros_ec_cmd_xfer_status() needs to return the
    number of received bytes, not 0. While fixing that (in patch 6/7),
    rearranged the function to reduce its indentation.
    Rebased series to v5.9-rc1

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
 drivers/platform/chrome/cros_ec_lightbar.c         | 10 ++--
 drivers/platform/chrome/cros_ec_proto.c            | 57 +++++++++++++++++-----
 drivers/platform/chrome/cros_ec_sysfs.c            | 24 ++++-----
 drivers/pwm/pwm-cros-ec.c                          | 37 +++++++-------
 6 files changed, 78 insertions(+), 54 deletions(-)
