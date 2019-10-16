Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6228AD8F0D
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390824AbfJPLN5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 07:13:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43039 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390471AbfJPLN5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:13:57 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKhFb-0004K6-Gm; Wed, 16 Oct 2019 13:13:55 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKhFa-0003mp-Le; Wed, 16 Oct 2019 13:13:54 +0200
Date:   Wed, 16 Oct 2019 13:13:54 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: stm32: Pass breakinput instead of its values
Message-ID: <20191016111354.bb34eedzzsmzm3so@pengutronix.de>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
 <20191016110601.1765415-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016110601.1765415-3-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 01:06:00PM +0200, Thierry Reding wrote:
> Instead of passing the individual values of the breakpoint, pass a
> pointer to the breakpoint.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
