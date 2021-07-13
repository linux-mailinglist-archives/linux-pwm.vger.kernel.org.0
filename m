Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C879A3C6FA4
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jul 2021 13:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhGMLZx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Jul 2021 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbhGMLZx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jul 2021 07:25:53 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E493C0613DD;
        Tue, 13 Jul 2021 04:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yGhDFnZM0A65W5PQXub87bUt7hi0BbiF5BkXDcA/Zr4=; b=ffLTrSEP1oIazt9MQBn1/8er4
        3sgMpXXzNFjn9Tdwdueb36QlruzqqCcSURPnHeqedRvfFPWhkTHYdYjjG4fvWr24TDV3ZFZnD7Vqb
        6zUhqHqoYcrwDJGYnSZGJEfEIPtXjGRiYqf6qn+ULprCyZCttHZ0+87T4GbudVKnv/URIkSiVuXsP
        qCm2q6xIAIof9Wc45z860/XHYcV2wK1xBl3lBTz8N6rV2i90D+fjEcaAOJkmffMvNQ2AZIyLtgsfp
        EvE/2PWJx5eau5kMIjcVs9L5SlE0lWfY4I6n9gTkwU5GVX+8uXaNBX3kL3L5xuitIuy8Q5zXnHOYz
        fWMql0T3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46046)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m3GV5-00060D-8l; Tue, 13 Jul 2021 12:22:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m3GV3-0000Ew-8A; Tue, 13 Jul 2021 12:22:53 +0100
Date:   Tue, 13 Jul 2021 12:22:53 +0100
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
Message-ID: <20210713112253.GH22278@shell.armlinux.org.uk>
References: <20210712231910.GA1831270@pc>
 <20210713063053.qqttzxlopvpnadj3@pengutronix.de>
 <20210713091954.GG22278@shell.armlinux.org.uk>
 <012ccfea2a564274bd9d2e1cfc130873@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012ccfea2a564274bd9d2e1cfc130873@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 13, 2021 at 11:07:00AM +0000, David Laight wrote:
> From: Russell King
> > Sent: 13 July 2021 10:20
> ....
> > I would also note that the code relies on there being no padding in
> > struct stm32_breakinput - it should be noted that a strict
> > interpretation of the C standard allows padding to be added anywhere
> > to a structure - at the start, end or between members.
> 
> I'm pretty certain I remember that padding before the first member
> isn't allowed.

You may be right there.

> In any case the kernel generally assumes there is no extra padding.
> (eg for structures that map hardware registers.)

That's incorrect. Places where we care either generally end up with
__packed or are carefully layed out to ensure members are naturally
aligned to reduce the likelyhood of it. 32-bit OABI ARM has been
particularly "fun" in this respect.

> For big structures it is worth adding a compile-time check of
> the structure size - but not really for three u32.

Sorry, structure size has absolutely nothing to do with whether it's
a good idea to have a compile-time check. The deciding factor is
whether the code relies on some property such as it being a certain
size. Such as in this exact case. If you grep for "BUILD_BUG_ON.*sizeof"
in fs/ for example, this illustrates the point rather well.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
