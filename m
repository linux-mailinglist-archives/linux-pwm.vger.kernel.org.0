Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63AC8E69
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2019 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfJBQcz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Oct 2019 12:32:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33508 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfJBQcz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Oct 2019 12:32:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so7278461pls.0
        for <linux-pwm@vger.kernel.org>; Wed, 02 Oct 2019 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHa2ifff61zSzcqlNyC/NW1wPlVFiEX+NgfwBD/73Mo=;
        b=oJ9hnWECguw7nK8f+kqKEFdwgoKdcYpQ6C2LocCNzbHG4wPPVwsgMTYGbs0DLoeBn9
         zpt70c81D/l56/svCOr4m8/Q27axDQS5LLI3KYhXMUFkhqNlCNyxIYmawcts1sabiJzs
         HODRZe6BFZAVOWl2G5Nvm2PTnB2dxGduISeDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHa2ifff61zSzcqlNyC/NW1wPlVFiEX+NgfwBD/73Mo=;
        b=hQtaV5zh/vEYMliaU5hbtMC8XuiW0EqRualWhcoOYPtv/wreX4Anq/thdlDxDUpwGq
         I/mI4AySbLV0gUJLsosyVRYvFU1Jjq63ssm22VsgF3uvZALzCtGs/fxvvi5uvmpPjVde
         3DUcR9QzqSNv38ASVwiVeUqz7Wm3+OHFP+ZTox/WhM603SC9Ml1J3ojheSstPl1hN0Pc
         r8LWfq0xeN7rMxMdzGo8qiaiZ7YEdHO3wOpTGsQNZxQSYlRUZv2rIHtXMxQD08Sdy+6a
         mQApTbLTuua4NLDeZk3B1u7N0TYP1ezVEuhraj9Y3k+zMfN6518zNEhPsKAlbuqcCyj3
         zjSg==
X-Gm-Message-State: APjAAAVTAHZcQ37/9KF4KOkCtALtF1BFjDSCeAWKDydRFTZ/S/LGEcNI
        tnso0kP6GvSkwrT9uJyYCegwFA==
X-Google-Smtp-Source: APXvYqzz5c1WsihtUOrz9EhiZpXsZb9IczkyfwU9rquOTW4vCRt+bTdbF/6F+a9Me86FT53hpQX64A==
X-Received: by 2002:a17:902:144:: with SMTP id 62mr4630720plb.283.1570033974166;
        Wed, 02 Oct 2019 09:32:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id r2sm22666315pfq.60.2019.10.02.09.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 09:32:52 -0700 (PDT)
Date:   Wed, 2 Oct 2019 09:32:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Don't assign levels table repeatedly
Message-ID: <20191002163248.GE87296@google.com>
References: <20191001162835.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
 <20191002100737.orm5ghpnw6oe6b3r@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191002100737.orm5ghpnw6oe6b3r@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 02, 2019 at 11:07:37AM +0100, Daniel Thompson wrote:
> On Tue, Oct 01, 2019 at 04:29:24PM -0700, Matthias Kaehlcke wrote:
> > pwm_backlight_probe() re-assigns pb->levels for every brightness
> > level. This is not needed and was likely not intended, since
> > neither side of the assignment changes during the loop. Assign
> > the field only once.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Makes sense but this should probably be dropping the curly braces too.

ack, I'll send a new version with the curly braces removed.

> >  drivers/video/backlight/pwm_bl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index 746eebc411df..959436b9e92b 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -564,6 +564,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  	memset(&props, 0, sizeof(struct backlight_properties));
> >  
> >  	if (data->levels) {
> > +		pb->levels = data->levels;
> > +
> >  		/*
> >  		 * For the DT case, only when brightness levels is defined
> >  		 * data->levels is filled. For the non-DT case, data->levels
> > @@ -572,8 +574,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  		for (i = 0; i <= data->max_brightness; i++) {
> >  			if (data->levels[i] > pb->scale)
> >  				pb->scale = data->levels[i];
> > -
> > -			pb->levels = data->levels;
> >  		}
> >  
> >  		if (pwm_backlight_is_linear(data))
> > -- 
> > 2.23.0.444.g18eeb5a265-goog
> > 
