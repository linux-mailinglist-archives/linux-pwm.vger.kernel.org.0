Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9776FA5315
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbfIBJlz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 05:41:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45434 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbfIBJlz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 05:41:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so13252798wrj.12
        for <linux-pwm@vger.kernel.org>; Mon, 02 Sep 2019 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZL2haMI2aTtJurgKOti2qg6P2dpB10rrMYX8xsD2bK8=;
        b=Jp3giVDeY/0YoOVsPWRfoipAvNrzI7SL/np7C/5ElKhomtCfzrE5qjSsgFLnvv+6ZH
         lILykF95Pb4ijIZzZkaRiTqqBEIeFeKsVvMtQvJ6lBPBwxjaQVfXsjEyVLkPFCKXE4B3
         DrWHHs+HbI/F+q3dhSOuFdgQsNXLr0nM2yrOla+U/Aw8bvW0fsrUez9tDU4q4HSs2cB4
         3UtfZt8rdx6Gl4LZk1oY0gUY8s7knHlKkWdn3nwNRkUjShH/h3ie/SGOfYieJgjpA2XY
         2DI18qzAQKD2TsWZW7QDG9lKvubbZH1Kkkp4cH54fJQ0CZG37DAim0aE1ELf7PWuLK4/
         zkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZL2haMI2aTtJurgKOti2qg6P2dpB10rrMYX8xsD2bK8=;
        b=MIePrEq7NJmiKsnWVEgiv43mpdfmEOHYtQtt3LZRfFWvHUJUhpn15F56UgIZO6OPad
         jMZGR/aJqWrzavDZZ/VDqWnNFu67E18wBo+h/PKQWftxopLpPZ29BOc2Tg0U7rvLFw7G
         KUX0ezp7SS3rSaOC0AmQw9fuNhvQei3cXIBQN9c2duLP0vc3KhuUo0Zv2PU+UWbh0Vrk
         CAvOwkk+bEhv2jdoae9uDS5vgekW+CKojwAXDw57VNr8yFETXXeYiZpiavhsLEZbL6v0
         6ZvOjwXyV69rwAbcBL3NphTwm0d7vc7vddQ6eFPfXy3f6eA2C3tQn54GA96VWqfK4kgQ
         pLjw==
X-Gm-Message-State: APjAAAVXHUCSBMxODML7LCRjvadByN0x24Q3TBKxN/Fc5h54nWsqQHRf
        M1aRK/2y6NhnjrkZ9rc1sw6baQ==
X-Google-Smtp-Source: APXvYqz+ei3zvK9WDCLGPKSb6mZHeIVD4NjOj/SiGtZ3rCzqedIErcw16UBzZxGSMgr8fc4SWNzRbQ==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr14215758wrv.206.1567417312894;
        Mon, 02 Sep 2019 02:41:52 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id j26sm4577684wrd.2.2019.09.02.02.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:41:52 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:41:50 +0100
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
Subject: Re: [PATCH v3 3/4] backlight: pwm_bl: Set scale type for CIE 1931
 curves
Message-ID: <20190902094150.GN32232@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-4-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709190007.91260-4-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 09 Jul 2019, Matthias Kaehlcke wrote:

> For backlight curves calculated with the CIE 1931 algorithm set
> the brightness scale type to non-linear. This makes the scale type
> available to userspace via the 'scale' sysfs attribute.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Changes in v3:
> - mark scale as non-linear instead of using the CIE1931 type which
>   has been removed
> - updated commit message
> 
> Changes in v2:
> - added Enric's 'Tested-by' tag
> - added Daniel's 'Acked-by' tag
> ---
>  drivers/video/backlight/pwm_bl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
