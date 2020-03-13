Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902401840EB
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2020 07:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgCMGpO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Mar 2020 02:45:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58141 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgCMGpO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Mar 2020 02:45:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jCe4D-00078K-5C; Fri, 13 Mar 2020 07:45:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jCe45-0002pC-Ep; Fri, 13 Mar 2020 07:45:01 +0100
Date:   Fri, 13 Mar 2020 07:45:01 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     thierry.reding@gmail.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: mvebu: avoid error message for optional IRQ
Message-ID: <20200313064501.43h5htrebbgceudj@pengutronix.de>
References: <20200313034244.26336-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200313034244.26336-1-chris.packham@alliedtelesis.co.nz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Fri, Mar 13, 2020 at 04:42:44PM +1300, Chris Packham wrote:
> platform_get_irq() will generate an error message if the requested irq
> is not present
> 
>   mvebu-gpio f1010140.gpio: IRQ index 3 not found
> 
> use platform_get_irq_optional() to avoid the error message being
> generated.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

LGTM

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
