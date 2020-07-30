Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAE232B15
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 06:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgG3Exg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Jul 2020 00:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3Exg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jul 2020 00:53:36 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258DBC061794;
        Wed, 29 Jul 2020 21:53:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id il6so3535625pjb.0;
        Wed, 29 Jul 2020 21:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sf5Dq5tsi5GV2zUB8sUssWfaU5oAjGutIobOkx+ddxs=;
        b=fT84vDGewy62CPWJO8RNzhXwSqb2uURyGMVCA5/4eFEHblytjNmxbBOwqrvXLi3wT8
         RN3BDKK9hXYlaZgVu8tWiP5dPOvhPyywb7y7szUMdwqpxEGGP7a9iGtRUMK1ahgWy9tX
         Wn6GyeBg7HMWkmZ8XuepNvHEUbW/J2wRetdLuw5jAUkPrbOVsqh0cAMpGHFOy5taph7K
         sOi8+q4S1NcRLRzJ5/35kJ/HthOVHIKr2YroY+bv0/OjvaT3kPJ/859lGKTJMqK1oV6U
         K/i7WJ8oGJBpQwwHd2cbn0ktZWeL7VwDcW9DYOTHTR1uIdIj5RX980aHmit47iFb4JDj
         0G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sf5Dq5tsi5GV2zUB8sUssWfaU5oAjGutIobOkx+ddxs=;
        b=glH2H7c1aqrKLgUVPh700UypLCJLckDwjNTD72mvybtPJYMROrcAKA7Ox1r+inFjMJ
         lsYfJSlbSxQZG18xGuG0D85HUKsE+iGWvW6jsLt7JMqEmA+j3MGIgbnK9L+SdKXRwakm
         wRU1uLz1bpecmc4ScrqufRjO5G4+vcozt+WYjUSFAMxSFWF+f5jEKsfksdI8ioKXYaoC
         qI16RgB025To4T+LRAZHxMmhogf6mDwtuMD6oFAYbWxlELELRRztkPs1P2NBZT7rl4Ul
         TvrAkyd2LBSj615CWwSJob8BDM6y6kCmFgFPMNevMlArZjZt+GBrRzlfbg3yPZU0zzoY
         +Odw==
X-Gm-Message-State: AOAM531Bv09KmC5iVlFArTBtD+uYXQ0kf1K3hTyoeZBRc383XRrWhQE3
        H9y2A7p8pr+stSZ/oQGUDDk=
X-Google-Smtp-Source: ABdhPJxd/Z+ESFlHNiITeMXZvNhjBIXKlhGnqJR0Lyip4hDtKOzh9XFFP3EB72xaU/13gYCw78e07A==
X-Received: by 2002:a17:90a:fa8c:: with SMTP id cu12mr13731416pjb.229.1596084815427;
        Wed, 29 Jul 2020 21:53:35 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id 17sm4289523pfv.16.2020.07.29.21.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 21:53:34 -0700 (PDT)
Date:   Wed, 29 Jul 2020 21:53:31 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 5/6] platform/input: cros_ec: Replace -ENOTSUPP with
 -ENOPROTOOPT
Message-ID: <20200730045331.GZ1665100@dtor-ws>
References: <20200726220101.29059-1-linux@roeck-us.net>
 <20200726220101.29059-6-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726220101.29059-6-linux@roeck-us.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jul 26, 2020 at 03:01:00PM -0700, Guenter Roeck wrote:
> -ENOTSUPP is not a SUSV4 error code and should not be used. Use
> -ENOPROTOOPT instead to report EC_RES_INVALID_VERSION responses
> from the EC. This matches match the NFS response for unsupported
> protocol versions.
> 
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

for the input bit.

> ---
> v3: Added patch
> 
>  drivers/input/keyboard/cros_ec_keyb.c   | 2 +-
>  drivers/platform/chrome/cros_ec_proto.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index fc1793ca2f17..15d17c717081 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -348,7 +348,7 @@ static int cros_ec_keyb_info(struct cros_ec_device *ec_dev,
>  	params->event_type = event_type;
>  
>  	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> -	if (ret == -ENOTSUPP) {
> +	if (ret == -ENOPROTOOPT) {
>  		/* With older ECs we just return 0 for everything */
>  		memset(result, 0, result_size);
>  		ret = 0;
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 3e745e0fe092..e5bbec979a2a 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -555,7 +555,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
>   *
>   * Return:
>   * >=0 - The number of bytes transferred
> - * -ENOTSUPP - Operation not supported
> + * -ENOPROTOOPT - Operation not supported
>   * -EPROTO - Protocol error
>   */
>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> @@ -569,7 +569,7 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  	} else if (msg->result == EC_RES_INVALID_VERSION) {
>  		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
>  			msg->result);
> -		return -ENOTSUPP;
> +		return -ENOPROTOOPT;
>  	} else if (msg->result != EC_RES_SUCCESS) {
>  		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
>  		return -EPROTO;
> -- 
> 2.17.1
> 

-- 
Dmitry
