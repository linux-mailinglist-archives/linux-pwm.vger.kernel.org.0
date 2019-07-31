Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2F7BA3B
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2019 09:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfGaHNE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 31 Jul 2019 03:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfGaHNE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 31 Jul 2019 03:13:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A39B206A3;
        Wed, 31 Jul 2019 07:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564557183;
        bh=Sp4+FZc9NKQ051raBO4CbmbijqaCq4A+7t/KXzXR3DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcPNd1Dbfemj0DZ/Hg9Jj+agvHlLUgthS0/+2n9XUyeuAwQp2I7SGqTxagJmH0NMy
         CL1NODGY2Lhc/C0+S14MXS+YGoSu/327OQu7/gfhJupm0HYcRA3LaYhLu3B6cHj7RY
         U1dIuXFpyYM4lUGToh3B19lANrE5BZGZW76ytwGc=
Date:   Wed, 31 Jul 2019 09:13:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 36/57] pwm: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190731071301.GA23317@kroah.com>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-37-swboyd@chromium.org>
 <20190731065853.3ohrhqtjtuhxfq5r@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190731065853.3ohrhqtjtuhxfq5r@pengutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jul 31, 2019 at 08:58:53AM +0200, Uwe Kleine-König wrote:
> On Tue, Jul 30, 2019 at 11:15:36AM -0700, Stephen Boyd wrote:
> > We don't need dev_err() messages when platform_get_irq() fails now that
> > platform_get_irq() prints an error message itself when something goes
> > wrong. Let's remove these prints with a simple semantic patch.
> 
> Looking at v5.3-rc2 it's not obvious to me that all error paths of
> platform_get_irq issue an error message. Do I miss something?

The commit is in my driver-core tree at the moment, so this should wait
until 5.4-rc1.  I woudn't recommend merging it in 5.3-rc as it's not a
bugfix.

thanks,

greg k-h
