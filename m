Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA5E43DA4
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2019 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbfFMPoB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Jun 2019 11:44:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36401 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732967AbfFMPoB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jun 2019 11:44:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so8314898plr.3
        for <linux-pwm@vger.kernel.org>; Thu, 13 Jun 2019 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5o6Xk9ScYRxy+DZ0+69hUl5hUqdW0wuATddsUALu0XI=;
        b=YrwQDeew1cdkq1HePhmUGExkzD7Hw0Tl9YIAShml3dVLN1XHu+g9LfJ8uAgS7R5RWE
         vVD76Aa60Fl6EQMMI+h5azGxOGo1dv54iB0+mySBPTr0F49K8qblZ6aupnQqoMwUQR64
         MMj6txi1/IGCtz2lKZFK2F0nwMFKLYBfm/IC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5o6Xk9ScYRxy+DZ0+69hUl5hUqdW0wuATddsUALu0XI=;
        b=LI3tXVLFXh1d6JXVrSwqINpyXZLueYV+WMCB/JUwGQCV21Bdw/h0haqYqG+SV8NA06
         YvXd/oZOQmHJ/cbMQD1WQam5oCvPoUH5fcA+T9iI/I6wO2Gfkbfuf5Vu4Ab7whzkjefc
         DE9/JVfFODiS1H1tgreODxLNsebv5JR98H9abo40qJ7/nwk6p3MpqxX27RHQf6WfnelZ
         /QhRKZS1cNevWyq348Wr0Wo5oBZI1TonlEyoKpWM3LJVhIQIzdE1OTpexwoT7NUXNDiG
         kmAFab2MQg8EGOQ5BDkS26tkFdfF9y0YVij53yjQKenhGOfY1Xfp9f2h1/1WFEyJ37PG
         /ijQ==
X-Gm-Message-State: APjAAAVpE0PrZ6x4c46v+z8979ok0j1T09bst/n5IlQ9VGpSi5vYjRg3
        dTbzsmmITsJE9zSCeTOmadkwOw==
X-Google-Smtp-Source: APXvYqyUWEmrNpFQmfgtHCbIExuUeMkq+BRkR8ZCRXQoaIKlUEIUFqCdlOi/wTKoB6TrOa2pgQk8TQ==
X-Received: by 2002:a17:902:24d:: with SMTP id 71mr90950845plc.166.1560440640131;
        Thu, 13 Jun 2019 08:44:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id w66sm83713pfb.47.2019.06.13.08.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 08:43:59 -0700 (PDT)
Date:   Thu, 13 Jun 2019 08:43:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Fix heuristic to determine number of
 brightness levels
Message-ID: <20190613154357.GN137143@google.com>
References: <20190612180003.161966-1-mka@chromium.org>
 <fd554750-7ec6-73e1-be3a-5bac0749fa0b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd554750-7ec6-73e1-be3a-5bac0749fa0b@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jun 13, 2019 at 11:14:55AM +0200, Enric Balletbo i Serra wrote:
> Hi Matthias,
> 
> On 12/6/19 20:00, Matthias Kaehlcke wrote:
> > With commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of
> > LED linearly to human eye") the number of set bits (aka hweight())
> > in the PWM period is used in the heuristic to determine the number
> > of brightness levels, when the brightness table isn't specified in
> > the DT. The number of set bits doesn't provide a reliable clue about
> > the length of the period, instead change the heuristic to:
> > 
> >  nlevels = period / fls(period)
> > 
> > Also limit the maximum number of brightness levels to 4096 to avoid
> > excessively large tables.
> > 
> > With this the number of levels increases monotonically with the PWM
> > period, until the maximum of 4096 levels is reached:
> > 
> > period (ns)    # levels
> > 
> > 100    	       16
> > 500	       62
> > 1000	       111
> > 5000	       416
> > 10000	       769
> > 50000	       3333
> > 100000	       4096
> > 
> > Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Tested on Samsung Chromebook Plus (16-bit pwm)
> 
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks!
