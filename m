Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6202A5319
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 11:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfIBJmP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 05:42:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53404 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbfIBJmP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 05:42:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id q19so4984915wmc.3
        for <linux-pwm@vger.kernel.org>; Mon, 02 Sep 2019 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iK4LKa2PqlS0Y5u4Gjl7mrzOSTmztak1fj4wGqVsFy4=;
        b=S/WMwjjBsYD6eC5+gEOI58+jRpAry6yXwLdfqno73t/WpmJzLCQpqM2O2mTs/aiwQR
         TCGv+n2vwxgVgIx+fPgz4pHjr9PA1fIL+38d3IdqZWTS9Tyg0SCxGxy5hC9PnOHU0A6S
         6S6nOWcPZFNCZ2aIevsy5XbQrn1qE0XwXbaXnXNnt6jhsNbdKuXnJjHv+pVAVFGLna0+
         YU/tKj9qpFXh/951Jev2PUuDzIubEmF24MUyCESqrgAuuraAsPwd1+e18ZC6zmc4eaRi
         cQ7yC7GHWkx6zeRgTvQrH97fL7TXhIoW0isOYDcSdW/bYVSopm5JEQjiBCDxmVrFQc+/
         YUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iK4LKa2PqlS0Y5u4Gjl7mrzOSTmztak1fj4wGqVsFy4=;
        b=hENq/x3xjzPXXXp45dt9u/26LOWLVI965s77vaV132PsRtqWF3WB1GdVQu3Tx7fQZ4
         gLgCniv5YQH2rcHLfWu8EqbGoWlT75+WHlHb756wao83W3bbpiQsv5m37X/BY9ECOIe+
         vjnteAqtN7cvnh5rbLpei+kQvPraNH5Gd2HmoSgMV0JP8LzQxsV/THYDUiunkpB7C/MA
         S80e70qA2gyl09FTv1Osk9fiBBdFTiZNuE4hXIUhgYsGyPtv0E8YiqAzX2RsyucIFfw2
         gzzJdGbqLGyZEt+ZiPtx9FaTQ3LZx85Z27SegkFnZMp9MjuVBDqtEyNXMrKasfjZ6SWM
         kbuA==
X-Gm-Message-State: APjAAAVHtepRUqJGkLhEh0luQaq/3HUTggzD0smoxb+LJ1kW2BngxqdJ
        0euQxaoUgG90FSV28wjlZ+DPyA==
X-Google-Smtp-Source: APXvYqzNZJNoxLswvc9p2LnkDfvzZJYlWCgpWeM7LW0HaPoM2ddXbfzMbv9rhLZWFOa3XTsnVAB6og==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr35998457wmb.116.1567417333221;
        Mon, 02 Sep 2019 02:42:13 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id k9sm16402618wrq.15.2019.09.02.02.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:42:12 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:42:11 +0100
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
Subject: Re: [PATCH v3 4/4] backlight: pwm_bl: Set scale type for brightness
 curves specified in the DT
Message-ID: <20190902094211.GO32232@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-5-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709190007.91260-5-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 09 Jul 2019, Matthias Kaehlcke wrote:

> Check if a brightness curve specified in the device tree is linear or
> not and set the corresponding property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> To determine if a curve is linear it is compared to a interpolated linear
> curve between min and max brightness. The curve is considered linear if
> no value deviates more than +/-5% of ${brightness_range} from their
> interpolated value.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Changes in v3:
> - none
> 
> Changes in v2:
> - use 128 (power of two) instead of 100 as factor for the slope
> - add comment about max quantization error
> - added Daniel's 'Acked-by' tag
> ---
>  drivers/video/backlight/pwm_bl.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
