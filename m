Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4233D5C5B
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2019 09:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfJNH13 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Oct 2019 03:27:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33486 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfJNH13 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Oct 2019 03:27:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so18388045wrs.0
        for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2019 00:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TWp5GZfXAuJiSjhN3OBoDFjXnsSknmpXMaB8oSLy2/g=;
        b=djTw1yvqaE4roQjMnJd2pe7/Kqo55OxZfnKi7PrNRYJCR3cP8VIuQ+Ac9RIOVFyZFp
         y8DgO8aeG3E0jLWMJirbmkXHnp+22ZU5W1/4Sle4LVjo00mv6/tkZp48vg8MI5G9bIk0
         TCoQCvmiECFLPfeKKhGJp28J0iY48QU45qXb4pB/QNZPE6U9DnhZfKU6CxHO6JjKO3rl
         JU/dDVqgr4+2HcxH+cdizMhUCpJDhKygiK7bLOk4voo6GA//n/Ao9fvlWyra5pv/itdG
         zhv6DyuGCQs0uuzCLvO64pnitnLClO7bcHr2MJBC6baxfXkXaLZ0LOS2hBpoz1e103jy
         EHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TWp5GZfXAuJiSjhN3OBoDFjXnsSknmpXMaB8oSLy2/g=;
        b=JLm9NOIrBbIhOhZ0pt3TmGDgOjTTmvGadNxGlqgt9DI/Ufy5U6xqJvEX/FI0WWWCUE
         yt58H0tvF5iXIxh6/y2dPVYX4Qx+c+nnymVFZOMSeQwq47tG8fuI7QQX89LU44JkjAg4
         wWwgIBcALEZqpGgPwC28Q26gHzeEqtYI7LD83Yk+d7JrqUtMt7ZjIigSSZo0FdMv9+oM
         uGeeoWAm7qYRetID+mZPxARCPpkpcbSnKarKLgKYaAUHaCL7bWTKyg+P+pimdF9QmlzF
         V525bf7d4P7XKCaHI2tjSFlG+xPYOnPkfKoVBSPikkw216M9PmoCtpqEhfAFWs8xb8e0
         8u1Q==
X-Gm-Message-State: APjAAAX5uPQ5kSyRXpT9c5MpYBOyTogWf9TkMJEcabCVj7/BZmCNEu1S
        yHhto2XHcj1EAq/eCVH8Wb3dVWUSAjE=
X-Google-Smtp-Source: APXvYqySNhmt9GNRmDIkVlWJrnjisv4DE3+x++TMdbO6SLMmNeMmkEEhShnSGMTeiIYd/7/Hcsc+JA==
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr11305190wrj.268.1571038047490;
        Mon, 14 Oct 2019 00:27:27 -0700 (PDT)
Received: from dell ([2.27.167.11])
        by smtp.gmail.com with ESMTPSA id e3sm16653686wme.39.2019.10.14.00.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 00:27:26 -0700 (PDT)
Date:   Mon, 14 Oct 2019 08:27:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] backlight: pwm_bl: eliminate a 64/32 division
Message-ID: <20191014072725.GF4545@dell>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
 <20191008120327.24208-3-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008120327.24208-3-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 08 Oct 2019, Rasmus Villemoes wrote:

> lightness*1000 is nowhere near overflowing 32 bits, so we can just use
> an ordinary 32/32 division, which is much cheaper than the 64/32 done
> via do_div().
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
