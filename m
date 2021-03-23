Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95536345877
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Mar 2021 08:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCWHT4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Mar 2021 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhCWHTf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Mar 2021 03:19:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA47C061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Mar 2021 00:19:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a7so25379764ejs.3
        for <linux-pwm@vger.kernel.org>; Tue, 23 Mar 2021 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0ZRWR7SyUfOFjKEhmvgj2n6DxL2rukToh7fqH5zbAY0=;
        b=tPFcX58ojqyf6SXv96EFP8FxHVmIAE8EjX/vZmP5zuB7KXDIZ/HYo29NUKR2tfNyKZ
         0EClqWxQXI/wZC6dJB2iVopWInz5N3ftT6rYwFmHVAk1CB1T/buLH7Evce318QrTWYaR
         vwC17qEl6oRcLQwob9mfed2D2xdvdlbrTMPa3gRu0d0vZqkwi6AQcpCCCPP7ddL2bpbX
         VOEbxcJ2iLSH4xjakMJeqV406ULIO3Zgew28wfgEv1NCo+VsgdBQ9SLQdaunBqSqskSj
         3xIu4u5brjzcOOa+vMrEuVNurTOokraJxImPknp3swP9G2FHFNF3qV3Xw7DyUR/26o5k
         +xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0ZRWR7SyUfOFjKEhmvgj2n6DxL2rukToh7fqH5zbAY0=;
        b=MUUQzhCQfqFIJE1fmzFo1kXa7H5xon/6ojr2u/lMtOONdaIj221TCKf5S8R8l7lJsd
         LNywblaeoxyaoTCL3ojTqqV/cvPaB/qCNeks2Aq9PH5Ru6VLSHuAr40VMzoo9GNMUMmj
         AUNl8PLT0ujv83aEjRlKs+5qNHLDx1kS3Fd7yEPy/4EvQm4N+aBu5A/nApqBf1cn80Qi
         GNY6wBNGVEqWx0iRuQFDeyf2ceeYNkHoKU2mtSUk4hsYN4qy2WzPRF0AG3uToKR+6l2G
         f4hwfSAoyJjdg8xjFq5K/y/uvCYaHQDmumYnJx+s/iuwX7BivwaMljOO2DDBvrUBtPeO
         LBRg==
X-Gm-Message-State: AOAM531BUc3K5fWLAYj1dV73gZL5Wab9WjkKSQHQEnktwNQK24LRPhRf
        RpPHDhJt12C+SZYCZCn7IkLTXw==
X-Google-Smtp-Source: ABdhPJzII9/3F/d3MIJ9LRagad+ReiGv4LKjlMdJhVAqh1b6LBFoMIOzP25UxaYZyPnS0WB7mNevtw==
X-Received: by 2002:a17:907:98f5:: with SMTP id ke21mr3552827ejc.552.1616483971317;
        Tue, 23 Mar 2021 00:19:31 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id r17sm10931354ejz.109.2021.03.23.00.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 00:19:30 -0700 (PDT)
Date:   Tue, 23 Mar 2021 07:19:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 00/14] pwm: Patches I consider ready for the next merge
 window
Message-ID: <20210323071929.GD2916463@dell>
References: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
 <YFia9Q4lLIlKdEmf@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFia9Q4lLIlKdEmf@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 22 Mar 2021, Thierry Reding wrote:

> On Fri, Mar 19, 2021 at 11:28:38AM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > this is the set of patches that are open on the list for some time.
> > Lee suggested to resend them.
> > 
> > @Thierry: I'm unsure what is the best way to nag. Is it really
> > resending? Or does this just result mostly in overhead because the
> > patches are still open in patchwork and it adds copies to your mailbox?
> > (Another downside is that taking the patches from this thread results in
> > recording a newer Author Date compared to picking up the originals.)
> 
> I use patchwork extensively for tracking, so merely resending patches so
> that they float to the top of my inbox isn't useful in itself. Patches
> do, by the way, float to the top of my inbox when you just reply to them
> (e.g. by pinging). Resending a particular series is fine because it's
> then easy to mark the old version as "superseded". Sending a collection
> of patch such as this is a bit more annoying because now the duplicates
> are spread about a bit more in patchwork, so it's a bit more work to get
> patchwork cleaned up. But it's not that bad, so no harm done.
> 
> Usually when I look at patchwork I will look at the A/F/R/T column and
> the more flags I see there, the more likely I will be to go and apply
> it. Anything else I will go and look at myself and comment and/or apply
> or sometimes wait for someone else to review.
> 
> Perhaps a better way to nag me would be to delegate patches that you've
> reviewed or think are ready to me, which would make them stand out more
> among the others.

It's not Uwe's fault, it's mine.

Since some of Uwe's patches had been left unreviewed for several
weeks, I asked him to collect up all of his dangling patches and
submit this resend for *me* to review.

As someone who does not use Patchwork, I find this to be the simplest
and cleanest method of patch collation.  Going by your almost
immediate reply, I guess it had a nice desired side-effect. :)

Thanks for taking the time.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
