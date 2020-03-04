Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D51178AF0
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Mar 2020 07:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCDGw4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Mar 2020 01:52:56 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50831 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgCDGw4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Mar 2020 01:52:56 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j9Ntm-0004oa-RJ; Wed, 04 Mar 2020 07:52:54 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j9Ntl-0000ez-Rf; Wed, 04 Mar 2020 07:52:53 +0100
Date:   Wed, 4 Mar 2020 07:52:53 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2] pwm: Enable compile testing for some of drivers
Message-ID: <20200304065253.dhxwemlc7skp2gbt@pengutronix.de>
References: <20200303202447.4245-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303202447.4245-1-krzk@kernel.org>
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

On Tue, Mar 03, 2020 at 09:24:47PM +0100, Krzysztof Kozlowski wrote:
> Some of the PWM drivers can be compile tested to increase build
> coverage.
> 
> The Meson PWM driver requires COMMON_CLK dependency.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com> # For Broadcoam
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # For Meson
> Acked-by: Claudiu Beznea <claudiu.beznea@microchip.com> # For Atmel

I wonder if this results in some autobuilder fallout, but even if it
does I still think this is a good thing to do.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
