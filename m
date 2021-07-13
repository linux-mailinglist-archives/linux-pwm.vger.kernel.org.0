Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AAC3C7077
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jul 2021 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbhGMMi1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Jul 2021 08:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbhGMMi1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jul 2021 08:38:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAA6C0613DD;
        Tue, 13 Jul 2021 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=febXSlnqHBcqwfMc/cqWyNSs3akzUbytq0SHLTlJG6U=; b=wPXgU39qlJPnevOo2ICp2PMxP
        +YC8r/8c8Vj25gmY9Scs+ok/PGyXY1Bia34Bc8wTxnp82+y/f8nQMDcoPw1Z1r6PczS+26YDd8QR8
        qGLzpDjsCWZ4HXc2AQ5svfmxovOezfPTcM/4nxZOmWmgVpoUqGIuXBOTyDLenwG14qv+VCWymsxzJ
        RF0Tsv3LZrAELaIIXLeD3vIdPsX3SGShsenxBcvij5WyzODC0qPGVLjgUj2W/wKV/RzzXo3kc8OaU
        RF4GpCCAtpncSxJ3+R7Jl+xNn2cCpVVaPUEFeq6i0Lt0x8frgxwYiKBMrHlkq3lxqZSS6WH8Q+p3x
        c6IGcX1vg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46054)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m3HdM-00066q-G3; Tue, 13 Jul 2021 13:35:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m3HdK-0000Hf-Gf; Tue, 13 Jul 2021 13:35:30 +0100
Date:   Tue, 13 Jul 2021 13:35:30 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Salah Triki <salah.triki@gmail.com>,
        "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] divide by 3*sizeof(u32) when computing array_size
Message-ID: <20210713123530.GI22278@shell.armlinux.org.uk>
References: <20210712231910.GA1831270@pc>
 <20210713063053.qqttzxlopvpnadj3@pengutronix.de>
 <20210713091954.GG22278@shell.armlinux.org.uk>
 <012ccfea2a564274bd9d2e1cfc130873@AcuMS.aculab.com>
 <20210713112253.GH22278@shell.armlinux.org.uk>
 <2f725f0be09349308bf7d9a24399d516@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f725f0be09349308bf7d9a24399d516@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 13, 2021 at 12:20:26PM +0000, David Laight wrote:
> > > For big structures it is worth adding a compile-time check of
> > > the structure size - but not really for three u32.
> > 
> > Sorry, structure size has absolutely nothing to do with whether it's
> > a good idea to have a compile-time check. The deciding factor is
> > whether the code relies on some property such as it being a certain
> > size. Such as in this exact case. If you grep for "BUILD_BUG_ON.*sizeof"
> > in fs/ for example, this illustrates the point rather well.
> 
> I'd not bother if the size is obviously going to be correct.

That's fine if you assume that the structure isn't going to be changed.
In this case, you can't do that - the structure looks to be a driver
internal structure. It certainly doesn't look like an interface to
anything that matters.

The code as written relies on the assumption that an array of
struct stm32_breakinput can be directly mapped to an array of u32,
where every third element of the u32 array falls on the first member
of each stm32_breakinput member. That is a _significant_ assumption
that the code _should_ be checking for.

> I did get some odd bugs a few years ago from a compiler that aligned
> all structures on 4-byte boundaries.
> I had to change a structure of two u16 into an array :-)

ARM OABI will do exactly that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
