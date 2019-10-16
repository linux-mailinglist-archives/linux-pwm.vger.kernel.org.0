Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08657D8A4B
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfJPHwZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 03:52:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54383 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfJPHwY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:52:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so1715082wmp.4
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l+eDQw7b9v7Rw46oLorXW5Yed3sU+eig9M618FB+PL4=;
        b=Zprs0y8kBPQ3qjTVj/r66c07zEzYHAzGc1PwpC8CEkHTDvqlLmt7M9IKkPG10MDX01
         D861ajFGmQM6HGs3TOMfSMF0Pe83Ip5jRZ55/ycWUp9KZ9IK11efTLb8xGOQhKdgb0wF
         xJjMI/h6Nl++vvudQQmifg+LMHoaMDAbSZKphm54kioxj9bGuPlc+qtMQ+nkiv/iSpel
         EhhAppoZJC+rVWeLFhgJb7pSEBRI7Xr5x3Xjkb+zL6MH+BhLHPhaESB7c8B95pqXhR1N
         q6WBHssNi/PNZA9Jkx8v2UHWiXPdNn7uPZ2K1uQsUWs+xYohzd7Ue5lt8SD9gFiVq90Y
         RpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l+eDQw7b9v7Rw46oLorXW5Yed3sU+eig9M618FB+PL4=;
        b=RA85f0lOWJJmyhjtOATxou7e1q47a9HQh5KrR8A4dQj/G64PVfP4nbdMMtkCwACTIc
         JCtQxvMr+9v7b7Lh+TMQFVl/2nYI9NUvr8SJC9FnPQrWI22twGf1kAWo6aju09s+2RRy
         uFGavesJAJa1o33hMkLPMyraNqauETPzmRQ09daTNR3lThs4kesxowUK4pLOHGW5caJn
         gPUpCg2qu7lDe7LWbN6Z4EjrGtvp+fQH1GVWMllcVgLjDuafNOUaObuLAXieLmsyEKPa
         cBrT8XN4HyuhseyB+IVKMDAzet+XM8xBe5yj0rybQ41P+CYW6GTe84FasKoRPGvYoOTy
         SENw==
X-Gm-Message-State: APjAAAUX0hH1IQVLPll2I8HnHBjeBLSARM7NLfijNmJPJj1aZLMFpfd8
        0UyxFwMyO5kana+Z274ZbbaFPg==
X-Google-Smtp-Source: APXvYqy2R+5UwjDoVktwSQkiSJQLn97WIr2FWHdpPx/CIry4HyNQrzJNEJ4i9wILKyZVVU8qvWRaBA==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr2044282wmg.119.1571212340927;
        Wed, 16 Oct 2019 00:52:20 -0700 (PDT)
Received: from dell ([95.149.164.86])
        by smtp.gmail.com with ESMTPSA id l11sm1630442wmh.34.2019.10.16.00.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:52:20 -0700 (PDT)
Date:   Wed, 16 Oct 2019 08:52:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: pwm_bl: Don't assign levels table
 repeatedly
Message-ID: <20191016075218.GB4365@dell>
References: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 02 Oct 2019, Matthias Kaehlcke wrote:

> pwm_backlight_probe() re-assigns pb->levels for every brightness
> level. This is not needed and was likely not intended, since
> neither side of the assignment changes during the loop. Assign
> the field only once.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v2:
> - removed curly braces from for loop
> 
>  drivers/video/backlight/pwm_bl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
