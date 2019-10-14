Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C41AD5C62
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2019 09:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfJNH1k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Oct 2019 03:27:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33508 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfJNH1k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Oct 2019 03:27:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so18388610wrs.0
        for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2019 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Lsu4fhje736plADrPfFak7Hyuvi8ToLdp9rnCK4hwgE=;
        b=QAeR6xlIwruriMfHuFp2cv0YcQ7dfUCPQKWO3lSStColxpeElXzjO1pIuQnkS1TUZN
         cty42z8g8KK99VaGUqB/ZKPZqONUVjGeeKHaO7U/ZeaPF/37YP+WnTh+wZVEllLcTG7w
         JQWbBUZoVWjxcHApwBnUGZGGLTX9yOvDPZDrs9WfgOL76QsRx9nGg4GgBGDJNp7H0VNL
         ndbPJ0Tv48BYDmb3RoNgWP2uo3DBciF1dy4MU724NcdBreSG4GtL9V6VplxrcEZdM5bi
         d5sPeIPQDBqskiN+LDOq4H1eHwwsSO34kxUg/hgSYldiDuEN2bNCl0bBPIeHsn8M84kI
         c+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Lsu4fhje736plADrPfFak7Hyuvi8ToLdp9rnCK4hwgE=;
        b=WNngoaNBmVZT6rg8DoiaevpbF6lsYdaVt3wh7m0XPRfiWF/uHbn4FE9y2IOPATEhwo
         AYqbycV7U4rnvWSe0aoTEKc3gph9dSmN5Xvzf2sapJQIr0KV8ZjoCGLjm1zz2kgux1QG
         p+iHJsnywIaAPy7uHAr4o0bquH3gh3kXJsE2TxE1ubrvgAEOaaQoR/yPRwDhG96IDsWB
         /PVpDyQvQvWEmgtNVwbos4ownMjM53PMW7XCvxXDtCBjAlO7nBvhUMQd0wItHnqsJ7zk
         rGskcKjEdIBJoH8Q+MGatXFgR8w8T2Cd4nb2Q2dpvRJFRGkeanDl+0VQnLEl9Pwg7kIV
         P2Sg==
X-Gm-Message-State: APjAAAW3Q1Zv7YEtJ9ehO2pmeIL6H4xG9sfTy0HZth0tHLnKbHp2kDFN
        dHJJBq0rQ2cPbqoMiDOtMAeFOA==
X-Google-Smtp-Source: APXvYqzw9fkcyJEo4AQK7M4LJ3HxW6G4IjmVLs+xsK03nZjv0Pw9xmGK1kAVONlnHG2VAyBzoqVlSg==
X-Received: by 2002:adf:e705:: with SMTP id c5mr23614156wrm.375.1571038056779;
        Mon, 14 Oct 2019 00:27:36 -0700 (PDT)
Received: from dell ([2.27.167.11])
        by smtp.gmail.com with ESMTPSA id f20sm14187442wmb.6.2019.10.14.00.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 00:27:36 -0700 (PDT)
Date:   Mon, 14 Oct 2019 08:27:34 +0100
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
Subject: Re: [PATCH v2 3/4] backlight: pwm_bl: drop use of int_pow()
Message-ID: <20191014072734.GG4545@dell>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
 <20191008120327.24208-4-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008120327.24208-4-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 08 Oct 2019, Rasmus Villemoes wrote:

> For a fixed small exponent of 3, it is more efficient to simply use
> two explicit multiplications rather than calling the int_pow() library
> function: Aside from the function call overhead, its implementation
> using repeated squaring means it ends up doing four 64x64
> multiplications.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/video/backlight/pwm_bl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
