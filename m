Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1375304E26
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Jan 2021 02:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbhA0ALx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Jan 2021 19:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbhAZRsG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 26 Jan 2021 12:48:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AC6522210;
        Tue, 26 Jan 2021 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611683241;
        bh=QSjIGuM+C7xQtQ14wnMWe+u6NdcYkUxatuTFVksOG3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Geex34o5uUaWTbBVZucPZI2Ib3kgkcnIa+9Dfi4qkRH+mZ4XQbGEETqDD2J0mtTMD
         2DPI39krNL7x7OYED8/yjB4wDxxseOhsvgpFVpxGsknHvGa+z0NrX/lyP8Jf0Amzl2
         8mE+2/3HIkCZuCZyoExOoitRzEnwv9rKofAVxRrY=
Date:   Tue, 26 Jan 2021 18:47:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     u.kleine-koenig@pengutronix.de, devel@driverdev.osuosl.org,
        linux-pwm@vger.kernel.org, f.fainelli@gmail.com,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy.shevchenko@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        wahrenst@gmx.net, p.zabel@pengutronix.de,
        linux-input@vger.kernel.org, bgolaszewski@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v7 07/11] staging: vchiq: Release firmware handle on
 unbind
Message-ID: <YBBVp4Miin2uT8tF@kroah.com>
References: <20210118123244.13669-1-nsaenzjulienne@suse.de>
 <20210118123244.13669-8-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118123244.13669-8-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jan 18, 2021 at 01:32:40PM +0100, Nicolas Saenz Julienne wrote:
> Use devm_rpi_firmware_get() so as to make sure we release RPi's firmware
> interface when unbinding the device.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
