Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76DB79E4B3
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Aug 2019 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfH0JpE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Aug 2019 05:45:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39212 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfH0JpD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Aug 2019 05:45:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so18104662wra.6
        for <linux-pwm@vger.kernel.org>; Tue, 27 Aug 2019 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6f+Icsxz68/2WUOQOXJPlnmhND3c9kjk7Qbbyj0A0kg=;
        b=DAEHqRPgmw98bL/haImN9fD6UfMYR1/S2NnQjdEW81PFCu9T2dceMxS2vBYT+J/OLc
         t2sru5JRJ0GKU0Zg8KmLGV4Rl/1mnBt8AMc4VqoVzpP4Bkq+eNnmp5LyyEsyu0HI+gAE
         I62570EvJBOCoNiTRpNvR+H7ZpvBO6rqAvAQ6Ao7dUAIRV6gvPmGQsXt5uQcy+M0MAO8
         ZD6MvYoxL4JxOwg1W7lDM6k59M+/nFzr1vEiYlrKUCGp4+bNnquLtb5hJOzbAxX/qXDQ
         ZjaRJMCJJ9YOQJwIFZhpn7xBIG+rUxC3uNxq+C2cOxRgHVL9QDNuse/CwpjGabaHxouc
         s6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6f+Icsxz68/2WUOQOXJPlnmhND3c9kjk7Qbbyj0A0kg=;
        b=JK7XwZXZFJxHPndSSh4DCLu5QuJAb1jks0iBtmUkblL5yAf5C9j3Bf4LxAjmdcse7+
         4cAJuaK7lywzxCAax+Y99cTsFKpF9vmPtRMUjXPDCsVxdO2vfOJXfYgirW/BU1PwqxOF
         /CTe8FtnFWJQf7d0vtUs76PlE1q+H2yT1JhftLH+A7S9tUyh/u9hKdi6oxYKxm5z6YuT
         yNy0qS2O5iI9g40bYIlBcxzRCnES3fkQN0DtR4QpLpTHAFmVgEiLtYW3rCYqXCxYB54d
         +h6KlExOpl+vm8odw0IAfmdA22Bmjcmj4A4LhdQ+RQAuIsa5WMKCBoU3+xG2BXJKvhK7
         8R/w==
X-Gm-Message-State: APjAAAUu3x/AFruX+M3iknOotiowKSzObxoZSfbxUblPqasehRZSLv0K
        N3LCvzjKQBmKkK+YQ6YERurPbw==
X-Google-Smtp-Source: APXvYqzj0vKC3iOhGGKsmddO0sx2ggiSMWTkca88AucPIDge5HC2ZDkK0IXCRr00WWZ8LAlMeqxRXw==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr6828393wrp.42.1566899101785;
        Tue, 27 Aug 2019 02:45:01 -0700 (PDT)
Received: from dell ([2.27.35.174])
        by smtp.gmail.com with ESMTPSA id f24sm2510743wmc.25.2019.08.27.02.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 02:45:01 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:44:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
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
Message-ID: <20190827094459.GB4804@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190807201528.GO250418@google.com>
 <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
 <20190816175317.GU250418@google.com>
 <20190819100241.5pctjxmsq6crlale@holly.lan>
 <20190819185049.GZ250418@google.com>
 <20190820135617.64urowbu2kwdynib@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820135617.64urowbu2kwdynib@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

[...]

> > IIUC the conclusion is that there is no need for a string attribute
> > because we only need to distinguish between 'perceptual' and
> > 'non-perceptual'. If that is correct, do you have any preference for
> > the attribute name ('perceptual_scale', 'perceptual', ...)?
> 
> More a summary than a conclusion! There is a reason I have left a bit or
> space for others to comment on this over the last month (and a bit).
> 
> To be clear my Reviewed-by: means that I believe that the kernel is better
> with "non-linear/linear/unknown" than without it and that I am comfortable
> the API isn't likely to be a millstone for us.
> 
> Lee, Jingoo: Either of you care to offer $0.02

No, not really.  Happy to leave it to your good judgement.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
