Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366EA345A4A
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Mar 2021 10:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCWJDU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Mar 2021 05:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCWJCz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Mar 2021 05:02:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B364C061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Mar 2021 02:02:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bf3so22566550edb.6
        for <linux-pwm@vger.kernel.org>; Tue, 23 Mar 2021 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PwQ1zGRRJZeMl0raQjRJkQLHTRA1rJVceDRF8uADlX8=;
        b=Y+RXJsq2EZJG/tEdyfA9tkHPOgqSBoirN14I+t5ux9volZ7wMGYwg1CXqneAk5jl5N
         m2Lj0aJL6jzGB/IImHo8Cu0EY533UohVq4kwOUyvexQi/WuNty1LRnqF/IDGCpBA3Vyp
         JySfp1Qk8AoQANclcS/CA1zMtAPrdcCWUDUqZY2eLK20daHsW6NGa6ZFXKLBa1fJA2GJ
         CZUV6Zj8WF7AtUIreD+QkoxdM5yw6gU1BlDvA8aT+sqUtoX32tLJoRosoByDUAElzGLv
         S+05QIlrLJ1gg7Spp4Sh3BkYVrjxyJU/z4AsHnx+4KMw0XxDlGS2yMgYgVHoEwYgrHWJ
         SyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PwQ1zGRRJZeMl0raQjRJkQLHTRA1rJVceDRF8uADlX8=;
        b=OwhgkYzcfjzMU84aTf6+bDDr9ouQxuMpd2vVHewpyG5ZrBU0qou7+4wNYV4KLoK2jb
         dspb6xGAXVuExVCRJSEfpPFLAqbWj1bU3mC2YCwk2rjFuw2jCfULf1ywKHcmV7vLHQT/
         pvhRSL7ODPCxKNdaZYSQ8o1SMV1KBvN7jVVOzXOeIm5l3jIUOKMD3Nbc3+Euvq+zMU5S
         G70lpMfThB4wMMoO9ig+/EsujD2gdT9kNhosJ359SNVN2X4efwMZrd8Mtw1tuyeQdGO3
         F1TR0wLjQxhXptAentHf5HBSHNnGpGplq4UhMCfGZD6gZ/2D1fgP4ltuDNkfsK5yVl+j
         Hvlg==
X-Gm-Message-State: AOAM533o9zDbZJYodV/EhGBtxNLyivpU7ecn4U8MS3RGW7smkhvrlM6v
        EtmfP4ry7EFQM2PbxDzHErLHO4CQiVejzg==
X-Google-Smtp-Source: ABdhPJzmMiYLGy8AK1yl217amnbVtAFik1HvZcx+liE4IQCs4pMsLx/whvEZKMD/RdLvp7G2NNiWjA==
X-Received: by 2002:a05:6402:3047:: with SMTP id bu7mr3542853edb.227.1616490174274;
        Tue, 23 Mar 2021 02:02:54 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id lm24sm10948540ejb.53.2021.03.23.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:02:53 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:02:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 00/14] pwm: Patches I consider ready for the next merge
 window
Message-ID: <20210323090252.GI2916463@dell>
References: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
 <YFia9Q4lLIlKdEmf@orome.fritz.box>
 <20210323071929.GD2916463@dell>
 <YFmso17v2N270Dd+@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFmso17v2N270Dd+@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 23 Mar 2021, Thierry Reding wrote:

> On Tue, Mar 23, 2021 at 07:19:29AM +0000, Lee Jones wrote:
> > On Mon, 22 Mar 2021, Thierry Reding wrote:
> > 
> > > On Fri, Mar 19, 2021 at 11:28:38AM +0100, Uwe Kleine-König wrote:
> > > > Hello,
> > > > 
> > > > this is the set of patches that are open on the list for some time.
> > > > Lee suggested to resend them.
> > > > 
> > > > @Thierry: I'm unsure what is the best way to nag. Is it really
> > > > resending? Or does this just result mostly in overhead because the
> > > > patches are still open in patchwork and it adds copies to your mailbox?
> > > > (Another downside is that taking the patches from this thread results in
> > > > recording a newer Author Date compared to picking up the originals.)
> > > 
> > > I use patchwork extensively for tracking, so merely resending patches so
> > > that they float to the top of my inbox isn't useful in itself. Patches
> > > do, by the way, float to the top of my inbox when you just reply to them
> > > (e.g. by pinging). Resending a particular series is fine because it's
> > > then easy to mark the old version as "superseded". Sending a collection
> > > of patch such as this is a bit more annoying because now the duplicates
> > > are spread about a bit more in patchwork, so it's a bit more work to get
> > > patchwork cleaned up. But it's not that bad, so no harm done.
> > > 
> > > Usually when I look at patchwork I will look at the A/F/R/T column and
> > > the more flags I see there, the more likely I will be to go and apply
> > > it. Anything else I will go and look at myself and comment and/or apply
> > > or sometimes wait for someone else to review.
> > > 
> > > Perhaps a better way to nag me would be to delegate patches that you've
> > > reviewed or think are ready to me, which would make them stand out more
> > > among the others.
> > 
> > It's not Uwe's fault, it's mine.
> > 
> > Since some of Uwe's patches had been left unreviewed for several
> > weeks, I asked him to collect up all of his dangling patches and
> > submit this resend for *me* to review.
> 
> Like I said, it's not a big deal. And I'm also aware that this is misery
> of my own making, so no worries.
> 
> > As someone who does not use Patchwork, I find this to be the simplest
> > and cleanest method of patch collation.  Going by your almost
> > immediate reply, I guess it had a nice desired side-effect. :)
> 
> Indeed, it achieved the desired effect, so can't argue about its
> effectiveness. =)

=:D

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
