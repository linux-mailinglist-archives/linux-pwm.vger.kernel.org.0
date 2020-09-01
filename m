Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0654B258B0F
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Sep 2020 11:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIAJKM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Sep 2020 05:10:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52458 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIAJKL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Sep 2020 05:10:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 50D5F28C318
Subject: Re: [PATCH v5 0/7] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200822150857.205775-1-linux@roeck-us.net>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5fe68c6d-ae3d-e756-ca5d-873f3ca1cc45@collabora.com>
Date:   Tue, 1 Sep 2020 11:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200822150857.205775-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dear all,

On 22/8/20 17:08, Guenter Roeck wrote:
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
> v5: If there is no error, cros_ec_cmd_xfer_status() needs to return the
>     number of received bytes, not 0. While fixing that (in patch 6/7),
>     rearranged the function to reduce its indentation.
>     Rebased series to v5.9-rc1
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
>  drivers/platform/chrome/cros_ec_lightbar.c         | 10 ++--
>  drivers/platform/chrome/cros_ec_proto.c            | 57 +++++++++++++++++-----
>  drivers/platform/chrome/cros_ec_sysfs.c            | 24 ++++-----
>  drivers/pwm/pwm-cros-ec.c                          | 37 +++++++-------
>  6 files changed, 78 insertions(+), 54 deletions(-)
> 

I applied all the patches and queued for 5.10 in the chrome-platform tree. If at
some point we need to create an immutable branch I can provide it.

Thanks,
 Enric
