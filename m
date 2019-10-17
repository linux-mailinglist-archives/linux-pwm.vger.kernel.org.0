Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE2DAB6F
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405275AbfJQLre (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 07:47:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52505 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405758AbfJQLre (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 07:47:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so2237684wmh.2
        for <linux-pwm@vger.kernel.org>; Thu, 17 Oct 2019 04:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9EgRoWT1S/esycl2KztK0v8EdhOHABE+DCs/Zs7xJ2g=;
        b=yk8pv0ZohxDRImGSseeQ94X4SFOB1f3whjH3gE0/kgd3BhXkwMfQuiFzfbo8kV7hWL
         WTWM5jOHJQqpVMIQwPB2qoXZmWLkGSYH+S7jw4dL81rSOAtR8ODMKEa03GnNzonNBqpi
         sqEgotnNJCGaaZli7QevDDrC0zvNJl48PllosPtH5bRKowTt0nfgPFT/dNYS/2PY+Bvu
         si1brAfp1c2sqxZ9sWW55jeccgEsLJTjQXkzdK+FUUgm/Ic48qG2BKOAr7kFARZL0lng
         O01Bak48rOIOgUgIOSFMUG0kZndFotRdFxYs+W1sGMpY1MAkI5HRrYvnEiSIvgyLfO6X
         0Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9EgRoWT1S/esycl2KztK0v8EdhOHABE+DCs/Zs7xJ2g=;
        b=YdUfPI3aXmllapix49PvRqlPioxCZIJzMgkbBq/BEG16ya5GypoROVNbf0gEcj8FO0
         Hg48G3Gph4lExp67f9I0ryxnj5+O+yQxnbNOmf01ISM9Q41H2wjNzG507WK1rZnaIKrk
         zpBhDnOwcGq+KPLVPEvOZ+LxB2PM9JV8MBwOWDM6QJ4hIuA5n8+IXw23cVCQ746iVG0c
         L5+qgIurs5sUfAt5wrDernRPi4Jw2HhA74UGJE9Kgon3DbTNkX4PChgCDffntftNQXgf
         ewrscPEi5ayy1rMA0myqZ0+9ft9FS0gLZpq4UXS+L54FHSbxdFd7FlkxOwqU6s2ZTv6e
         X8CA==
X-Gm-Message-State: APjAAAV9r86+rpuCTa7HSTDhBHAL9/JuoFW1bP3u3k3wwbIFmIJuYx1Z
        b9vKogqKZK59gJYJGPDVknHXfw==
X-Google-Smtp-Source: APXvYqzhSWmeuMPlHQbLiJ024kOkuwLOq4wR8LHDKVRH96iLuA31ZMAoJouWa9QvRJfI5cC0Eh+JAA==
X-Received: by 2002:a1c:a8c7:: with SMTP id r190mr2320221wme.148.1571312850183;
        Thu, 17 Oct 2019 04:47:30 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z189sm2554703wmc.25.2019.10.17.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:47:29 -0700 (PDT)
Date:   Thu, 17 Oct 2019 12:47:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Adam Ford <aford173@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
Message-ID: <20191017114727.fy5tg2kgi6mr2sei@holly.lan>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-König wrote:
> A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> pwm_get_state() return the last implemented state")) changed the
> semantic of pwm_get_state() and disclosed an (as it seems) common
> problem in lowlevel PWM drivers. By not relying on the period and duty
> cycle being retrievable from a disabled PWM this type of problem is
> worked around.
> 
> Apart from this issue only calling the pwm_get_state/pwm_apply_state
> combo once is also more effective.

I'm only interested in the second paragraph here.

There seems to be a reasonable consensus that the i.MX27 and cros-ec
PWM drivers should be fixed for the benefit of other PWM clients.
So we make this change because it makes the pwm-bl better... not to
work around bugs ;-).

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 746eebc411df..ddebd62b3978 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
>  
>  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  {
> -	struct pwm_state state;
> -
> -	pwm_get_state(pb->pwm, &state);
> -	if (!pb->enabled)
> -		return;
> -

Why remove the pb->enabled check? I thought that was there to ensure we
don't mess up the regular reference counts.


Daniel.
