Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C83CC37F
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 21:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfJDTWR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 15:22:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60479 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfJDTWR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Oct 2019 15:22:17 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iGT9a-0005j9-2W; Fri, 04 Oct 2019 21:22:14 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iGT9W-0006gL-R1; Fri, 04 Oct 2019 21:22:10 +0200
Date:   Fri, 4 Oct 2019 21:22:10 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/6] dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
Message-ID: <20191004192210.777t6tuku3y45fn3@pengutronix.de>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
 <20191004133207.6663-5-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191004133207.6663-5-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 04, 2019 at 03:32:05PM +0200, Rasmus Villemoes wrote:
> We need to increase the pwm-cells for the optional flags parameter, in
> order to implement support for polarity setting via DT.
> 
> Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
