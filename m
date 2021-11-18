Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806AE4558B4
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Nov 2021 11:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244525AbhKRKOW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Nov 2021 05:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244516AbhKRKMv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Nov 2021 05:12:51 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A7C061764;
        Thu, 18 Nov 2021 02:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LbHt7EJoFhOZV5kub5JngiZnvgmRApjPOTDxo+lLz4I=; b=yn/MviBBs9GuGJOPYQtbWTc10J
        3bJXszwjy2n4ksLEz5pN3TssG6jLuQ7sloPDL/FkW1EEnTXGE0uNZwSGfd1+rV/gpp31so/+LrdmE
        G40SSHuM6NCyJ+LOZ+jISQ3AUBIGszfgs3k7GiftgJ0f6Itusd7TgmweSscUc3rCo/98OA6l5qLLD
        yLuHTZsYByFB9FyvFktEV6wbXp/4+1xsCHd9UnTULsnxpE3pXDBjSE5ppcnTZxK1yfaCB+hD+dp6H
        rzwlQe4d3vypAQ6v76WYLKoL8tral5qXuNoHfPx7t5MyHRG/xj1DRgGWYaFjhQXoBIIhpZbWMptjt
        3tp3Z5rg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55710)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mneMT-0002nO-5y; Thu, 18 Nov 2021 10:09:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mneMP-0003qm-4t; Thu, 18 Nov 2021 10:09:41 +0000
Date:   Thu, 18 Nov 2021 10:09:41 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     cgel.zte@gmail.com, linux-pwm@vger.kernel.org,
        alexandre.belloni@bootlin.com, Zeal Robot <zealci@zte.com.cn>,
        linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com,
        thierry.reding@gmail.com,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: Use div64_ul instead of do_div
Message-ID: <YZYmZecp8WPkFY2F@shell.armlinux.org.uk>
References: <20211117020426.159242-1-deng.changcheng@zte.com.cn>
 <20211117112400.bkscb2pyavonpfsn@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211117112400.bkscb2pyavonpfsn@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 17, 2021 at 12:24:00PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Nov 17, 2021 at 02:04:26AM +0000, cgel.zte@gmail.com wrote:
> > From: Changcheng Deng <deng.changcheng@zte.com.cn>
> > 
> > do_div() does a 64-by-32 division. If the divisor is unsigned long, using
> > div64_ul can avoid truncation to 32-bit.
> 
> After some research I understood your commit log. I'd write:
> 
> 	do_div() does a 64-by-32 division. Here the divsor is an
> 	unsigned long which on some platforms is 64 bit wide. So use
> 	div64_ul instead of do_div to avoid a possible truncation.
> 
> The priority of this patch seems to be low, as the device seems to exist
> only on (32bit) arm.

... where unsigned long is 32-bit.

In any case, for this to overflow, we would need to have a clock in
excess of 2^32-1 Hz, or around 4GHz - and if we had such a situation
on 32-bit devices, we need to change the type for holding the frequency
in the clk API, and probably a lot of code in the CCF as well.

Unless there is a real reason for this change, I would suggest leaving
the code as is - there is absolutely no point in making these divisions
more expensive unless there is a real reason.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
