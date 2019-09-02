Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2D4A5307
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfIBJl3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 05:41:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36329 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbfIBJl3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 05:41:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so13301894wrd.3
        for <linux-pwm@vger.kernel.org>; Mon, 02 Sep 2019 02:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h2Js6ck3D0UcikM7wY4O7TjuGNb/yewcebe0HVIWGVI=;
        b=IOJ6QyqKfV+Hn6dfHFS8VoI5kBFRJjPBRY+dx4Yb4MfdW3phxnyHIhL0fGu/EhWgQu
         SIQu6UvnMMp+UA442ybHMp4KX2Ny2Ni02sAfWv5YY00VCfm77lS2WogHJCv3Hn+EfU0X
         /sV15ifCB3BoEK3u3ejE+TlSTUQW/JtMM6nSaMmrll/a6lucI2DBikWSb5O3XHwnwLTz
         OJ/a3ZB0AXMNFuAgOMrpFUAWWPUSH6pGo0bV+d2a4d0UEr+H39lgwOUS73hSZcl2tyux
         xbUow1z61D1QEge+o3r80ODMyFZ1RdI084qGulClFTRdu3FSd9wWVn26sobjSUzIKrIu
         sPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h2Js6ck3D0UcikM7wY4O7TjuGNb/yewcebe0HVIWGVI=;
        b=MyK94g1SpdXleLTbAgQ6ake3iG2HjS8Tlt1sIo5y+GmbexP19gnT4BmzB8e+1tiFH8
         fVzvIM4pxlry2gOvO7E3BP+uUJ3quRHbIE/LycSXBoDVSQazJ3PAXjJEVDQhX8IDA8uQ
         9gwOpzSbZ27t/UYZaKZo6ai/x1lSEpbHGJFXLyki9PaJZSpoIIJ6k+XYGwYEZXFHTYXs
         Pka8u4wyqz7OudXvwplBvkko8WqqjTK76oLEqYhFQ9QGBGJA5Amy8SMPOK78H7X+SOrY
         MFb6Vbg7xwHeLeCQ68iD9rBFKPiO+Brne62YFB/bGsOvxzSJThkAmPI5s4LCcTZ7FkaW
         PASQ==
X-Gm-Message-State: APjAAAXKcJYQI0MJjCpRqDugxXCOrD6vyhqknl1JoZtqAx7oXd/2JnOG
        CbUV5ZTumpW/MedR6epXDlFhIg==
X-Google-Smtp-Source: APXvYqzkKuhIC5ceSL2MqksiJo+nl+juinzoBL6gv5vjR2DoMcJVpuf7UEULPjzSEYwJ3tB+sKZ3Hg==
X-Received: by 2002:adf:bace:: with SMTP id w14mr36779064wrg.283.1567417287276;
        Mon, 02 Sep 2019 02:41:27 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id l20sm11130924wrb.61.2019.09.02.02.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:41:26 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:41:25 +0100
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
Subject: Re: [PATCH v3 1/4] MAINTAINERS: Add entry for stable backlight sysfs
 ABI documentation
Message-ID: <20190902094125.GL32232@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709190007.91260-2-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 09 Jul 2019, Matthias Kaehlcke wrote:

> Add an entry for the stable backlight sysfs ABI to the MAINTAINERS
> file.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Changes in v3:
> - none
> 
> Changes in v2:
> - added Daniel's 'Acked-by' tag
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
