Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8580CB472
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 08:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbfJDGXr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 02:23:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41963 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfJDGXr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Oct 2019 02:23:47 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iGH08-0002b5-Iz; Fri, 04 Oct 2019 08:23:40 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iGH04-0005Rk-Dy; Fri, 04 Oct 2019 08:23:36 +0200
Date:   Fri, 4 Oct 2019 08:23:36 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: Fix the usage of uninitialized variable in
 stm32_pwm_config()
Message-ID: <20191004062336.jidzrytx4z5talro@pengutronix.de>
References: <20191004044649.2405-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191004044649.2405-1-yzhai003@ucr.edu>
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

On Thu, Oct 03, 2019 at 09:46:49PM -0700, Yizhuo wrote:
> Inside function stm32_pwm_config(), variable "psc" and " arr"
> could be uninitialized if regmap_read() returns -EINVALs.
> However, they are used later in the if statement to decide
> the return value which is potentially unsafe.
> 
> The same case happens in function stm32_pwm_detect_channels()
> with variable "ccer", but we cannot just return -EINVAL because
> the error code is not acceptable by the caller. Aslo, the variable

s/Aslo/Also/

> "ccer" in functionstm32_pwm_detect_complementary() could also be

s/functionstm32_pwm_detect_/function stm32_pwm_detect_/

> uninitialized, since stm32_pwm_detect_complementary() returns void,
> the patch is not easy.

active_channels() is also affected. Also there are calls to
regmap_update_bits which should have their return values checked.

While a patch to fix these all is not trivial it is certainly possible
and I would prefer to fix the problem completely.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
