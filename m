Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE6694D54
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfHSS6T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 14:58:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44810 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfHSS6T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 14:58:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so1391169plr.11
        for <linux-pwm@vger.kernel.org>; Mon, 19 Aug 2019 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0e2APdFMcCL115V7DOVVJSnlHloFclNY39dd69/lO0=;
        b=WbPRIlO58ztUhi7i2oz12gIxghvYFhvGj5detvHL64ciojw1Jbh1rIUinASAN5D8ZH
         oktM00ScxqNk41KTkk3qw/+BHQPD4Q3wJeTI1oV2U3gwQatbTu8PX10ZFmAfuarYSyE2
         ivJrpHi6loe1F9bmEmdOWwWzx2oF50n/ZrQtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0e2APdFMcCL115V7DOVVJSnlHloFclNY39dd69/lO0=;
        b=ey0eyVHQBtxldOyTcMooRhR0skTELKSRot2rQT7zO4dfh+8lbW8aamFQ10Sik3/l1E
         d+fleHAJLhJId7FHAWZ3hgTINvCUQ2LtkdH1rNCLesAfvKEzLf7G8Z+ZLhHIY3ULcFa6
         6S+cKuKYP05KzmCUh0SvSVVpe64ss5Z+laU9RWWNgNGm5PxITMDXqeuDX+haAwVzSG3O
         KSW7nQrdv40RR2A/52hdYEnQGQvtnglx42Ek2pFrwtjJPbMExLFTpfire7fXAoyPOjHJ
         ucUUN9KkyDxXuNo7Ysoy9p9bJt1vhmXtIJMnqBL0Obc9///FDYp4j+ZUYv/vw5/b2feS
         oydQ==
X-Gm-Message-State: APjAAAWg5hrbUcRRBuxr8vXIYpJXMpiF4lFV8I1CIADoR/yH76I8bRoM
        hWknsSBsb44J8Yi2WrVvI7Qsig==
X-Google-Smtp-Source: APXvYqxh+E8TFUryXTjcfNmp7eEgV3tGYzniOp22FCvAHtBGpb7ARiJTtlOQVWkRBrXizfRtmjdGHw==
X-Received: by 2002:a17:902:788b:: with SMTP id q11mr24093153pll.308.1566240655357;
        Mon, 19 Aug 2019 11:50:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x25sm18660949pfa.90.2019.08.19.11.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 11:50:54 -0700 (PDT)
Date:   Mon, 19 Aug 2019 11:50:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
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
Message-ID: <20190819185049.GZ250418@google.com>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190807201528.GO250418@google.com>
 <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
 <20190816175317.GU250418@google.com>
 <20190819100241.5pctjxmsq6crlale@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190819100241.5pctjxmsq6crlale@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Daniel,

On Mon, Aug 19, 2019 at 11:02:41AM +0100, Daniel Thompson wrote:
> On Fri, Aug 16, 2019 at 10:53:17AM -0700, Matthias Kaehlcke wrote:
> > On Fri, Aug 16, 2019 at 04:54:18PM +0100, Daniel Thompson wrote:
> > > On 07/08/2019 21:15, Matthias Kaehlcke wrote:
> > > > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> > > > > Backlight brightness curves can have different shapes. The two main
> > > > > types are linear and non-linear curves. The human eye doesn't
> > > > > perceive linearly increasing/decreasing brightness as linear (see
> > > > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > > > linearly to human eye"), hence many backlights use non-linear (often
> > > > > logarithmic) brightness curves. The type of curve currently is opaque
> > > > > to userspace, so userspace often uses more or less reliable heuristics
> > > > > (like the number of brightness levels) to decide whether to treat a
> > > > > backlight device as linear or non-linear.
> > > > > 
> > > > > Export the type of the brightness curve via the new sysfs attribute
> > > > > 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> > > > > 'unknown'. For devices that don't provide information about the scale
> > > > > of their brightness curve the value of the 'scale' attribute is 'unknown'.
> > > > > 
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > 
> > > > Daniel (et al): do you have any more comments on this patch/series or
> > > > is it ready to land?
> > > 
> > > I decided to leave it for a long while for others to review since I'm still
> > > a tiny bit uneasy about the linear/non-linear terminology.
> > > 
> > > However that's my only concern, its fairly minor and I've dragged by feet
> > > for more then long enough, so:
> > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > 
> > Thanks!
> > 
> > If you or someone else has another suggestion for the terminology that
> > we can all agree on I'm happy to change it.
> 
> As you will see in my reply to Uwe. The term I tend to adopt when I want
> to be precise about userspace behaviour is "perceptual" (e.g. that a
> backlight can be mapped directly to a slider and it will feel right).
> 
> However that raises its own concerns: mostly about what is perceptual
> enough.
> 
> Clear the automatic brightness curve support in the PWM driver is
> perceptual.
> 
> To be honest I suspect that in most cases a true logarithmic curve (given a
> sane exponent) would be perceptual enough. In other words it will feel
> comfortable with a direct mapped slider and using it for animation
> won't be too bad.
> 
> However when we get right down to it *that* is the information that is
> actually most useful to userspace: explicit confirmation that the scale
> can be mapped directly to a slider. I think it also aligned better with
> Uwe's feedback (e.g. to start working towards having a preferred scale).

IIUC the conclusion is that there is no need for a string attribute
because we only need to distinguish between 'perceptual' and
'non-perceptual'. If that is correct, do you have any preference for
the attribute name ('perceptual_scale', 'perceptual', ...)?
