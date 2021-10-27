Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96443CB81
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Oct 2021 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbhJ0OHZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242299AbhJ0OHZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Oct 2021 10:07:25 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B826C061767
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 07:05:00 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so949808ooi.7
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VntufPEXWFWBoEDKmzIiyo/GIHA3Qut0nsI1RRSquPQ=;
        b=b1UGX9rErTp6W+4QIxehwiD2vWEVnO96A45hsBlatKYdl7QbrI9WKakB84huYPAA2w
         JYUJdbu1vtNCj2vv/XnjFio/MNRKVxv0jYJA3sy56eGrEAqqE4X/xSdj81dBbHmY5KJi
         j4OkPBAufm+jKunkkyK7mDNwpKCezsbDmPS2IcgRImLC7Qxh6SX9cFaOxswfxMzVcFFK
         95H9bsaUc0bpJbZbyjpZFZCziskFTMWhLC4vSVPW5k0xv6ujYE/s6E6W/auOa2e7OGBg
         B8AvE0RYLfATlhqRhvVlpS73eW20bEIuCXxIaeGopdOswiP+vau3eFKGk2+CSG0EvpHS
         r8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VntufPEXWFWBoEDKmzIiyo/GIHA3Qut0nsI1RRSquPQ=;
        b=IgjS6MMJMQ8pyD9fhE/wfWgi/iyDoDHwVKv7B+gv2rTjnhyL3THZtI2AZaSv9SUY0F
         HQ6HLYvMmPXXPRXLh2PZ3d6Ln5qGA8gaC0Y0vU472u3zpSJ5JTh7Jmu6NJI35nW5ibRq
         Ybhe3K3x6i32t4rEZpssDWdmF/UwVS7OS202reNkBzyGWBEPamYVqChyHIZJFhBgJp2z
         OwIP27C5TjAD7PNV4h1aMIYW5iKgBv2AZfDHpGepf2S47JP35sTpk2Ar2RV9VGXmgxq+
         riFgAxRhp9zRNEaaPI2DzMgFWBrxZGlka319ikAaZoOkrxgv+5zNyj7JRcKmwMTgaAVO
         u7ug==
X-Gm-Message-State: AOAM530tUl2UO4Cvlc/e/ACioADl3bpwbB2sFJ1l6wJuE8idlz4/YikM
        L2n6hclqoxOI9cJd6O9Ltz5bIQ==
X-Google-Smtp-Source: ABdhPJyn5syHeDgk5I1YEs92D7gGAaJtHbLqnyK3p9VdwN3sOi7j7PgsxuQuGYkzVcRWjuTLOsK9QQ==
X-Received: by 2002:a4a:de94:: with SMTP id v20mr22599573oou.77.1635343499224;
        Wed, 27 Oct 2021 07:04:59 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id i28sm31734ood.23.2021.10.27.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:04:58 -0700 (PDT)
Date:   Wed, 27 Oct 2021 07:06:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] drm/bridge: ti-sn65dsi86: Use regmap_bulk_write
 API
Message-ID: <YXlc+7BzbADe/p4A@ripper>
References: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
 <20211025170925.3096444-2-bjorn.andersson@linaro.org>
 <CAG3jFysN4pFqTrF8tGTVapCzysPkvO=MpYosAJnErY-AW7BqgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG3jFysN4pFqTrF8tGTVapCzysPkvO=MpYosAJnErY-AW7BqgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed 27 Oct 01:29 PDT 2021, Robert Foss wrote:

> Hey Bjorn,
> 
> On Mon, 25 Oct 2021 at 19:07, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > The multi-register u16 write operation can use regmap_bulk_write()
> > instead of two separate regmap_write() calls.
> >
> > It's uncertain if this has any effect on the actual updates of the
> > underlying registers, but this at least gives the hardware the
> > opportunity and saves us one transation on the bus.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Did you miss including Dougs R-B from v6? As far as I can tell nothing
> else changed between v6 & v7.
> 

Yes, I missed adding Doug's R-b from v6. I also missed fixing the
spelling of transaction (transation) in the commit message.

Would you be willing to correct these two items as you apply the
patches?

Thanks,
Bjorn

> > ---
> >
> > Changes since v6:
> > - None
> >
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > index 6154bed0af5b..5b59d8dd3acd 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -193,8 +193,9 @@ static const struct regmap_config ti_sn65dsi86_regmap_config = {
> >  static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
> >                                    unsigned int reg, u16 val)
> >  {
> > -       regmap_write(pdata->regmap, reg, val & 0xFF);
> > -       regmap_write(pdata->regmap, reg + 1, val >> 8);
> > +       u8 buf[2] = { val & 0xff, val >> 8 };
> > +
> > +       regmap_bulk_write(pdata->regmap, reg, buf, ARRAY_SIZE(buf));
> >  }
> >
> >  static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn65dsi86 *pdata)
> > --
> > 2.29.2
> >
