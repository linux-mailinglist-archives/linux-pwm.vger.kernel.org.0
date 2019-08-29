Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C93A1C61
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Aug 2019 16:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfH2OJK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Aug 2019 10:09:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44934 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2OJK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Aug 2019 10:09:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id b6so789724wrv.11
        for <linux-pwm@vger.kernel.org>; Thu, 29 Aug 2019 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IkHNgNXF6D7gCyp+RTOcFkFjmwHzwHacGQCef/fkUxY=;
        b=xFOj/svuT22SFm97iQcFsK0oNFWzU154jPyVuCgNRf5gyBEcfHhZ2ZsekaoCHfHUm9
         s6hPxGLyB/81mzV7lVqSs/AUJShAiedtr5S85sXwK3ra0J54ydcopngIC6im8ct3ziDM
         jCXSqPriXn4lrUAtUn2oU1+EIn67VeCKSLM5ljZ7yJHmM4TooBhQ7O3TFc3hWlzQsWf6
         HKmgS8YkGFWZwEV79UeejLszdVZJPS7YT+OMKbBA8/OUuPwvsJIhQ69adRXIwa68KfKP
         9MtDV92BUEiGX36sbnzNHwQGQdXswpSiKsjsQGwbJ15TNO2d3vyDdGf5aHTv1C+li7Oz
         uvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IkHNgNXF6D7gCyp+RTOcFkFjmwHzwHacGQCef/fkUxY=;
        b=aOvkBi6NvTVke+euPCx2gK7pJEh01A5MiE0GDrcwLuf5IKSqBmhQhKLgu+XoRzGb7G
         GEQ+jiB1DlPAl/XpuyJKnAhlV5xof7lGoWjw5M1dsPqxcII2O3xLJKhcauG4QS2HB5FH
         rRXmdinrPbARWuQV+kxY7jEm3Zr1bd6Q9zRZWc5IcTZin8k0m76bhl74aXt7jEMqP437
         l/5mqG4A8odcQlW/J/+E8RMX8eRWe0Lqo7SSPiQXzJYjkt5IqRmCEQEEU9i2m5HzkSLd
         WedFtUGPRP0w7TmUZIm4UaIjMIGQUHa5U0q5LOxsgHkdGEiOKTHENfFN4rrQRxp/4vK2
         O6HQ==
X-Gm-Message-State: APjAAAWG+1dGp1vThHa+4aSH18LcIMOX4qf9t7lhMfnHtQivg7ZBGppm
        tG+dNdvIWSaMdtqBpD/rHXA39Q==
X-Google-Smtp-Source: APXvYqwiMxS8OI3sVqHrlxU2MXj7Dr8WUNvrh5fZlS6vkfDCaJgvdL8CdRuYQ0wj2AMCRBXiyNGY7g==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr12172324wrq.29.1567087748452;
        Thu, 29 Aug 2019 07:09:08 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x10sm3753474wrn.39.2019.08.29.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:09:07 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:09:05 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
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
Message-ID: <20190829140905.wkv2pwzmhhfyzan4@holly.lan>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190807201528.GO250418@google.com>
 <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
 <20190816175317.GU250418@google.com>
 <20190819100241.5pctjxmsq6crlale@holly.lan>
 <20190819185049.GZ250418@google.com>
 <20190820135617.64urowbu2kwdynib@holly.lan>
 <20190827094459.GB4804@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827094459.GB4804@dell>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 27, 2019 at 10:44:59AM +0100, Lee Jones wrote:
> [...]
> 
> > > IIUC the conclusion is that there is no need for a string attribute
> > > because we only need to distinguish between 'perceptual' and
> > > 'non-perceptual'. If that is correct, do you have any preference for
> > > the attribute name ('perceptual_scale', 'perceptual', ...)?
> > 
> > More a summary than a conclusion! There is a reason I have left a bit or
> > space for others to comment on this over the last month (and a bit).
> > 
> > To be clear my Reviewed-by: means that I believe that the kernel is better
> > with "non-linear/linear/unknown" than without it and that I am comfortable
> > the API isn't likely to be a millstone for us.
> > 
> > Lee, Jingoo: Either of you care to offer $0.02
> 
> No, not really.  Happy to leave it to your good judgement.

In that case... the patch has my reviewed-by and although the concerns
raised in the associated threads have merit I don't think they are
enough to stop the patch.

Please merge.


Daniel.

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
