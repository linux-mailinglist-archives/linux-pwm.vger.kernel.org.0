Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087C33C6D2D
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jul 2021 11:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhGMJWy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Jul 2021 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhGMJWu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jul 2021 05:22:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4D8C0613DD;
        Tue, 13 Jul 2021 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3U4fXEvYZQ6jKgkN4/AU7jjky/mHZ4e2qC/cN+142q0=; b=ZbjSuQFu6xUZKyZmP35KKaa7h
        oWMT3hLQ9U1A2HSPpBdszaEgUZ1/9Ac9qHhgTIMIFET76inyqnQZMbTQPGp1ookCogmz/lhU6Iijo
        EancHG/EMjM0MUzW9zmyJGKlOy3VgtfXFRr8VBW2BDrG/zpZ0f8UgXyOB4jIC+a5Vvr3Vq56vEmvB
        y1Zc8FLFWBl70qcGOTu3a5/hbbtDY9oi2MFiySCgCTwNpsEcTx887gGRqQ4gOuQzoza3e0PWGUvjt
        w4FxDaZz6plRmLauHEHixlZvZs2y/ggp17tTlk7HglTPwBXz3qRVqUYSN+02MmxecPpvzpzGOzMRK
        kygaE7KLw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46044)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m3Ea4-0005pG-7B; Tue, 13 Jul 2021 10:19:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m3Ea2-0000Am-Kx; Tue, 13 Jul 2021 10:19:54 +0100
Date:   Tue, 13 Jul 2021 10:19:54 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Salah Triki <salah.triki@gmail.com>, fabrice.gasnier@foss.st.com,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] divide by 3*sizeof(u32) when computing array_size
Message-ID: <20210713091954.GG22278@shell.armlinux.org.uk>
References: <20210712231910.GA1831270@pc>
 <20210713063053.qqttzxlopvpnadj3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210713063053.qqttzxlopvpnadj3@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 13, 2021 at 08:30:53AM +0200, Uwe Kleine-König wrote:
> Hello Salah,
> 
> On Tue, Jul 13, 2021 at 12:19:10AM +0100, Salah Triki wrote:
> > Divide by 3*sizeof(u32) when computing array_size, since stm32_breakinput
> > has 3 fields of type u32.
> > 
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---
> >  drivers/pwm/pwm-stm32.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index 794ca5b02968..fb21bc2b2dd6 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -544,7 +544,7 @@ static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
> >  		return -EINVAL;
> >  
> >  	priv->num_breakinputs = nb;
> > -	array_size = nb * sizeof(struct stm32_breakinput) / sizeof(u32);
> > +	array_size = nb * sizeof(struct stm32_breakinput) / (3 * sizeof(u32));
> >  	ret = of_property_read_u32_array(np, "st,breakinput",
> >  					 (u32 *)priv->breakinputs, array_size);
> >  	if (ret)
> 
> I agree with Philipp here; this looks strange and needs a better
> description.
> 
> Looking a bit more in details:
> 
>  - priv->breakinputs has type struct stm32_breakinput[MAX_BREAKINPUT]
>  - nb is in [0 .. MAX_BREAKINPUT]
>  - sizeof(struct stm32_breakinput) == 3 * sizeof(u32)
>  - of_property_read_u32_array reads $array_size u32 quantities
> 
> so to read $nb members of type stm32_breakinput array_size must be a
> multiple of 3 which isn't given any more after your patch. This makes me
> believe your suggested change to be wrong.

I concur with your analysis. "array_size" is the number of u32 values
to read from DT. It is not the number of entries in priv->breakinputs.

I would also note that the code relies on there being no padding in
struct stm32_breakinput - it should be noted that a strict
interpretation of the C standard allows padding to be added anywhere
to a structure - at the start, end or between members.

Some further thoughts... DT is effectively an interface (we maintain
definitions of what we expect.) The way the code is structured,
"struct stm32_breakinput" defines that interface. Maybe this should
be commented, and maybe there should be a build time assert that
"sizeof(struct stm32_breakinput)" is "3 * sizeof(u32)" since the
code is relying on that property?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
