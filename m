Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA524D075
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 10:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgHUIVe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Aug 2020 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHUIVd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Aug 2020 04:21:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C218C061385;
        Fri, 21 Aug 2020 01:21:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5BC6E29AED4
Subject: Re: [PATCH v4 0/7] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200806153308.204605-1-linux@roeck-us.net>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0dfbce79-0413-de27-a2cb-a687ab2fd9d8@collabora.com>
Date:   Fri, 21 Aug 2020 10:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806153308.204605-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Guenter et all,

On 6/8/20 17:33, Guenter Roeck wrote:
> The EC reports a variety of error codes. Most of those, with the exception
> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
> error code gets lost. In cros_ec_cmd_xfer_status(), convert all EC errors
> to Linux error codes to report a more meaningful error to the caller to aid
> debugging.
> 
> To prepare for this change, handle error codes other than -EPROTO for all
> callers of cros_ec_cmd_xfer_status(). Specifically, no longer assume that
> -EPROTO reflects an error from the EC and all other error codes reflect a
> transfer error.
> 
> v2: Add patches 1/4 to 3/4 to handle callers of cros_ec_cmd_xfer_status()
> v3: Add patches 4/6 and 5/6 to handle additional callers of
> 	cros_ec_cmd_xfer_status()
>     Use -ENOPROTOOPT for EC_RES_INVALID_VERSION
>     Implement function to convert error codes
> v4: Add coments describing the functionality of cros_ec_num_pwms().
>     Add patch 7/7 to clean up cros_ec_num_pwms() after the new error code
>     support has been implemented.
>     Rebased series to v5.8.
> 
> ----------------------------------------------------------------
> Guenter Roeck (7):
>       iio: cros_ec: Accept -EOPNOTSUPP as 'not supported' error code
>       cros_ec_lightbar: Accept more error codes from cros_ec_cmd_xfer_status
>       platform/chrome: cros_ec_sysfs: Report range of error codes from EC
>       pwm: cros-ec: Accept more error codes from cros_ec_cmd_xfer_status
>       platform/input: cros_ec: Replace -ENOTSUPP with -ENOPROTOOPT
>       platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
>       pwm: cros-ec: Simplify EC error handling
> 
>  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  2 +-
>  drivers/input/keyboard/cros_ec_keyb.c              |  2 +-
>  drivers/platform/chrome/cros_ec_lightbar.c         | 10 ++---
>  drivers/platform/chrome/cros_ec_proto.c            | 52 +++++++++++++++++-----
>  drivers/platform/chrome/cros_ec_sysfs.c            | 24 ++++------
>  drivers/pwm/pwm-cros-ec.c                          | 37 +++++++--------
>  6 files changed, 74 insertions(+), 53 deletions(-)
> 

The patches LGTM, and if the other maintainers are fine, I'd like to queue all
these through the chrome-platform tree.

I noticed, thought, that KernelCI reported a regression on Kevin that I'll try
to debug at the beginning of next week.

[    3.821203] cros-ec-spi spi2.0: Wrong size 1/3: 0 != 4
[    3.827320] cros-ec-keyb ff200000.spi:ec@0:keyboard-controller: cannot
register non-matrix inputs: -71
[    3.838506] cros-ec-keyb: probe of ff200000.spi:ec@0:keyboard-controller
failed with error -71
[    3.853492] cros-ec-spi spi2.0: Chrome EC device registered

Thanks,
 Enric
