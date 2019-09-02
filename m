Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C989A530F
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 11:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfIBJll (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 05:41:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33660 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731293AbfIBJll (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 05:41:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so13324325wrr.0
        for <linux-pwm@vger.kernel.org>; Mon, 02 Sep 2019 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XEaajhYL2DDcNnig232ycVZm5Az7zzGM6juW3JXG9yQ=;
        b=a/f0r3wh1i2nTAvJVAJBZEoLNeDpRYSXvLUG800eabb6+vAM1Piy+0FYiXbkWJS4on
         aywDOCMGNAhoBqPGDYyF+qGX2MgbkO8+mFR9K0wa5ChpvAgCDdzrq9vMq5dxnIhF+0yf
         N1vkx4pEtz5FJsNy3IIZoe3eMtE5GJBw9V3pdcQrBLYSshV3ucgoY6rq5hvTd+BWrteQ
         ZF8RYGsso3WxK/1Jp841Xpgz5qdpswdGBggqH3JmJxaYM3g3Hx0XAQYucE7PREvRuj9X
         kG60QBVhiW/tOtPkagKKds9jkvxyfjfCSXna7SOZDdD925Sq37LrwNctNNT8h4i04gaH
         G3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XEaajhYL2DDcNnig232ycVZm5Az7zzGM6juW3JXG9yQ=;
        b=CZMoWULAtBriLnKj01SJYETsX/98OPSSdEEEl3KW4nXfXz7758bv1CCiph9rFcLmCD
         GzsAQ1jrGKXMA+HUQIdCM9iqZlIyfvv6G9M7jbO7SRlI3BsHWSZiNjgxx7UVygyvcDEh
         8uv5azmRNCoC9H9f8H3tBfxwPIt2vu9NmQVi93TkUxYqA2O5YrXiIBGzFUfkQfohFCJ2
         17oBNEVOMHy+MJPeTmoU4ln8gMz6WDj2aGrnj3s2RmrmwE01KSG4Y4I/L+oLYvWH0rRW
         inYTvYarRVMuuH5wU5AU2FiCXva3g3PxJHCXL5z7X+vTxDJyo+Ztl5buLR/ii7vBvM8T
         TH4w==
X-Gm-Message-State: APjAAAWIL+E61gQeFZL7eWBhgQrL90uV2Eu1F27GPsm0+s284pkdZvDK
        9GwA7/FkF12ZDxLSkBe5eDqwTg==
X-Google-Smtp-Source: APXvYqzc9kvt4IxUGw8ouqARjHnLlmJJZz62Rz9BCP9k67kGZc0ulYwTxiSzmVBXrtHgzH6HcjVbGw==
X-Received: by 2002:adf:e603:: with SMTP id p3mr4027156wrm.102.1567417299891;
        Mon, 02 Sep 2019 02:41:39 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id g201sm11439111wmg.34.2019.09.02.02.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:41:39 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:41:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190902094137.GM32232@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709190007.91260-3-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 09 Jul 2019, Matthias Kaehlcke wrote:

> Backlight brightness curves can have different shapes. The two main
> types are linear and non-linear curves. The human eye doesn't
> perceive linearly increasing/decreasing brightness as linear (see
> also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> linearly to human eye"), hence many backlights use non-linear (often
> logarithmic) brightness curves. The type of curve currently is opaque
> to userspace, so userspace often uses more or less reliable heuristics
> (like the number of brightness levels) to decide whether to treat a
> backlight device as linear or non-linear.
> 
> Export the type of the brightness curve via the new sysfs attribute
> 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> 'unknown'. For devices that don't provide information about the scale
> of their brightness curve the value of the 'scale' attribute is 'unknown'.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Feel free to suggest improvements in the documentation :)
> 
> Changes in v3:
> - removed composite strings, only keep 'linear', 'non-linear' and
>   'unknown'
> - updated sysfs attribute documentation
> - updated commit message
> 
> Changes in v2:
> - changed order of brightness scale enums, explicitly make 'unknown' zero
> - minor update of commit message
> - deleted excess blank line after 'backlight_scale_types'
> - s/curves/curve/ in sysfs doc
> ---
>  .../ABI/testing/sysfs-class-backlight         | 26 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  drivers/video/backlight/backlight.c           | 19 ++++++++++++++
>  include/linux/backlight.h                     |  8 ++++++
>  4 files changed, 54 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
